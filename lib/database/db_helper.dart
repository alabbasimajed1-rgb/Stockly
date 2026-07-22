import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  // إنشاء نسخة واحدة من قاعدة البيانات (Singleton) لضمان عدم استهلاك الذاكرة
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  factory DatabaseHelper() => _instance;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    // تحديد مسار حفظ ملف قاعدة البيانات داخل الهاتف
    String path = join(await getDatabasesPath(), 'stockly_database.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  // إنشاء الجداول عند فتح التطبيق لأول مرة
  Future<void> _onCreate(Database db, int version) async {
    // 1. جدول الفئات
    await db.execute('''
      CREATE TABLE categories(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name_ar TEXT NOT NULL,
        name_en TEXT NOT NULL,
        icon_path TEXT NOT NULL
      )
    ''');

    // 2. جدول الأصناف (مرتبط بجدول الفئات)
    await db.execute('''
      CREATE TABLE items(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        category_id INTEGER NOT NULL,
        name_ar TEXT NOT NULL,
        name_en TEXT NOT NULL,
        barcode TEXT NOT NULL,
        image_path TEXT,
        min_qty_alert INTEGER NOT NULL,
        expiry_months_alert INTEGER NOT NULL,
        FOREIGN KEY (category_id) REFERENCES categories (id) ON DELETE CASCADE
      )
    ''');

    // 3. جدول الدفعات (مرتبط بجدول الأصناف)
    await db.execute('''
      CREATE TABLE batches(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        item_id INTEGER NOT NULL,
        quantity REAL NOT NULL,
        expire_date TEXT NOT NULL,
        is_active INTEGER NOT NULL DEFAULT 1,
        FOREIGN KEY (item_id) REFERENCES items (id) ON DELETE CASCADE
      )
    ''');

    // 4. جدول الفعاليات/السجل (مرتبط بجدول الأصناف)
    await db.execute('''
      CREATE TABLE activities(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        transaction_type TEXT NOT NULL,
        item_id INTEGER NOT NULL,
        quantity_changed REAL NOT NULL,
        transaction_date TEXT NOT NULL,
        note TEXT,
        FOREIGN KEY (item_id) REFERENCES items (id) ON DELETE CASCADE
      )
    ''');
  }
}