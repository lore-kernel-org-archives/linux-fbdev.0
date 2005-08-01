From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 2/2] tridentfb: Fix scrolling artifacts during disk IO
Date: Mon, 01 Aug 2005 23:51:34 +0800
Message-ID: <42EE4506.1000000@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DzcbM-0007Dt-Bo
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 01 Aug 2005 08:53:16 -0700
Received: from wproxy.gmail.com ([64.233.184.195])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1DzcbL-0002P7-Jn
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 01 Aug 2005 08:53:16 -0700
Received: by wproxy.gmail.com with SMTP id i27so1139683wra
        for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 01 Aug 2005 08:53:09 -0700 (PDT)
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
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: Jochen Hein <jochen@jochen.org>, Knut Petersen <Knut_Petersen@t-online.de>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

   Reported by: Jochen Hein (Bugzilla Bug 4312)

   When there is disk I/O happening, the framebuffer has a little snow on the
   screen.  Once I/O has finished, no garbage remains on screen.

   This bug was explained by: Knut Petersen

   Most important is CRTC register 2f, signal quality is also improved for
   higher vclk values by changing set_vclk() according to the X drivers and
   cyblafb.c

   Fix is to set the performance register (0x2f) with a more stable value.

   From: Antonino Daplas <adaplas@pol.net>
   Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

tridentfb.c |    2 +-
1 files changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/video/tridentfb.c
+++ b/drivers/video/tridentfb.c
@@ -904,7 +904,7 @@ static int tridentfb_set_par(struct fb_i
	write3X4(DRAMControl, tmp);	//both IO,linear enable

	write3X4(InterfaceSel, read3X4(InterfaceSel) | 0x40);
-	write3X4(Performance,0x20);
+	write3X4(Performance,0x92);
	write3X4(PCIReg,0x07);		//MMIO & PCI read and write burst enable

	/* convert from picoseconds to MHz */




-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
