From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 06/12] pvr2fb: Make PVR2_VBLANK
	interrupt shareable
Date: Sat, 15 Sep 2007 08:03:56 +0800
Message-ID: <46EB216C.6040002@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IWLEi-0007m7-W6 for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 14 Sep 2007 17:10:14 -0700
Received: from rv-out-0910.google.com ([209.85.198.189])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1IWLEi-0003jU-NA
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 14 Sep 2007 17:10:12 -0700
Received: by rv-out-0910.google.com with SMTP id g11so3286302rvb
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Fri, 14 Sep 2007 17:10:12 -0700 (PDT)
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
To: Andrew Morton <akpm@osdl.org>
Cc: Adrian McMenamin <adrian@mcmen.demon.co.uk>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

From: Adrian McMenamin <adrian@mcmen.demon.co.uk>

This makes the PVR2 VBLANK interrupt on the SEGA Dreamcast
shareable - a small but necessary change to enable ongoing efforts to
develop a driver for the maple bus on the Dreamcast. (Maple is Sega's
proprietary serial interface for the Dreamcast and can be set to
synchronise dma transfers to the VBLANK).

This has no impact on the performance of the PVR2.

Signed-off-by: Adrian McMenamin <adrian@mcmen.demon.co.uk>
Signed-off-by: Antonino Daplas <adaplas@gmail.com>
---

 drivers/video/pvr2fb.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/video/pvr2fb.c b/drivers/video/pvr2fb.c
index 994baad..cc0cf07 100644
--- a/drivers/video/pvr2fb.c
+++ b/drivers/video/pvr2fb.c
@@ -890,7 +890,7 @@ static int __init pvr2fb_dc_init(void)
 	pvr2_fix.mmio_start	= 0xa05f8000;	/* registers start here */
 	pvr2_fix.mmio_len	= 0x2000;
 
-	if (request_irq(HW_EVENT_VSYNC, pvr2fb_interrupt, 0,
+	if (request_irq(HW_EVENT_VSYNC, pvr2fb_interrupt, IRQF_SHARED,
 	                "pvr2 VBL handler", fb_info)) {
 		return -EBUSY;
 	}


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
