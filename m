From: James Simmons <jsimmons@infradead.org>
Subject: Re: Framebuffer cursor updates.
Date: Wed, 2 Apr 2003 20:03:32 +0100 (BST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0304022002320.1611-100000@phoenix.infradead.org>
References: <Pine.LNX.4.33.0304021137570.7983-100000@maxwell.earthlink.net>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from phoenix.mvhi.com ([195.224.96.167] helo=phoenix.infradead.org)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 190nWr-0001nD-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 02 Apr 2003 11:04:10 -0800
In-Reply-To: <Pine.LNX.4.33.0304021137570.7983-100000@maxwell.earthlink.net>
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
To: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

> 
> Hi folks!!!
> 
>   I have a new patch to fix the cursor problems. This patch Is a massive 
> rewrite of the cursor handling code. I have tested it on two machines. The 
> VBL irq code in fbcon.c should be moved to there respected drivers. Please 
> review and test. 

Oops. The patch is at 

http://phoenix.infradead.org/~jsimmons/fbdev.diff.gz

and it does apply against 2.5.66. 

 Documentation/devices.txt       |    7 
 drivers/video/aty/aty128fb.c    |   16 -
 drivers/video/cfbimgblt.c       |    4 
 drivers/video/console/fbcon.c   |  548 ++++++++++++++++++----------------------
 drivers/video/console/fbcon.h   |    1 
 drivers/video/controlfb.c       |   18 -
 drivers/video/fbcmap.c          |   33 +-
 drivers/video/fbmem.c           |  159 ++++++-----
 drivers/video/i810/i810.h       |    6 
 drivers/video/i810/i810_accel.c |  140 +++++-----
 drivers/video/i810/i810_dvt.c   |    3 
 drivers/video/i810/i810_gtf.c   |    7 
 drivers/video/i810/i810_main.c  |  135 ++++-----
 drivers/video/i810/i810_main.h  |    4 
 drivers/video/logo/logo.c       |   69 ++---
 drivers/video/platinumfb.c      |   28 --
 drivers/video/radeonfb.c        |   10 
 drivers/video/riva/fbdev.c      |    2 
 drivers/video/softcursor.c      |  198 +++++++-------
 drivers/video/tdfxfb.c          |   18 -
 drivers/video/tgafb.c           |    2 
 drivers/video/vga16fb.c         |    6 
 include/linux/fb.h              |   16 -
 include/linux/linux_logo.h      |    2 
 24 files changed, 690 insertions(+), 742 deletions(-)

through these ChangeSets:

<jsimmons@kozmo.(none)> (03/04/02 1.991.1.2)
   [FBDEV SOFT CURSOR] Test to see if kmalloc failed.
   
   [FBCON] Test to see if the user priovides there own work queue.

<jsimmons@kozmo.(none)> (03/04/02 1.991.1.1)
   [FBDEV] Final cursor code cleanups. Now the burden of handling the cursor code lies on the driver side. The reason for this is that a invalid cursor might come from userland.

<jsimmons@kozmo.(none)> (03/03/31 1.990)
   [FBDEV] Massive cleanups of the cursor api.

<jsimmons@maxwell.earthlink.net> (03/03/26 1.986)
   [FBDEV] Documentation on the device numbers of /dev/fb being mulitples of 32 is no longer true. Removed that info.
   
   [FBDEV] Logo fixes. Now we can display different color logos on screens of different color depths.
   
   [VGA16 FBDEV] Small compile error. Fixed it now.

<jsimmons@maxwell.earthlink.net> (03/03/26 1.984)
   [I810 FBDEV] Driver updates.
   
   [FBCON] Reversed some of my cursor changes.

<jsimmons@kozmo.(none)> (03/03/25 1.983)
   [FBDEV] The image color depth of zero hack has been killed.

<jsimmons@maxwell.earthlink.net> (03/03/25 1.982)
   [FBCON] Now we use workqueues so framebuffer code can always work in a process context.
   
   [GENERIC CURSOR] Safety check in case kmalloc failes

<jsimmons@maxwell.earthlink.net> (03/03/25 1.981)
   [FBCON] Could be called outside of a process context. This fixes that.

<jsimmons@maxwell.earthlink.net> (03/03/25 1.979)
   [RAGE 128/CONTROL/PLATNIUM FBDEV] PPC updates.
   
   [RADEON FBDEV] PLL fix for specific type of card.




-------------------------------------------------------
This SF.net email is sponsored by: ValueWeb: 
Dedicated Hosting for just $79/mo with 500 GB of bandwidth! 
No other company gives more support or power for your dedicated server
http://click.atdmt.com/AFF/go/sdnxxaff00300020aff/direct/01/
