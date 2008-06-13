From: Frans Pop <elendil@planet.nl>
Subject: Re: fb layer & ioremap_wc
Date: Fri, 13 Jun 2008 18:42:15 +0200
Message-ID: <200806131842.16619.elendil@planet.nl>
References: <200805022122.03576.elendil@planet.nl>
	<200805052059.01535.elendil@planet.nl>
	<200805051204.49135.jesse.barnes@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1K7CM8-0002Yj-1k for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 13 Jun 2008 09:42:28 -0700
Received: from hpsmtp-eml11.kpnxchange.com ([213.75.38.111])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1K7CM7-0005VZ-Ih
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 13 Jun 2008 09:42:28 -0700
In-Reply-To: <200805051204.49135.jesse.barnes@intel.com>
Content-Disposition: inline
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
To: Jesse Barnes <jesse.barnes@intel.com>
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, Yinghai Lu <yhlu.kernel@gmail.com>, "Pallipadi,  Venkatesh" <venkatesh.pallipadi@intel.com>, Ingo Molnar <mingo@elte.hu>, "Packard, Keith" <keith.packard@intel.com>

On Monday 05 May 2008, Jesse Barnes wrote:
> On Monday, May 05, 2008 11:59 am Frans Pop wrote:
> > On Monday 05 May 2008, you wrote:
> > > On Monday, May 05, 2008 10:32 am Frans Pop wrote:
> > > > I suspect it could be vesafb/fbcon related instead. Normally I
> > > > boot my system with 'quiet vga=791', i.e. with vesafb. I then see
> > > > the artifacts.
> > > >
> > > > When I boot with 'video=vfb:off', I do _not_ get the artifacts
> > > > when X exits.
> > >
> > > Ahhh, I missed that part of your config.  That could definitely
> > > have an effect on things...  You'll probably want something like
> > > the attached
> >
> > Not sure what to make of this.
> > With your patch I still get the artifacts, but they are displayed a
> > lot shorter. I get only a flash instead of a-2 seconds.
>
> Hm, so I guess some other user is still using UC on the region.  [Note
> to fb list:  the patch just made vesafb use ioremap_wc instead of
> ioremap).

AFAIK there has been no progress on this issue, which is now listed on the 
regression list for .26 [1]. As there has been no response from any fb 
devs, is someone else maybe willing to have a closer look at this?

I'm still seeing the artifacts with -rc6 and the severity seems to depend 
on what was last displayed: sometimes the whole display is covered with 
colored nonsense, artistic maybe but not desired...

Cheers,
FJP

[1] http://bugzilla.kernel.org/show_bug.cgi?id=10843

-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://sourceforge.net/services/buy/index.php
