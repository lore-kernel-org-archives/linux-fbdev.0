From: James Simmons <jsimmons@infradead.org>
Subject: New Permedia2 framebuffer driver.
Date: Wed, 3 Mar 2004 22:20:58 +0000 (GMT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0403032220410.30666-100000@phoenix.infradead.org>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Ayewq-00065f-Bs
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 03 Mar 2004 14:34:40 -0800
Received: from phoenix.infradead.org ([213.86.99.234])
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30)
	id 1AyeQV-0001pu-NS
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 03 Mar 2004 14:01:16 -0800
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>


This patch fixes the permedia2 framebuffer driver. Currently it doesn't 
event compile. This patch only touches the current permedia driver. 
Regular patch is valiable at

http://phoenix.infradead.org/~jsimmons/pm2fb.diff

or you can grab the patch at:

	bk pull bk://fbdev.bkbits.net/fbdev-2.6

This will update the following files:

 drivers/video/cvisionppc.h |   51 
 include/video/pm2fb.h      |  222 ---
 drivers/video/Kconfig      |   18 
 drivers/video/Makefile     |    2 
 drivers/video/pm2fb.c      | 3014 +++++++++++++--------------------------------
 include/video/cvisionppc.h |   51 
 include/video/permedia2.h  |  222 +++
 7 files changed, 1210 insertions(+), 2370 deletions(-)

through these ChangeSets:

<jsimmons@infradead.org> (04/02/17 1.1557.1.5)
   [PERMEDIA2 FBDEV] Updated to the new api.





-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
