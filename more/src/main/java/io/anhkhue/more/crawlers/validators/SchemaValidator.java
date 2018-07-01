package io.anhkhue.more.crawlers.validators;

import lombok.extern.slf4j.Slf4j;
import org.springframework.core.io.ClassPathResource;
import org.springframework.stereotype.Component;
import org.xml.sax.SAXException;

import javax.xml.XMLConstants;
import javax.xml.bind.JAXBContext;
import javax.xml.bind.JAXBException;
import javax.xml.bind.Marshaller;
import javax.xml.bind.util.JAXBSource;
import javax.xml.transform.Source;
import javax.xml.validation.Schema;
import javax.xml.validation.SchemaFactory;
import javax.xml.validation.Validator;
import java.io.*;

@Slf4j
@Component
public class SchemaValidator {

    public void validate(Object jaxbObj, String schemaPath) throws JAXBException, IOException, SAXException {
        SchemaFactory schemaFactory = SchemaFactory.newInstance(XMLConstants.W3C_XML_SCHEMA_NS_URI);

        // Set up Schema for validation
        Schema schema = schemaFactory.newSchema(getSchema(schemaPath));

        // Create JAXB Context
        JAXBContext jaxbContext = JAXBContext.newInstance(jaxbObj.getClass());

        Validator validator = schema.newValidator();
        Source jaxbSource = new JAXBSource(jaxbContext, jaxbObj);
        validator.validate(jaxbSource);

        // Instantiate marshaller
        Marshaller marshaller = jaxbContext.createMarshaller();
        marshaller.setSchema(schema);

        StringWriter stringWriter = new StringWriter();

        marshaller.marshal(jaxbObj, stringWriter);
    }

    private File getSchema(String schemaPath) throws IOException {
        return new ClassPathResource(schemaPath).getFile();
    }
}