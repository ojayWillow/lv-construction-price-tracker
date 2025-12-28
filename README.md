# LV Construction Price Tracker

## Overview
A real-time price tracking system and database for construction materials across major Latvian retailers. This project monitors prices, availability, and discounts from the following stores:

- **Depo** (online.depo.lv)
- **K-Senukai** (ksenukai.lv)
- **Kurši** (kursi.lv)
- **Buvserviss** (buvserviss.lv)
- **Cenuklubs** (cenuklubs.lv)
- **Būvniecības ABC** (buvniecibas-abc.lv)
- **Bau24** (bau24.lv)
- **Krūza** (kruza.lv)
- **BMVīde** (bmvide.lv)
- **Jumtu Outlet** (jumtu-outlet.lv)

## Features
- 🔄 **Real-time price tracking** - Automated scraping of product prices
- 📊 **Price history** - Track price changes over time to identify true discounts
- 🏷️ **EAN/SKU mapping** - Unify products across different retailers using barcode data
- 📦 **Availability monitoring** - Track stock levels across stores
- 💰 **Volume pricing** - Detect bulk discounts (e.g., Depo's volume prices)
- 📈 **Price comparison** - Side-by-side comparison across all retailers
- 🔔 **Discount alerts** - Identify flash sales and limited-time offers

## Project Structure
```
lv-construction-price-tracker/
├── scrapers/          # Web scrapers for each store
├── database/          # Database schema and migrations
├── api/               # REST API for accessing price data
├── frontend/          # Web interface for price comparison
├── utils/             # Helper functions and utilities
├── config/            # Configuration files
└── tests/             # Unit and integration tests
```

## Database Schema

### Products Table
- `product_id` - Primary key
- `ean_code` - Unique barcode identifier
- `brand` - Product brand (Knauf, Sakret, etc.)
- `name` - Product name
- `category` - Product category
- `weight` - Package weight
- `unit` - Unit of measure

### Stores Table
- `store_id` - Primary key
- `store_name` - Retailer name
- `base_url` - Website URL
- `api_endpoint` - API endpoint (if available)

### Price_History Table
- `price_id` - Primary key
- `product_id` - Foreign key to Products
- `store_id` - Foreign key to Stores
- `current_price` - Latest scraped price
- `volume_price` - Bulk purchase price (optional)
- `is_discounted` - Boolean flag
- `is_available` - Stock availability
- `timestamp` - Update timestamp

## Technology Stack
- **Language**: Python 3.11+
- **Web Scraping**: Playwright / Selenium
- **Database**: PostgreSQL / SQLite
- **API**: FastAPI
- **Frontend**: React (TBD)
- **Data Storage**: Git LFS for large datasets

## Installation

```bash
# Clone the repository
git clone https://github.com/ojayWillow/lv-construction-price-tracker.git
cd lv-construction-price-tracker

# Create virtual environment
python -m venv venv
source venv/bin/activate  # On Windows: venv\Scripts\activate

# Install dependencies
pip install -r requirements.txt

# Set up database
python database/setup.py
```

## Usage

### Running Scrapers
```bash
# Run all scrapers
python scrapers/run_all.py

# Run specific store scraper
python scrapers/depo_scraper.py
```

### API Server
```bash
# Start the API server
uvicorn api.main:app --reload
```

### Query Examples
```python
# Get current price for Knauf Rotband 30kg across all stores
GET /api/products/4750614000014/prices

# Get price history for a product
GET /api/products/4750614000014/history

# Compare prices for a category
GET /api/compare?category=plaster
```

## Roadmap

- [ ] Set up initial database schema
- [ ] Implement scrapers for top 3 retailers (Depo, K-Senukai, Kurši)
- [ ] Create price history tracking system
- [ ] Build REST API for data access
- [ ] Add automated scraping scheduler
- [ ] Implement discount detection algorithm
- [ ] Create web dashboard for price comparison
- [ ] Add email/SMS alerts for price drops
- [ ] Support for professional contractor accounts
- [ ] Mobile app (future consideration)

## Contributing
Contributions are welcome! Please open an issue or submit a pull request.

## License
MIT License - see LICENSE file for details

## Disclaimer
This project is for educational and research purposes. Please respect the terms of service of all scraped websites. Consider using official APIs where available.
