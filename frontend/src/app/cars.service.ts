import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';
import { Car } from './car';
import { environment } from '../environments/environment';

@Injectable({
  providedIn: 'root'
})
export class CarsService {

  // Utilisation de l'URL depuis l'environnement
  private baseUrl = `${environment.apiUrl}`;

  constructor(private httpClient: HttpClient) { }

  getCartList(): Observable<Car[]> {
    return this.httpClient.get<Car[]>(`${this.baseUrl}/read`);
  }

  addCar(car: Car): Observable<object> {
    return this.httpClient.post(`${this.baseUrl}/create`, car);
  }

  getCarById(immatriculation: string): Observable<Car> {
    return this.httpClient.get<Car>(`${this.baseUrl}/read/${immatriculation}`);
  }

  updateCar(immatriculation: string, car: Car): Observable<Object> {
    return this.httpClient.put(`${this.baseUrl}/update/${immatriculation}`, car);
  }

  deleteCar(immatriculation: string): Observable<Object> {
    return this.httpClient.delete(`${this.baseUrl}/delete/${immatriculation}`);
  }

  updateCarStatus(car: any) {
    return this.httpClient.put(
      `${this.baseUrl}/cars/${car.immatriculation}/status`,
      { status: car.status }
    ).subscribe();
  }

}
