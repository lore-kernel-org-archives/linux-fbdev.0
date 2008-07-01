From: Manuel Lauss <mano@roarinelk.homelinux.net>
Subject: Re: [PATCH v3] video: sh7760fb: SH7760/SH7763
	LCDC framebuffer	driver
Date: Tue, 1 Jul 2008 10:17:49 +0200
Message-ID: <20080701081748.GA5499@roarinelk.homelinux.net>
References: <4869DC13.30604@renesas.com> <20080701080006.GB4726@linux-sh.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KDb3k-0001qL-JO for Linux-fbdev-devel@lists.sourceforge.net;
	Tue, 01 Jul 2008 01:17:56 -0700
Received: from fnoeppeil48.netpark.at ([217.175.205.176]
	helo=roarinelk.homelinux.net)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1KDb3i-00045l-Vb
	for Linux-fbdev-devel@lists.sourceforge.net;
	Tue, 01 Jul 2008 01:17:56 -0700
Content-Disposition: inline
In-Reply-To: <20080701080006.GB4726@linux-sh.org>
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
To: Paul Mundt <lethal@linux-sh.org>, Nobuhiro Iwamatsu <iwamatsu.nobuhiro@renesas.com>, linux-fbdev <Linux-fbdev-devel@lists.sourceforge.net>, Linux-sh <linux-sh@vger.kernel.org>Nobuh

Hello Paul, Iwamatsu-san,

On Tue, Jul 01, 2008 at 05:00:06PM +0900, Paul Mundt wrote:
> On Tue, Jul 01, 2008 at 04:26:11PM +0900, Nobuhiro Iwamatsu wrote:
> > +static void sh7760fb_wait_vsync(struct fb_info *info)
> > +{
> > +	struct sh7760fb_par *par = info->par;
> > +
> > +	if (par->pd->novsync)
> > +		return;
> > +}
> > +
> This doesn't do anything, and you never use ->novsync for anything
> anywhere else either. I'd suggest killing both of them off until such a
> time that you plan to do something with it.

I'm working on reimplementing it. I'll submit a patch when it's ready.

 
> > +	/* poll for access grant */
> > +	tmo = 100;
> > +	while (!(ioread16(par->base + LDPALCR) & (1 << 4)) && (--tmo))
> > +		msleep(0);
> > +
> Err.. you are sleeping for 0ms? Just use cpu_relax() here instead if you
> don't have an explicit timing requirement.

I put the msleep here to prevent gcc from removing the loop.


Best regards,
	Manuel Lauss

-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://sourceforge.net/services/buy/index.php
