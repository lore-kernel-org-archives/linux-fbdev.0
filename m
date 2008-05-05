From: Frans Pop <elendil@planet.nl>
Subject: Re: fb layer & ioremap_wc
Date: Mon, 5 May 2008 21:30:14 +0200
Message-ID: <200805052130.14939.elendil@planet.nl>
References: <200805022122.03576.elendil@planet.nl>
	<200805052059.01535.elendil@planet.nl>
	<200805051204.49135.jesse.barnes@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Jt6OM-0006Z2-7o for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 05 May 2008 12:30:30 -0700
Received: from hpsmtp-eml17.kpnxchange.com ([213.75.38.117])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1Jt6OK-0000Df-M8
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 05 May 2008 12:30:30 -0700
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
To: linux-fbdev-devel@lists.sourceforge.net

FYI

This is from a thread started on lkml about a regression with 2.6.26-rc1 
where artifacts are shown when X is exited if X86_PAT is enabled. 

The full thread can be seen here:
http://www.gossamer-threads.com/lists/linux/kernel/914812?do=post_view_threaded

The most relevant part starts here:
http://www.gossamer-threads.com/lists/linux/kernel/915956?do=post_view_threaded

On Monday 05 May 2008, Jesse Barnes wrote:
> On Monday, May 05, 2008 11:59 am Frans Pop wrote:
> > On Monday 05 May 2008, you wrote:
> > > On Monday, May 05, 2008 10:32 am Frans Pop wrote:
> > > > I suspect it could be vesafb/fbcon related instead. Normally I boot
> > > > my system with 'quiet vga=791', i.e. with vesafb. I then see the
> > > > artifacts.
> > > >
> > > > When I boot with 'video=vfb:off', I do _not_ get the artifacts when
> > > > X exits.
> > >
> > > Ahhh, I missed that part of your config.  That could definitely have
> > > an effect on things...  You'll probably want something like the
> > > attached
> >
> > Not sure what to make of this.
> > With your patch I still get the artifacts, but they are displayed a lot
> > shorter. I get only a flash instead of a-2 seconds.
>
> Hm, so I guess some other user is still using UC on the region.  [Note to
> fb list:  the patch just made vesafb use ioremap_wc instead of ioremap).
>
> > > (there are other places in the fb layer that want similar treatment,
> > > iirc, maybe fb_pgprotect?).
> >
> > Do you want to try a more complete review/patch or should this be
> > punted over to the framebuffer folks?
>
> Yeah, those bits have changed since I last looked at them, hopefully the
> fb guys can help.


-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Don't miss this year's exciting event. There's still time to save $100. 
Use priority code J8TL2D2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
