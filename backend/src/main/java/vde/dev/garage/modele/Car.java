package vde.dev.garage.modele;

import jakarta.persistence.*;
import lombok.*;

import java.util.Date;

@Entity
@Table(name = "car")
@Getter
@Setter
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class Car {
    @Id
    private String immatriculation;
    @Column(length = 50)
    private String marque;
    @Column(length = 50)
    private String modele;
    @Column(length = 50)
    private String etat ;

    @Enumerated(EnumType.STRING)
    private StatutName status;

    public Car(String immatriculation, String marque, String modele, String etat,StatutName status){
        this.immatriculation=immatriculation;
        this.marque=marque;
        this.modele=modele;
        this.etat=etat;
        this.status=status;
    }

    public Car(String immatriculation, String marque, String modele, String etat){
        this.immatriculation=immatriculation;
        this.marque=marque;
        this.modele=modele;
        this.etat=etat;
    }

    @ManyToOne
    private AppUser user;

}
