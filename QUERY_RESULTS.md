# Expected Query Results

These results were calculated from the current CSV files in this repository. Large result sets are summarized with row counts and sample rows; run `SOLUTIONS.sql` in DBeaver for the complete grids.

## Data Load Check

| Table | Row count |
| --- | ---: |
| `TARIFFS` | 4 |
| `CUSTOMERS` | 10000 |
| `MONTHLY_STATS` | 9950 |

## 1.1 Kobiye Destek Customers

Row count: `2483`

| CUSTOMER_ID | NAME | CITY | SIGNUP_DATE |
| ---: | --- | --- | --- |
| 15 | Fatih | MUŞ | 27/10/2025 |
| 33 | Fadime | KAYSERİ | 19/11/2025 |
| 34 | Recep | BİLECİK | 09/04/2025 |
| 35 | Özlem | EDİRNE | 02/09/2025 |
| 44 | Hasan | BOLU | 25/02/2026 |
| 45 | Süleyman | KIRIKKALE | 14/12/2025 |
| 49 | Esra | BİNGÖL | 07/12/2025 |
| 54 | Burak | DÜZCE | 13/09/2025 |
| 55 | Ramazan | UŞAK | 12/08/2025 |
| 61 | Fatma | MERSİN | 28/04/2025 |
| 62 | Hakan | ZONGULDAK | 09/11/2025 |
| 63 | Hülya | ARDAHAN | 09/12/2025 |

## 1.2 Newest Kobiye Destek Customers

Newest signup date: `05/04/2026`

| CUSTOMER_ID | NAME | CITY | SIGNUP_DATE |
| ---: | --- | --- | --- |
| 84 | Hakan | EDİRNE | 05/04/2026 |
| 247 | Meryem | KAHRAMANMARAŞ | 05/04/2026 |
| 5145 | Ömer | ŞANLIURFA | 05/04/2026 |
| 5854 | Ramazan | KARS | 05/04/2026 |
| 7156 | Süleyman | MERSİN | 05/04/2026 |
| 8164 | Yusuf | SİNOP | 05/04/2026 |
| 8295 | Ömer | AFYONKARAHİSAR | 05/04/2026 |

## 2.1 Tariff Distribution

| TARIFF_ID | TARIFF_NAME | CUSTOMER_COUNT | CUSTOMER_PERCENTAGE |
| ---: | --- | ---: | ---: |
| 1 | Genç Dinamik | 2527 | 25.27 |
| 2 | Kurumsal SMS | 2577 | 25.77 |
| 3 | Çalışan GB | 2413 | 24.13 |
| 4 | Kobiye Destek | 2483 | 24.83 |

## 3.1 Earliest Customers

Earliest signup date: `07/04/2025`

Row count: `35`

## 3.2 Earliest Customer City Distribution

| CITY | CUSTOMER_COUNT |
| --- | ---: |
| ADIYAMAN | 1 |
| AFYONKARAHİSAR | 1 |
| AĞRI | 1 |
| ANKARA | 1 |
| ANTALYA | 2 |
| AYDIN | 1 |
| BİTLİS | 1 |
| BURSA | 1 |
| ÇANKIRI | 1 |
| GAZİANTEP | 2 |
| HAKKARİ | 1 |
| HATAY | 1 |
| ISPARTA | 1 |
| İSTANBUL | 1 |
| KAHRAMANMARAŞ | 1 |
| KARABÜK | 1 |
| KAYSERİ | 1 |
| KIRIKKALE | 1 |
| KIRKLARELİ | 1 |
| KIRŞEHİR | 1 |
| KONYA | 1 |
| NİĞDE | 1 |
| ORDU | 1 |
| SAKARYA | 2 |
| SAMSUN | 1 |
| SİNOP | 1 |
| ŞIRNAK | 2 |
| YALOVA | 1 |
| YOZGAT | 2 |
| ZONGULDAK | 1 |

## 4.1 Missing Monthly Records

Row count: `50`

Missing customer IDs:

```text
6, 10, 31, 39, 45, 81, 116, 136, 140, 156,
205, 211, 218, 221, 229, 233, 301, 326, 329, 343,
413, 449, 458, 463, 467, 507, 526, 533, 534, 543,
577, 583, 596, 604, 616, 617, 678, 783, 788, 819,
842, 869, 885, 889, 903, 905, 930, 935, 953, 988
```

## 4.2 Missing Customer City Distribution

| CITY | MISSING_CUSTOMER_COUNT |
| --- | ---: |
| ADANA | 1 |
| AĞRI | 1 |
| ANTALYA | 1 |
| ARDAHAN | 1 |
| BİTLİS | 2 |
| BURDUR | 1 |
| BURSA | 1 |
| ÇANKIRI | 1 |
| DENİZLİ | 2 |
| DÜZCE | 1 |
| ERZURUM | 1 |
| ESKİŞEHİR | 1 |
| GAZİANTEP | 1 |
| GİRESUN | 1 |
| GÜMÜŞHANE | 1 |
| HATAY | 1 |
| İZMİR | 2 |
| KARABÜK | 1 |
| KARAMAN | 1 |
| KAYSERİ | 2 |
| KIRIKKALE | 2 |
| KIRKLARELİ | 1 |
| KIRŞEHİR | 1 |
| KOCAELİ | 1 |
| KONYA | 1 |
| MANİSA | 1 |
| MARDİN | 1 |
| MUŞ | 2 |
| NEVŞEHİR | 2 |
| NİĞDE | 1 |
| ORDU | 2 |
| OSMANİYE | 3 |
| SAKARYA | 1 |
| SAMSUN | 1 |
| SİİRT | 1 |
| ŞIRNAK | 1 |
| SİVAS | 2 |
| TEKİRDAĞ | 1 |
| YALOVA | 1 |

## 5.1 Customers Using At Least 75 Percent of Data Limit

Row count: `1880`

| CUSTOMER_ID | NAME | CITY | TARIFF_NAME | DATA_USAGE | DATA_LIMIT | DATA_USAGE_PERCENTAGE |
| ---: | --- | --- | --- | ---: | ---: | ---: |
| 1 | Emine | AĞRI | Çalışan GB | 18420.61 | 20480 | 89.94 |
| 4 | Ömer | KAHRAMANMARAŞ | Genç Dinamik | 7879.83 | 10240 | 76.95 |
| 28 | Büşra | ÇORUM | Genç Dinamik | 9603.74 | 10240 | 93.79 |
| 30 | Yasin | DÜZCE | Çalışan GB | 19378.38 | 20480 | 94.62 |
| 38 | Adem | BOLU | Genç Dinamik | 8786.73 | 10240 | 85.81 |
| 40 | Murat | KÜTAHYA | Genç Dinamik | 8899.47 | 10240 | 86.91 |
| 42 | Yusuf | ANKARA | Genç Dinamik | 9075.72 | 10240 | 88.63 |
| 43 | Hülya | MALATYA | Çalışan GB | 18680.21 | 20480 | 91.21 |
| 46 | Aynur | AFYONKARAHİSAR | Çalışan GB | 19836.26 | 20480 | 96.86 |
| 53 | Sultan | HAKKARİ | Genç Dinamik | 7716.97 | 10240 | 75.36 |

## 5.2 Customers Exhausting All Package Limits

Row count: `0`

## 6.1 Customers with Unpaid Fees

Row count: `1454`

| CUSTOMER_ID | NAME | CITY | TARIFF_NAME | PAYMENT_STATUS |
| ---: | --- | --- | --- | --- |
| 19 | Enes | KAYSERİ | Kurumsal SMS | UNPAID |
| 20 | İsmail | YOZGAT | Çalışan GB | UNPAID |
| 22 | Rabia | BOLU | Kurumsal SMS | UNPAID |
| 25 | Hacer | NİĞDE | Genç Dinamik | UNPAID |
| 33 | Fadime | KAYSERİ | Kobiye Destek | UNPAID |
| 36 | Fadime | DİYARBAKIR | Genç Dinamik | UNPAID |
| 40 | Murat | KÜTAHYA | Genç Dinamik | UNPAID |
| 48 | Yusuf | SİİRT | Kurumsal SMS | UNPAID |
| 54 | Burak | DÜZCE | Kobiye Destek | UNPAID |
| 57 | Fadime | ORDU | Çalışan GB | UNPAID |

## 6.2 Payment Status Distribution by Tariff

| TARIFF_ID | TARIFF_NAME | PAYMENT_STATUS | CUSTOMER_COUNT |
| ---: | --- | --- | ---: |
| 1 | Genç Dinamik | LATE | 372 |
| 1 | Genç Dinamik | PAID | 1792 |
| 1 | Genç Dinamik | UNPAID | 352 |
| 2 | Kurumsal SMS | LATE | 368 |
| 2 | Kurumsal SMS | PAID | 1796 |
| 2 | Kurumsal SMS | UNPAID | 403 |
| 3 | Çalışan GB | LATE | 365 |
| 3 | Çalışan GB | PAID | 1692 |
| 3 | Çalışan GB | UNPAID | 339 |
| 4 | Kobiye Destek | LATE | 392 |
| 4 | Kobiye Destek | PAID | 1719 |
| 4 | Kobiye Destek | UNPAID | 360 |
