import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Router } from '@angular/router';
import { jwtDecode } from 'jwt-decode';
import { Observable, tap } from 'rxjs';
import { environment } from '../environments/environment';

@Injectable({
  providedIn: 'root'
})
export class AuthService {

  // Utilisation de l'URL dynamique depuis l'environnement
  private baseUrl = `${environment.apiUrl}/garage`;

  constructor(private http: HttpClient, private router: Router) {}

  login(credentials: any): Observable<any> {
    return this.http.post<any>(`${this.baseUrl}/login`, credentials)
      .pipe(
        tap(response => {
          const accessToken = response.accessToken;
          const refreshToken = response.refreshToken;

          if (accessToken && refreshToken) {
            localStorage.setItem('accessToken', accessToken);
            localStorage.setItem('refreshToken', refreshToken);
          }
        })
      );
  }

  refreshToken(): Observable<any> {
    const refreshToken = localStorage.getItem('refreshToken');
    return this.http.post<any>(`${this.baseUrl}/refresh-token`, {
      refreshToken: refreshToken
    });
  }

  logout(): void {
    localStorage.removeItem('accessToken');
    localStorage.removeItem('refreshToken');
    this.router.navigate(['/login']);
  }

  isLoggedIn(): boolean {
    const token = localStorage.getItem('accessToken');
    return !!token;
  }

  isAuthenticated(): boolean {
    return this.isLoggedIn();
  }

  getAccessToken(): string | null {
    return localStorage.getItem('accessToken');
  }

  getRefreshToken(): string | null {
    return localStorage.getItem('refreshToken');
  }

  saveToken(token: string): void {
    localStorage.setItem('accessToken', token);
  }

  getRoles(): string[] {
    const token = localStorage.getItem('accessToken');
    if (!token) return [];

    try {
      const decodedToken: any = jwtDecode(token);
      return decodedToken.roles || [];
    } catch (error) {
      return [];
    }
  }

  isAdmin(): boolean {
    return this.getRoles().some(role =>
      role === 'ADMIN' || role === 'ROLE_ADMIN'
    );
  }

  isManager(): boolean {
    return this.getRoles().some(role =>
      role === 'MANAGER' || role === 'ROLE_MANAGER'
    );
  }

  isUser(): boolean {
    return this.getRoles().some(role =>
      role === 'USER' || role === 'ROLE_USER'
    );
  }

  getUserRole(): string | null {
    const token = localStorage.getItem('accessToken');
    if (!token) return null;

    try {
      const decodedToken: any = jwtDecode(token);
      const roles = decodedToken.roles || [];
      return roles.length > 0 ? roles[0] : null;
    } catch {
      return null;
    }
  }

  hasRole(role: string): boolean {
    return this.getRoles().includes(role) || this.getRoles().includes(`ROLE_${role}`);
  }
}
