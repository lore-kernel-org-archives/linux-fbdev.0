From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Fri, 02 Mar 2012 06:56:21 +0000
Subject: [patch] backlight: s6e63m0: corruption storing gamma mode
Message-Id: <20120302065620.GC24508@elgon.mountain>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

strict_strtoul() writes a long but ->gamma_mode only has space to store
an int, so on 64 bit systems we end up scribbling over
->gamma_table_count as well.  I've changed it to use kstrtouint()
instead.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/drivers/video/backlight/s6e63m0.c b/drivers/video/backlight/s6e63m0.c
index 9b0092e..e264f55 100644
--- a/drivers/video/backlight/s6e63m0.c
+++ b/drivers/video/backlight/s6e63m0.c
@@ -690,7 +690,7 @@ static ssize_t s6e63m0_sysfs_store_gamma_mode(struct device *dev,
 	struct backlight_device *bd = NULL;
 	int brightness, rc;
 
-	rc = strict_strtoul(buf, 0, (unsigned long *)&lcd->gamma_mode);
+	rc = kstrtouint(buf, 0, &lcd->gamma_mode);
 	if (rc < 0)
 		return rc;
 
