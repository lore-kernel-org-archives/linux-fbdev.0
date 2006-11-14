From: James Simmons <jsimmons@infradead.org>
Subject: ACPI output/lcd/auxdisplay mess
Date: Tue, 14 Nov 2006 19:41:37 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0611141939050.6957@pentafluge.infradead.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Gk4AH-0003Ua-5O for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 14 Nov 2006 11:41:49 -0800
Received: from pentafluge.infradead.org ([213.146.154.40])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1Gk4AF-0007Nn-Ia
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 14 Nov 2006 11:41:49 -0800
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
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Luming Yu <Luming.yu@intel.com>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Miguel Ojeda Sandonis <maxextreme@gmail.com>, Andrew Zabolotny <zap@homelink.ru>, Jamey Hicks <jamey.hicks@hp.com>


I have noticed a bunch of patches coming in dealing with the same problem. How to handle displays 
i.e LCD, CRT etc. We have a lcd class in video/backlight which no one is using. Because no one was
aware of it auxdisplay was created instead. Then we have the acpi code which wants a output class
to handle powering down the display device. Plus the acpi layer does something very similar to the
framebuffer with getting edids and data relating to the display device. We really should place all
this handling in one standard place. To do this I need to know what all of you require.

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
