From: Bill Pemberton <wfp5p@virginia.edu>
Date: Mon, 19 Nov 2012 18:19:37 +0000
Subject: [PATCH 028/493] video: hpfb: remove use of __devexit_p
Message-Id: <1353349642-3677-28-git-send-email-wfp5p@virginia.edu>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

CONFIG_HOTPLUG is going away as an option so __devexit_p is no longer
needed, remove it.

Also fix the indentation for the initialization of the
hpfb_driver struct to make chkpatch happy.

Signed-off-by: Bill Pemberton <wfp5p@virginia.edu>
Cc: Florian Tobias Schandinat <FlorianSchandinat@gmx.de> 
Cc: linux-fbdev@vger.kernel.org 
---
 drivers/video/hpfb.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/video/hpfb.c b/drivers/video/hpfb.c
index 7324865..1f15523 100644
--- a/drivers/video/hpfb.c
+++ b/drivers/video/hpfb.c
@@ -370,10 +370,10 @@ static struct dio_device_id hpfb_dio_tbl[] = {
 };
 
 static struct dio_driver hpfb_driver = {
-    .name      = "hpfb",
-    .id_table  = hpfb_dio_tbl,
-    .probe     = hpfb_dio_probe,
-    .remove    = __devexit_p(hpfb_remove_one),
+	.name      = "hpfb",
+	.id_table  = hpfb_dio_tbl,
+	.probe     = hpfb_dio_probe,
+	.remove    = hpfb_remove_one,
 };
 
 int __init hpfb_init(void)
-- 
1.8.0

