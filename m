From: Jingoo Han <jg1.han@samsung.com>
Date: Fri, 04 Jan 2013 08:29:11 +0000
Subject: [PATCH] backlight: check null deference of name when device is registered
Message-Id: <000b01cdea55$92725aa0$b7570fe0$%han@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: 'Andrew Morton' <akpm@linux-foundation.org>, 'LKML' <linux-kernel@vger.kernel.org>
Cc: linux-fbdev@vger.kernel.org, 'Richard Purdie' <rpurdie@rpsys.net>, 'Devendra Naga' <devendra.aaru@gmail.com>, 'Jingoo Han' <jg1.han@samsung.com>

NULL deference of name is checked when device is registered.
If the name is null, it will cause a kernel oops in dev_set_name().

Acked-by: Devendra Naga <devendra.aaru@gmail.com>
Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/video/backlight/backlight.c |    5 +++++
 drivers/video/backlight/lcd.c       |    5 +++++
 2 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/drivers/video/backlight/backlight.c b/drivers/video/backlight/backlight.c
index 345f666..f2db904 100644
--- a/drivers/video/backlight/backlight.c
+++ b/drivers/video/backlight/backlight.c
@@ -292,6 +292,11 @@ struct backlight_device *backlight_device_register(const char *name,
 	struct backlight_device *new_bd;
 	int rc;
 
+	if (name = NULL) {
+		pr_err("backlight name is null\n");
+		return ERR_PTR(-EINVAL);
+	}
+
 	pr_debug("backlight_device_register: name=%s\n", name);
 
 	new_bd = kzalloc(sizeof(struct backlight_device), GFP_KERNEL);
diff --git a/drivers/video/backlight/lcd.c b/drivers/video/backlight/lcd.c
index 34fb6bd..3d0ac0c 100644
--- a/drivers/video/backlight/lcd.c
+++ b/drivers/video/backlight/lcd.c
@@ -207,6 +207,11 @@ struct lcd_device *lcd_device_register(const char *name, struct device *parent,
 	struct lcd_device *new_ld;
 	int rc;
 
+	if (name = NULL) {
+		pr_err("lcd name is null\n");
+		return ERR_PTR(-EINVAL);
+	}
+
 	pr_debug("lcd_device_register: name=%s\n", name);
 
 	new_ld = kzalloc(sizeof(struct lcd_device), GFP_KERNEL);
-- 
1.7.2.5


