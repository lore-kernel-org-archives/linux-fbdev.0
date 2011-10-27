From: Ondrej Zary <linux@rainbow-software.org>
Date: Thu, 27 Oct 2011 20:31:12 +0000
Subject: [PATCH] fbtest: fix test011 with xpanstep or ypanstep greater than 1
Message-Id: <201110272231.16202.linux@rainbow-software.org>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Hello,
this patch fixes test011 in fbtest if framebuffer driver requires xpanstep or
ypanstep to be greater than 1. Without this, test011 fails on savagefb:

ioctl FBIOPAN_DISPLAY: Invalid argument

Signed-off-by: Ondrej Zary <linux@rainbow-software.org>

--- fbtest-orig/tests/test011.c	2011-10-27 22:20:47.000000000 +0200
+++ fbtest/tests/test011.c	2011-10-27 22:22:16.000000000 +0200
@@ -93,16 +93,25 @@ static int linegen_next(struct linegen *
     return 1;
 }
 
-static void move(u32 cx, u32 cy, u32 x1, u32 y1, u32 x2, u32 y2)
+static void move(u32 cx, u32 cy, u32 x1, u32 y1, u32 x2, u32 y2, u32 xpanstep, u32 ypanstep)
 {
     struct linegen gen;
     u32 x, y;
     static int cnt = 0;
 
+    if (xpanstep = 0)
+    	xpanstep = 1;
+    if (ypanstep = 0)
+        ypanstep = 1;
+    x1 /= xpanstep;
+    x2 /= xpanstep;
+    y1 /= ypanstep;
+    y2 /= ypanstep;
+
     linegen_init(&gen, x1, y1, x2, y2);
     while (linegen_next(&gen, &x, &y)) {
 	fill_circle(cx+x, cy+y, 2, cnt & 4 ? black_pixel : white_pixel);
-	fb_pan(x, y);
+	fb_pan(x * xpanstep, y * ypanstep);
 	wait_ms(SLEEP_MS);
 	cnt++;
     }
@@ -137,29 +146,29 @@ static enum test_res test011_func(void)
     dy = fb_fix.ypanstep ? fb_var.yres_virtual-fb_var.yres : 0;
 
     /* move right */
-    move(cx, cy, 0, 0, dx, 0);
+    move(cx, cy, 0, 0, dx, 0, fb_fix.xpanstep, fb_fix.ypanstep);
 
     /* move down */
-    move(cx, cy, dx, 0, dx, dy);
+    move(cx, cy, dx, 0, dx, dy, fb_fix.xpanstep, fb_fix.ypanstep);
 
     /* move left */
-    move(cx, cy, dx, dy, 0, dy);
+    move(cx, cy, dx, dy, 0, dy, fb_fix.xpanstep, fb_fix.ypanstep);
 
     if (dx >= 2 && dy >= 2) {
 	/* move up and right */
-	move(cx, cy, 0, dy, dx/2, 0);
+	move(cx, cy, 0, dy, dx/2, 0, fb_fix.xpanstep, fb_fix.ypanstep);
 
 	/* move right and down */
-	move(cx, cy, dx/2, 0, dx, dy/2);
+	move(cx, cy, dx/2, 0, dx, dy/2, fb_fix.xpanstep, fb_fix.ypanstep);
 
 	/* move left and down */
-	move(cx, cy, dx, dy/2, dx/2, dy);
+	move(cx, cy, dx, dy/2, dx/2, dy, fb_fix.xpanstep, fb_fix.ypanstep);
 
 	/* move up and left */
-	move(cx, cy, dx/2, dy, 0, 0);
+	move(cx, cy, dx/2, dy, 0, 0, fb_fix.xpanstep, fb_fix.ypanstep);
     } else {
 	/* move up */
-	move(cx, cy, 0, dy, 0, 0);
+	move(cx, cy, 0, dy, 0, 0, fb_fix.xpanstep, fb_fix.ypanstep);
     }
 
     wait_for_key(10);


-- 
Ondrej Zary
