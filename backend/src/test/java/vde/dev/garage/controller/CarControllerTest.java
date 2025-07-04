package vde.dev.garage.controller;

import vde.dev.garage.modele.*;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.BeforeEach;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.boot.test.mock.mockito.MockBean;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.test.context.support.WithMockUser;
import org.springframework.test.context.ActiveProfiles;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import static org.mockito.Mockito.doNothing;


import java.util.List;
import java.util.Set;
import java.util.Optional;

import vde.dev.garage.modele.Car;
import vde.dev.garage.repository.*;
import vde.dev.garage.configuration.JwtUtils;
import vde.dev.garage.service.CarServiceImpl;
import static org.mockito.Mockito.*;

import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.lenient;
import static org.mockito.Mockito.when;

import static org.junit.jupiter.api.Assertions.assertTrue;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.put;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.delete;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.jsonPath;

@SpringBootTest
@AutoConfigureMockMvc
@ActiveProfiles("test")
class CarControllerTest {

    @Autowired
    private MockMvc mockMvc;

    @MockBean
    private CarServiceImpl carService;

    @MockBean
    private UserRepository uRepo;

    @MockBean
    private PermissionRepository permissionRepository;

    @MockBean
    private RoleRepository roleRepository;

    @MockBean
    private PasswordEncoder passwordEncoder;

    @MockBean
    private AuthenticationManager authenticationManager;

    @MockBean
    private JwtUtils jwtUtils;

    @MockBean
    private CarRepository carRepository;

    @Test
    @WithMockUser(username = "admin1", roles = {"ADMIN"})
    void shouldReadCar() throws Exception {
        Car car1 = new Car("TG-545-YH", "Yamaha", "sonny", "usage");
        Car car2 = new Car("VC-545-YT", "BZZZ", "Tony", "occasion");

        lenient().when(carService.readCars()).thenReturn(List.of(car1, car2));

        mockMvc.perform(get("/garage/read").header("Authorization", "Bearer fake-token"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$[0].immatriculation").value("TG-545-YH"));
    }

    @Test
    @WithMockUser(username = "admin1", roles = {"ADMIN"})
    void shouldCreateCar() throws Exception {
        String json = """
                {
                    "immatriculation": "DZ-568-KY",
                    "marque": "Toyota4",
                    "modele": "Yaris4",
                    "etat": "Neuve4"
                }
                """;

        lenient().when(carService.createCar(any(Car.class))).thenReturn(new Car());

        mockMvc.perform(MockMvcRequestBuilders.post("/garage/create")
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(json))
                .andExpect(result -> {
                    int status = result.getResponse().getStatus();
                    assertTrue(status == HttpStatus.OK.value() || status == HttpStatus.CREATED.value());
                });
    }

    @Test
    @WithMockUser(username = "admin1", roles = {"ADMIN"})
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
        when(carService.findCarById("DZ-568-KY")).thenReturn(Optional.of(new Car()));

        when(carService.updateCar(eq("DZ-568-KY"), any(Car.class))).thenReturn(updatedCar);

        mockMvc.perform(put("/garage/update/DZ-568-KY")
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(json))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.marque").value("Berline"));
    }

    @Test
    @WithMockUser(username = "admin1", roles = {"ADMIN"})
    void shouldDeleteCar() throws Exception {
        Car car = new Car("DZ-568-KY", "Toyota4", "Yarris4", "neuve4");


        when(carRepository.findById("DZ-568-KY")).thenReturn(Optional.of(car));

        mockMvc.perform(delete("/garage/delete/DZ-568-KY"))
                .andExpect(status().isOk());
    }

}
