From: Antonino Daplas <adaplas@pol.net>
Subject: Re: Reading the EDID block for x86 machines
Date: 12 Mar 2003 05:47:37 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1047419211.1186.32.camel@localhost.localdomain>
References: <Pine.LNX.4.44.0303111537420.23668-100000@phoenix.infradead.org> 
	<1047418384.1100.5.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from pine.compass.com.ph ([202.70.96.37])
	by sc8-sf-list1.sourceforge.net with smtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18srec-0007LL-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 11 Mar 2003 13:51:22 -0800
In-Reply-To: <1047418384.1100.5.camel@localhost.localdomain>
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
To: Antonino Daplas <adaplas@pol.net>
Cc: James Simmons <jsimmons@infradead.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Wed, 2003-03-12 at 05:33, Antonino Daplas wrote:

> I think I found a chunk of around 500 bytes between INITRD and EDD, so
> we can squeeze in EDID in there :-)  Although I'm confident on this,
> I'll feel better if someone who boots with initrd can test it.

Forgot the patch :-)

Tony

diff -Naur linux-2.5.64-fbdev/arch/i386/boot/compressed/misc.c linux-2.5.64/arch/i386/boot/compressed/misc.c
--- linux-2.5.64-fbdev/arch/i386/boot/compressed/misc.c	2003-03-11 21:19:34.000000000 +0000
+++ linux-2.5.64/arch/i386/boot/compressed/misc.c	2003-03-11 21:07:24.000000000 +0000
@@ -91,7 +91,7 @@
 #define ALT_MEM_K   (*(unsigned long *)(real_mode + 0x1e0))
 #endif
 #define SCREEN_INFO (*(struct screen_info *)(real_mode+0))
-#define EDID_INFO   (*(struct edid_info   *)(real_mode+0x600))
+#define EDID_INFO   (*(struct edid_info   *)(real_mode+0x440))
 
 extern char input_data[];
 extern int input_len;
diff -Naur linux-2.5.64-fbdev/arch/i386/boot/video.S linux-2.5.64/arch/i386/boot/video.S
--- linux-2.5.64-fbdev/arch/i386/boot/video.S	2003-03-11 21:19:34.000000000 +0000
+++ linux-2.5.64/arch/i386/boot/video.S	2003-03-11 21:07:24.000000000 +0000
@@ -1888,7 +1888,6 @@
 	popw	%ax
 	ret
 
-#if defined(CONFIG_EDID)
 	store_edid:
 	pushw	%es				# just save all affected 
 	pushw	%ax				# affected registers
@@ -1914,21 +1913,22 @@
 store_edid_magic:	
 	movb	$0x13, %al 
 	movw    $128, %cx
-	movw	$0x600, %di
+	movw	$0x440, %di
 	cld
 	rep 
 	stosb  
 	ret
+#if defined(CONFIG_EDID)
 read_edid:	
 	movw	$0x4f15, %ax
 	movw	$0x01, %bx
 	movw	$0x00, %cx
 	movw    $0x01, %dx
-	movw	$0x600, %di
+	movw	$0x440, %di
 	int	$0x10	
 	ret
 #else
-store_edid:
+read_edid:
 	ret
 #endif
 
diff -Naur linux-2.5.64-fbdev/arch/i386/kernel/setup.c linux-2.5.64/arch/i386/kernel/setup.c
--- linux-2.5.64-fbdev/arch/i386/kernel/setup.c	2003-03-11 21:19:34.000000000 +0000
+++ linux-2.5.64/arch/i386/kernel/setup.c	2003-03-11 21:07:24.000000000 +0000
@@ -496,23 +496,6 @@
 #define copy_edd() do {} while (0)
 #endif
 
-#if defined(CONFIG_EDID)
-/*
- * Since empty_zero_page has a limited size, we are going to use the
- * same offset as EDD.  Thus, copying of the EDID block will only be
- * enabled if EDD is disabled.  
- */
-static inline void copy_edid(void)
-{
-	edid_info = EDID_INFO;
-}
-#else
-static inline void copy_edid(void)
-{
-	memset(&edid_info, 0x13, 128);
-}
-#endif
-
 /*
  * Do NOT EVER look at the BIOS memory size location.
  * It does not work on many machines.
@@ -880,7 +863,7 @@
  	ROOT_DEV = ORIG_ROOT_DEV;
  	drive_info = DRIVE_INFO;
  	screen_info = SCREEN_INFO;
-	copy_edid();
+	edid_info = EDID_INFO;
 	apm_info.bios = APM_BIOS_INFO;
 	saved_videomode = VIDEO_MODE;
 	printk("Video mode to be used for restore is %lx\n", saved_videomode);
diff -Naur linux-2.5.64-fbdev/drivers/video/Kconfig linux-2.5.64/drivers/video/Kconfig
--- linux-2.5.64-fbdev/drivers/video/Kconfig	2003-03-11 21:19:34.000000000 +0000
+++ linux-2.5.64/drivers/video/Kconfig	2003-03-11 21:07:47.000000000 +0000
@@ -6,7 +6,7 @@
 
 config EDID
 	bool "Get EDID block from VBE"
-	depends on X86 && !EDD
+	depends on X86
           
 config FB
 	bool "Support for frame buffer devices"
diff -Naur linux-2.5.64-fbdev/include/asm-i386/setup.h linux-2.5.64/include/asm-i386/setup.h
--- linux-2.5.64-fbdev/include/asm-i386/setup.h	2003-03-11 21:19:34.000000000 +0000
+++ linux-2.5.64/include/asm-i386/setup.h	2003-03-11 21:07:25.000000000 +0000
@@ -37,10 +37,10 @@
 #define KERNEL_START (*(unsigned long *) (PARAM+0x214))
 #define INITRD_START (*(unsigned long *) (PARAM+0x218))
 #define INITRD_SIZE (*(unsigned long *) (PARAM+0x21c))
+#define EDID_INFO   (*(struct edid_info *) (PARAM+0x440))
+#define EDID_SIZE   128
 #define EDD_NR     (*(unsigned char *) (PARAM+EDDNR))
 #define EDD_BUF     ((struct edd_info *) (PARAM+EDDBUF))
-/* Note: EDID_INFO uses the same offset as EDD_BUF */
-#define EDID_INFO   (*(struct edid_info *) (PARAM+EDDBUF))
 #define COMMAND_LINE ((char *) (PARAM+2048))
 #define COMMAND_LINE_SIZE 256
 



-------------------------------------------------------
This SF.net email is sponsored by:Crypto Challenge is now open! 
Get cracking and register here for some mind boggling fun and 
the chance of winning an Apple iPod:
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0031en
