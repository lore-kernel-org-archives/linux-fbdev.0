From: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH] pm3fb: fix section mismatch warnings
Date: Sat, 12 Jan 2008 11:34:12 +0100
Message-ID: <20080112103412.GB2523@uranus.ravnborg.org>
References: <20080111170401.694b066f.rdunlap@xenotime.net>
	<20080112051829.b43a328b.krzysztof.h1@wp.pl>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JDdgr-0007lS-KD for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 12 Jan 2008 02:34:13 -0800
Received: from pasmtpa.tele.dk ([80.160.77.114])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1JDdgq-0007wp-72
	for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 12 Jan 2008 02:34:13 -0800
Content-Disposition: inline
In-Reply-To: <20080112051829.b43a328b.krzysztof.h1@wp.pl>
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
To: Krzysztof Helt <krzysztof.h1@wp.pl>
Cc: romain@dolbeau.org, Randy Dunlap <rdunlap@xenotime.net>, linux-fbdev-devel@lists.sourceforge.net, akpm <akpm@linux-foundation.org>, adaplas@gmail.com

On Sat, Jan 12, 2008 at 05:18:29AM +0100, Krzysztof Helt wrote:
> On Fri, 11 Jan 2008 17:04:01 -0800
> Randy Dunlap <rdunlap@xenotime.net> wrote:
> 
> > From: Randy Dunlap <randy.dunlap@oracle.com>
> > 
> > Add __devinit to one function to clean up section mismatch warnings:
> > 
> > 
> >  /* mmio register are already mapped when this function is called */
> >  /* the pm3fb_fix.smem_start is also set */
> > -static unsigned long pm3fb_size_memory(struct pm3_par *par)
> > +static unsigned long __devinit pm3fb_size_memory(struct pm3_par *par)
> >  {
> 
> Exactly the same patch is already in the -mm tree (by Adrian Bunk):
> drivers-video-pm3fbc-section-fix.patch

Such obviously correct fixes should be pushed towards mainline sooner.
With all the warnings being fixed lately by Randy and others we are now
at the point where it is sensible to turn this check from a warning
to an error so we really get them fixed before hitting -mm or -mainline
with new code.

It will most likely happen at -rc1 time and then I will see how much
noise it results in.

The rationale is that a precentage of the warnings are actually
real bugs waiting to trigger. This patch is not one of these but
it does hide the real ones.

	Sam

-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://ad.doubleclick.net/clk;164216239;13503038;w?http://sf.net/marketplace
