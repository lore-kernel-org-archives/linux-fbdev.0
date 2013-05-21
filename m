From: Geoff Levand <geoff@infradead.org>
Date: Tue, 21 May 2013 13:01:42 +0000
Subject: [PATCH] video/ps3fb: Fix section mismatch warning
Message-Id: <1369141302.3652.14.camel@clam>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Remove the __initdata attribute from the ps3fb_fix variable.  This is in
follow up to the removal of the __devinit attribute on the ps3fb_probe()
routine in commit 48c68c4f1b542444f175a9e136febcecf3e704d8 (Drivers:
video: remove __dev* attributes).

Fixes build warnings like these:

  WARNING: vmlinux.o Section mismatch in reference from the function .ps3fb_probe() to the variable .init.data:ps3fb_fix
  The function .ps3fb_probe() references the variable __initdata ps3fb_fix.
  This is often because .ps3fb_probe lacks a __initdata annotation or the annotation of ps3fb_fix is wrong.

Signed-off-by: Geoff Levand <geoff@infradead.org>
---
 drivers/video/ps3fb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/ps3fb.c b/drivers/video/ps3fb.c
index a397271d..4819cdf 100644
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
1.8.1.2



