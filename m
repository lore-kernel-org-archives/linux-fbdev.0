From: Alessandro Selli <dhatarattha@route-add.net>
Subject: Jitter on Matrox G450 in Xorg
Date: Sat, 30 Aug 2008 19:39:47 +0200
Message-ID: <48B985E3.4060901@route-add.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KZUQa-0000tv-As for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 30 Aug 2008 10:40:00 -0700
Received: from mailfe16.tele2.it ([212.247.155.237] helo=swip.net)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1KZUQX-0007ZH-LK
	for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 30 Aug 2008 10:40:00 -0700
Received: from [93.148.101.57] (account eu1855535@tele2.it HELO
	[192.168.110.4]) by mailfe16.swip.net (CommuniGate Pro SMTP 5.2.6)
	with ESMTPA id 317134929 for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 30 Aug 2008 19:39:50 +0200
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
To: linux-fbdev-devel@lists.sourceforge.net

   Hello,
	I am experiencing a jitter under Xorg 7.2 with a G450 AGP card on a 
VIA, AMD K6-II PC.  I noticed this happens with kernels 2.6.23 and later.

   Investigating this, I read on 
http://www.kernel.org/pub/linux/kernel/v2.6/ChangeLog-2.6.23:

commit e798bd95b61918e653f3d28f9176237236f2d103
Author: Paul A. Clarke <pc@us.ibm.com>
Date:   Fri Aug 10 13:00:49 2007 -0700

     matroxfb: rectify jitter (G450/G550)

     This builds upon my previous attempts to resolve some jitter
     problems seen with the Matrox G450 and G550 -based cards,
     including odd disparities observed between x86 and Power -based
     machines in a somewhat less hackish way (removing the hacked
     ifdefs).

     Apparently, preference should be given to use the DVI PLL when
     frequencies permit, the Standard PLL otherwise.  The max pixel clock
     for the panellink interface is extracted from the PInS information
     on the card and used as a limit to determine which PLL to use.


   The same information, with diffs, I could read on the following post 
from this ML's archive: 
http://sourceforge.net/mailarchive/message.php?msg_id=46B0396C.1020407%40gmail.com

   I am not 100% sure this has to do with the framebuffer driver or with 
some other kernel driver that xorg uses (DRM_MGA?), but so far I only 
found jitter issues concerning the matroxfb driver and did not find 
references to the mga driver in the above changelog.

   If the jitter I am experiencing is due to the above change, I wonder 
if there is a way to revert to the old mechanism without modifying the 
driver source code and recompiling.  That is, I wonder if there is a 
driver load-time parameter that allows trying first the DVI PLL when 
possible, or sticking to the Standard PLL regardless.

   BTW, how can I see which PLL the driver is currently using?


   Thank you,

-- 
Alessandro Selli
Tel: 340.839.73.05
http://alessandro.route-add.net
Chiave PGP/GPG key: EC885A8B

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
