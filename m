From: James Simmons <jsimmons@infradead.org>
Subject: Framebuffer fixes.
Date: Wed, 26 Mar 2003 19:57:08 +0000 (GMT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0303261951090.21188-100000@phoenix.infradead.org>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from carisma.slowglass.com ([195.224.96.167] helo=phoenix.infradead.org)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 18yH1s-0003Em-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 26 Mar 2003 11:57:46 -0800
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


Okay. Here you go. This patch is against 2.5.66 vanialla. I tested to see 
if it applied. It does. Basically I added back in the static buffers in 
accel_cursor in fbcon.c. Now the cursor will work just like it did before. 
The draw back is that if you have more than one framebuffer then the 
cursors will be messed up. So for single headed frmaebuffer systems it 
will work perfectly. It is not that big of a deal since the console layer 
is broken for multi-head and pre-emptive support anyways. Plus fbcon has 
issues as well. The proper fix would require a huge amount of work. 
I have a few updated drivers as well. Please test.

http://phoenix.infradead.org/~jsimmons/fbdev.diff.gz

 drivers/video/aty/aty128fb.c    |   16 +-
 drivers/video/cfbimgblt.c       |    4
 drivers/video/console/fbcon.c   |  246 +++++++++++++++++++++-------------------
 drivers/video/controlfb.c       |   18 --
 drivers/video/fbmem.c           |   42 ++----
 drivers/video/i810/i810.h       |    6
 drivers/video/i810/i810_accel.c |  140 +++++++++++-----------
 drivers/video/i810/i810_dvt.c   |    3
 drivers/video/i810/i810_gtf.c   |    7 -
 drivers/video/i810/i810_main.c  |  135 +++++++++------------
 drivers/video/i810/i810_main.h  |    4
 drivers/video/logo/logo.c       |   69 +++++------
 drivers/video/platinumfb.c      |   28 +---
 drivers/video/radeonfb.c        |   10 +
 drivers/video/riva/fbdev.c      |    2
 drivers/video/softcursor.c      |   95 ++++-----------
 drivers/video/tdfxfb.c          |   18 +-
 drivers/video/tgafb.c           |    2
 drivers/video/vga16fb.c         |    4
 include/linux/fb.h              |    4
 include/linux/linux_logo.h      |    2
 21 files changed, 393 insertions(+), 462 deletions(-)




-------------------------------------------------------
This SF.net email is sponsored by:
The Definitive IT and Networking Event. Be There!
NetWorld+Interop Las Vegas 2003 -- Register today!
http://ads.sourceforge.net/cgi-bin/redirect.pl?keyn0001en
