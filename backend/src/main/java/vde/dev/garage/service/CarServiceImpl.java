package vde.dev.garage.service;

import lombok.AllArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.mail.SimpleMailMessage;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.server.ResponseStatusException;
import vde.dev.garage.modele.AppUser;
import vde.dev.garage.modele.Car;
import vde.dev.garage.modele.StatutName;
import vde.dev.garage.repository.CarRepository;

import java.util.List;
import java.util.Optional;

@Service
@AllArgsConstructor
public class CarServiceImpl implements CarService {

    private final CarRepository carRepository;



    @Override
    public Car createCar(Car car) {
        return carRepository.save(car);
    }

    @Override
    public List<Car> readCars() {
        return carRepository.findAll();
    }

    @Override
    public Optional<Car> findCarById(String immatriculation) {
        return carRepository.findById(immatriculation);
    }
/*
    @Override
    public Car findCarById(String immatriculation) {
        return carRepository.findById(immatriculation)
                .orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND, "Voiture non trouvée"));

    }

 */

    @Override
    public Car updateCar(String immatriculation, Car updatedCar) {
        Car car = carRepository.findByImmatriculation(immatriculation)
                .orElseThrow(() -> new RuntimeException("Voiture non trouvée"));

        car.setMarque(updatedCar.getMarque());
        car.setModele(updatedCar.getModele());
        car.setEtat(updatedCar.getEtat());

        return carRepository.save(car);
/*
        return carRepository.findById(immatriculation)
        .map(c->{
            c.setMarque(car.getMarque());
            c.setModele(car.getModele());
            c.setEtat(car.getEtat());
            return carRepository.save(c);
        }).orElseThrow(()-> new RuntimeException("Car non trouvé "));

 */
    }

//    @Override
//    public String deleteCar(String immatriculation) {
//        carRepository.deleteById(immatriculation);
//        return "Car supprimé avec succès !";
//    }

    public void deleteCar(String immatriculation) {
        Car car = carRepository.findById(immatriculation)
                .orElseThrow(() -> new RuntimeException("Voiture non trouvée !"));
        carRepository.delete(car);
    }


    @Override
    public boolean existsByImmatriculation(String immatriculation) {
        return carRepository.existsByImmatriculation(immatriculation);
    }
    @Transactional
    public void updateCarStatus(String immatriculation, StatutName newStatus) {
        Car car = carRepository.findById(immatriculation)
                .orElseThrow(() -> new RuntimeException("Car not found"));

        car.setStatus(newStatus);
        carRepository.save(car);

//        sendEmailNotification(car);
    }

}
