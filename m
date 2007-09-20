From: "Maciej W. Rozycki" <macro@linux-mips.org>
Subject: Re: [PATCH] drivers/video/pmag-ba-fb.c: Improve
	diagnostics
Date: Thu, 20 Sep 2007 13:52:39 +0100 (BST)
Message-ID: <Pine.LNX.4.64N.0709201342160.30788@blysk.ds.pg.gda.pl>
References: <Pine.LNX.4.64N.0709171736580.17606@blysk.ds.pg.gda.pl>
	<Pine.LNX.4.64N.0709181314300.9650@blysk.ds.pg.gda.pl>
	<20070919172412.725508d0.akpm@linux-foundation.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IYLWd-0007JG-Ta for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 20 Sep 2007 05:52:59 -0700
Received: from cerber.ds.pg.gda.pl ([153.19.208.18])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1IYLWc-00009X-8y
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 20 Sep 2007 05:52:59 -0700
In-Reply-To: <20070919172412.725508d0.akpm@linux-foundation.org>
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
Cc: Antonino Daplas <adaplas@pol.net>, linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, linux-mips@linux-mips.org

On Wed, 19 Sep 2007, Andrew Morton wrote:

> > patch-mips-2.6.23-rc5-20070904-pmag-ba-err-2
> > diff -up --recursive --new-file linux-mips-2.6.23-rc5-20070904.macro/drivers/video/pmag-ba-fb.c linux-mips-2.6.23-rc5-20070904/drivers/video/pmag-ba-fb.c
> > --- linux-mips-2.6.23-rc5-20070904.macro/drivers/video/pmag-ba-fb.c	2007-02-21 05:56:47.000000000 +0000
> > +++ linux-mips-2.6.23-rc5-20070904/drivers/video/pmag-ba-fb.c	2007-09-18 10:56:51.000000000 +0000
> > @@ -147,16 +147,23 @@ static int __init pmagbafb_probe(struct 
> >  	resource_size_t start, len;
> >  	struct fb_info *info;
> >  	struct pmagbafb_par *par;
> > +	int err = 0;
> 
> This initialisation to zero is not good.
> 
> Because if some error-path code forgot to do `err = -EFOO' then probe()
> will return zero and the driver will leave things in half-initialised state
> and will then proceed as if things had succeeded.  It will crash.

 GCC used to complain: "`foo' might be used uninitialized..." and this is 
the usual cure; let me see if this not the case anymore (I have 4.1.2).

> So it's better to leave this local uninitialised, because we really want to
> get that compiler warning if someone forgot to set the return value.

 Yes of course, barring the issue mentioned.  Note the message above is 
not the same as: "`foo' is used uninitialized..." that would be reported 
in the case which you are concerned of.

> I made that change, but am too stupid to be able to work out how to create
> a config which will let me compile this thing.
> 
> akpm:/usr/src/25> grep PMAG arch/arm/configs/*
> akpm:/usr/src/25> 

 TURBOchannel is currently MIPS only:

$ grep PMAG arch/mips/configs/*
arch/mips/configs/decstation_defconfig:# CONFIG_FB_PMAG_AA is not set
arch/mips/configs/decstation_defconfig:CONFIG_FB_PMAG_BA=y
arch/mips/configs/decstation_defconfig:CONFIG_FB_PMAGB_B=y
$

 Thanks for your review.

  Maciej

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
