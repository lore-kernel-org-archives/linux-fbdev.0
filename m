From: James Simmons <jsimmons@infradead.org>
Subject: Permedia2 framebuffer update.
Date: Thu, 19 Feb 2004 18:52:24 +0000 (GMT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0402191850370.26734-100000@phoenix.infradead.org>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1AttN6-0005Ah-5s
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 19 Feb 2004 10:58:04 -0800
Received: from phoenix.infradead.org ([213.86.99.234])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30)
	id 1AttHg-00065g-R5
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 19 Feb 2004 10:52:29 -0800
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
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>


Hi!

  Here is the new permedia2 framebuffer driver ported to the new api. Link 
to diff for viewing is at

http://phoenix.infradead.org:~/jsimmons/pm2fb.diff

Linus, please do a

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

<jsimmons@infradead.org> (04/02/17 1.1562)
   [PERMEDIA2 FBDEV] Updated to the new api.




-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
