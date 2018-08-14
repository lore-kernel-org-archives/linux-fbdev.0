From: <michael.hennerich@analog.com>
Date: Tue, 14 Aug 2018 11:28:20 +0000
Subject: [PATCH 3/7] drivers: video: backlight: Update MODULE AUTHOR email address
Message-Id: <1534246100-816-1-git-send-email-michael.hennerich@analog.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

From: Michael Hennerich <michael.hennerich@analog.com>

No functional changes

Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
---
 drivers/video/backlight/adp5520_bl.c | 2 +-
 drivers/video/backlight/adp8860_bl.c | 2 +-
 drivers/video/backlight/adp8870_bl.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/video/backlight/adp5520_bl.c b/drivers/video/backlight/adp5520_bl.c
index 35373e2..5e38353 100644
--- a/drivers/video/backlight/adp5520_bl.c
+++ b/drivers/video/backlight/adp5520_bl.c
@@ -391,7 +391,7 @@ static struct platform_driver adp5520_bl_driver = {
 
 module_platform_driver(adp5520_bl_driver);
 
-MODULE_AUTHOR("Michael Hennerich <hennerich@blackfin.uclinux.org>");
+MODULE_AUTHOR("Michael Hennerich <michael.hennerich@analog.com>");
 MODULE_DESCRIPTION("ADP5520(01) Backlight Driver");
 MODULE_LICENSE("GPL");
 MODULE_ALIAS("platform:adp5520-backlight");
diff --git a/drivers/video/backlight/adp8860_bl.c b/drivers/video/backlight/adp8860_bl.c
index 16119bd..f48fafb 100644
--- a/drivers/video/backlight/adp8860_bl.c
+++ b/drivers/video/backlight/adp8860_bl.c
@@ -821,5 +821,5 @@ static struct i2c_driver adp8860_driver = {
 module_i2c_driver(adp8860_driver);
 
 MODULE_LICENSE("GPL v2");
-MODULE_AUTHOR("Michael Hennerich <hennerich@blackfin.uclinux.org>");
+MODULE_AUTHOR("Michael Hennerich <michael.hennerich@analog.com>");
 MODULE_DESCRIPTION("ADP8860 Backlight driver");
diff --git a/drivers/video/backlight/adp8870_bl.c b/drivers/video/backlight/adp8870_bl.c
index 4fec9aa..8d50e02 100644
--- a/drivers/video/backlight/adp8870_bl.c
+++ b/drivers/video/backlight/adp8870_bl.c
@@ -992,5 +992,5 @@ static struct i2c_driver adp8870_driver = {
 module_i2c_driver(adp8870_driver);
 
 MODULE_LICENSE("GPL v2");
-MODULE_AUTHOR("Michael Hennerich <hennerich@blackfin.uclinux.org>");
+MODULE_AUTHOR("Michael Hennerich <michael.hennerich@analog.com>");
 MODULE_DESCRIPTION("ADP8870 Backlight driver");
-- 
2.7.4
