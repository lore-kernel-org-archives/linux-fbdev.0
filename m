From: James Simmons <jsimmons@infradead.org>
Subject: [BK FBDEV] A few more updates.
Date: Tue, 25 Mar 2003 10:32:11 -0800 (PST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.33.0303251031180.4272-100000@maxwell.earthlink.net>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from scaup.mail.pas.earthlink.net ([207.217.120.49])
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18xsQH-0001iQ-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 25 Mar 2003 09:41:17 -0800
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
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>


Linus, please do a

	bk pull http://fbdev.bkbits.net/fbdev-2.5

This will update the following files:

 drivers/video/aty/aty128fb.c  |   16 +++++++---------
 drivers/video/console/fbcon.c |    4 ++--
 drivers/video/controlfb.c     |   18 +++---------------
 drivers/video/platinumfb.c    |   28 ++++++++--------------------
 drivers/video/radeonfb.c      |   10 ++++++++++
 drivers/video/softcursor.c    |    2 +-
 6 files changed, 31 insertions(+), 47 deletions(-)

through these ChangeSets:

<jsimmons@maxwell.earthlink.net> (03/03/25 1.981)
   [FBCON] Could be called outside of a process context. This fixes that.

<jsimmons@maxwell.earthlink.net> (03/03/25 1.979)
   [RAGE 128/CONTROL/PLATNIUM FBDEV] PPC updates.

   [RADEON FBDEV] PLL fix for specific type of card.




-------------------------------------------------------
This SF.net email is sponsored by:
The Definitive IT and Networking Event. Be There!
NetWorld+Interop Las Vegas 2003 -- Register today!
http://ads.sourceforge.net/cgi-bin/redirect.pl?keyn0001en
