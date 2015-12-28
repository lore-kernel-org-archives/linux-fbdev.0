From: Jakub Wilk <jwilk@jwilk.net>
Date: Mon, 28 Dec 2015 12:57:23 +0000
Subject: [PATCH] Documentation/fb: Fix typos
Message-Id: <1451307443-1481-1-git-send-email-jwilk@jwilk.net>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Signed-off-by: Jakub Wilk <jwilk@jwilk.net>
---
 Documentation/fb/fbcon.txt    | 2 +-
 Documentation/fb/sh7760fb.txt | 2 +-
 Documentation/fb/sm712fb.txt  | 2 +-
 Documentation/fb/sstfb.txt    | 2 +-
 Documentation/fb/udlfb.txt    | 6 +++---
 5 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/Documentation/fb/fbcon.txt b/Documentation/fb/fbcon.txt
index 4a9739a..5bc41ca 100644
--- a/Documentation/fb/fbcon.txt
+++ b/Documentation/fb/fbcon.txt
@@ -144,7 +144,7 @@ C. Boot options
 	Support is compiled in your kernel.
 
 	NOTE: This is purely console rotation.  Any other applications that
-	use the framebuffer will remain at their 'normal'orientation.
+	use the framebuffer will remain at their 'normal' orientation.
 	Actually, the underlying fb driver is totally ignorant of console
 	rotation.
 
diff --git a/Documentation/fb/sh7760fb.txt b/Documentation/fb/sh7760fb.txt
index b994c3b..280c849 100644
--- a/Documentation/fb/sh7760fb.txt
+++ b/Documentation/fb/sh7760fb.txt
@@ -20,7 +20,7 @@ Caveats:
   a) if you're using 15/16bit color modes at >= 640x480 px resolutions,
   b) during PCMCIA (or any other slow bus) activity.
 
-* Rotation works only 90degress clockwise, and only if horizontal
+* Rotation works only 90 degrees clockwise, and only if horizontal
   resolution is <= 320 pixels.
 
 files:   drivers/video/sh7760fb.c
diff --git a/Documentation/fb/sm712fb.txt b/Documentation/fb/sm712fb.txt
index c388442..438a2bf 100644
--- a/Documentation/fb/sm712fb.txt
+++ b/Documentation/fb/sm712fb.txt
@@ -27,5 +27,5 @@ Missing Features
 ========
 (alias TODO list)
 
-	* 2D acceleratrion
+	* 2D acceleration
 	* dual-head support
diff --git a/Documentation/fb/sstfb.txt b/Documentation/fb/sstfb.txt
index 13db107..8cd3547 100644
--- a/Documentation/fb/sstfb.txt
+++ b/Documentation/fb/sstfb.txt
@@ -116,7 +116,7 @@ Tools
 
 	These tools are mostly for debugging purposes, but you can 
 	find some of these interesting :
-	 - con2fb , maps a tty to a fbramebuffer .
+	 - con2fb , maps a tty to a framebuffer .
 		con2fb /dev/fb1 /dev/tty5
 	 - sst_dbg_vgapass , changes vga passthrou. You have to recompile the
 	driver with SST_DEBUG and SST_DEBUG_IOCTL set to 1
diff --git a/Documentation/fb/udlfb.txt b/Documentation/fb/udlfb.txt
index 57d2f29..c985cb6 100644
--- a/Documentation/fb/udlfb.txt
+++ b/Documentation/fb/udlfb.txt
@@ -9,7 +9,7 @@ pairing that with a hardware framebuffer (16MB) on the other end of the
 USB wire.  That hardware framebuffer is able to drive the VGA, DVI, or HDMI
 monitor with no CPU involvement until a pixel has to change.
 
-The CPU or other local resource does all the rendering; optinally compares the
+The CPU or other local resource does all the rendering; optionally compares the
 result with a local shadow of the remote hardware framebuffer to identify
 the minimal set of pixels that have changed; and compresses and sends those
 pixels line-by-line via USB bulk transfers.
@@ -66,10 +66,10 @@ means that from a hardware and fbdev software perspective, everything is good.
 At that point, a /dev/fb? interface will be present for user-mode applications
 to open and begin writing to the framebuffer of the DisplayLink device using
 standard fbdev calls.  Note that if mmap() is used, by default the user mode
-application must send down damage notifcations to trigger repaints of the
+application must send down damage notifications to trigger repaints of the
 changed regions.  Alternatively, udlfb can be recompiled with experimental
 defio support enabled, to support a page-fault based detection mechanism
-that can work without explicit notifcation.
+that can work without explicit notification.
 
 The most common client of udlfb is xf86-video-displaylink or a modified
 xf86-video-fbdev X server. These servers have no real DisplayLink specific
-- 
2.6.4

