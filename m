From: Alexandre Courbot <acourbot@nvidia.com>
Date: Thu, 06 Jun 2013 07:20:59 +0000
Subject: [PATCH] simplefb: add support for a8b8g8r8 pixel format
Message-Id: <1370503259-16618-1-git-send-email-acourbot@nvidia.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Stephen Warren <swarren@wwwdotorg.org>, Olof Johansson <olof@lixom.net>
Cc: gnurou@gmail.org, linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, Alexandre Courbot <acourbot@nvidia.com>

Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
---
 Documentation/devicetree/bindings/video/simple-framebuffer.txt | 1 +
 drivers/video/simplefb.c                                       | 1 +
 2 files changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/video/simple-framebuffer.txt b/Documentation/devicetree/bindings/video/simple-framebuffer.txt
index 3ea4605..70c26f3 100644
--- a/Documentation/devicetree/bindings/video/simple-framebuffer.txt
+++ b/Documentation/devicetree/bindings/video/simple-framebuffer.txt
@@ -12,6 +12,7 @@ Required properties:
 - stride: The number of bytes in each line of the framebuffer.
 - format: The format of the framebuffer surface. Valid values are:
   - r5g6b5 (16-bit pixels, d[15:11]=r, d[10:5]=g, d[4:0]=b).
+  - a8b8g8r8 (32-bit pixels, d[31:24]=a, d[23:16]=b, d[15:8]=g, d[7:0]=r).
 
 Example:
 
diff --git a/drivers/video/simplefb.c b/drivers/video/simplefb.c
index e2e9e3e..d7041aa 100644
--- a/drivers/video/simplefb.c
+++ b/drivers/video/simplefb.c
@@ -84,6 +84,7 @@ struct simplefb_format {
 
 static struct simplefb_format simplefb_formats[] = {
 	{ "r5g6b5", 16, {11, 5}, {5, 6}, {0, 5}, {0, 0} },
+	{ "a8b8g8r8", 32, {0, 8}, {8, 8}, {16, 8}, {31, 8} },
 };
 
 struct simplefb_params {
-- 
1.8.3

