-- LV Construction Price Tracker Database Schema
-- PostgreSQL / SQLite compatible

-- Products Table
CREATE TABLE IF NOT EXISTS products (
    product_id SERIAL PRIMARY KEY,
    ean_code VARCHAR(20) UNIQUE NOT NULL,
    brand VARCHAR(100) NOT NULL,
    name VARCHAR(255) NOT NULL,
    category VARCHAR(100),
    weight DECIMAL(10, 2),
    unit VARCHAR(20),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Stores Table
CREATE TABLE IF NOT EXISTS stores (
    store_id SERIAL PRIMARY KEY,
    store_name VARCHAR(100) UNIQUE NOT NULL,
    base_url VARCHAR(255) NOT NULL,
    api_endpoint VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Price History Table
CREATE TABLE IF NOT EXISTS price_history (
    price_id SERIAL PRIMARY KEY,
    product_id INTEGER NOT NULL,
    store_id INTEGER NOT NULL,
    current_price DECIMAL(10, 2) NOT NULL,
    volume_price DECIMAL(10, 2),
    is_discounted BOOLEAN DEFAULT FALSE,
    is_available BOOLEAN DEFAULT TRUE,
    stock_level INTEGER,
    timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (product_id) REFERENCES products(product_id) ON DELETE CASCADE,
    FOREIGN KEY (store_id) REFERENCES stores(store_id) ON DELETE CASCADE
);

-- Indexes for performance
CREATE INDEX idx_price_history_product ON price_history(product_id);
CREATE INDEX idx_price_history_store ON price_history(store_id);
CREATE INDEX idx_price_history_timestamp ON price_history(timestamp DESC);
CREATE INDEX idx_products_ean ON products(ean_code);
CREATE INDEX idx_products_category ON products(category);

-- Insert default stores
INSERT INTO stores (store_name, base_url) VALUES 
('Depo', 'https://online.depo.lv'),
('K-Senukai', 'https://www.ksenukai.lv'),
('Kursi', 'https://www.kursi.lv'),
('Buvserviss', 'https://www.buvserviss.lv'),
('Cenuklubs', 'https://cenuklubs.lv'),
('Buvniecibas ABC', 'https://buvniecibas-abc.lv'),
('Bau24', 'https://bau24.lv'),
('Kruza', 'https://kruza.lv'),
('BMVide', 'https://bmvide.lv'),
('Jumtu Outlet', 'https://jumtu-outlet.lv')
ON CONFLICT (store_name) DO NOTHING;
