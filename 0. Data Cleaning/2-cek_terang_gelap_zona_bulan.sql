SELECT
  to_char(waktulokal,'HH24') jam, --ambil jam dari waktu lokal dengan format 24H
  COUNT(consecutive_number) jumlah_kejadian, 
  CASE
    -- +interval '-5 hours'
    WHEN state_name IN ('Connecticut','District of Columbia','Delaware','Florida','Georgia','Indiana','Kentucky','Maine','Maryland','Massachusetts',
      'Michigan','New Hampshire','New Jersey','New York','North Carolina','Ohio','Pennsylvania','Rhode Island','South Carolina','Tennessee',
      'Vermont','Virginia','West Virginia')
      THEN 'EST'
    -- + interval '-6 Hours'
    WHEN state_name IN ( 'Alabama','Arkansas','Florida','Illinois','Indiana','Iowa','Kansas','Kentucky','Louisiana','Michigan',
      'Minnesota','Mississippi','Missouri','Nebraska','N.Dakota', 'Oklahoma','South Dakota','Tennessee','Texas','Wisconsin')
      THEN 'CST'
      --+ interval '-7 Hours'
    WHEN state_name IN ('Arizona','Arizona','Colorado','Idaho','Kansas','Montana','Nebraska','New Mexico',
      'North Dakota','Oregon','South Dakota','Texas','Utah','Wyoming')
      THEN 'MST'
    -- + interval '-8 Hours' '
    WHEN state_name IN ('California','Idaho','Nevada','Oregon','Washington')
      THEN 'PST'
    --+ interval '-9 Hours'
    WHEN state_name IN ('Alaska')
      THEN  'AKST'
    -- + interval '-10 Hours'
    WHEN state_name IN ('Hawaii')
      THEN 'HST'
  END zona,
  CASE 
    WHEN light_condition_name IN ('Dusk','Dawn','Reported as Unknown','Not Reported','Other') THEN 'Cahaya lain-lain'
    WHEN light_condition_name IN ('Dark - Lighted','Dark - Not Lighted','Dark - Unknown Lighting') THEN 'Gelap'
    ELSE light_condition_name
  END cahaya,
  to_char(waktulokal,'MM') angka_bulan

FROM new_crash
Where atmospheric_conditions_1_name = 'Clear'
GROUP BY jam,zona,cahaya,angka_bulan
order by jam, zona
