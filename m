From: Otto Wyss <otto.wyss@orpatec.ch>
Subject: Generic framebuffer driver
Date: Fri, 20 Aug 2004 17:42:42 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <41261BF3.19B87A64@orpatec.ch>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1ByBXX-0003dk-V9
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 20 Aug 2004 08:42:51 -0700
Received: from mail.xor.ch ([212.55.210.163])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.34)
	id 1ByBXX-00036M-3f
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 20 Aug 2004 08:42:51 -0700
Received: from orpatec.ch (217.162.130.125)
          by mail.xor.ch with MERCUR Mailserver (v4.03.03 NjYtMjMxMS00NjIy)
          for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 20 Aug 2004 17:47:37 +0200
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
To: 'linux-fbdev-devel' <linux-fbdev-devel@lists.sourceforge.net>

Since I never could acceptable align my monitor screen between Windows,
Linux console and Linux X-server I bought a DVI cable and switch to
digital mode. Immediately I discovered a fantastic feature of the radeon
framebuffer driver, it's able to discover the correct resolution of my
LCD monitor.

I guess this is a common feature of the digital interface and might be
available for any graphic card/monitor with DVI. Does anyone know for
sure? If yes this feature would allow to create a generic framebuffer
driver which could be built into the kernel and used right from the
start. How nice would it be to have a shiny startup screen right from
the start of Linux! All the startup messages could be shown in a decent
font (maybe even configurable) and might be surrounded by a nice window.
What a difference would it make against the current DOS-like look.

The main task of this generic driver is to detect and switch to the
correct resolution and may only handle simple 2D drawing. It should only
support common features. It needs only be useful during startup and in
cases no specific framebuffer driver exists. And of course it has to
stop working and yield any resources when a card specific driver is loaded.

Do you also think such a generic driver should exist? Is anyone able to
create it, maybe simply extract it from the radeonfb?

O. Wyss

-- 
See a huge pile of work at "http://wyodesktop.sourceforge.net/"


-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
