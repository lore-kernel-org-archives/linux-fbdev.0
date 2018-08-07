From: Randy Dunlap <rdunlap@infradead.org>
Date: Tue, 07 Aug 2018 16:27:52 +0000
Subject: [PATCH] Documentation/fb: corrections for fbcon.txt
Message-Id: <74fe20d7-0200-fb2b-c765-63da788456be@infradead.org>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, Linux Fbdev development list <linux-fbdev@vger.kernel.org>, dri-devel <dri-devel@lists.freedesktop.org>
Cc: Antonino Daplas <adaplas@pol.net>, Jonathan Corbet <corbet@lwn.net>, Geert Uytterhoeven <geert@linux-m68k.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

From: Randy Dunlap <rdunlap@infradead.org>

Fix grammar, spacing, indentation, and Kconfig menu locations
in fbcon.txt.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Antonino Daplas <adaplas@pol.net>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-fbdev@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: dri-devel@lists.freedesktop.org
Cc: linux-doc@vger.kernel.org
---
 Documentation/fb/fbcon.txt |   29 +++++++++++++++--------------
 1 file changed, 15 insertions(+), 14 deletions(-)

--- lnx-418-rc8.orig/Documentation/fb/fbcon.txt
+++ lnx-418-rc8/Documentation/fb/fbcon.txt
@@ -18,9 +18,10 @@ made available by the underlying graphic
 A. Configuration
 
 	The framebuffer console can be enabled by using your favorite kernel
-configuration tool.  It is under Device Drivers->Graphics Support->Support for
-framebuffer devices->Framebuffer Console Support. Select 'y' to compile
-support statically, or 'm' for module support.  The module will be fbcon.
+configuration tool.  It is under Device Drivers->Graphics Support->Frame
+buffer Devices->Console display driver support->Framebuffer Console Support.
+Select 'y' to compile support statically or 'm' for module support.  The
+module will be fbcon.
 
 	In order for fbcon to activate, at least one framebuffer driver is
 required, so choose from any of the numerous drivers available. For x86
@@ -29,10 +30,10 @@ always be available. However, using a ch
 more speed and features, such as the ability to change the video mode
 dynamically.
 
-	To display the penguin logo, choose any logo available in Logo
-Configuration->Boot up logo.
+	To display the penguin logo, choose any logo available in Graphics
+support->Bootup logo.
 
-	Also, you will need to select at least one compiled-in fonts, but if
+	Also, you will need to select at least one compiled-in font, but if
 you don't do anything, the kernel configuration tool will select one for you,
 usually an 8x16 font.
 
@@ -135,16 +136,16 @@ C. Boot options
 
 	The angle can be changed anytime afterwards by 'echoing' the same
 	numbers to any one of the 2 attributes found in
-	 /sys/class/graphics/fbcon
+	/sys/class/graphics/fbcon:
 
 		rotate     - rotate the display of the active console
 		rotate_all - rotate the display of all consoles
 
-	Console rotation will only become available if Console Rotation
-	Support is compiled in your kernel.
+	Console rotation will only become available if Framebuffer Console
+	Rotation support is compiled in your kernel.
 
 	NOTE: This is purely console rotation.  Any other applications that
-	use the framebuffer will remain at their 'normal'orientation.
+	use the framebuffer will remain at their 'normal' orientation.
 	Actually, the underlying fb driver is totally ignorant of console
 	rotation.
 
@@ -157,7 +158,7 @@ C. Boot options
 
 C. Attaching, Detaching and Unloading
 
-Before going on how to attach, detach and unload the framebuffer console, an
+Before going on to how to attach, detach and unload the framebuffer console, an
 illustration of the dependencies may help.
 
 The console layer, as with most subsystems, needs a driver that interfaces with
@@ -175,7 +176,7 @@ because fbcon is an intermediate layer b
 
 console ---> fbcon ---> fbdev drivers ---> hardware
 
-The fbdev drivers cannot be unloaded if it's bound to fbcon, and fbcon cannot
+The fbdev drivers cannot be unloaded if bound to fbcon, and fbcon cannot
 be unloaded if it's bound to the console layer.
 
 So to unload the fbdev drivers, one must first unbind fbcon from the console,
@@ -225,7 +226,7 @@ restored properly. The following is one
        echo 0 > /sys/class/vtconsole/vtcon1/bind
 
 6. That's it, you're back to VGA mode. And if you compiled fbcon as a module,
-   you can unload it by 'rmmod fbcon'
+   you can unload it by 'rmmod fbcon'.
 
 7. To reattach fbcon:
 
@@ -283,7 +284,7 @@ Samples:
 ====
 
 Here are 2 sample bash scripts that you can use to bind or unbind the
-framebuffer console driver if you are in an X86 box:
+framebuffer console driver if you are on an X86 box:
 
 ---------------------------------------------------------------------------
 #!/bin/bash


