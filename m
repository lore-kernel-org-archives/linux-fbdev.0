From: Andrew Morton <akpm@osdl.org>
Subject: Fw: [PATCH][2.6.11-mm3] CONFIG_FB_ATY linkage error on PPC32
Date: Sun, 13 Mar 2005 13:28:44 -0800
Message-ID: <20050313132844.7270c817.akpm@osdl.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DAaeD-0005yj-GR
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 13 Mar 2005 13:29:17 -0800
Received: from fire.osdl.org ([65.172.181.4] helo=smtp.osdl.org)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.41)
	id 1DAaeA-0002zu-VR
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 13 Mar 2005 13:29:17 -0800
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
To: Jon Smirl <jonsmirl@gmail.com>, linux-fbdev-devel@lists.sourceforge.net
Cc: Mikael Pettersson <mikpe@csd.uu.se>

ack?


Begin forwarded message:

Date: Sun, 13 Mar 2005 00:27:01 +0100 (MET)
From: Mikael Pettersson <mikpe@csd.uu.se>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH][2.6.11-mm3] CONFIG_FB_ATY linkage error on PPC32


On ppc32 the ATI Mach64 frame buffer references symbols on macmodes.o.
In Linus' 2.6.11 macmodes.o is automatically included, but not so in
2.6.11-mm3, causing linkage errors.

The quick-and-dirty hack below worked for me.

/Mikael

--- linux-2.6.11-mm2/drivers/video/Makefile.~1~	2005-03-09 23:20:08.000000000 +0100
+++ linux-2.6.11-mm2/drivers/video/Makefile	2005-03-11 18:03:29.000000000 +0100
@@ -29,7 +29,7 @@ obj-$(CONFIG_FB_PM3)		  += pm3fb.o
 obj-$(CONFIG_FB_MATROX)		  += matrox/
 obj-$(CONFIG_FB_RIVA)		  += riva/ vgastate.o
 obj-$(CONFIG_FB_NVIDIA)		  += nvidia/
-obj-$(CONFIG_FB_ATY)		  += aty/
+obj-$(CONFIG_FB_ATY)		  += aty/ macmodes.o
 obj-$(CONFIG_FB_ATY128)		  += aty/
 obj-$(CONFIG_FB_RADEON)		  += aty/
 obj-$(CONFIG_FB_SIS)		  += sis/


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
