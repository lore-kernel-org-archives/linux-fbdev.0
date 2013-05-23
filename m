From: Alexandre Courbot <acourbot@nvidia.com>
Date: Thu, 23 May 2013 08:03:51 +0000
Subject: [PATCH] video: simplefb: add mode parsing function
Message-Id: <1369296231-26597-1-git-send-email-acourbot@nvidia.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Cc: gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Alexandre Courbot <acourbot-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org

The naming scheme of simplefb's mode is precise enough to allow building
the mode structure from it instead of using a static list of modes. This
patch introduces a function that does this. In case exotic modes that
cannot be represented from their name alone are needed, the static list
of modes is still available as a backup.

Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
---
Stephen, please note that the "r5g6b5" mode initially supported
by the driver becomes "b5g6r5" with the new function. This is because
the least significant bits are defined first in the string - this
makes parsing much easier, notably for modes which do not fill whole
bytes (e.g. 15 bit modes). I hope this is not a problem - it's probably
better to do the change now while the driver is still new.

 .../bindings/video/simple-framebuffer.txt          | 12 +++-
 drivers/video/simplefb.c                           | 66 +++++++++++++++++++++-
 2 files changed, 73 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/video/simple-framebuffer.txt b/Documentation/devicetree/bindings/video/simple-framebuffer.txt
index 3ea4605..f933b3d 100644
--- a/Documentation/devicetree/bindings/video/simple-framebuffer.txt
+++ b/Documentation/devicetree/bindings/video/simple-framebuffer.txt
@@ -10,8 +10,16 @@ Required properties:
 - width: The width of the framebuffer in pixels.
 - height: The height of the framebuffer in pixels.
 - stride: The number of bytes in each line of the framebuffer.
-- format: The format of the framebuffer surface. Valid values are:
-  - r5g6b5 (16-bit pixels, d[15:11]=r, d[10:5]=g, d[4:0]=b).
+- format: The format of the framebuffer surface. Described as a sequence of
+	channel/nbbits pairs, where each pair describes how many bits are used
+	by a given color channel. Value channels are "r" (red), "g" (green),
+	"b" (blue) and "a" (alpha). Channels are listed starting in
+	bit-significance order. For instance, a format named "r5g6b5" describes
+	a 16-bit format where red is encoded in the 5 less significant bits,
+	green in the 6 following ones, and blue in the 5 last:
+				BBBBBGGG GGGRRRRR
+				^               ^
+			       MSB             LSB
 
 Example:
 
diff --git a/drivers/video/simplefb.c b/drivers/video/simplefb.c
index 8105c3d..1a1be71 100644
--- a/drivers/video/simplefb.c
+++ b/drivers/video/simplefb.c
@@ -21,6 +21,7 @@
  */
 
 #include <linux/errno.h>
+#include <linux/ctype.h>
 #include <linux/fb.h>
 #include <linux/io.h>
 #include <linux/module.h>
@@ -82,8 +83,64 @@ struct simplefb_format {
 	struct fb_bitfield transp;
 };
 
-struct simplefb_format simplefb_formats[] = {
-	{ "r5g6b5", 16, {11, 5}, {5, 6}, {0, 5}, {0, 0} },
+static struct simplefb_format *simplefb_parse_format(struct device *dev,
+						     const char *str)
+{
+	struct simplefb_format *format;
+	unsigned int cpt = 0;
+	unsigned int i = 0;
+
+	format = devm_kzalloc(dev, sizeof(*format), GFP_KERNEL);
+	if (!format)
+		return ERR_PTR(-ENOMEM);
+
+	while (str[i] != 0) {
+		struct fb_bitfield *field = 0;
+		char c = str[i++];
+
+		switch (c) {
+		case 'r':
+		case 'R':
+			field = &format->red;
+			break;
+		case 'g':
+		case 'G':
+			field = &format->green;
+			break;
+		case 'b':
+		case 'B':
+			field = &format->blue;
+			break;
+		case 'a':
+		case 'A':
+			field = &format->transp;
+			break;
+		default:
+			goto error;
+		}
+
+		c = str[i++];
+		if (c = 0 || !isdigit(c))
+			goto error;
+
+		field->offset = cpt;
+		field->length = c - '0';
+
+		cpt += field->length;
+	}
+
+	format->bits_per_pixel = ((cpt + 7) / 8) * 8;
+	format->name = str;
+	return format;
+
+error:
+	dev_err(dev, "Invalid format string\n");
+	return ERR_PTR(-EINVAL);
+}
+
+/* if you use exotic modes that simplefb_parse_format cannot decode, you can
+   specify them here. */
+static struct simplefb_format simplefb_formats[] = {
 };
 
 struct simplefb_params {
@@ -131,7 +188,10 @@ static int simplefb_parse_dt(struct platform_device *pdev,
 		params->format = &simplefb_formats[i];
 		break;
 	}
-	if (!params->format) {
+	if (!params->format)
+		params->format = simplefb_parse_format(&pdev->dev, format);
+
+	if (!params->format || IS_ERR(params->format)) {
 		dev_err(&pdev->dev, "Invalid format value\n");
 		return -EINVAL;
 	}
-- 
1.8.2.3

