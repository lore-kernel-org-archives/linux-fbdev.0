From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 1/2]Freescale i.MX framebuffer driver
Date: Fri, 18 Mar 2005 19:48:00 +0100 (CET)
Message-ID: <Pine.LNX.4.62.0503181947300.8265@numbat.sonytel.be>
References: <20050317173624.GA29286@metis.extern.pengutronix.de>
 <200503180344.58891.adaplas@hotpop.com> <20050318113912.GA18354@metis.extern.pengutronix.de>
 <200503182214.30492.adaplas@hotpop.com> <20050318175407.GA25784@metis.extern.pengutronix.de>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DCMWC-00031N-LF
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 18 Mar 2005 10:48:20 -0800
Received: from witte.sonytel.be ([80.88.33.193])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1DCMWB-0004nh-17
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 18 Mar 2005 10:48:20 -0800
In-Reply-To: <20050318175407.GA25784@metis.extern.pengutronix.de>
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>
Cc: adaplas@pol.net

On Fri, 18 Mar 2005, Sascha Hauer wrote:
> +static struct imxfb_rgb def_rgb_16 = {
> +	.red	= { offset: 8,  length: 4, },
> +	.green	= { offset: 4,  length: 4, },
> +	.blue	= { offset: 0,  length: 4, },
> +	.transp = { offset: 0,  length: 0, },
> +};
> +
> +static struct imxfb_rgb def_rgb_8 = {
> +	.red	= { offset: 0,  length: 8, },
> +	.green	= { offset: 0,  length: 8, },
> +	.blue	= { offset: 0,  length: 8, },
> +	.transp = { offset: 0,  length: 0, },
> +};

Please use C99-style struct initializers for offset and length as well.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
