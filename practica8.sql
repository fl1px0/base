-- Удаляем таблицы, если они существуют, чтобы избежать ошибок при повторном выполнении
DROP TABLE IF EXISTS Order_Items;
DROP TABLE IF EXISTS Orders;
DROP TABLE IF EXISTS Products;
DROP TABLE IF EXISTS Customers;

-- Создание таблицы Покупателей
CREATE TABLE Customers (
    customer_id SERIAL PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    registration_date DATE NOT NULL,
    recommended_by INT,
    FOREIGN KEY (recommended_by) REFERENCES Customers(customer_id)
);

-- Создание таблицы Товаров
CREATE TABLE Products (
    product_id SERIAL PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    category VARCHAR(50) NOT NULL,
    price DECIMAL(10, 2) NOT NULL
);

-- Создание таблицы Заказов
CREATE TABLE Orders (
    order_id SERIAL PRIMARY KEY,
    customer_id INT,
    order_date DATE NOT NULL,
    status VARCHAR(20) NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);

-- Создание таблицы Состава Заказа
CREATE TABLE Order_Items (
    order_item_id SERIAL PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT NOT NULL,
    price_per_unit DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES Orders(order_id),
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);

-- Наполнение таблиц данными
INSERT INTO Customers (customer_id, full_name, email, registration_date, recommended_by) VALUES
(1, 'Иван Иванов', 'ivan.ivanov@example.com', '2023-01-15', NULL),
(2, 'Мария Петрова', 'maria.petrova@example.com', '2023-02-20', 1),
(3, 'Алексей Смирнов', 'alex.smirnov@example.com', '2023-03-10', 1),
(4, 'Елена Васильева', 'elena.v@example.com', '2023-04-01', 2),
(5, 'Андрей Николаев', 'andrey.n@example.com', '2023-05-01', NULL);

INSERT INTO Products (product_name, category, price) VALUES
('Смартфон', 'Электроника', 70000.00),
('Ноутбук', 'Электроника', 120000.00),
('Кофемашина', 'Бытовая техника', 25000.00),
('Книга "Основы SQL"', 'Книги', 1500.00),
('Фен', 'Бытовая техника', 4500.00),
('Пылесос', 'Бытовая техника', 15000.00);

INSERT INTO Orders (customer_id, order_date, status) VALUES
(1, '2024-05-10', 'Доставлен'),
(2, '2024-05-12', 'В обработке'),
(1, '2024-05-15', 'Отправлен'),
(3, '2024-05-16', 'Доставлен');

INSERT INTO Order_Items (order_id, product_id, quantity, price_per_unit) VALUES
(1, 1, 1, 70000.00),  -- Иван купил Смартфон
(1, 4, 2, 1400.00),   -- и 2 книги
(2, 2, 1, 120000.00), -- Мария купила Ноутбук
(3, 3, 1, 25000.00),  -- Иван купил Кофемашину
(4, 1, 1, 70000.00),  -- Алексей купил Смартфон
(4, 5, 1, 4500.00);   -- и Фен


SELECT
    c.full_name
    o.order_date
FROM Customers c 
Join Orders o ON c.customer_id = o.customer_id

SELECT
     c.full_name
FROM customers c
Left Join orders o on c.customer_id = o.customer_id
WHERE o.order_id is NULL

SELECT
     p.product_name
     oi.quantity
     oi.price_per_unit
FROM order_items oi 
JOIN products p ON p.product_id = oi.product_id
WHERE oi.order_id = 1

SELECT
     c.full_name
     p.product_name
FROM c.customers
JOIN p.products on

SELECT
    full_name
FROM Customers
WHERE customer_id IN (
    SELECT o.customer_id
    FROM Orders o
    JOIN OrderItems oi ON o.order_id = oi.order_id
    JOIN Products p ON p.product_id = oi.product_id
    WHERE p.product_name = 'Смартфон'
);

SELECT product_name
FROM products
WHERE price > (SELECT AVG(price) from products)

SELECT order_id, order_date
from Orders
WHERE EXISTS (
    SELECT 1
    FROM Order_Items oi
    Join Products p on oi.product_id = p. product_id
    Where oi.order_id = o.order_id and p.price > 100000
);

SELECT DISTINCT c.full_name
from Customers c
Left join Orders o on c.customer_id = o.customer_id
Left join Order_Items oi on o.order_id = oi.order_id
Left join Products p on p.product_id = oi.product_id
WHERE product_name = "Ноутбук" and product_id is null; 

SELECT full_name
FROM Customers
WHERE customer_id not in (
    SELECT o.customer_id
    FROM orders o
    Join order_items oi on o.order_id = oi.order_id
    Join products p on oi.product_id = p.product_id
    WHERE p.product_name = "Ноутбук"
);

Select p.product_name
from Products p
Left join order_items oi on p.product_id = oi.product_id
Where oi.order_id is null

SELECT c.full_name, p.product_name, o.order_date
FROM customers c
FULL OUTER JOIN orders o on c.customer_id = o.customer_id
FULL OUTER JOIN order_items oi ON o.order_id = oi.order_id
FULL OUTER JOIN products p ON p.product_id = oi.product_id

SELECT DISTINCT c.full_name
FROM Customers c
JOIN Orders o ON c.customer_id = o.customer_id
JOIN OrderItems oi ON o.order_id = oi.order_id
JOIN Products p ON p.product_id = oi.product_id
WHERE p.price = (SELECT MAX(price) FROM Products);

SELECT full_name
FROM Customers
WHERE customer_id IN (
    SELECT o.customer_id
    FROM Orders o
    WHERE o.order_id IN (
        SELECT order_id
        FROM OrderItems
        WHERE product_id IN (
            SELECT product_id
            FROM Products
            WHERE price = (SELECT MAX(price) FROM Products)
        )
    )
);

SELECT c.full_name,
p.category
from customers c
CROSS JOIN products p;

SELECT
    recommender.full_name AS recommended_by,
    customer.full_name AS new_customer
FROM Customers customer
JOIN Customers recommender ON customer.recommended_by = recommender.customer_id