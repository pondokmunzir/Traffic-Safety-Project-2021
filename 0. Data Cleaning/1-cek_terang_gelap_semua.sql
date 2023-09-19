SELECT
  to_char(waktulokal,'HH24') jam, -- mengambil waktu hanya jam dengan format 24H
    CASE 
      -- menggabungan cahaya yang bukan terang dan gelap menjadi satu "Cahaya lain-lain"
      WHEN light_condition_name IN ('Dusk','Dawn','Reported as Unknown','Other','Not Reported') 
        THEN 'Cahaya lain-lain'
      -- menggabungkan kondisi langit gelap menjadi gelap
      WHEN light_condition_name IN ('Dark - Lighted','Dark - Not Lighted','Dark - Unknown Lighting') 
        THEN 'Gelap'
      ELSE light_condition_name
    END cahaya,
    CASE 
      --menggabungjan yang bukan clear, rain,cloudy, dan not reported menjadi cuaca lain-laon
      WHEN atmospheric_conditions_1_name IN ('Fog, Smog, Smoke','Snow','Reported as Unknown',
      'Severe Crosswinds','Freezing Rain or Drizzle','Blowing Snow','Sleet or Hail','Other',
      'Blowing Sand, Soil, Dirt') 
        THEN 'Cuaca Lain-lain'
      ELSE atmospheric_conditions_1_name
  END cuaca,
  COUNT(consecutive_number) jumlah_kecelakaan
FROM new_crash
GROUP BY jam,cahaya,cuaca

