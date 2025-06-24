package vde.dev.garage.service;

import org.junit.jupiter.api.Test;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import vde.dev.garage.modele.Car;
import vde.dev.garage.repository.CarRepository;
import java.util.List;
import java.util.Optional;

import static org.assertj.core.api.Assertions.assertThat;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;
import org.springframework.boot.test.context.SpringBootTest;
import static org.junit.jupiter.api.Assertions.assertEquals;
import org.springframework.test.context.ActiveProfiles;
import static org.junit.jupiter.api.Assertions.*;

@SpringBootTest
@ActiveProfiles("test")
class CarServiceImplTest {


    @Mock
    private CarRepository carRepository;

    @InjectMocks
    private CarServiceImpl carService;

    @Test
    void createCar() {
        // GIVEN
        Car newCar = new Car("TG-545-YH", "Toyota", "Corolla", "Usage");

        // WHEN - le comportement du repository
        when(carRepository.save(any(Car.class)))
                .thenAnswer(invocation -> invocation.getArgument(0));

        // WHEN - appel du service
        Car savedCar = carService.createCar(newCar);

        // THEN
        assertThat(savedCar).isNotNull();
        assertThat(savedCar.getImmatriculation()).isEqualTo("TG-545-YH");
        assertThat(savedCar.getMarque()).isEqualTo("Toyota");
        assertThat(savedCar.getModele()).isEqualTo("Corolla");
        assertThat(savedCar.getEtat()).isEqualTo("Usage");

        verify(carRepository).save(newCar); // vérifie que save a bien été appelé
    }

    @Test
    void shouldReadCars() {
        //Arrange
       Car car1 = new Car("TG-545-YH","Yamaha","sonny","usage");
       Car car2 = new Car("VC-545-YT","BZZZ","Tony","occasion");

       when(carRepository.findAll()).thenReturn(List.of(car1, car2));

       List<Car> cars=carService.readCars();

       //Assert
       assertThat(cars).hasSize(2).contains(car1, car2);

    }


    @Test
    void shouldUpdateCar() {
        // Arrange
        String immatriculation = "DZ-568-KY";
        Car existingCar = new Car(immatriculation, "Toyota", "Yaris", "neuve");
        Car updatedCar = new Car(immatriculation, "Peugeot", "208", "occasion");

        when(carRepository.findByImmatriculation(immatriculation)).thenReturn(Optional.of(existingCar));
        when(carRepository.save(any(Car.class))).thenReturn(updatedCar);

        // Act
        Car result = carService.updateCar(immatriculation, updatedCar);

        // Assert
        assertNotNull(result);
        assertEquals("Peugeot", result.getMarque());
        assertEquals("208", result.getModele());
        assertEquals("occasion", result.getEtat());
    }



    @Test
    void deleteCar() {
        // given
        Car car = new Car("DZ-568-KC", "Toyota", "Yaris", "neuve");
        when(carRepository.findById("DZ-568-KC")).thenReturn(Optional.of(car));

        // when
        carService.deleteCar("DZ-568-KC");

        // then
        verify(carRepository).delete(car);
    }

}