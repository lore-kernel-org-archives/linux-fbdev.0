From: James Simmons <jsimmons@transvirtual.com>
Subject: Re: Re: fbdev updates.
Date: Wed, 5 Jun 2002 10:21:19 -0700 (PDT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0206051020150.24667-100000@www.transvirtual.com>
References: <20020605175013.G10293@flint.arm.linux.org.uk>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from www.transvirtual.com ([206.14.214.140])
	by usw-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 17FeTO-00079N-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 05 Jun 2002 10:21:26 -0700
In-Reply-To: <20020605175013.G10293@flint.arm.linux.org.uk>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=linux-fbdev-devel>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Russell King <rmk@arm.linux.org.uk>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>


> On Wed, Jun 05, 2002 at 09:39:48AM -0700, James Simmons wrote:
> > Since no one has complianed for some time I like to push the next set of
> > changes to Linus. Anyone with objections please give a yell.
>
> A small suggestion - could you post diffstat -p1 output with your patch
> announcements please?

Patch at http://www.transvirtual.com/~jsimmons/fbdev.diff.gz

diffstat results:

 drivers/video/Config.in     |   40
 drivers/video/Makefile      |   28
 drivers/video/anakinfb.c    |    4
 drivers/video/aty128fb.c    |    5
 drivers/video/cfbcopyarea.c |    4
 drivers/video/cfbimgblt.c   |   10
 drivers/video/clps711xfb.c  |    3
 drivers/video/cyber2000fb.c |    5
 drivers/video/dn_accel.h    |    9
 drivers/video/dn_cfb4.c     |  492 -----
 drivers/video/dn_cfb8.c     |  540 ------
 drivers/video/dnfb.c        |  535 +-----
 drivers/video/fbcmap.c      |    2
 drivers/video/fbmem.c       |    3
 drivers/video/maxinefb.c    |  290 ---
 drivers/video/neofb.c       | 3639 ++++++++++++++++++++------------------------
 drivers/video/neofb.h       |  291 ---
 drivers/video/pm2fb.c       |  745 ++++++---
 drivers/video/pmag-ba-fb.c  |  343 ----
 drivers/video/pmagb-b-fb.c  |  344 ----
 drivers/video/skeletonfb.c  |    2
 drivers/video/tdfxfb.c      | 2434 ++++++++---------------------
 drivers/video/tx3912fb.c    |  566 ++----
 drivers/video/tx3912fb.h    |  128 -
 drivers/video/vfb.c         |    4
 include/video/neomagic.h    |  264 +++
 include/video/pm2fb.h       |  222 ++
 include/video/tx3912.h      |   62
 28 files changed, 4034 insertions(+), 6980 deletions(-)



_______________________________________________________________

Don't miss the 2002 Sprint PCS Application Developer's Conference
August 25-28 in Las Vegas -- http://devcon.sprintpcs.com/adp/index.cfm
