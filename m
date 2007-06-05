From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 3/5] i386: Set 6-bit DAC channel
 properties in vesa video setup
Date: Tue, 05 Jun 2007 19:21:05 +0800
Message-ID: <46654721.9040503@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HvXDd-0008Uc-QK for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 05 Jun 2007 04:28:57 -0700
Received: from py-out-1112.google.com ([64.233.166.180])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HvXDd-0005wq-GS
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 05 Jun 2007 04:28:57 -0700
Received: by py-out-1112.google.com with SMTP id u77so2968809pyb
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Tue, 05 Jun 2007 04:28:57 -0700 (PDT)
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, "H. Peter Anvin" <hpa@zytor.com>

If the video BIOS is not capable of switching or failed to switch the
hardware to 8-bit DAC, the channel properties are not set.  This leads
to a blank (all black) display with vesafb at 8 bpp. Fix by defaulting
to a 6-bit DAC.

Signed-off-by: Antonino Daplas <adaplas@gmail.com>
---

 arch/i386/boot/video-vesa.c |   25 +++++++++++++------------
 1 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/arch/i386/boot/video-vesa.c b/arch/i386/boot/video-vesa.c
index 26d66a7..3c21bd7 100644
--- a/arch/i386/boot/video-vesa.c
+++ b/arch/i386/boot/video-vesa.c
@@ -153,19 +153,21 @@ static int vesa_set_mode(struct mode_inf
 /* Switch DAC to 8-bit mode */
 static void vesa_dac_set_8bits(void)
 {
-	u16 ax, bx;
-	u8 dac_size;
+	u8 dac_size = 6;
 
-	ax = 0x4f08;
-	bx = 0x0800;
-	asm volatile(INT10
-		     : "+a" (ax), "+b" (bx)
-		     : : "ecx", "edx", "esi", "edi");
+	/* If possible, switch the DAC to 8-bit mode */
+	if (vginfo.capabilities & 1) {
+		u16 ax, bx;
 
-	if (ax != 0x004f)
-		return;
+		ax = 0x4f08;
+		bx = 0x0800;
+		asm volatile(INT10
+			     : "+a" (ax), "+b" (bx)
+			     : : "ecx", "edx", "esi", "edi");
 
-	dac_size = bx >> 8;
+		if (ax == 0x004f)
+			dac_size = bx >> 8;
+	}
 
 	/* Set the color sizes to the DAC size, and offsets to 0 */
 	boot_params.screen_info.red_size = dac_size;
@@ -219,8 +221,7 @@ static void vesa_store_mode_params_graph
 	/* General parameters */
 	boot_params.screen_info.lfb_size = vginfo.total_memory;
 
-	/* If possible, switch the DAC to 8-bit mode */
-	if (vminfo.bpp <= 8 && (vginfo.capabilities & 1))
+	if (vminfo.bpp <= 8)
 		vesa_dac_set_8bits();
 
 	vesa_store_pm_info();


-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
