package io.anhkhue.more.models.mining.report;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.xml.bind.annotation.*;

// Lombok
@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
// JAXB
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "", propOrder = {
        "logo",
        "date",
        "vendor",
        "movies"
})
@XmlRootElement(name = "report")
public class Report {

    @XmlElement(name = "logo", required = true)
    private String logo;
    @XmlElement(name = "date", required = true)
    private String date;
    @XmlElement(name = "vendor", required = true)
    private Vendor vendor;
    @XmlElement(name = "movies", required = true)
    private Movies movies;
}
