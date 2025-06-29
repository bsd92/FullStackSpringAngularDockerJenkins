import { HttpClient } from '@angular/common/http';
import { Component, OnInit } from '@angular/core';
import { environment } from '../../../environments/environment';

@Component({
  selector: 'app-role-management',
  standalone: false,
  templateUrl: './role-management.component.html',
  styleUrls: ['./role-management.component.css']
})
export class RoleManagementComponent implements OnInit {

  users: any[] = [];
  availableRoles = ['USER', 'MANAGER', 'ADMIN'];

  // URL API dynamique
  private baseUrl = `${environment.apiUrl}/admin`;

  constructor(private http: HttpClient) {}

  ngOnInit(): void {
    this.loadUsers();
  }

  loadUsers() {
    this.http.get<any[]>(`${this.baseUrl}/users`).subscribe(data => {
      this.users = data;
    });
  }

  updateUserRoles(user: any) {
    this.http.put(`${this.baseUrl}/users/${user.id}/roles`, user.roles).subscribe(() => {
      alert(`Rôles de ${user.username} mis à jour !`);
    });
  }

  toggleRole(user: any, role: string) {
    const index = user.roles.indexOf(role);
    if (index === -1) {
      user.roles.push(role);
    } else {
      user.roles.splice(index, 1);
    }
  }
}
