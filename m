From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 1/1 2.6.13] framebuffer: bit_putcs()
 optimization for 8x* fonts
Date: Tue, 30 Aug 2005 18:18:08 +0200 (CEST)
Message-ID: <Pine.LNX.4.62.0508301814470.6045@numbat.sonytel.be>
References: <43148610.70406@t-online.de>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EA8p0-0000NP-9T
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 30 Aug 2005 09:18:50 -0700
Received: from witte.sonytel.be ([80.88.33.193])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1EA8oz-0005hA-My
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 30 Aug 2005 09:18:50 -0700
In-Reply-To: <43148610.70406@t-online.de>
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
Cc: Andrew Morton <akpm@osdl.org>, "Antonino A. Daplas" <adaplas@gmail.com>, Linux Kernel Development <linux-kernel@vger.kernel.org>, Jochen Hein <jochen@jochen.org>

On Tue, 30 Aug 2005, Knut Petersen wrote:
> linux/drivers/video/console/bitblit.c
> --- linuxorig/drivers/video/console/bitblit.c	2005-08-29 01:41:01.000000000
> +0200
> +++ linux/drivers/video/console/bitblit.c	2005-08-30 17:19:57.000000000
> +0200
> @@ -114,7 +114,7 @@ static void bit_putcs(struct vc_data *vc
> 	unsigned int scan_align = info->pixmap.scan_align - 1;
> 	unsigned int buf_align = info->pixmap.buf_align - 1;
> 	unsigned int shift_low = 0, mod = vc->vc_font.width % 8;
> -	unsigned int shift_high = 8, pitch, cnt, size, k;
> +	unsigned int shift_high = 8, pitch, cnt, size, i, k;
> 	unsigned int idx = vc->vc_font.width >> 3;
> 	unsigned int attribute = get_attribute(info, scr_readw(s));
> 	struct fb_image image;
> @@ -175,7 +175,11 @@ static void bit_putcs(struct vc_data *vc
> 					src = buf;
> 				}
> 
> -				fb_pad_aligned_buffer(dst, pitch, src, idx,
> image.height);
> +				if (idx == 1)
> +					for(i=0; i < image.height; i++)
> +						dst[pitch*i] = src[i];
                                                    ^^^^^^^
> +				else
> +					fb_pad_aligned_buffer(dst, pitch, src,
> idx, image.height);
> 				dst += width;
> 			}
> 		}

Probably you can make it even faster by avoiding the multiplication, like

    unsigned int offset = 0;
    for (i = 0; i < image.height; i++) {
	dst[offset] = src[i];
	offset += pitch;
    }

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
