From: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH] uvesafb: fix section mismatch
	warnings
Date: Mon, 14 Jan 2008 14:53:19 +0100
Message-ID: <20080114135319.GA8389@uranus.ravnborg.org>
References: <20080111170409.10ecb8a9.rdunlap@xenotime.net>
	<20080112104203.GC2523@uranus.ravnborg.org>
	<20080113103134.d8955a1a.rdunlap@xenotime.net>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JEPkj-0003Db-K3 for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 14 Jan 2008 05:53:25 -0800
Received: from pasmtpb.tele.dk ([80.160.77.98])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1JEPki-0000J4-7X
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 14 Jan 2008 05:53:25 -0800
Content-Disposition: inline
In-Reply-To: <20080113103134.d8955a1a.rdunlap@xenotime.net>
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
To: Randy Dunlap <rdunlap@xenotime.net>
Cc: spock@gentoo.org, linux-fbdev-devel@lists.sourceforge.net, akpm <akpm@linux-foundation.org>, adaplas@gmail.com

On Sun, Jan 13, 2008 at 10:31:34AM -0800, Randy Dunlap wrote:
> On Sat, 12 Jan 2008 11:42:03 +0100 Sam Ravnborg wrote:
> 
> > On Fri, Jan 11, 2008 at 05:04:09PM -0800, Randy Dunlap wrote:
> > > From: Randy Dunlap <randy.dunlap@oracle.com>
> > > 
> > > Mark uvesafb_init_mtrr() as __devinit since its caller is __devinit
> > > and since it accesses __devinitdata.
> > > 
> > > WARNING: vmlinux.o(.text+0x4df80e): Section mismatch: reference to .init.data: (between 'uvesafb_init_mtrr' and 'uvesafb_show_vbe_ver')
> > 
> > OK
> > 
> > > 
> > > Variable 'blank' cannot be __devinitdata since it is referenced in an
> > > fb_ops method that could be called at any time.
> > 
> > The patch is correct but the explanation is wrong.
> > uvesafb uses local variables named blank in two spots that hides the
> > global defined blank which I assume has confused you.
> 
> Ack, thanks.

Randy - can I ask you to send an updated version with a correct changelog.
I think Andrew queued this due to my comment awaiting a conclusion.

Thanks,
	Sam

-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://ad.doubleclick.net/clk;164216239;13503038;w?http://sf.net/marketplace
