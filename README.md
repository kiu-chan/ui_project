# Hướng dẫn bổ sung ngôn ngữ mới

Dự án này sử dụng hệ thống localization của Flutter để hỗ trợ đa ngôn ngữ. Dưới đây là các bước để thêm một ngôn ngữ mới vào ứng dụng:

## 1. Tạo file ARB mới

- Điều hướng đến thư mục `lib/l10n/` trong dự án.
- Tạo một file ARB mới với tên theo mẫu `app_<mã ngôn ngữ>.arb`.
  Ví dụ: `app_fr.arb` cho tiếng Pháp.

## 2. Thêm các chuỗi đã dịch

- Mở file ARB mới tạo.
- Thêm các chuỗi đã dịch theo định dạng JSON. Ví dụ:

```json
{
  "helloWorld": "Bonjour le monde",
  "helloWorld": "Bonjour le monde"
}
```
- Nhớ là ko để dấu ',' ở cuối

## 3. Tạo lại các file localization

- Mở file terminal gõ để tạo lại các file localization:

```yaml
  flutter gen-l10n
```

## 4. Cập nhật settings
- Vô settings cập nhật thêm lựa chọn mới
```dart
DropdownMenuItem(
    value: 'ja',
    child: Text(AppLocalizations.of(context)!.japanese),
),
```

## 6. Sử dụng trong code

Để sử dụng chuỗi đã dịch trong code:

```dart
Text(AppLocalizations.of(context)!.helloWorld)
```


## Lưu ý

- Đảm bảo rằng tất cả các chuỗi trong ứng dụng đều được dịch sang ngôn ngữ mới.
- Kiểm tra kỹ lưỡng để đảm bảo rằng bố cục UI không bị ảnh hưởng bởi độ dài của văn bản đã dịch.
- Cân nhắc sử dụng các công cụ dịch thuật hoặc dịch vụ chuyên nghiệp để đảm bảo chất lượng bản dịch.
