From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 12/12] fbdev: Firmware EDID fixes
Date: Sat, 29 Apr 2006 08:44:40 +0800
Message-ID: <4452B6F8.9050202@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from [10.3.1.93] (helo=sc8-sf-list1-new.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FZdun-0005Tb-2z
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 28 Apr 2006 18:06:29 -0700
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1FZdun-0001IM-3c
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 28 Apr 2006 18:06:29 -0700
Received: from xproxy.gmail.com ([66.249.82.205])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1FZdik-0006gw-2A
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 28 Apr 2006 17:54:02 -0700
Received: by xproxy.gmail.com with SMTP id t4so1463996wxc
        for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 28 Apr 2006 17:54:01 -0700 (PDT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

- make firmware edid independent from framebuffer (No need to choose
  framebuffer just to disable this option
- enable this option in X86_64
- check if VBE/DDC function is implemented before calling actual function

Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

 arch/i386/boot/video.S   |   19 ++++++++++++++++++-
 arch/x86_64/boot/video.S |   19 +++++++++++++++++++
 drivers/video/Kconfig    |   31 +++++++++++++++----------------
 drivers/video/fbmon.c    |    2 +-
 4 files changed, 53 insertions(+), 18 deletions(-)

diff --git a/arch/i386/boot/video.S b/arch/i386/boot/video.S
index c9343c3..8c2a6fa 100644
--- a/arch/i386/boot/video.S
+++ b/arch/i386/boot/video.S
@@ -1929,7 +1929,7 @@ skip10:	movb	%ah, %al
 	ret
 
 store_edid:
-#ifdef CONFIG_FB_FIRMWARE_EDID
+#ifdef CONFIG_FIRMWARE_EDID
 	pushw	%es				# just save all registers
 	pushw	%ax
 	pushw	%bx
@@ -1947,6 +1947,22 @@ store_edid:
 	rep
 	stosl
 
+	pushw   %es				# save ES
+	xorw    %di, %di                        # Report Capability
+	pushw   %di
+	popw    %es                             # ES:DI must be 0:0
+	movw	$0x4f15, %ax
+	xorw	%bx, %bx
+	xorw	%cx, %cx
+	int	$0x10
+	popw    %es                             # restore ES
+
+	cmpb    $0x00, %ah                      # call successful
+	jne     no_edid
+
+	cmpb    $0x4f, %al                      # function supported
+	jne     no_edid
+
 	movw	$0x4f15, %ax                    # do VBE/DDC
 	movw	$0x01, %bx
 	movw	$0x00, %cx
@@ -1954,6 +1970,7 @@ store_edid:
 	movw	$0x140, %di
 	int	$0x10
 
+no_edid:
 	popw	%di				# restore all registers
 	popw	%dx
 	popw	%cx
diff --git a/arch/x86_64/boot/video.S b/arch/x86_64/boot/video.S
index 32327bb..2aa565c 100644
--- a/arch/x86_64/boot/video.S
+++ b/arch/x86_64/boot/video.S
@@ -1929,6 +1929,7 @@ skip10:	movb	%ah, %al
 	ret
 
 store_edid:
+#ifdef CONFIG_FIRMWARE_EDID
 	pushw	%es				# just save all registers
 	pushw	%ax
 	pushw	%bx
@@ -1946,6 +1947,22 @@ store_edid:
 	rep
 	stosl
 
+	pushw   %es				# save ES
+	xorw    %di, %di                        # Report Capability
+	pushw   %di
+	popw    %es                             # ES:DI must be 0:0
+	movw	$0x4f15, %ax
+	xorw	%bx, %bx
+	xorw	%cx, %cx
+	int	$0x10
+	popw    %es                             # restore ES
+
+	cmpb    $0x00, %ah                      # call successful
+	jne     no_edid
+
+	cmpb    $0x4f, %al                      # function supported
+	jne     no_edid
+
 	movw	$0x4f15, %ax                    # do VBE/DDC
 	movw	$0x01, %bx
 	movw	$0x00, %cx
@@ -1953,12 +1970,14 @@ store_edid:
 	movw	$0x140, %di
 	int	$0x10
 
+no_edid:
 	popw	%di				# restore all registers
 	popw	%dx
 	popw	%cx
 	popw	%bx
 	popw	%ax
 	popw	%es
+#endif
 	ret
 
 # VIDEO_SELECT-only variables
diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
index 1d1381b..db6f0cd 100644
--- a/drivers/video/Kconfig
+++ b/drivers/video/Kconfig
@@ -4,6 +4,21 @@
 
 menu "Graphics support"
 
+config FIRMWARE_EDID
+       bool "Enable firmware EDID"
+       default y
+       ---help---
+         This enables access to the EDID transferred from the firmware.
+	 On the i386, this is from the Video BIOS. Enable this if DDC/I2C
+	 transfers do not work for your driver and if you are using
+	 nvidiafb, i810fb or savagefb.
+
+	 In general, choosing Y for this option is safe.  If you
+	 experience extremely long delays while booting before you get
+	 something on your display, try setting this to N.  Matrox cards in
+	 combination with certain motherboards and monitors are known to
+	 suffer from this problem.
+
 config FB
 	tristate "Support for frame buffer devices"
 	---help---
@@ -70,22 +85,6 @@ config FB_MACMODES
        depends on FB
        default n
 
-config FB_FIRMWARE_EDID
-       bool "Enable firmware EDID"
-       depends on FB
-       default y
-       ---help---
-         This enables access to the EDID transferred from the firmware.
-	 On the i386, this is from the Video BIOS. Enable this if DDC/I2C
-	 transfers do not work for your driver and if you are using
-	 nvidiafb, i810fb or savagefb.
-
-	 In general, choosing Y for this option is safe.  If you
-	 experience extremely long delays while booting before you get
-	 something on your display, try setting this to N.  Matrox cards in
-	 combination with certain motherboards and monitors are known to
-	 suffer from this problem.
-
 config FB_MODE_HELPERS
         bool "Enable Video Mode Handling Helpers"
         depends on FB
diff --git a/drivers/video/fbmon.c b/drivers/video/fbmon.c
index 87b0224..3ccfff7 100644
--- a/drivers/video/fbmon.c
+++ b/drivers/video/fbmon.c
@@ -1301,7 +1301,7 @@ int fb_validate_mode(const struct fb_var
 		-EINVAL : 0;
 }
 
-#if defined(CONFIG_FB_FIRMWARE_EDID) && defined(__i386__)
+#if defined(CONFIG_FIRMWARE_EDID) && defined(CONFIG_X86)
 
 /*
  * We need to ensure that the EDID block is only returned for



-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
