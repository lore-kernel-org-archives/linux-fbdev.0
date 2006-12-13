From: James Cloos <cloos@jhcloos.com>
Subject: drivers/video/aty/radeon_backlight.c
Date: Wed, 13 Dec 2006 08:46:24 -0500
Message-ID: <m3irgflxh4.fsf@lugabout.jhcloos.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GuURx-0007dx-M9 for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 13 Dec 2006 05:47:09 -0800
Received: from ore.jhcloos.com ([64.240.156.239])
	by mail.sourceforge.net with esmtps (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.44) id 1GuURv-0000WS-9E
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 13 Dec 2006 05:47:09 -0800
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
Cc: linux-kernel@vger.kernel.org

Are there any dependencies in $subject which would preclude changing
drivers/video/Kconfig with:

 config FB_RADEON_BACKLIGHT
         bool "Support for backlight control"
-        depends on FB_RADEON && PMAC_BACKLIGHT
+        depends on FB_RADEON
         select FB_BACKLIGHT
         default y
         help
           Say Y here if you want to control the backlight of your display.

or is radeon_backlight.c only functional when -DCONFIG_PMAC_BACKLIGHT,
even though the pmac routines are all ifdef'ed?

-JimC
-- 
James Cloos <cloos@jhcloos.com>         OpenPGP: 1024D/ED7DAEA6

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
