From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: Re: [PATCH] fbdev kconfig update (2nd rev)
Date: Sun, 10 Aug 2008 23:44:36 +0200
Message-ID: <20080810234436.8c514eb6.krzysztof.h1@poczta.fm>
References: <20080810192207.f65de894.krzysztof.h1@poczta.fm>
	<Pine.LNX.4.64.0808102013500.10672@anakin>
	<20080810224832.d9d7075e.krzysztof.h1@poczta.fm>
	<Pine.LNX.4.64.0808102248420.10672@anakin>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KSIcq-000503-8D for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 10 Aug 2008 14:38:56 -0700
Received: from smtp239.poczta.interia.pl ([217.74.64.239])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1KSIco-0003nB-Qh
	for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 10 Aug 2008 14:38:56 -0700
In-Reply-To: <Pine.LNX.4.64.0808102248420.10672@anakin>
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
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Linux-fbdev-devel <linux-fbdev-devel@lists.sourceforge.net>

On Sun, 10 Aug 2008 22:49:07 +0200 (CEST)
Geert Uytterhoeven <geert@linux-m68k.org> wrote:

> On Sun, 10 Aug 2008, Krzysztof Helt wrote:

> > --- linux-old/drivers/video/Kconfig	2008-08-04 18:00:45.000000000 +0200
> > +++ linux-mm/drivers/video/Kconfig	2008-08-10 19:15:39.463597618 +0200
> > @@ -259,16 +259,24 @@ config FB_PM2
> >  	select FB_CFB_COPYAREA
> >  	select FB_CFB_IMAGEBLIT
> >  	help
> > -	  This is the frame buffer device driver for the Permedia2 AGP frame
> > -	  buffer card from ASK, aka `Graphic Blaster Exxtreme'.  There is a
> > -	  product page at
> > -	  <http://www.ask.com.hk/product/Permedia%202/permedia2.htm>.
> > +	  This is the frame buffer device driver for cards based on
> > +	  the 3D Labs Permedia, Permedia 2 and Permedia 2V chips.
> > +	  The driver was tested on following cards are:
>                                                    ^^^
> still a bogus `are'.
> 
> Gr{oetje,eeting}s,
>

I give up for now. It is late night here.

Regards,
Krzysztof


----------------------------------------------------------------------
Tylko dla detektywow! Konkurs na Smaker.pl
Kliknij >>> http://link.interia.pl/f1eb1


-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
