From: Dennis Munsie <dmunsie@cecropia.com>
Subject: [PATCH 0/5 2.6.17-rc6-mm2] add vsync interrupt
	support to intelfb driver
Date: Wed, 14 Jun 2006 09:10:18 -0400
Message-ID: <F321C0F0-2A24-4A4D-B1FE-C721C8B9DE20@cecropia.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0 (Apple Message framework v750)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-list1-b.sourceforge.net ([10.3.1.7]
	helo=sc8-sf-list1.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1FqV6i-00072R-6K for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 14 Jun 2006 06:08:28 -0700
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FqV6i-0002iI-0w for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 14 Jun 2006 06:08:28 -0700
Received: from mail8.sea5.speakeasy.net ([69.17.117.10])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1FqV6h-0004yv-QW
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 14 Jun 2006 06:08:28 -0700
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
To: linux-fbdev-devel@lists.sourceforge.net
Cc: Eric Hustvedt <ehustvedt@cecropia.com>, Dave Airlie <airlied@skynet.ie>

Hi again,

here is a series of patches for the intelfb driver that adds vsync  
interrupt support to the intelfb driver.  There are two ways to get  
at the exposed functionality -- you can use either the unofficial  
FBIO_WAITFORVSYNC ioctl or you can pass FB_ACTIVATE_VBL as a flag  
when you pan the display.  Either way, you can now get a flicker-free  
display out of the framebuffer.

This functionality was modeled on existing functionality that is  
already in the aty and matrox framebuffer drivers.

dennis
