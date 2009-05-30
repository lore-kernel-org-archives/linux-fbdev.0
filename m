From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: Re: [PATCH] GXT400P and GXT6500P support
Date: Sat, 30 May 2009 13:42:36 +0200
Message-ID: <20090530134236.b97158c9.krzysztof.h1@poczta.fm>
References: <a265241c0905271157s45e23528haefbd2fa31ba6763@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <krzysztof.h1@poczta.fm>) id 1MAMqw-0003qL-Pj
	for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 30 May 2009 11:35:54 +0000
Received: from smtp239.poczta.interia.pl ([217.74.64.239])
	by 72vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MAMqv-0005Ns-CA for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 30 May 2009 11:35:54 +0000
In-Reply-To: <a265241c0905271157s45e23528haefbd2fa31ba6763@mail.gmail.com>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Giuseppe Coviello <cjg@cruxppc.org>
Cc: linux-fbdev-devel@lists.sourceforge.net

On Wed, 27 May 2009 20:57:55 +0200
Giuseppe Coviello <cjg@cruxppc.org> wrote:

> This patch adds support for GXT4000P and GXT6500P cards found on some
> IBM pSeries machines.
> GXT4000P/6000P and GXT4500P/6500P  couples are  identical from
> software's point of view and are based on the same  Raster Engine
> (RC1000), except for a different reference clock for the PLL.
> GXT6x00P models are equipped with an additional Geometry Engine
> (GT1000) but this driver doesn't use it.
> 
> Regards, Giuseppe
> 
> 
> Signed-off-by: Nico Macrionitis <acrux@cruxppc.org>
> Signed-off-by: Giuseppe Coviello <cjg@cruxppc.org>
> 
> --- /usr/src/linux-2.6.30-rc3/drivers/video/Kconfig	2009-04-22
> 05:07:00.000000000 +0200
> +++ Kconfig	2009-05-05 10:55:17.000000000 +0200
> @@ -1985,8 +1985,10 @@
>  	select FB_CFB_COPYAREA
>  	select FB_CFB_IMAGEBLIT
>  	---help---
> -	  Say Y here to enable support for the IBM GXT4500P display
> -	  adaptor, found on some IBM System P (pSeries) machines.
> +	  Say Y here to enable support for the IBM GXT4000P/6000P and	
> +	  GXT4500P/6500P display adaptor based on Raster Engine RC1000,
> +	  found on some IBM System P (pSeries) machines. This driver
> +	  doesn't use Geometry Engine GT1000.
> 

Please also change name of the option to reflect the fact it supports
more than just the GXT4500P, e.g.

"Framebuffer support for IBM GXT4000P/4500P/6000P/6500P adaptors"

Please cc the updated patch to the linuxppc-dev@ozlabs.org.

Regards,
Krzysztof

----------------------------------------------------------------------
Przekaz dalej wiadomosc: Zawsze warto oszczedzac. Teraz 5,5%!
Sprawdz > http://link.interia.pl/f21b1


------------------------------------------------------------------------------
Register Now for Creativity and Technology (CaT), June 3rd, NYC. CaT 
is a gathering of tech-side developers & brand creativity professionals. Meet
the minds behind Google Creative Lab, Visual Complexity, Processing, & 
iPhoneDevCamp as they present alongside digital heavyweights like Barbarian 
Group, R/GA, & Big Spaceship. http://p.sf.net/sfu/creativitycat-com 
