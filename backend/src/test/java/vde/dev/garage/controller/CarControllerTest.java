package vde.dev.garage.controller;

import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;

import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.security.authentication.AuthenticationManager;

import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.test.context.support.WithMockUser;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import vde.dev.garage.configuration.JwtUtils;
import vde.dev.garage.modele.Car;
import java.util.Optional;
import vde.dev.garage.repository.UserRepository;
import vde.dev.garage.service.CarServiceImpl;
import org.springframework.test.context.ActiveProfiles;
import org.springframework.boot.test.mock.mockito.MockBean;

@AutoConfigureMockMvc
@SpringBootTest
@ActiveProfiles("test")
class CarControllerTest {

    @Autowired
    private MockMvc mockMvc;

    @MockBean
    private CarServiceImpl carService;

    @MockBean
    private UserRepository uRepo;

    @MockBean
    private PasswordEncoder passwordEncoder;

    @MockBean
    private AuthenticationManager authenticationManager;

    @MockBean
    private JwtUtils jwtUtils;

    @Test
    @WithMockUser(username = "admin1", authorities = {"CAN_VIEW_CARS"})
    void shouldReadCar() throws Exception {
        Car car1 = new Car("TG-545-YH", "Yamaha", "sonny", "usage");
        Car car2 = new Car("VC-545-YT", "BZZZ", "Tony", "occasion");

        Mockito.when(carService.readCars()).thenReturn(List.of(car1, car2));

        mockMvc.perform(get("/garage/read"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$[0].immatriculation").value("TG-545-YH"));
    }

    @Test
    @WithMockUser(username = "admin1", authorities = {"CAN_CREATE_CARS"})
    void shouldCreateCar() throws Exception {
        String json = """
                {
                    "immatriculation": "DZ-568-KY",
                    "marque": "Toyota4",
                    "modele": "Yaris4",
                    "etat": "Neuve4"
                }
                """;

        Car car = new Car("DZ-568-KY", "Toyota4", "Yaris4", "Neuve4");
        Mockito.when(carService.createCar(any(Car.class))).thenReturn(car);

        mockMvc.perform(MockMvcRequestBuilders.post("/garage/create")
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(json))
                .andExpect(status().isCreated())
                .andExpect(jsonPath("$.immatriculation").value("DZ-568-KY"));
    }

    @Test
    @WithMockUser(username = "admin1", authorities = {"CAN_UPDATE_CARS"})
    void shouldUpdateCar() throws Exception {
        String json = """
                {
                    "immatriculation": "DZ-568-KY",
                    "marque": "Berline",
                    "modele": "Hiernos",
                    "etat": "occasion"
                }
                """;

        Car updatedCar = new Car("DZ-568-KY", "Berline", "Hiernos", "occasion");
        Mockito.when(carService.updateCar(eq("DZ-568-KY"), any(Car.class))).thenReturn(updatedCar);

        mockMvc.perform(MockMvcRequestBuilders.put("/garage/update/DZ-568-KY")
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(json))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.marque").value("Berline"));
    }

    @Test
    @WithMockUser(username = "admin1", authorities = {"CAN_DELETE_CARS"})
    void shouldDeleteCar() throws Exception {
        Car car = new Car("DZ-568-KC", "toyota4", "Yarris4", "neuve4");
        Mockito.when(carService.findCarById("DZ-568-KC")).thenReturn(Optional.of(car));
        Mockito.doNothing().when(carService).deleteCar("DZ-568-KC");

        mockMvc.perform(MockMvcRequestBuilders.delete("/garage/delete/DZ-568-KC"))
                .andExpect(status().isOk());
    }
}
