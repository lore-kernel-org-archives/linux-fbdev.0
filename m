From: bernie@plugable.com
Date: Tue, 02 Aug 2011 05:54:32 +0000
Subject: [PATCH 5/5] udlfb: Enable fb_defio by default
Message-Id: <1312264472-2900-5-git-send-email-bernie@plugable.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

From: Bernie Thompson <bernie@plugable.com>

Enables page fault based detection of mmap writes to the framebuffer,
which allows standard fbdev apps (like the generic fbdev xorg driver)
to work on DisplayLink devices.

Not all bugs are shaken out of the fb_defio path of udlfb, but it's
tantalizingly close, so this seems a good time to enable by default.

Alternatively, option can be disabled when running with an xorg driver
that can more directly communicate damaged regions of the framebuffer
via IOCTL. This is a simpler, higher perf option, when available.

Signed-off-by: Bernie Thompson <bernie@plugable.com>
---
 Documentation/fb/udlfb.txt |   24 ++++++++++++++++--------
 drivers/video/udlfb.c      |    4 ++--
 2 files changed, 18 insertions(+), 10 deletions(-)

diff --git a/Documentation/fb/udlfb.txt b/Documentation/fb/udlfb.txt
index 473ceed..c6d90a6 100644
--- a/Documentation/fb/udlfb.txt
+++ b/Documentation/fb/udlfb.txt
@@ -87,20 +87,28 @@ Special configuration for udlfb is usually unnecessary. There are a few
 options, however.
 
 From the command line, pass options to modprobe
-modprobe udlfb defio=1 console=1
+modprobe udlfb fb_defio=0 console=1 shadow=1
 
-Or for permanent option, create file like /etc/modprobe.d/options with text
-options udlfb defio=1 console=1
+Or modify options on the fly at /sys/module/udlfb/parameters directory via
+sudo nano fb_defio
+change the parameter in place, and save the file.
 
-Accepted options:
+Unplug/replug USB device to apply with new settings
+
+Or for permanent option, create file like /etc/modprobe.d/udlfb.conf with text
+options udlfb fb_defio=0 console=1 shadow=1
+
+Accepted boolean options:
 
 fb_defio	Make use of the fb_defio (CONFIG_FB_DEFERRED_IO) kernel
 		module to track changed areas of the framebuffer by page faults.
-        	Standard fbdev applications that use mmap but that do not
-		report damage, may be able to work with this enabled.
-		Disabled by default because of overhead and other issues.
+		Standard fbdev applications that use mmap but that do not
+		report damage, should be able to work with this enabled.
+		Disable when running with X server that supports reporting
+		changed regions via ioctl, as this method is simpler,
+		more stable, and higher performance.
 
-console		Allow fbcon to attach to udlfb provided framebuffers. This
+console	Allow fbcon to attach to udlfb provided framebuffers. This
 		is disabled by default because fbcon will aggressively consume
 		the first framebuffer it finds, which isn't usually what the
 		user wants in the case of USB displays.
diff --git a/drivers/video/udlfb.c b/drivers/video/udlfb.c
index 5a13dc5..5207bd2 100644
--- a/drivers/video/udlfb.c
+++ b/drivers/video/udlfb.c
@@ -71,7 +71,7 @@ MODULE_DEVICE_TABLE(usb, id_table);
 
 /* module options */
 static int console;   /* Optionally allow fbcon to consume first framebuffer */
-static int fb_defio;  /* Optionally enable experimental fb_defio mmap support */
+static int fb_defio = 1;  /* Detect mmap writes using page faults */
 static int shadow = 1; /* Optionally disable shadow framebuffer */
 
 /* dlfb keeps a list of urbs for efficient bulk transfers */
@@ -1961,7 +1961,7 @@ module_param(console, bool, S_IWUSR | S_IRUSR | S_IWGRP | S_IRGRP);
 MODULE_PARM_DESC(console, "Allow fbcon to consume first framebuffer found");
 
 module_param(fb_defio, bool, S_IWUSR | S_IRUSR | S_IWGRP | S_IRGRP);
-MODULE_PARM_DESC(fb_defio, "Enable fb_defio mmap support. *Experimental*");
+MODULE_PARM_DESC(fb_defio, "Page fault detection of mmap writes");
 
 module_param(shadow, bool, S_IWUSR | S_IRUSR | S_IWGRP | S_IRGRP);
 MODULE_PARM_DESC(shadow, "Shadow vid mem. Disable to save mem but lose perf");
-- 
1.7.4.1

