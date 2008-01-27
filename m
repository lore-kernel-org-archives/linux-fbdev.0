From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [patch 04/11] ps3fb: Inline macros that are
	used only once
Date: Sat, 26 Jan 2008 22:01:33 -0800
Message-ID: <20080126220133.eb99e5c4.akpm@linux-foundation.org>
References: <20080125150623.202631389@vixen.sonytel.be>
	<20080125153107.177014292@vixen.sonytel.be>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JJ0aJ-00005L-GZ for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 26 Jan 2008 22:01:39 -0800
Received: from smtp2.linux-foundation.org ([207.189.120.14])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1JJ0aI-0001lK-4v
	for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 26 Jan 2008 22:01:39 -0800
In-Reply-To: <20080125153107.177014292@vixen.sonytel.be>
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
Cc: Geert.Uytterhoeven@sonycom.com, linuxppc-dev@ozlabs.org, linux-fbdev-devel@lists.sourceforge.net, cbe-oss-dev@ozlabs.org, adaplas@gmail.com

> On Fri, 25 Jan 2008 16:06:27 +0100 Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com> wrote:
> From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
> 
> ps3fb: inline the X_OFF(), Y_OFF(), WIDTH(), HEIGHT(), and VP_OFF() macros,
> as they're used in one place only
> 

I think the term "open-code" would be more suitable here.  "inlining" means
"make it an inline function".  I'll update the changelog.

> -#define X_OFF(i)	(ps3fb_res[i].xoff)	/* left/right margin (pixel) */
> -#define Y_OFF(i)	(ps3fb_res[i].yoff)	/* top/bottom margin (pixel) */
> -#define WIDTH(i)	(ps3fb_res[i].xres)	/* width of FB */
> -#define HEIGHT(i)	(ps3fb_res[i].yres)	/* height of FB */
>  #define BPP		4			/* number of bytes per pixel */
>  
> -/* Start of the virtual frame buffer (relative to fullscreen ) */
> -#define VP_OFF(i)	((WIDTH(i) * Y_OFF(i) + X_OFF(i)) * BPP)
> -
>  
>  static int ps3fb_mode;
>  module_param(ps3fb_mode, int, 0);
> @@ -611,7 +604,10 @@ static int ps3fb_set_par(struct fb_info 
>  
>  	par->width = info->var.xres;
>  	par->height = info->var.yres;
> -	offset = VP_OFF(i);
> +
> +	/* Start of the virtual frame buffer (relative to fullscreen) */
> +	offset = ps3fb_res[i].yoff * ddr_line_length + ps3fb_res[i].xoff * BPP;
> +


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
