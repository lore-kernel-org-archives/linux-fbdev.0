From: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
Subject: Re: [PATCH v3] add new Cobalt LCD framebuffer
	driver
Date: Thu, 17 Jul 2008 14:19:24 +0900
Message-ID: <200807170517.m6H5HriF002901@po-mbox300.hop.2iij.net>
References: <20080715222751.86091a71.yoichi_yuasa@tripeaks.co.jp>
	<20080716173154.8cb87400.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KJLsX-0006VF-Fo for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 16 Jul 2008 22:18:09 -0700
Received: from mo30.po.2iij.net ([210.128.50.53])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1KJLsV-0001nm-Uh
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 16 Jul 2008 22:18:09 -0700
In-Reply-To: <20080716173154.8cb87400.akpm@linux-foundation.org>
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
To: Andrew Morton <akpm@linux-foundation.org>
Cc: adaplas@pol.net, linux-mips@linux-mips.org, linux-fbdev-devel@lists.sourceforge.net, ralf@linux-mips.org, yoichi_yuasa@tripeaks.co.jp

On Wed, 16 Jul 2008 17:31:54 -0700
Andrew Morton <akpm@linux-foundation.org> wrote:

> On Tue, 15 Jul 2008 22:27:51 +0900
> Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp> wrote:
> 
> > I update cobalt_lcdfb driver.
> > 
> > v3
> > - fix read/write count boundary check.
> > - add <include/uaccess.h>.
> > - fix MODULE_AUTHOR.
> > 
> > v2
> > - add dpends MIPS_COBALT in Kconfig.
> > - add handling of signal_pending().
> > - check overflow of read/write count.
> > 
> > v1
> > - first release.
> 
> This driver has been merged into the subsystem tree for a long time and
> has been reviewed and has been perhaps tested by others.  Sending a
> complete new version of the entire thing is really quite an unfriendly
> act.  It basically invalidates all the review and test work which
> everyone else has done.
>
> This is why I will almost always turn replacement patches into
> incremental patches - so I can see what changed.  But that's only good
> for me.  Everyone else who is reading your new version won't bother
> doing that.
> 
> 
> So I generated the incremental patch and:
> 
> - The driver I have already includes linux/uaccess.h, so that change
>   was unneeded.
> 
> - The driver I have has already fixed the reject in
>   drivers/video/Makefile, so I get to fix it again, ho hum.
> 
> Here's what I ended up committing:
> 
>  drivers/video/Kconfig        |    2 +-
>  drivers/video/cobalt_lcdfb.c |   24 ++++++++++++++++++------
>  2 files changed, 19 insertions(+), 7 deletions(-)

OK.
If I update the driver to v4, I'll send the incremental patch.

Thanks a lot,

Yoichi

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
