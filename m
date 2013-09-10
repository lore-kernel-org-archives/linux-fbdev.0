From: Vladimir Murzin <murzin.v@gmail.com>
Date: Tue, 10 Sep 2013 16:46:30 +0000
Subject: [PATCH 3/3] fbdev/ps3fb: fix section mismatch warning for ps3fb_probe
Message-Id: <1378831590-2349-1-git-send-email-murzin.v@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org, cbe-oss-dev@lists.ozlabs.org, linuxppc-dev@lists.ozlabs.org
Cc: geoff@infradead.org, Vladimir Murzin <murzin.v@gmail.com>, tomi.valkeinen@ti.com, plagnioj@jcrosoft.com

While cross-building for PPC64 I've got

WARNING: drivers/video/built-in.o(.text+0x9f9ca): Section mismatch in
reference from the function .ps3fb_probe() to th e variable
.init.data:ps3fb_fix The function .ps3fb_probe() references the
variable __initdata ps3fb_fix.  This is often because .ps3fb_probe
lacks a __initdata annotation or the annotation of ps3fb_fix is wrong.

WARNING: drivers/video/built-in.o(.text+0x9f9d2): Section mismatch in
reference from the function .ps3fb_probe() to the variable
.init.data:ps3fb_fix The function .ps3fb_probe() references the
variable __initdata ps3fb_fix.  This is often because .ps3fb_probe
lacks a __initdata annotation or the annotation of ps3fb_fix is wrong.

WARNING: drivers/built-in.o(.text+0xe222a): Section mismatch in
reference from the function .ps3fb_probe() to the variable
.init.data:ps3fb_fix The function .ps3fb_probe() references the
variable __initdata ps3fb_fix.  This is often because .ps3fb_probe
lacks a __initdata annotation or the annotation of ps3fb_fix is wrong.

WARNING: drivers/built-in.o(.text+0xe2232): Section mismatch in
reference from the function .ps3fb_probe() to the variable
.init.data:ps3fb_fix The function .ps3fb_probe() references the
variable __initdata ps3fb_fix.  This is often because .ps3fb_probe
lacks a __initdata annotation or the annotation of ps3fb_fix is wrong.

WARNING: vmlinux.o(.text+0x561d4a): Section mismatch in reference from
the function .ps3fb_probe() to the variable .init.data:ps3fb_fix The
function .ps3fb_probe() references the variable __initdata ps3fb_fix.
This is often because .ps3fb_probe lacks a __initdata annotation or
the annotation of ps3fb_fix is wrong.

Mismatch was introduced with 48c68c4f "Drivers: video: remove __dev*
attributes."

Remove __init data annotation from ps3fb_fix.

Signed-off-by: Vladimir Murzin <murzin.v@gmail.com>
---
 drivers/video/ps3fb.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/ps3fb.c b/drivers/video/ps3fb.c
index dbfe2c1..b269abd 100644
--- a/drivers/video/ps3fb.c
+++ b/drivers/video/ps3fb.c
@@ -952,7 +952,7 @@ static struct fb_ops ps3fb_ops = {
 	.fb_compat_ioctl = ps3fb_ioctl
 };
 
-static struct fb_fix_screeninfo ps3fb_fix __initdata = {
+static struct fb_fix_screeninfo ps3fb_fix = {
 	.id =		DEVICE_NAME,
 	.type =		FB_TYPE_PACKED_PIXELS,
 	.visual =	FB_VISUAL_TRUECOLOR,
-- 
1.7.10.4

