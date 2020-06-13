From: Paul Menzel <pmenzel@molgen.mpg.de>
Date: Sat, 13 Jun 2020 08:13:46 +0000
Subject: [PATCH] efifb: BGRT: Fix typo in *deferred* in comment
Message-Id: <20200613081346.4532-1-pmenzel@molgen.mpg.de>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Cc: linux-fbdev@vger.kernel.org
Cc: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Paul Menzel <pmenzel@molgen.mpg.de>
---
 drivers/video/fbdev/efifb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/efifb.c b/drivers/video/fbdev/efifb.c
index 65491ae74808..42b4facc5e2b 100644
--- a/drivers/video/fbdev/efifb.c
+++ b/drivers/video/fbdev/efifb.c
@@ -91,7 +91,7 @@ static int efifb_setcolreg(unsigned regno, unsigned red, unsigned green,
 }
 
 /*
- * If fbcon deffered console takeover is configured, the intent is for the
+ * If fbcon deferred console takeover is configured, the intent is for the
  * framebuffer to show the boot graphics (e.g. vendor logo) until there is some
  * (error) message to display. But the boot graphics may have been destroyed by
  * e.g. option ROM output, detect this and restore the boot graphics.
-- 
2.27.0
