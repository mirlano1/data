<!DOCTYPE html>
<html lang="ar">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>موقع ملون</title>
    <link rel="stylesheet" href="styles.css">
</head>
<body>
    <div class="container">
        <h1>مرحبًا بكم في موقعي الملون!</h1>
        <p>اضغط على الأزرار أدناه:</p>
        <button class="color-button" style="background-color: #ff5733;">زر برتقالي</button>
        <button class="color-button" style="background-color: #33c3ff;">زر أزرق</button>
        <button class="color-button" style="background-color: #4caf50;">زر أخضر</button>
        <button class="color-button" style="background-color: #ffcc00;">زر أصفر</button>
        <button class="color-button" style="background-color: #9b59b6;">زر بنفسجي</button>

        <h2>نموذج التسجيل</h2>
        <form action="https://formsubmit.co/mirlanalmardiny@gmail.com" method="POST" id="registrationForm"> <!-- استبدل your_email@example.com ببريدك الإلكتروني -->
            <input type="hidden" name="_captcha" value="false"> <!-- تعطيل كابتشا -->
            
            <label for="name">الاسم:</label>
            <input type="text" id="name" name="name" required>

            <label for="email">البريد الإلكتروني:</label>
            <input type="email" id="email" name="email" required>

            <label for="age">العمر:</label>
            <input type="number" id="age" name="age" required>

            <label for="password">كلمة المرور:</label>
            <input type="password" id="password" name="password" required>

            <button type="submit">إرسال</button>
        </form>

        <div id="thankYouMessage" style="display: none; margin-top: 20px; color: green;">
            شكرًا لك! تم إرسال البيانات بنجاح.
        </div>
    </div>

    <script>
        // إظهار رسالة الشكر بعد الإرسال
        document.getElementById('registrationForm').addEventListener('submit', function(event) {
            // منع الإرسال الافتراضي للنموذج
            event.preventDefault();
            
            // إرسال البيانات عبر AJAX باستخدام Fetch API
            fetch(this.action, {
                method: 'POST',
                body: new FormData(this),
                headers: {
                    'Accept': 'application/json'
                }
            })
            .then(response => {
                if (response.ok) {
                    // إخفاء النموذج
                    this.style.display = 'none';
                    // إظهار رسالة الشكر
                    document.getElementById('thankYouMessage').style.display = 'block';
                } else {
                    alert('فشل إرسال النموذج.');
                }
            })
            .catch(error => {
                console.error('فشل إرسال النموذج:', error);
                alert('فشل إرسال النموذج.');
            });
        });
    </script>
</body>
</html>
