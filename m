From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: pm2fb: big endian fix
Date: Mon, 24 Dec 2007 12:05:41 +0100 (CET)
Message-ID: <Pine.LNX.4.64.0712241204210.24252@anakin>
References: <20071224113456.faa212a1.krzysztof.h1@poczta.fm>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1J6l88-0006E1-Si for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 24 Dec 2007 03:05:57 -0800
Received: from nelson.telenet-ops.be ([195.130.133.66])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1J6l87-00072f-6W
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 24 Dec 2007 03:05:56 -0800
In-Reply-To: <20071224113456.faa212a1.krzysztof.h1@poczta.fm>
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
To: Krzysztof Helt <krzysztof.h1@poczta.fm>
Cc: Andrew Morton <akpm@linux-foundation.org>, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>

On Mon, 24 Dec 2007, Krzysztof Helt wrote:
> From: Krzysztof Helt <krzysztof.h1@wp.pl>
> 
> This patch fixes garbled letters on big endian
> machines with acceleration enabled.
> 
> Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>
> 
> ---
> 
> --- linux-ref/drivers/video/pm2fb.c	2007-12-23 20:39:09.000000000 +0100
> +++ linux-new/drivers/video/pm2fb.c	2007-12-24 00:41:32.000000000 +0100
> @@ -1210,7 +1210,11 @@ static void pm2fb_imageblit(struct fb_in
>  			PM2F_INCREASE_X | PM2F_INCREASE_Y);
>  		/* BitMapPackEachScanline & invert bits and byte order*/
>  		/* force background */
> +#ifdef __LITTLE_ENDIAN
>  		pm2_WR(par, PM2R_RASTERIZER_MODE,  (1 << 9) | 1 | (3 << 7));
> +#else
> +		pm2_WR(par, PM2R_RASTERIZER_MODE,  (1 << 9) | 1);
> +#endif
>  		pm2_WR(par, PM2R_CONSTANT_COLOR, fgx);
>  		pm2_WR(par, PM2R_RENDER,
>  			PM2F_RENDER_RECTANGLE |
> @@ -1225,7 +1229,11 @@ static void pm2fb_imageblit(struct fb_in
>  			PM2F_RENDER_FASTFILL |
>  			PM2F_INCREASE_X | PM2F_INCREASE_Y);
>  		/* invert bits and byte order*/
> +#ifdef __LITTLE_ENDIAN
>  		pm2_WR(par, PM2R_RASTERIZER_MODE,  1 | (3 << 7));
> +#else
> +		pm2_WR(par, PM2R_RASTERIZER_MODE,  1);
> +#endif
>  		pm2_WR(par, PM2R_FB_BLOCK_COLOR, fgx);
>  		pm2_WR(par, PM2R_RENDER,
>  			PM2F_RENDER_RECTANGLE |

What about something like

    #ifdef __LITTLE_ENDIAN
    #define PM2R_RASTERIZER_MODE_ENDIANNESS	(3 << 7)
    #else
    #define PM2R_RASTERIZER_MODE_ENDIANNESS	0
    #endif

at the top, so you can just use

    pm2_WR(par, PM2R_RASTERIZER_MODE,  (1 << 9) | 1 |
		PM2R_RASTERIZER_MODE_ENDIANNESS);

everywhere else?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
