From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Date: Wed, 11 Sep 2019 05:58:26 +0000
Subject: [PATCH] video: fbdev: fsl-diu-fb: mark expected switch fall-throughs
Message-Id: <20190911113604.GA31512@embeddedor>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Timur Tabi <timur@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, "Gustavo A. R. Silva" <gustavo@embeddedor.com>

Mark switch cases where we are expecting to fall through.

Fix the following warnings (Building: mpc512x_defconfig powerpc):

drivers/video/fbdev/fsl-diu-fb.c: In function ‘fsl_diu_ioctl’:
./include/linux/device.h:1750:2: warning: this statement may fall through [-Wimplicit-fallthrough=]
  _dev_warn(dev, dev_fmt(fmt), ##__VA_ARGS__)
  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/video/fbdev/fsl-diu-fb.c:1287:3: note: in expansion of macro ‘dev_warn’
   dev_warn(info->dev,
   ^~~~~~~~
drivers/video/fbdev/fsl-diu-fb.c:1290:2: note: here
  case MFB_SET_PIXFMT:
  ^~~~
In file included from ./include/linux/acpi.h:15:0,
                 from ./include/linux/i2c.h:13,
                 from ./include/uapi/linux/fb.h:6,
                 from ./include/linux/fb.h:6,
                 from drivers/video/fbdev/fsl-diu-fb.c:20:
./include/linux/device.h:1750:2: warning: this statement may fall through [-Wimplicit-fallthrough=]
  _dev_warn(dev, dev_fmt(fmt), ##__VA_ARGS__)
  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/video/fbdev/fsl-diu-fb.c:1296:3: note: in expansion of macro ‘dev_warn’
   dev_warn(info->dev,
   ^~~~~~~~
drivers/video/fbdev/fsl-diu-fb.c:1299:2: note: here
  case MFB_GET_PIXFMT:
  ^~~~

Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/video/fbdev/fsl-diu-fb.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/video/fbdev/fsl-diu-fb.c b/drivers/video/fbdev/fsl-diu-fb.c
index d19f58263b4e..3e410b9eb272 100644
--- a/drivers/video/fbdev/fsl-diu-fb.c
+++ b/drivers/video/fbdev/fsl-diu-fb.c
@@ -1287,6 +1287,7 @@ static int fsl_diu_ioctl(struct fb_info *info, unsigned int cmd,
 		dev_warn(info->dev,
 			 "MFB_SET_PIXFMT value of 0x%08x is deprecated.\n",
 			 MFB_SET_PIXFMT_OLD);
+		/* fall through */
 	case MFB_SET_PIXFMT:
 		if (copy_from_user(&pix_fmt, buf, sizeof(pix_fmt)))
 			return -EFAULT;
@@ -1296,6 +1297,7 @@ static int fsl_diu_ioctl(struct fb_info *info, unsigned int cmd,
 		dev_warn(info->dev,
 			 "MFB_GET_PIXFMT value of 0x%08x is deprecated.\n",
 			 MFB_GET_PIXFMT_OLD);
+		/* fall through */
 	case MFB_GET_PIXFMT:
 		pix_fmt = ad->pix_fmt;
 		if (copy_to_user(buf, &pix_fmt, sizeof(pix_fmt)))
-- 
2.23.0
