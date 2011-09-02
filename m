From: Manuel Lauss <manuel.lauss@googlemail.com>
Date: Fri, 02 Sep 2011 14:40:51 +0000
Subject: [PATCH 6/6] fbdev: au1200fb: silence debug output
Message-Id: <1314974451-8535-7-git-send-email-manuel.lauss@googlemail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

it's annoying and takes up way too much space in dmesg.

Signed-off-by: Manuel Lauss <manuel.lauss@googlemail.com>
---
 drivers/video/au1200fb.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/video/au1200fb.c b/drivers/video/au1200fb.c
index ed5dcdb2..a19a40e 100644
--- a/drivers/video/au1200fb.c
+++ b/drivers/video/au1200fb.c
@@ -49,7 +49,7 @@
 #define DRIVER_NAME "au1200fb"
 #define DRIVER_DESC "LCD controller driver for AU1200 processors"
 
-#define DEBUG 1
+#define DEBUG 0
 
 #define print_err(f, arg...) printk(KERN_ERR DRIVER_NAME ": " f "\n", ## arg)
 #define print_warn(f, arg...) printk(KERN_WARNING DRIVER_NAME ": " f "\n", ## arg)
-- 
1.7.6

