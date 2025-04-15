package com.samseng.web.DummyData;

import com.samseng.web.models.Product;
import com.samseng.web.models.Account;
import com.samseng.web.models.Address;
import com.samseng.web.models.Product;
import com.samseng.web.models.Variant;
import com.samseng.web.repositories.Account.AccountRepository;

import com.samseng.web.repositories.Address.AddressRepository;
import com.samseng.web.repositories.Product.ProductRepository;
import com.samseng.web.repositories.Variant.VariantRepository;
import jakarta.annotation.PostConstruct;
import jakarta.ejb.Singleton;
import jakarta.ejb.Startup;
import jakarta.inject.Inject;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.persistence.EntityManager;
import jakarta.transaction.Transactional;
import org.jboss.logging.annotations.Signature;

import javax.swing.*;
import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.Set;


@Startup
@Singleton
@Transactional
public class insertDummyDataP {

    @Inject
    VariantRepository variantRepository;
    @Inject
    ProductRepository productRepository;


    @PostConstruct
    public void insertTest() {

        int num=18;
        for (int i=0;i<num;i++){
            Product product = new Product();
            if(i==0) {

                Set<String> sps24Images = Set.of(
                        "SP-S24-front.png",
                        "SP-S24-side.png",
                        "SP-S24-back.png"
                );
                product.setId("SP-S24");
                product.setName("Samseng Milkyway S24");
                product.setImageUrls(sps24Images);
                product.setDesc("Design and Display:\n-Models and Sizes: The series includes the Galaxy S25 with a 6.2-inch display, the S25 Ultra with a 6.7-inch display, and the S25 Ultra featuring a 6.9-inch screen. \u200B\n-Display Technology: Each model is equipped with a Dynamic AMOLED 2X screen, offering vibrant visuals and smooth scrolling experiences. \u200B\n\nPerformance:\n-Processor: All models are powered by the Snapdragon 8 Elite chipset, delivering a 40% performance boost over previous generations. \u200B\nBattery Life: Optimized battery performance ensures extended usage, with fast and wireless charging options available across the series. \u200B\n\nCamera System:\n-Milkyway S36: Feature a multi-camera setup, including a 50 MP main camera, a 12 MP ultra-wide lens, and a 10 MP telephoto lens, complemented by a 12 MP front-facing camera. \u200B\n-Milkyway S36: Boasts a 200-megapixel main camera, enhanced ultra-wide and telephoto lenses, and advanced AI-driven features like Virtual Aperture for improved depth of field control. \u200B\n\nArtificial Intelligence Features:\n\n-AI Integration: The series introduces Galaxy AI, offering features such as Live Translation for real-time language interpretation and Nightography for capturing stunning low-light photos.\n-Enhanced User Experience: AI-driven functionalities like Circle to Search with Google and AI Select anticipate user needs, providing a more intuitive and personalized experience.");
                product.setCategory("Mobile Phone");
                productRepository.create(product);
            }
            if(i==1) {

                Set<String> spaf6Images = Set.of(
                        "SP-AF6-front.png",
                        "SP-AF6-side.png",
                        "SP-AF6-back.png"
                );

                product.setId("SP-AF6");
                product.setName("Samseng Milkyway A Fold6");
                product.setImageUrls(spaf6Images);
                product.setDesc("\"Design and Display:\n" +
                        "\n" +
                        "-Foldable Screen: The Milkyway A Fold6 offers a versatile experience with its foldable design, featuring a convenient outer screen and an expansive inner screen, effectively providing the functionality of two devices in one. \u200B\n" +
                        "Samsung\n" +
                        "\n" +
                        "Performance:\n" +
                        "\n" +
                        "-Processor: Equipped with the Snapdragon® 8 Gen 3 Mobile Platform for Milkyway, the Milkyway A Fold6 delivers high-performance capabilities, ensuring smooth multitasking and gaming experiences. \u200B\n" +
                        "-Battery Life: Despite retaining the same 4,400mAh (typical) battery as its predecessor, the Milkyway A Fold6 benefits from an advanced processor that enables more efficient power usage. This allows for up to 77 hours of music playback or up to 23 hours of video watching on a single charge. \u200B\n" +
                        "\n" +
                        "\n" +
                        "Camera System:\n" +
                        "-Rear Cameras: The device is equipped with a triple-camera setup on the rear, including a 50MP wide-angle camera, a 12MP ultra-wide camera, and a 10MP telephoto camera, enabling users to capture high-quality photos and videos. \u200B\n" +
                        "-Front Cameras: For selfies and video calls, the Galaxy Z Fold6 features a 10MP cover camera and a 4MP under-display camera on the main screen, maintaining a seamless display experience. \n" +
                        "\n" +
                        "Durability and Build:\n" +
                        "-Design Improvements: The Milkyway A Fold6 is lighter and slimmer than its predecessor, making it more portable and user-friendly.\"\n");
                product.setCategory("Mobile Phone");
                productRepository.create(product);
            }
            if(i==2) {

                Set<String> sps25uImages = Set.of(
                        "https://yourdomain.com/uploads/products/SP-S25U-front.png",
                        "https://yourdomain.com/uploads/products/SP-S25U-side.png",
                        "https://yourdomain.com/uploads/products/SP-S25U-back.png"
                );
                insertP("SP-S25U", "Samseng MilkyWay S25 Ultra", sps25uImages, "\"Design and Display:\n" +
                                "- Larger Screen: Features a 6.9-inch Dynamic AMOLED 2X display, offering an immersive viewing experience.\n" +
                                "- Durability: Utilizes Corning's Gorilla Armor 2 glass for enhanced screen protection.\n" +
                                "\n" +
                                "Performance:\n" +
                                "- Processor: Powered by the Snapdragon 8 Elite chipset, delivering a 40% increase in performance compared to previous models.\n" +
                                "- AI Integration: Incorporates Galaxy AI with features like Audio Eraser to eliminate unwanted sounds and Virtual Aperture for depth of field control.\n" +
                                "\n" +
                                "Camera System:\n" +
                                "- Main Sensor: Equipped with a 200-megapixel main camera, complemented by improved ultra-wide and telephoto lenses.\n" +
                                "- AI Enhancements: Includes features such as Virtual Aperture for enhanced depth of field control and ProScaler for improved video quality.\n" +
                                "\n" +
                                "Software and Updates:\n" +
                                "- Operating System: Ships with Android 15 and Samsung's One UI 7 interface.\n" +
                                "- Support: Samsung promises 7 years of OS and security updates for the S25 series. \"\n"
                        , "Mobile Phone");
            }

            if(i==3) {
                Set<String> spc36gImages = Set.of(
                        "https://yourdomain.com/uploads/products/SP-C36g-front.png",
                        "https://yourdomain.com/uploads/products/SP-C36g-side.png",
                        "https://yourdomain.com/uploads/products/SP-C36g-back.png"
                );
                insertP("SP-C36g", "Samseng MilkyWay C36 5G", spc36gImages, "\"Design and Display:\n" +
                                "-Sleek Aesthetics: Features a clean, linear camera layout with a premium glass back, slimmer bezels, and a flat side frame for a stylish and comfortable grip. \n" +
                                "-Vibrant Screen: Equipped with a 6.7-inch Full HD+ Super AMOLED display, offering a 120Hz refresh rate and peak brightness of 1,200 nits for crisp and fluid visuals, ideal for streaming and gaming. \u200B\n" +
                                "\n" +
                                "Performance:\n" +
                                "-Powerful Processing: Powered by an octa-core processor with a 15% larger vapor chamber, ensuring smoother gameplay and efficient multitasking. \u200B\n" +
                                "-Ample Memory and Storage: Offers configurations with 6GB, 8GB, or 12GB of RAM and storage options of 128GB or 256GB, providing ample space for apps, photos, and videos. \u200B\n" +
                                "\n" +
                                "Camera System:\n" +
                                "-High-Resolution Imaging: Features a 50MP main camera, enabling users to capture detailed and vibrant photos. \u200B\n" +
                                "-Enhanced Selfies: Equipped with a 12MP front camera with video HDR support for clear and dynamic selfies. \u200B\n" +
                                "\n" +
                                "Battery and Charging:\n" +
                                "-Long-Lasting Battery: Houses a 5,000mAh battery, providing extended usage for gaming, streaming, and daily tasks. \u200B\n" +
                                "-Fast Charging: Supports 45W fast charging, allowing for quick power-ups to keep you connected throughout the day. \u200B\"\n"
                        , "Mobile Phone");
            }

           if(i==4){
               Set<String> spb06gImages = Set.of(
                       "https://yourdomain.com/uploads/products/SP-B06g-front.png",
                       "https://yourdomain.com/uploads/products/SP-B06g-side.png",
                       "https://yourdomain.com/uploads/products/SP-B06g-back.png"
               );
               insertP("SP-B06g", "Samseng Milkyway B06 5G", spb06gImages, "\"Display and Design:\n" +
                               "- Screen: 6.7-inch PLS LCD with a 90Hz refresh rate for smooth visuals.\n" +
                               "- Resolution: HD+ (720 x 1600 pixels).\n" +
                               "- Build: Slim profile at 8mm thickness and weighs 191g.\n" +
                               "- Durability: IP54-rated for dust and water resistance.\n" +
                               "- Colors: Available in Light Green, Light Gray, and Black.\n" +
                               "\n" +
                               "Performance:\n" +
                               "- Processor: MediaTek Dimensity 6300 (6nm) octa-core chipset.\n" +
                               "- RAM & Storage: Options of 4GB or 6GB RAM with 128GB internal storage, expandable via microSD.\n" +
                               "- Operating System: Android 15 with One UI 7; promises 4 major OS updates and 4 years of security patches.\n" +
                               "\n" +
                               "Camera System:\n" +
                               "- Rear Cameras: 50MP main sensor with f/1.8 aperture and a 2MP depth sensor.\n" +
                               "- Front Camera: 8MP sensor with f/2.0 aperture.\n" +
                               "- Video Recording: Supports up to 1080p at 30fps.\n" +
                               "\n" +
                               "Battery and Charging:\n" +
                               "- Capacity: 5000mAh battery.\n" +
                               "- Charging: Supports 25W wired fast charging.\"\n"
                       , "Mobile Phone");

           }


            if(i==5){
                Set<String> ts10Images = Set.of(
                        "https://yourdomain.com/uploads/products/T-S10+-front.png",
                        "https://yourdomain.com/uploads/products/T-S10+-side.png",
                        "https://yourdomain.com/uploads/products/T-S10+-back.png"
                );
                insertP("T-S10+", "Milkyway Tab S10+ ", ts10Images,
                        "\"Display:\n" +
                                "-Size: 12.4 inches\u200B\n" +
                                "-Type: Dynamic AMOLED 2X with Anti-Reflective coating\u200B\n" +
                                "\n" +
                                "Memory and Storage:\n" +
                                "-RAM: 12GB\u200B\n" +
                                "-Internal Storage: 256GB\u200B\n" +
                                "\n" +
                                "Cameras:\n" +
                                "-Front Camera: 12MP Ultra-Wide\u200B\n" +
                                "-Rear Cameras: 13MP main sensor paired with an 8MP Ultra-Wide lens\u200B\n" +
                                "\n" +
                                "Battery Life:\n" +
                                "-Capable of up to 16 hours of usage on a single charge\u200B\n" +
                                "\n" +
                                "Durability:\n" +
                                "-Constructed with Enhanced Armor Aluminum\u200B\n" +
                                "Samsung\n" +
                                "-IP68-rated for water and dust resistance\"\n"
                        , "Tab");
            }

            if (i==6){
                Set<String> ts6lImages = Set.of(
                        "https://yourdomain.com/uploads/products/T-S6L-front.png",
                        "https://yourdomain.com/uploads/products/T-S6L-side.png",
                        "https://yourdomain.com/uploads/products/T-S6L-back.png"
                );
                insertP("T-S6L", "Milkyway Tab S6 Lite", ts6lImages,
                        "\"Display:\n" +
                                "-Size: 10.4 inches\u200B\n" +
                                "-Resolution: 2000 x 1200 pixels (WUXGA+)\u200B\n" +
                                "-Type: TFT LCD\u200B\n" +
                                "\n" +
                                "Performance:\n" +
                                "-Processor: Octa-core (Quad 2.3GHz + Quad 1.7GHz)\u200B\n" +
                                "-RAM: 4GB\u200B\n" +
                                "-Storage: 128GB internal, expandable via microSD up to 1TB\u200B\n" +
                                "\n" +
                                "Camera:\n" +
                                "-Rear: 8.0 MP with autofocus\u200B\n" +
                                "-Front: 5.0 MP\u200B\n" +
                                "\n" +
                                "Battery:\n" +
                                "-Capacity: 7,040mAh\u200B\n" +
                                "-Charging: Supports 15W wired charging\u200B\n" +
                                "\n" +
                                "Additional Features:\n" +
                                "-S Pen: Included for enhanced productivity and creativity\u200B\n" +
                                "-Audio: Dual speakers with Dolby Atmos support\u200B\n" +
                                "-Operating System: Android, with One UI\u200B\n" +
                                "-Dimensions: 244.5 x 154.3 x 7.0 mm\u200B\n" +
                                "-Weight: 465g\"\n"
                        , "Tab");
            }

            if (i==7){
                Set<String> wtsw6Images = Set.of(
                        "https://yourdomain.com/uploads/products/WT-SW6-front.png",
                        "https://yourdomain.com/uploads/products/WT-SW6-side.png",
                        "https://yourdomain.com/uploads/products/WT-SW6-back.png"
                );
                insertP("WT-SW6", "Sirius Smartwatch 6", wtsw6Images,
                        "\"Design and Build:\n" +
                                "-Materials: Features a sapphire crystal front and a stainless steel frame, ensuring durability and a classic look.\u200B\n" +
                                "-Rotating Bezel: Equipped with a physical rotating bezel for intuitive navigation.\u200B\n" +
                                "-Dimensions and Weight:\n" +
                                "\t-43mm Model: 42.5 x 42.5 x 10.9 mm; weighs 52g.\u200B\n" +
                                "\t-47mm Model: 46.5 x 46.5 x 10.9 mm; weighs 59g.\u200B\n" +
                                "-Strap Compatibility: Compatible with standard 20mm straps.\u200B\n" +
                                "-Durability: MIL-STD-810H compliant and IP68-rated, offering dust and water resistance up to 50 meters.\u200B\n" +
                                "\n" +
                                "Display:\n" +
                                "-Type: Super AMOLED with Always-on Display feature.\u200B\n" +
                                "-Size and Resolution: Both models have a 1.5-inch display with a resolution of 480 x 480 pixels, resulting in approximately 453 ppi density.\u200B\n" +
                                "-Protection: Sapphire crystal for enhanced scratch resistance.\u200B\n" +
                                "\n" +
                                "Performance:\n" +
                                "-Processor: Powered by the Exynos W930 chipset built on a 5nm process, featuring a dual-core 1.4 GHz Cortex-A55 CPU and Mali-G68 GPU.\u200B\n" +
                                "-Memory: Equipped with 2GB of RAM and 16GB of internal storage.\u200B\n" +
                                "\n" +
                                "Operating System:\n" +
                                "-OS: Runs on Android Wear OS 4, upgradeable to version 5.0, with Samsung's One UI Watch 6 interface.\u200B\n" +
                                "-Sensors and Health Monitoring:\n" +
                                "-Includes accelerometer, gyroscope, compass, barometer, heart rate monitor, SpO2 sensor, and a skin temperature sensor.\u200B\n" +
                                "-Features ECG certification and a blood pressure monitor for comprehensive health tracking.\u200B\n" +
                                "\n" +
                                "Battery Life:\n" +
                                "-Capacity:\n" +
                                "\t-43mm Model: 300mAh battery.\u200B\n" +
                                "\t-47mm Model: 425mAh battery.\u200B\n" +
                                "\n" +
                                "-Charging: Supports 10W wireless charging.\u200B\n" +
                                "\n" +
                                "Connectivity:\n" +
                                "-Offers eSIM support for GSM, HSPA, and LTE networks.\u200B\n" +
                                "-Includes Wi-Fi 802.11 a/b/g/n (dual-band), Bluetooth 5.3, NFC, and GPS with GLONASS, GALILEO, and BDS support.\"\n",
                        "Watch");

            }
            if (i==8) {
                Set<String> wtsw7Images = Set.of(
                        "https://yourdomain.com/uploads/products/WT-SW7-front.png",
                        "https://yourdomain.com/uploads/products/WT-SW7-side.png",
                        "https://yourdomain.com/uploads/products/WT-SW7-back.png"
                );
                insertP("WT-SW7", "Sirius Smartwatch 7", wtsw7Images, "\"Design and Display:\n" + "-Dimensions: 44.4 x 44.4 x 9.7 mm\u200B\n" + "-Weight: 33.8 grams\u200B\n" + "-Display: 1.47-inch Super AMOLED with a resolution of 480 x 480 pixels, protected by sapphire crystal for enhanced durability.\u200B\n" + "-Materials: Constructed with an aluminum chassis, offering a sleek and lightweight design.\u200B\n" + "\n" + "Performance:\n" + "-Processor: Exynos W1000 chipset with a 5-core configuration (one Cortex-A78 core at 1.6GHz and four Cortex-A55 cores at up to 1.5GHz), providing efficient performance.\u200B\n" + "-Memory: 2GB of RAM and 32GB of internal storage.\u200B\n" + "Operating System: Runs on Wear OS 5 with Samsung's One UI Watch 6 interface, offering a user-friendly experience.\u200B\n" + "\n" + "Health and Fitness Tracking:\n" + "-Sensors: Equipped with a heart rate monitor, blood oxygen monitor, electrocardiography (ECG), blood pressure monitor, bioelectrical impedance analysis, temperature sensor, accelerometer, barometer, gyroscope, geomagnetic sensor, and light sensor.\u200B\n" + "-Fitness Features: Supports tracking of over 100 workouts, advanced sleep tracking, and a Body Composition tool that provides insights into metrics like body fat, water levels, and BMI.\u200B\n" + "\n" + "Battery Life:\n" + "-Capacity: 425mAh battery, offering approximately one to two days of usage depending on -settings and usage patterns.\u200B\n" + "-Charging: Supports wireless charging up to 15W.\u200B\n" + "\n" + "Connectivity:\n" + "-Bluetooth: Version 5.3 for seamless connection with compatible devices.\u200B\n" + "-Wi-Fi: Supports Wi-Fi 802.11 a/b/g/n, dual-band.\u200B\n" + "-NFC: Enables contactless payments and other NFC functionalities.\u200B\n" + "-GPS: Includes A-GPS, GLONASS, Beidou, and Galileo support for accurate location tracking.\u200B\n" + "\n" + "Additional Features:\n" + "-Water Resistance: IP68-rated, providing dust and water resistance up to 50 meters.\u200B\n" + "-Compatibility: Designed to work seamlessly with Android smartphones, offering features like Natural Language Command and Dictation, and an Emergency SOS System.\u200B\"\n", "Watch");
            }

            if (i==9) {
                Set<String> pv7Images = Set.of(
                        "https://yourdomain.com/uploads/products/P-v7-front.png",
                        "https://yourdomain.com/uploads/products/P-v7-side.png",
                        "https://yourdomain.com/uploads/products/P-v7-back.png"
                );
                insertP("P-v7", "Smart Pen v7", pv7Images,
                        "\"Precision and Control:\n" +
                                "-The v Pen is sensitive to both pressure and tilt, allowing for detailed sketches and illustrations. \u200B\n" +
                                "\n" +
                                "Air Command Functionality:\n" +
                                "-Personalize v Pen actions with the Air Command feature, providing a shortcut menu for a faster workflow and greater control. \u200B\n" +
                                "\n" +
                                "Water Resistance:\n" +
                                "-With an IP68 rating, the v Pen is water-resistant, capable of withstanding submersion in up to 1.5 meters of freshwater for up to 30 minutes. \u200B\n" +
                                "\n" +
                                "Convenient Storage and Charging:\n" +
                                "-The v Pen magnetically attaches to the tablet for secure storage and charges while attached, ensuring it's always ready for use. \u200B\n" +
                                "\n" +
                                "Physical Specifications:\n" +
                                "-Dimensions: 8.2 x 145.04 x 7.7 mm\u200B\n" +
                                "-Weight: 8.75 g\"\n",
                        "Accessories");
            }
            if (i==10) {
                Set<String> bab2Images = Set.of(
                        "https://yourdomain.com/uploads/products/B-AB2-front.png",
                        "https://yourdomain.com/uploads/products/B-AB2-side.png",
                        "https://yourdomain.com/uploads/products/B-AB2-back.png"
                );
                insertP("B-AB2", "Sirius Buds2", bab2Images,
                        "\"Audio Quality:\n" +
                                "-Balanced Sound: Engineered to deliver well-balanced audio across various genres.\u200B\n" +
                                "\n" +
                                "Active Noise Cancellation (ANC):\n" +
                                "-Equipped with ANC technology that effectively reduces ambient noise, allowing for an immersive listening experience.\u200B\n" +
                                "\n" +
                                "Call Clarity:\n" +
                                "-Triple Microphone System: Features three microphones and a built-in voice pickup unit to enhance call clarity.\u200B\n" +
                                "-Noise Filtering: Utilizes machine-learning-based solutions to filter out unwanted sounds, ensuring clearer communication.\u200B\n" +
                                "\n" +
                                "Design and Comfort:\n" +
                                "-Lightweight Build: Each earbud weighs approximately 5 grams, providing comfort during extended use.\u200B\n" +
                                "-Ergonomic Fit: Comes with soft, flexible silicone ear tips in three sizes to ensure a secure and personalized fit.\u200B\n" +
                                "\n" +
                                "Battery Life:\n" +
                                "-Long-Lasting Playtime: Offers up to 5 hours of continuous playback with ANC enabled, extending to 20 hours with the charging case.\u200B\n" +
                                "\n" +
                                "Connectivity:\n" +
                                "-Bluetooth 5.2: Ensures a stable and efficient connection with compatible devices.\u200B\n" +
                                "\n" +
                                "Compatibility:\n" +
                                "-Designed to work seamlessly with smartphones running Android 7.0 or higher with at least 1.5GB of RAM.\u200B\"\n",
                        "Earbuds");
            }

            if (i==11) {
                Set<String> bab3Images = Set.of(
                        "https://yourdomain.com/uploads/products/B-AB3-front.png",
                        "https://yourdomain.com/uploads/products/B-AB3-side.png",
                        "https://yourdomain.com/uploads/products/B-AB3-back.png"
                );
                insertP("B-AB3", "Sirius Buds3", bab3Images,
                        "\"360 Audio: These earbuds incorporate 360 Audio technology, which detects the direction of sound as you move your head, providing a surround sound experience for more vivid listening and viewing. \n" +
                                "\n" +
                                "Battery Life: Each earbud is equipped with a 48mAh battery, offering up to 5 hours of continuous listening with Active Noise Cancellation (ANC) enabled, and up to 24 hours total when combined with the charging case. With ANC turned off, the earbuds can last up to 6 hours, extending to 30 hours with the case. \u200B\n" +
                                "\n" +
                                "Charging Case: The redesigned charging case features a transparent top and houses a 515mAh battery, providing additional charges to keep your earbuds powered throughout the day. \u200B\n" +
                                "\n" +
                                "Active Noise Cancellation (ANC): The Apollo Buds3 offer ANC capabilities, allowing you to focus on your music or calls by reducing unwanted ambient noise.\n" +
                                "\n" +
                                "Design: Featuring an all-new, open-type design, these earbuds provide a comfortable fit for extended listening sessions. \u200B\n" +
                                "\n" +
                                "Adaptive EQ: The Adaptive EQ feature automatically adjusts the sound quality based on your environment, ensuring an optimal listening experience. \"\n",
                        "Earbuds");
            }

            if (i==12){
                Set<String> pbv10Images = Set.of(
                        "https://yourdomain.com/uploads/products/PB-v10-front.png",
                        "https://yourdomain.com/uploads/products/PB-v10-side.png",
                        "https://yourdomain.com/uploads/products/PB-v10-back.png"
                );
                insertP("PB-v10", "Wireless Power Bank v10", pbv10Images,
                        "\"Battery Capacity:\n" +
                                "-10,000mAh\u200B\n" +
                                "\n" +
                                "Charging Capabilities:\n" +
                                "-Wired Charging: Supports up to 25W Super Fast Charging via USB-C, allowing for rapid charging of compatible devices.\u200B\n" +
                                "-Wireless Charging: Features Qi-certified wireless charging, enabling you to charge your device by simply placing it on the battery pack.\u200B\n" +
                                "-Dual Device Charging: Equipped with dual ports, allowing you to charge two devices simultaneously—one wired and one wireless.\u200B\n" +
                                "\n" +
                                "Design and Portability:\n" +
                                "-Dimensions: 70 x 148 x 15.6 mm\u200B\n" +
                                "-Weight: 210 grams\u200B\n" +
                                "-Color: Beige\u200B\n" +
                                "\n" +
                                "Portability: \n" +
                                "-Compact and lightweight design makes it convenient to carry, ensuring your devices remain powered throughout the day.\u200B\n" +
                                "\n" +
                                "Environmental Considerations:\n" +
                                "-Constructed with UL-certified recycled materials, reflecting Samsung's commitment to sustainability.\"\n",
                        "Power Bank");
            }

            if (i==13){Set<String> og6Images = Set.of(
                    "https://yourdomain.com/uploads/products/MT-OG6-front.png",
                    "https://yourdomain.com/uploads/products/MT-OG6-side.png",
                    "https://yourdomain.com/uploads/products/MT-OG6-back.png"
            );
                insertP("MT-OG7", "Olympus G7 UHD 144Hz Gaming Monitor", og6Images,
                        "\"Display:\n" +
                                "-Resolution: 4K UHD (3,840 x 2,160 pixels)\u200B\n" +
                                "-Aspect Ratio: 16:9\u200B\n" +
                                "-Panel Type: IPS\u200B\n" +
                                "-Brightness: 350 cd/㎡ (typical)\u200B\n" +
                                "-Contrast Ratio: 1000:1 (static)\u200B\n" +
                                "-HDR Support: VESA DisplayHDR 400 and HDR10+ Gaming\u200B\n" +
                                "-Response Time: 1ms (GTG)\u200B\n" +
                                "-Refresh Rate: Up to 144Hz\u200B\n" +
                                "-Viewing Angle: 178° (horizontal/vertical)\u200B\n" +
                                "\n" +
                                "Gaming Features:\n" +
                                "-Adaptive Sync: Supports AMD FreeSync Premium for smooth, tear-free gameplay.\u200B\n" +
                                "-Game Bar 2.0: Provides quick access to gaming settings and adjustments.\u200B\n" +
                                "-Core Sync: Enhances the gaming ambiance with synchronized lighting effects.\u200B\n" +
                                "\n" +
                                "Additional Features:\n" +
                                "-Eye Saver Mode: Reduces blue light emissions for comfortable viewing during extended gaming sessions.\u200B\n" +
                                "-Flicker-Free Technology: Minimizes screen flickering to reduce eye strain.\u200B\n" +
                                "-Auto Source Switch+: Automatically detects and switches to active input sources.\u200B\n" +
                                "-Adaptive Picture: Adjusts brightness based on surrounding light conditions for optimal viewing.\u200B\n" +
                                "-Ultrawide Game View: Offers a wider field of view for an enhanced gaming experience.\"\n",
                        "Monitor");}


            if (i==14) {
                // Olympus OLED G8 4K 240Hz Gaming Monitor
                Set<String> og8Images = Set.of(
                        "https://yourdomain.com/uploads/products/MT-OG8-front.png",
                        "https://yourdomain.com/uploads/products/MT-OG8-side.png",
                        "https://yourdomain.com/uploads/products/MT-OG8-back.png"
                );
                insertP("MT-OG8", "Olympus OLED G8 4K 240Hz Gaming Monitor", og8Images,
                        "\"Display:\n" +
                                "-Resolution: 4K UHD (3,840 x 2,160 pixels)\u200B\n" +
                                "-Aspect Ratio: 16:9\u200B\n" +
                                "-Panel Type: OLED with Quantum Dot technology (QD-OLED)\u200B\n" +
                                "-Brightness: 260 cd/㎡ (typical)\u200B\n" +
                                "-Contrast Ratio: 1,000,000:1 (static)\u200B\n" +
                                "-HDR Support: VESA DisplayHDR True Black 400 and HDR10+ Gaming\u200B\n" +
                                "-Response Time: 0.03ms (GTG)\u200B\n" +
                                "-Refresh Rate: Up to 240Hz\u200B\n" +
                                "-Viewing Angle: 178° (horizontal/vertical)\u200B\n" +
                                "\n" +
                                "Gaming Features:\n" +
                                "-Adaptive Sync: Supports both AMD FreeSync Premium Pro and NVIDIA G-SYNC Compatible technologies for smooth, tear-free gameplay.\u200B\n" +
                                "-Glare-Free Technology: Minimizes reflections and distractions, allowing for better focus during gaming sessions.\u200B\n" +
                                "-Samseng OLED Safeguard+: Incorporates advanced technologies to prevent burn-ins, ensuring the longevity of the display.\u200B\n" +
                                "\n" +
                                "Additional Features:\n" +
                                "-Design: Sleek and modern aesthetics with a focus on enhancing the gaming environment.\u200B\n" +
                                "-Connectivity: Offers multiple ports, including HDMI and USB, to accommodate various devices and peripherals.\"\n",
                        "Monitor");
            }
            if(i==15) {
                // Olympus 49'' S6 Monitor
                Set<String> vs6Images = Set.of(
                        "https://yourdomain.com/uploads/products/MT-VS6-front.png",
                        "https://yourdomain.com/uploads/products/MT-VS6-side.png",
                        "https://yourdomain.com/uploads/products/MT-VS6-back.png"
                );
                insertP("MT-VS6", "49’’ Olympus Monitor S6", vs6Images,
                        "\"Display:\n" +
                                "-Screen Size: 49 inches\u200B\n" +
                                "-Resolution: Dual QHD (5,120 x 1,440 pixels)\u200B\n" +
                                "-Aspect Ratio: 32:9\u200B\n" +
                                "-Panel Type: OLED\u200B\n" +
                                "-Brightness: 250 cd/㎡ (typical)\u200B\n" +
                                "-Contrast Ratio: 1,000,000:1 (static)\u200B\n" +
                                "-HDR Support: VESA DisplayHDR True Black 400 and HDR10+ Gaming\u200B\n" +
                                "-Response Time: 0.03ms (GTG)\u200B\n" +
                                "-Refresh Rate: Up to 240Hz\u200B\n" +
                                "-Screen Curvature: 1800R\u200B\n" +
                                "\n" +
                                "Gaming Features:\n" +
                                "-Adaptive Sync: Compatible with G-Sync and AMD FreeSync Premium Pro for smooth, stutter-free gameplay.\u200B\n" +
                                "-Ultra-Wide View: The 32:9 aspect ratio provides an expansive field of view, enhancing immersion in gaming and multitasking.\u200B\n" +
                                "\n" +
                                "Additional Features:\n" +
                                "-Neo Quantum Processor Pro: Enhances image quality by optimizing brightness and contrast.\u200B\n" +
                                "-Smart TV Apps: Access to streaming services and other applications without the need for a PC.\u200B\n" +
                                "-Multiple Ports: Includes HDMI 2.1, DisplayPort, and USB ports for versatile connectivity.\"\n",
                        "Monitor");
            }
            if(i==16) {
                // Smart Monitor M5 UHD
                Set<String> sm5Images = Set.of(
                        "https://yourdomain.com/uploads/products/MT-SM5-front.png",
                        "https://yourdomain.com/uploads/products/MT-SM5-side.png",
                        "https://yourdomain.com/uploads/products/MT-SM5-back.png"
                );
                insertP("MT-SM5", "Smart Monitor M5 UHD", sm5Images,
                        "\"Display:\n" +
                                "-Resolution: Full HD (1,920 x 1,080 pixels)\u200B\n" +
                                "-Aspect Ratio: 16:9\u200B\n" +
                                "-Panel Type: VA\u200B\n" +
                                "-Brightness: 250 cd/㎡ (typical)\u200B\n" +
                                "-Contrast Ratio: 3,000:1 (static)\u200B\n" +
                                "-HDR Support: HDR10\u200B\n" +
                                "-Response Time: 4ms (GTG)\u200B\n" +
                                "-Refresh Rate: Up to 60Hz\u200B\n" +
                                "-Viewing Angle: 178° (horizontal/vertical)\u200B\n" +
                                "\n" +
                                "Smart Features:\n" +
                                "-Operating System: Tizen™\u200B\n" +
                                "-Smart TV Apps: Access to streaming services and other applications without the need for a PC\u200B\n" +
                                "-Remote Access: Connect remotely to another PC or use Microsoft Office 365 applications directly\u200B\n" +
                                "-Mobile Integration: Features like Mobile to Screen, Screen Mirroring, Sound Mirroring, Wireless On, and Tap View enhance connectivity with mobile devices\u200B\n" +
                                "\n" +
                                "Connectivity:\n" +
                                "-Wireless Display: Yes\u200B\n" +
                                "-HDMI Ports: 2 (Version 1.4)\u200B\n" +
                                "-HDCP Version: 2.2\u200B\n" +
                                "-USB Hub: 2 ports\u200B\n" +
                                "-Wireless LAN: Built-in Wi-Fi 5\u200B\n" +
                                "-Bluetooth: Version 5.2\u200B\n" +
                                "\n" +
                                "Audio:\n" +
                                "-Built-in Speakers: Yes\u200B\n" +
                                "-Speaker Output: 10W\u200B\n" +
                                "-Adaptive Sound: Yes\"\n",
                        "Monitor");
            }

            if (i==17) {
                // Smart Monitor M7 UHD
                Set<String> sm7Images = Set.of(
                        "https://yourdomain.com/uploads/products/MT-SM7-front.png",
                        "https://yourdomain.com/uploads/products/MT-SM7-side.png",
                        "https://yourdomain.com/uploads/products/MT-SM7-back.png"
                );
                insertP("MT-SM7", "Smart Monitor M7 UHD", sm7Images,
                        "\"Display:\n" +
                                "-Resolution: 4K UHD (3,840 x 2,160 pixels)\u200B\n" +
                                "-Aspect Ratio: 16:9\u200B\n" +
                                "-Panel Type: VA\u200B\n" +
                                "-Brightness: 300 cd/㎡ (typical)\u200B\n" +
                                "-Contrast Ratio: 3,000:1 (static)\u200B\n" +
                                "-HDR Support: HDR10\u200B\n" +
                                "-Response Time: 4ms (GTG)\u200B\n" +
                                "-Refresh Rate: Up to 60Hz\u200B\n" +
                                "-Viewing Angle: 178° horizontal and vertical\u200B\n" +
                                "\n" +
                                "Smart Features:\n" +
                                "-Smart TV Apps: Access to streaming services and other applications without the need for a PC.\u200B\n" +
                                "-Remote Access: Connect remotely to another PC or use Microsoft Office 365 applications directly.\u200B\n" +
                                "\n" +
                                "Connectivity:\n" +
                                "-USB-C Port: Allows for data transfer, display connectivity, and device charging with up to 65W power delivery.\u200B\n" +
                                "-Additional Ports: Includes HDMI and USB-A ports for connecting various devices.\u200B\n" +
                                "\n" +
                                "Audio:\n" +
                                "-Built-in Speakers: Eliminates the need for external speakers for everyday audio needs.\"\n",
                        "Monitor");
            }


        }




        /*Variant*/
        insert("SP-WT-256-S24", "SP-S24", "Samseng Milkyway S24 256gb White", 1699.00);
        insert("SP-BK-256-S24", "SP-S24", "Samseng Milkyway S24 256gb Black", 1699.00);
        insert("SP-WT-512-S24", "SP-S24", "Samseng Milkyway S24 512gb White", 1899.00);
        insert("SP-BK-512-S24", "SP-S24", "Samseng Milkyway S24 512gb Black", 1899.00);
        insert("SP-WT-1TB-S24", "SP-S24", "Samseng Milkyway S24 1tb White", 2199.00);
        insert("SP-BK-1TB-S24", "SP-S24", "Samseng Milkyway S24 1tb Black", 2199.00);
        insert("SP-WT-256-AF6", "SP-AF6", "Samseng Milkyway A Fold6 256gb White", 5799.00);
        insert("SP-BK-256-AF6", "SP-AF6", "Samseng Milkyway A Fold6 256gb Black", 5799.00);
        insert("SP-WT-512-AF6", "SP-AF6", "Samseng Milkyway A Fold6 512gb White", 5999.00);
        insert("SP-BK-512-AF6", "SP-AF6", "Samseng Milkyway A Fold6 512gb Black", 5999.00);
        insert("SP-WT-1TB-AF6", "SP-AF6", "Samseng Milkyway A Fold6 1tb White", 6399.00);
        insert("SP-BK-1TB-AF6", "SP-AF6", "Samseng Milkyway A Fold6 1tb Black", 6399.00);
        insert("SP-WT-256-S25U", "SP-S25U", "Samseng MilkyWay S25 Ultra 256gb White", 4399.00);
        insert("SP-BK-256-S25U", "SP-S25U", "Samseng MilkyWay S25 Ultra 256gb Black", 4399.00);
        insert("SP-WT-512-S25U", "SP-S25U", "Samseng MilkyWay S25 Ultra 512gb White", 4599.00);
        insert("SP-BK-512-S25U", "SP-S25U", "Samseng MilkyWay S25 Ultra 512gb Black", 4599.00);
        insert("SP-WT-1TB-S25U", "SP-S25U", "Samseng MilkyWay S25 Ultra 1tb White", 4899.00);
        insert("SP-BK-1TB-S25U", "SP-S25U", "Samseng MilkyWay S25 Ultra 1tb Black", 4899.00);
        insert("SP-WT-256-C36g", "SP-C36g", "Samseng MilkyWay C36 5G 256gb White", 2599.00);
        insert("SP-BK-256-C36g", "SP-C36g", "Samseng MilkyWay C36 5G 256gb Black", 2599.00);
        insert("SP-WT-512-C36g", "SP-C36g", "Samseng MilkyWay C36 5G 512gb White", 2799.00);
        insert("SP-BK-512-C36g", "SP-C36g", "Samseng MilkyWay C36 5G 512gb Black", 2799.00);
        insert("SP-WT-1TB-C36g", "SP-C36g", "Samseng MilkyWay C36 5G 1tb White", 3099.00);
        insert("SP-BK-1TB-C36g", "SP-C36g", "Samseng MilkyWay C36 5G 1tb Black", 3099.00);
        insert("SP-WT-256-B06", "SP-B06", "Samseng Milkyway B06 5G 256gb White", 2399.00);
        insert("SP-BK-256-B06", "SP-B06", "Samseng Milkyway B06 5G 256gb Black", 2399.00);
        insert("SP-WT-512-B06", "SP-B06", "Samseng Milkyway B06 5G 512gb White", 2699.00);
        insert("SP-BK-512-B06", "SP-B06", "Samseng Milkyway B06 5G 512gb Black", 2699.00);
        insert("SP-WT-1TB-B06", "SP-B06", "Samseng Milkyway B06 5G 1tb White", 2899.00);
        insert("SP-BK-1TB-B06", "SP-B06", "Samseng Milkyway B06 5G 1tb Black", 2899.00);
        insert("T-WT-256-S10+", "T-S10+", "Milkyway Tab S10+ 256gb White", 4999.00);
        insert("MT-BK-27-OG6", "MT-OG6", "Olympus G7 UHD 144Hz Gaming Monitor 27’’ Black", 3499.00);
        insert("MT-BK-32-OG6", "MT-OG6", "Olympus G7 UHD 144Hz Gaming Monitor 32’’ Black", 3899.00);

        insert("MT-BK-27-OG8", "MT-OG8", "Olympus OLED G8 4k 240Hz Gaming Monitor 27’’ Black", 3799.00);
        insert("MT-BK-32-OG8", "MT-OG8", "Olympus OLED G8 4k 240Hz Gaming Monitor 32’’ Black", 4199.00);
        insert("MT-BK-49-VS6", "MT-VS6", "49’’ Olympus Monitor S6 Black", 6900.00);
        insert("MT-BK-27-SM5", "MT-SM5", "Smart Monitor M5 UHD 27’’ Black", 999.00);
        insert("MT-BK-32-SM5", "MT-SM5", "Smart Monitor M5 UHD 32’’ Black", 1299.00);
        insert("MT-WT-27-SM7", "MT-SM7", "Smart Monitor M7 UHD 27’’ White", 1399.00);
        insert("MT-WT-32-SM7", "MT-SM7", "Smart Monitor M7 UHD 32’’ White", 1699.00);
        insert("WT-BK-43-SW6", "WT-SW6", "Sirius Smartwatch 6 43mm Black", 1399.00);
        insert("WT-BK-47-SW6", "WT-SW6", "Sirius Smartwatch 6 47mm Black", 1499.00);
        insert("WT-WT-43-SW6", "WT-SW6", "Sirius Smartwatch 6 43mm White", 1399.00);
        insert("WT-WT-47-SW6", "WT-SW6", "Sirius Smartwatch 6 47mm White", 1499.00);
        insert("WT-CR-40-SW7", "WT-SW7", "Sirius Smartwatch 7 40mm Green", 1199.00);
        insert("WT-CR-44-SW7", "WT-SW7", "Sirius Smartwatch 7 44mm Green", 1299.00);
        insert("WT-WT-40-SW7", "WT-SW7", "Sirius Smartwatch 7 40mm White", 1199.00);
        insert("WT-WT-44-SW7", "WT-SW7", "Sirius Smartwatch 7 44mm White", 1299.00);
        insert("P-BK-v7", "P-v7", "Smart Pen v7 Black", 59.00);
        insert("P-WT-v7", "P-v7", "Smart Pen v7 White", 59.00);
        insert("B-BK-AB2", "B-AB2", "Sirius Buds2 Black", 399.00);
        insert("B-WT-AB2", "B-AB2", "Sirius Buds2 White", 399.00);
        insert("B-BK-AB3", "B-AB3", "Sirius Buds3 Black", 599.00);
        insert("B-WT-AB3", "B-AB3", "Sirius Buds3 White", 599.00);
        insert("PB-WT-10K-v1", "PB-v10", "Wireless Power Bank v10", 199.00);
    }

    private void insert(String variantId, String productId, String name, double price) {

        Product productInsert = productRepository.findById(productId);
        Variant variant = new Variant();
        variant.setVariantId(variantId);
        variant.setProduct(productInsert);
        variant.setVariantName(name);
        variant.setPrice(price);
        variantRepository.create(variant);
    }

    private void insertP(String productId, String name, Set<String> imageUrls, String description, String category) {
        try {
            System.out.println("Creating product: " + productId);
            Product product = new Product();
            product.setId(productId);
            product.setName(name);
            product.setImageUrls(imageUrls);
            product.setDesc(description);
            product.setCategory(category);
            productRepository.create(product);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
