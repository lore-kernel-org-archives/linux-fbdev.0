From: Antonino Daplas <adaplas@pol.net>
Subject: [PATCH]  Getting the EDID block for x86
Date: 02 Apr 2003 23:41:53 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1049298092.5239.56.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from pine.compass.com.ph ([202.70.96.37])
	by sc8-sf-list1.sourceforge.net with smtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 190kSY-0006Pf-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 02 Apr 2003 07:47:30 -0800
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Linux Kernel List <linux-kernel@vger.kernel.org>, James Simmons <jsimmons@infradead.org>

Hi Linus,

Attached is a diff against 2.5.66 which gets the EDID block via VBE/DDC
service.  This is done before switching to protected mode.

It's useful for video drivers to have some kind of information about the
primary display's operating limits and capability.  Please, kindly
apply.

Tony

diff -Naur linux-2.5.66-orig/arch/i386/boot/compressed/misc.c linux-2.5.66-edid/arch/i386/boot/compressed/misc.c
--- linux-2.5.66-orig/arch/i386/boot/compressed/misc.c	2003-02-16 00:47:53.000000000 +0000
+++ linux-2.5.66-edid/arch/i386/boot/compressed/misc.c	2003-04-02 13:54:55.000000000 +0000
@@ -12,6 +12,7 @@
 #include <linux/linkage.h>
 #include <linux/vmalloc.h>
 #include <linux/tty.h>
+#include <video/edid.h>
 #include <asm/io.h>
 
 /*
@@ -91,6 +92,7 @@
 #define ALT_MEM_K   (*(unsigned long *)(real_mode + 0x1e0))
 #endif
 #define SCREEN_INFO (*(struct screen_info *)(real_mode+0))
+#define EDID_INFO   (*(struct edid_info *)(real_mode+0x440))
 
 extern char input_data[];
 extern int input_len;
diff -Naur linux-2.5.66-orig/arch/i386/boot/video.S linux-2.5.66-edid/arch/i386/boot/video.S
--- linux-2.5.66-orig/arch/i386/boot/video.S	2002-12-16 02:07:50.000000000 +0000
+++ linux-2.5.66-edid/arch/i386/boot/video.S	2003-04-02 14:06:09.000000000 +0000
@@ -135,6 +135,7 @@
 #endif /* CONFIG_VIDEO_RETAIN */
 #endif /* CONFIG_VIDEO_SELECT */
 	call	mode_params			# Store mode parameters
+	call	store_edid
 	popw	%ds				# Restore original DS
 	ret
 
@@ -1887,6 +1888,39 @@
 	popw	%ax
 	ret
 
+store_edid:
+	pushw	%es				# just save all registers 
+	pushw	%ax				
+	pushw	%bx
+	pushw   %cx
+	pushw	%dx
+	pushw   %di
+
+	pushw	%fs                             
+	popw    %es
+
+	movl	$0x13131313, %eax		# memset block with 0x13
+	movw    $32, %cx
+	movw	$0x440, %di
+	cld
+	rep 
+	stosl  
+
+	movw	$0x4f15, %ax                    # do VBE/DDC 
+	movw	$0x01, %bx
+	movw	$0x00, %cx
+	movw    $0x01, %dx
+	movw	$0x440, %di
+	int	$0x10	
+
+	popw	%di				# restore all registers        
+	popw	%dx
+	popw	%cx
+	popw	%bx
+	popw	%ax
+	popw	%es	
+	ret
+
 # VIDEO_SELECT-only variables
 mt_end:		.word	0	# End of video mode table if built
 edit_buf:	.space	6	# Line editor buffer
diff -Naur linux-2.5.66-orig/arch/i386/kernel/setup.c linux-2.5.66-edid/arch/i386/kernel/setup.c
--- linux-2.5.66-orig/arch/i386/kernel/setup.c	2003-03-29 12:36:36.000000000 +0000
+++ linux-2.5.66-edid/arch/i386/kernel/setup.c	2003-04-02 13:56:21.000000000 +0000
@@ -37,6 +37,7 @@
 #include <linux/console.h>
 #include <linux/root_dev.h>
 #include <linux/highmem.h>
+#include <video/edid.h>
 #include <asm/e820.h>
 #include <asm/mpspec.h>
 #include <asm/edd.h>
@@ -85,7 +86,7 @@
 	unsigned short length;
 	unsigned char table[0];
 };
-
+struct edid_info edid_info;
 struct e820map e820;
 
 unsigned char aux_device_present;
@@ -883,6 +884,7 @@
  	ROOT_DEV = ORIG_ROOT_DEV;
  	drive_info = DRIVE_INFO;
  	screen_info = SCREEN_INFO;
+	edid_info = EDID_INFO;
 	apm_info.bios = APM_BIOS_INFO;
 	saved_videomode = VIDEO_MODE;
 	printk("Video mode to be used for restore is %lx\n", saved_videomode);
diff -Naur linux-2.5.66-orig/include/asm-i386/setup.h linux-2.5.66-edid/include/asm-i386/setup.h
--- linux-2.5.66-orig/include/asm-i386/setup.h	2002-12-16 02:08:12.000000000 +0000
+++ linux-2.5.66-edid/include/asm-i386/setup.h	2003-04-02 13:53:34.000000000 +0000
@@ -37,6 +37,7 @@
 #define KERNEL_START (*(unsigned long *) (PARAM+0x214))
 #define INITRD_START (*(unsigned long *) (PARAM+0x218))
 #define INITRD_SIZE (*(unsigned long *) (PARAM+0x21c))
+#define EDID_INFO   (*(struct edid_info *) (PARAM+0x440))
 #define EDD_NR     (*(unsigned char *) (PARAM+EDDNR))
 #define EDD_BUF     ((struct edd_info *) (PARAM+EDDBUF))
 #define COMMAND_LINE ((char *) (PARAM+2048))
diff -Naur linux-2.5.66-orig/include/video/edid.h linux-2.5.66-edid/include/video/edid.h
--- linux-2.5.66-orig/include/video/edid.h	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.5.66-edid/include/video/edid.h	2003-04-02 13:52:50.000000000 +0000
@@ -0,0 +1,14 @@
+#ifndef __linux_video_edid_h__
+#define __linux_video_edid_h__
+
+#include <linux/config.h>
+
+#ifdef CONFIG_X86
+struct edid_info {
+	unsigned char dummy[128];
+};
+
+extern struct edid_info edid_info;
+#endif /* CONFIG_X86 */
+
+#endif /* __linux_video_edid_h__ */






-------------------------------------------------------
This SF.net email is sponsored by: ValueWeb: 
Dedicated Hosting for just $79/mo with 500 GB of bandwidth! 
No other company gives more support or power for your dedicated server
http://click.atdmt.com/AFF/go/sdnxxaff00300020aff/direct/01/
