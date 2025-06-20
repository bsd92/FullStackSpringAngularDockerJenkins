package vde.dev.garage.repository;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.orm.jpa.DataJpaTest;
import org.springframework.boot.test.autoconfigure.jdbc.AutoConfigureTestDatabase;
import org.springframework.test.context.ActiveProfiles;
import vde.dev.garage.modele.Car;

import java.util.List;
import java.util.Optional;

import static org.junit.jupiter.api.Assertions.*;

@DataJpaTest
@AutoConfigureTestDatabase(replace = AutoConfigureTestDatabase.Replace.NONE)
@ActiveProfiles("test")
class CarRepositoryTest {

    @Autowired
    private CarRepository carRepository;

    @BeforeEach
    void setUp() {
        carRepository.deleteAll(); // Clean slate
        carRepository.save(new Car("DZ-568-KC", "toyota", "yaris", "neuve"));
        carRepository.save(new Car("AB-123-CD", "peugeot", "308", "occasion"));
        carRepository.save(new Car("XY-456-ZT", "renault", "clio", "neuve"));
    }

    @Test
    public void shouldReturnAllCars() {
        List<Car> cars = carRepository.findAll();
        assertEquals(3, cars.size());
        assertEquals("toyota", cars.get(0).getMarque());
    }

    @Test
    public void shouldReturnCarByImmatriculation() {
        Car car = carRepository.findById("DZ-568-KC").get();
        assertEquals("toyota", car.getMarque());
        assertEquals("yaris", car.getModele());
    }

    @Test
    public void shouldCreateCar() {
        Car car = new Car("EF-565-JU", "Audi", "Vimus", "neuve");
        Car savedCar = carRepository.save(car);

        assertNotNull(savedCar.getImmatriculation());
        assertEquals("EF-565-JU", savedCar.getImmatriculation());
        assertEquals("Audi", savedCar.getMarque());
        assertEquals("Vimus", savedCar.getModele());
    }

    @Test
    public void shouldUpdateCar() {
        Car car = carRepository.findById("DZ-568-KC").get();
        car.setMarque("Ford");
        Car savedCar = carRepository.save(car);

        assertEquals("Ford", savedCar.getMarque());
    }

    @Test
    public void shouldDeleteCar() {
        carRepository.save(new Car("EF-565-JU", "Audi", "Vimus", "neuve"));
        carRepository.deleteById("EF-565-JU");

        Optional<Car> carDel = carRepository.findById("EF-565-JU");
        assertFalse(carDel.isPresent());
    }
}
