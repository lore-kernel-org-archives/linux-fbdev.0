From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Thu, 24 Jan 2013 07:05:24 +0000
Subject: [patch] backlight: s6e63m0: report ->gamma_table_count correctly
Message-Id: <20130124070524.GD5611@elgon.mountain>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

gamma_table has 3 arrays which each hold MAX_GAMMA_LEVEL pointers to
int.

The current code sets ->gamma_table_count to 6 on 64bit arches and to 3
on 32 bit arches.  It should be 3 on everything.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
This is from reading the code.  We use ->gamma_table_count in sysfs file
but other than that I'm not sure what it's for.  I am not very familiar
with this code.

diff --git a/drivers/video/backlight/s6e63m0.c b/drivers/video/backlight/s6e63m0.c
index 2126b96..9c2677f 100644
--- a/drivers/video/backlight/s6e63m0.c
+++ b/drivers/video/backlight/s6e63m0.c
@@ -766,7 +766,7 @@ static int s6e63m0_probe(struct spi_device *spi)
 	 * know that.
 	 */
 	lcd->gamma_table_count -	    sizeof(gamma_table) / (MAX_GAMMA_LEVEL * sizeof(int));
+	    sizeof(gamma_table) / (MAX_GAMMA_LEVEL * sizeof(int *));
 
 	ret = device_create_file(&(spi->dev), &dev_attr_gamma_mode);
 	if (ret < 0)
