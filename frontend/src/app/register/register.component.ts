import { HttpClient } from '@angular/common/http';
import { Component } from '@angular/core';
import { environment } from '../../../src/environments/environment';

@Component({
  selector: 'app-register',
  standalone: false,
  templateUrl: './register.component.html',
  styleUrls: ['./register.component.css'] // ✅ Attention: c'est "styleUrls" (avec un "s")
})
export class RegisterComponent {

  user = {
    username: '',
    email: '',
    password: ''
  };

  availableRoles = ['USER', 'MANAGER', 'ADMIN'];
  availablePermissions = [
    'CAN_VIEW_CARS',
    'CAN_CREATE_CARS',
    'CAN_UPDATE_CARS',
    'CAN_DELETE_CARS'
  ];

  successMessage: string | null = null;
  errorMessage: string | null = null;

  // ✅ URL API dynamique
  private baseUrl = `${environment.apiUrl}/garage`;

  constructor(private http: HttpClient) {}

  ngOnInit(): void {}

  registerUser() {
    this.http.post(`${this.baseUrl}/register`, this.user).subscribe({
      next: (response) => {
        this.successMessage = (response as any).message || 'Utilisateur créé avec succès';
        this.errorMessage = null;
      },
      error: (err) => {
        this.successMessage = null;
        this.errorMessage = "Erreur lors de la création: " + (err.error?.message || err.message);
      }
    });
  }
}
