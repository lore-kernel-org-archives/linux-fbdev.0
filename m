From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] - video/tridentfb.c warning fix.
Date: Tue, 20 Apr 2004 09:56:17 +0200 (MEST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.58.0404200955320.21445@waterleaf.sonytel.be>
References: <20040419162807.7ba9c5ec.lcapitulino@prefeitura.sp.gov.br>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BFq7G-0003n3-Q6
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 20 Apr 2004 00:56:26 -0700
Received: from witte.sonytel.be ([80.88.33.193])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.30)
	id 1BFq7G-0003yw-GV
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 20 Apr 2004 00:56:26 -0700
In-Reply-To: <20040419162807.7ba9c5ec.lcapitulino@prefeitura.sp.gov.br>
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
To: "Luiz Fernando N. Capitulino" <lcapitulino@prefeitura.sp.gov.br>
Cc: Andrew Morton <akpm@osdl.org>, James Simmons <jsimmons@infradead.org>, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>

On Mon, 19 Apr 2004, Luiz Fernando N. Capitulino wrote:
> diff -X dontdiff -Nparu a/drivers/video/Kconfig a~/drivers/video/Kconfig
> --- a/drivers/video/Kconfig	2004-04-16 20:03:09.000000000 -0300
> +++ a~/drivers/video/Kconfig	2004-04-16 20:04:24.000000000 -0300
> @@ -772,6 +772,14 @@ config FB_TRIDENT
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called tridentfb.
>
> +config FB_TRIDENT_ACCEL
> +	bool "Trident Acceleration functions (EXPERIMENTAL)"
> +	depends on FB_TRIDENT

Didn't notice this before: if you want it to be experimental, it should depend
on FB_TRIDENT && EXPERIMENTAL

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
