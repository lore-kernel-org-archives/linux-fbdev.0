From: James Simmons <jsimmons@infradead.org>
Subject: Framebuffer updates.
Date: Tue, 25 Mar 2003 17:57:18 +0000 (GMT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.33.0303251032320.4272-100000@maxwell.earthlink.net>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from phoenix.mvhi.com ([195.224.96.167] helo=phoenix.infradead.org)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 18xsgK-0001XD-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 25 Mar 2003 09:57:53 -0800
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>


As usually I have a patch avalaible at 

http://phoenix.infradead.org/~jsimmons/fbdev.diff.gz

 drivers/video/aty/aty128fb.c  |   16 +++++++---------
 drivers/video/console/fbcon.c |    4 ++--
 drivers/video/controlfb.c     |   18 +++---------------
 drivers/video/platinumfb.c    |   28 ++++++++--------------------
 drivers/video/radeonfb.c      |   10 ++++++++++
 drivers/video/softcursor.c    |    2 +-
 6 files changed, 31 insertions(+), 47 deletions(-)

The patch has updates for the ATI Rage 128, Control, and Platnium 
framebuffer driver. The Radeon patch adds PLL times for the R* series of
cards. Memory is now safe to allocate for the software cursor and inside 
fbcon. There still are issues with syncing which cause the cursor on some 
systems to become corrupt sometimes. 





-------------------------------------------------------
This SF.net email is sponsored by:
The Definitive IT and Networking Event. Be There!
NetWorld+Interop Las Vegas 2003 -- Register today!
http://ads.sourceforge.net/cgi-bin/redirect.pl?keyn0001en
