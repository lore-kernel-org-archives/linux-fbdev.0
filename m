From: Kronos <kronos@kronoz.cjb.net>
Subject: [PATCH] New framebuffer_alloc API and class_dev changes
Date: Mon, 15 Sep 2003 21:33:51 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20030915193351.GA16370@dreamland.darkstar.lan>
Reply-To: kronos@kronoz.cjb.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19yz7Q-00032p-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 15 Sep 2003 12:34:40 -0700
Received: from mail-5.tiscali.it ([195.130.225.151])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 19yz7Q-00017W-2s
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 15 Sep 2003 12:34:40 -0700
Content-Disposition: inline
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: James Simmons <jsimmons@infradead.org>
Cc: linux-fbdev-devel@lists.sourceforge.net

Ok,  I  finished  the  class_dev  stuff. Now  we  have  a  new  function
framebuffer_alloc which  creates a  new struct fb_info  and (optionally)
allocates space for driver specific stuff. It also takes care of setting
class_dev.dev.

I left untouched only (hope so) drivers that are still using old API.

James, you can find the BK patch (against you tree) here:

	http://web.tiscali.it/kronoz/linux/fbdev-class_dev-all.bk.bz2

You can import this changeset into BK by piping this whole file to:
'| bzip2 -cd | bk receive [path to repository]' or apply the patch as usual.

This will update the following files:

 drivers/video/acornfb.c               |  261 +++++++++++++++++-----------------
 drivers/video/amifb.c                 |  120 +++++++++------
 drivers/video/anakinfb.c              |   34 ++--
 drivers/video/aty/aty128fb.c          |   42 ++---
 drivers/video/aty/atyfb_base.c        |   60 ++-----
 drivers/video/bw2.c                   |   72 ++++-----
 drivers/video/cg14.c                  |   99 ++++++------
 drivers/video/cg3.c                   |   81 +++++-----
 drivers/video/cg6.c                   |   91 +++++------
 drivers/video/chipsfb.c               |   51 ++++--
 drivers/video/cyber2000fb.c           |  207 ++++++++++++++------------
 drivers/video/dnfb.c                  |   18 +-
 drivers/video/fbmem.c                 |  121 ++++++++-------
 drivers/video/ffb.c                   |  112 +++++++-------
 drivers/video/fm2fb.c                 |   33 ++--
 drivers/video/g364fb.c                |   28 ++-
 drivers/video/hgafb.c                 |   38 ++--
 drivers/video/hitfb.c                 |   33 ++--
 drivers/video/hpfb.c                  |   22 +-
 drivers/video/i810/i810_main.c        |   49 ++----
 drivers/video/i810/i810_main.h        |    2 
 drivers/video/igafb.c                 |   26 +--
 drivers/video/imsttfb.c               |   33 ++--
 drivers/video/leo.c                   |   80 +++++-----
 drivers/video/macfb.c                 |   28 ++-
 drivers/video/matrox/i2c-matroxfb.c   |    2 
 drivers/video/matrox/matroxfb_accel.c |   16 +-
 drivers/video/matrox/matroxfb_base.c  |  140 +++++++++---------
 drivers/video/matrox/matroxfb_base.h  |   26 ---
 drivers/video/matrox/matroxfb_crtc2.c |  130 ++++++++--------
 drivers/video/matrox/matroxfb_crtc2.h |    2 
 drivers/video/matrox/matroxfb_misc.c  |    6 
 drivers/video/maxinefb.c              |   24 +--
 drivers/video/neofb.c                 |   21 +-
 drivers/video/offb.c                  |   14 -
 drivers/video/p9100.c                 |   64 ++++----
 drivers/video/platinumfb.c            |   46 +++--
 drivers/video/pmag-ba-fb.c            |   17 +-
 drivers/video/pmagb-b-fb.c            |   19 +-
 drivers/video/pvr2fb.c                |   12 -
 drivers/video/q40fb.c                 |   24 +--
 drivers/video/radeonfb.c              |   71 ++++-----
 drivers/video/riva/fbdev.c            |   38 ++--
 drivers/video/sa1100fb.c              |  163 ++++++++++-----------
 drivers/video/sa1100fb.h              |    2 
 drivers/video/sgivwfb.c               |   62 ++++----
 drivers/video/sis/sis_main.c          |  143 +++++++++++-------
 drivers/video/sis/sis_main.h          |    7 
 drivers/video/sstfb.c                 |   42 ++---
 drivers/video/stifb.c                 |   75 +++++----
 drivers/video/tcx.c                   |  117 +++++++--------
 drivers/video/tdfxfb.c                |   35 ++--
 drivers/video/tgafb.c                 |   74 ++++-----
 drivers/video/tridentfb.c             |   92 +++++++----
 drivers/video/tx3912fb.c              |   40 +++--
 drivers/video/valkyriefb.c            |   41 ++---
 drivers/video/vesafb.c                |   34 ++--
 drivers/video/vfb.c                   |   31 ++--
 drivers/video/vga16fb.c               |   58 ++++---
 include/linux/fb.h                    |    6 
 include/video/neomagic.h              |    4 
 61 files changed, 1834 insertions(+), 1605 deletions(-)

through these ChangeSets:

<kronos@kronoz.cjb.net> (03/09/15 1.1217.3.21)
   Introduce new framebuffer_alloc API.
   struct fb_info must be created using framebuffer_alloc.
   
   struct fb_info will be registered with the driver module and will be kfree'd when the
   driver is unregistered.


I'll also send split patches to this list and to driver maintainers for
review.

Luca
-- 
Reply-To: kronos@kronoz.cjb.net
Home: http://kronoz.cjb.net
Non sempre quello che viene dopo e` progresso.
Alessandro Manzoni


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
