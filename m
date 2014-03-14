From: Alexander Shiyan <shc_work@mail.ru>
Date: Fri, 14 Mar 2014 11:09:13 +0000
Subject: [PATCH v2] lcd: Provide dummy functions if CONFIG_LCD_CLASS_DEVICE is not set
Message-Id: <1394795353-1931-1-git-send-email-shc_work@mail.ru>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Provide dummy functions for LCD register()/unregister() if
CONFIG_LCD_CLASS_DEVICE is not set.
This allows us to use the LCD class as an optional.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 include/linux/lcd.h | 37 ++++++++++++++++++++++++++++++-------
 1 file changed, 30 insertions(+), 7 deletions(-)

diff --git a/include/linux/lcd.h b/include/linux/lcd.h
index 504f624..39c41c7 100644
--- a/include/linux/lcd.h
+++ b/include/linux/lcd.h
@@ -110,14 +110,37 @@ static inline void lcd_set_power(struct lcd_device *ld, int power)
 	mutex_unlock(&ld->update_lock);
 }
 
-extern struct lcd_device *lcd_device_register(const char *name,
-	struct device *parent, void *devdata, struct lcd_ops *ops);
-extern struct lcd_device *devm_lcd_device_register(struct device *dev,
-	const char *name, struct device *parent,
+#if defined(CONFIG_LCD_CLASS_DEVICE) || defined(CONFIG_LCD_CLASS_DEVICE_MODULE)
+struct lcd_device *lcd_device_register(const char *name, struct device *parent,
 	void *devdata, struct lcd_ops *ops);
-extern void lcd_device_unregister(struct lcd_device *ld);
-extern void devm_lcd_device_unregister(struct device *dev,
-	struct lcd_device *ld);
+struct lcd_device *devm_lcd_device_register(struct device *dev,
+	const char *name, struct device *parent, void *devdata,
+	struct lcd_ops *ops);
+void lcd_device_unregister(struct lcd_device *ld);
+void devm_lcd_device_unregister(struct device *dev, struct lcd_device *ld);
+#else
+static inline struct lcd_device *lcd_device_register(const char *name,
+	struct device *parent, void *devdata, struct lcd_ops *ops)
+{
+	return NULL;
+}
+
+static inline struct lcd_device *devm_lcd_device_register(struct device *dev,
+	const char *name, struct device *parent, void *devdata,
+	struct lcd_ops *ops)
+{
+	return NULL;
+}
+
+static inline void lcd_device_unregister(struct lcd_device *ld)
+{
+}
+
+static inline void devm_lcd_device_unregister(struct device *dev,
+	struct lcd_device *ld)
+{
+}
+#endif
 
 #define to_lcd_device(obj) container_of(obj, struct lcd_device, dev)
 
-- 
1.8.3.2

