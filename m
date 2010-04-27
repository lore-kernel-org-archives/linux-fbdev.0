From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] fix Kconfig breakage in
	drivers/video
Date: Tue, 27 Apr 2010 15:57:51 -0700
Message-ID: <20100427155751.6c7f209a.akpm@linux-foundation.org>
References: <20100314225329.f5dc3e05.krzysztof.h1@poczta.fm>
	<20100315063919.GB27515@jasper.tkos.co.il>
	<20100323121137.7fe466de.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <akpm@linux-foundation.org>) id 1O6tj9-0003F8-Mi
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 27 Apr 2010 22:58:03 +0000
Received: from smtp1.linux-foundation.org ([140.211.169.13])
	by sfi-mx-3.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1O6tj6-00045S-L9
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 27 Apr 2010 22:58:03 +0000
In-Reply-To: <20100323121137.7fe466de.akpm@linux-foundation.org>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Baruch Siach <baruch@tkos.co.il>, Krzysztof Helt <krzysztof.h1@poczta.fm>, linux-fbdev-devel@lists.sourceforge.net, David Miller <davem@davemloft.net>, Uwe

On Tue, 23 Mar 2010 12:11:37 -0700
Andrew Morton <akpm@linux-foundation.org> wrote:

> On Mon, 15 Mar 2010 08:39:20 +0200
> Baruch Siach <baruch@tkos.co.il> wrote:
> 
> > Hi Krzysztof,
> > 
> > On Sun, Mar 14, 2010 at 10:53:29PM +0100, Krzysztof Helt wrote:
> > > From: Krzysztof Helt <krzysztof.h1@wp.pl>
> > > 
> > > There are two new options inside the CONFIG_FB section which do not
> > > depend on the CONFIG_FB. This break Kconfig menu layout.
> > > 
> > > Fix it and reduce few conditions for sparc frame buffers
> > > as the FB_SBUS == ((FB = y) && SPARC).
> > > 
> > > Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>
> > > ---
> > > 
> > > --- linux-orig/drivers/video/Kconfig	2010-03-14 23:54:39.000000000 +0100
> > > +++ linux-git/drivers/video/Kconfig	2010-03-15 00:05:59.000000000 +0100
> > > @@ -400,12 +400,9 @@ config FB_SA1100
> > >  	  If you plan to use the LCD display with your SA-1100 system, say
> > >  	  Y here.
> > >  
> > > -config HAVE_FB_IMX
> > > -	bool
> > > -
> > >  config FB_IMX
> > >  	tristate "Motorola i.MX LCD support"
> > > -	depends on FB && (HAVE_FB_IMX || ARCH_MX1 || ARCH_MX2)
> > > +	depends on FB && (ARCH_MX1 || ARCH_MX2)
> > 
> > This hunk reverts f6014419 (imxfb: add support for i.MX25). Is this 
> > intentional?
> > 
> 
> Did this question get addressed?
> 
> Thanks.

<a month passes>

Krzysztof?

------------------------------------------------------------------------------
