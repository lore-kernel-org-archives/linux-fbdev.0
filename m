From: aherrman@arcor.de
Subject: Re: [PATCH 4/4] radeonfb: use PCI device Id in
	hex for name string
Date: Mon, 10 Sep 2007 23:41:18 +0200
Message-ID: <20070910214118.GA5155@devil>
References: <20070904110050.GH7320@devil>
	<1188913688.5972.155.camel@localhost.localdomain>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IUqzI-0004BU-Dv for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 10 Sep 2007 14:40:08 -0700
Received: from mail-in-08.arcor-online.net ([151.189.21.48])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1IUqzG-0003Yn-Ni
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 10 Sep 2007 14:40:08 -0700
Content-Disposition: inline
In-Reply-To: <1188913688.5972.155.camel@localhost.localdomain>
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
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org

On Tue, Sep 04, 2007 at 03:48:07PM +0200, Benjamin Herrenschmidt wrote:
> Well... ATI used to have printable characters and those were commonly
> used to identify the cards. I'm not sure we want to unilateraly switch
> to hex here...

I see.
How about the following patch?
As an illustration this gives following output for some cards:

  radeonfb (0000:01:05.0): ATI Radeon 5975 "Yu"
  radeonfb (0000:02:00.0): ATI Radeon 5b60 "[`"
  radeonfb (0000:02:00.0): ATI Radeon 5960 "Y`"


Regards,

Andreas

--
radeonfb: use PCI device id in hex for name string

Additionally provide PCI device id in character format if possible.
(The printable characters were commonly used to identify the cards.)

Signed-off-by: Andreas Herrmann <aherrman@arcor.de>
---
 drivers/video/aty/radeon_base.c |   14 +++++++++++---
 1 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/video/aty/radeon_base.c b/drivers/video/aty/radeon_base.c
index b1bee6f..306d3c7 100644
--- a/drivers/video/aty/radeon_base.c
+++ b/drivers/video/aty/radeon_base.c
@@ -57,6 +57,7 @@
 #include <linux/kernel.h>
 #include <linux/errno.h>
 #include <linux/string.h>
+#include <linux/ctype.h>
 #include <linux/mm.h>
 #include <linux/slab.h>
 #include <linux/delay.h>
@@ -2156,6 +2157,7 @@ static int __devinit radeonfb_pci_register (struct pci_dev *pdev,
 	struct fb_info *info;
 	struct radeonfb_info *rinfo;
 	int ret;
+	unsigned char c1, c2;
 
 	RTRACE("radeonfb_pci_register BEGIN\n");
 	
@@ -2183,9 +2185,15 @@ static int __devinit radeonfb_pci_register (struct pci_dev *pdev,
 	rinfo->lvds_timer.function = radeon_lvds_timer_func;
 	rinfo->lvds_timer.data = (unsigned long)rinfo;
 
-	strcpy(rinfo->name, "ATI Radeon XX ");
-	rinfo->name[11] = ent->device >> 8;
-	rinfo->name[12] = ent->device & 0xFF;
+	c1 = ent->device >> 8;
+	c2 = ent->device & 0xff;
+	if (isprint(c1) && isprint(c2))
+		snprintf(rinfo->name, sizeof(rinfo->name),
+			 "ATI Radeon %x \"%c%c\"", ent->device & 0xffff, c1, c2);
+	else
+		snprintf(rinfo->name, sizeof(rinfo->name),
+			 "ATI Radeon %x", ent->device & 0xffff);
+
 	rinfo->family = ent->driver_data & CHIP_FAMILY_MASK;
 	rinfo->chipset = pdev->device;
 	rinfo->has_CRTC2 = (ent->driver_data & CHIP_HAS_CRTC2) != 0;
-- 
1.5.3



-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
