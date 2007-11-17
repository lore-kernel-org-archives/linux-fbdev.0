From: Helge Deller <deller@gmx.de>
Subject: [PATCH] stifb: fix crash A1439A CRX (Rattler)
	graphics card
Date: Sat, 17 Nov 2007 22:37:07 +0100
Message-ID: <200711172237.07833.deller@gmx.de>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1ItVNC-0002Qj-Aj for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 17 Nov 2007 13:38:42 -0800
Received: from mail.gmx.net ([213.165.64.20])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1ItVNA-0005AK-MR
	for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 17 Nov 2007 13:38:42 -0800
Content-Disposition: inline
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: linux-fbdev-devel@lists.sourceforge.net, "Antonino A.Daplas" <adaplas@gmail.com>

Fix kernel crash when stifb driver is used with a A1439A CRX (Rattler) graphics card.
(Reference: http://thread.gmane.org/gmane.linux.ports.hppa/1834)

Signed-off-by: Helge Deller <deller@gmx.de>

 stifb.c |   22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/drivers/video/stifb.c b/drivers/video/stifb.c
index c97709e..6e5f138 100644
--- a/drivers/video/stifb.c
+++ b/drivers/video/stifb.c
@@ -505,16 +505,24 @@ ngleSetupAttrPlanes(struct stifb_info *fb, int BufferNumber)
 static void
 rattlerSetupPlanes(struct stifb_info *fb)
 {
+	int saved_id, y;
+
+ 	/* Write RAMDAC pixel read mask register so all overlay
+	 * planes are display-enabled.  (CRX24 uses Bt462 pixel
+	 * read mask register for overlay planes, not image planes).
+	 */
 	CRX24_SETUP_RAMDAC(fb);
     
-	/* replacement for: SETUP_FB(fb, CRX24_OVERLAY_PLANES); */
-	WRITE_WORD(0x83000300, fb, REG_14);
-	SETUP_HW(fb);
-	WRITE_BYTE(1, fb, REG_16b1);
+	/* change fb->id temporarily to fool SETUP_FB() */
+	saved_id = fb->id;
+	fb->id = CRX24_OVERLAY_PLANES;
+	SETUP_FB(fb);
+	fb->id = saved_id;
+
+	for (y = 0; y < fb->info.var.yres; ++y)
+		memset(fb->info.screen_base + y * fb->info.fix.line_length,
+			0xff, fb->info.var.xres * fb->info.var.bits_per_pixel/8);
 
-	fb_memset((void*)fb->info.fix.smem_start, 0xff,
-		fb->info.var.yres*fb->info.fix.line_length);
-    
 	CRX24_SET_OVLY_MASK(fb);
 	SETUP_FB(fb);
 }

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
