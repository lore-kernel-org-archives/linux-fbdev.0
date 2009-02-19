From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] Incorrect URL given in
	drivers/video/Kconfig
Date: Thu, 19 Feb 2009 21:58:13 +0100 (CET)
Message-ID: <Pine.LNX.4.64.0902192156560.2221@anakin>
References: <20090117233539.07abdfc2@lithium.local.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <geert@linux-m68k.org>) id 1LaFyX-0002eD-TV
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 19 Feb 2009 20:58:29 +0000
Received: from juliette.telenet-ops.be ([195.130.137.74])
	by 72vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1LaFyS-000580-Ey for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 19 Feb 2009 20:58:29 +0000
In-Reply-To: <20090117233539.07abdfc2@lithium.local.net>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Alex Buell <alex.buell@munted.org.uk>
Cc: Andrew Morton <akpm@linux-foundation.org>, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>, Linux Kernel Development <linux-kernel@vger.kernel.org>

On Sat, 17 Jan 2009, Alex Buell wrote:
> --- linux/drivers/video/Kconfig.old	2009-01-17 23:31:53.831765544 +0000
> +++ linux/drivers/video/Kconfig	2009-01-17 23:32:40.049414838 +0000
> @@ -41,7 +41,7 @@
>  	  You need an utility program called fbset to make full use of frame
>  	  buffer devices. Please read <file:Documentation/fb/framebuffer.txt>
>  	  and the Framebuffer-HOWTO at
> -	  <http://www.tahallah.demon.co.uk/programming/prog.html> for more
> +	  <http://www.munted.org.uk/programming/Framebuffer-HOWTO-1.2.html> for more

Which got obsoleted by
http://www.munted.org.uk/programming/Framebuffer-HOWTO-1.3.html in the mean
time...

Any chance we could have a permanent link here?

>  	  information.
>  
>  	  Say Y here and to the driver for your graphics board below if you

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

------------------------------------------------------------------------------
Open Source Business Conference (OSBC), March 24-25, 2009, San Francisco, CA
-OSBC tackles the biggest issue in open source: Open Sourcing the Enterprise
-Strategies to boost innovation and cut costs with open source participation
-Receive a $600 discount off the registration fee with the source code: SFAD
http://p.sf.net/sfu/XcvMzF8H
