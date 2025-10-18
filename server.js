// server.js
import express from "express";
import path from "path";
import mysql from "mysql2/promise";
import { fileURLToPath } from "url";

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

const app = express();
const PORT = process.env.PORT || 3000;

// Kết nối MySQL
const db = await mysql.createConnection({
  host: "localhost",
  user: "root",
  password: "12345",
  database: "classicmodels"
});

console.log("✅ Kết nối MySQL thành công!");

// Middleware
app.use(express.json());
app.use(express.static(path.join(__dirname, "public")));

// API: lấy danh sách sản phẩm từ bảng `products`
app.get("/api/products", async (req, res) => {
  try {
    const [rows] = await db.execute(
      "SELECT productCode, productName, productLine, buyPrice, MSRP, productDescription FROM products LIMIT 20"
    );
    res.json(rows);
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: "Lỗi truy vấn CSDL" });
  }
});

// Fallback SPA
app.use((req, res) => {
  res.sendFile(path.join(__dirname, "public", "index.html"));
});

app.listen(PORT, () =>
  console.log(`🚀 Server chạy tại http://localhost:${PORT}`)
);
