From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: Error in fbcon_switch ?
Date: Wed, 21 May 2008 09:17:45 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0805210915510.14927@anakin>
References: <20080520231121.a8fbecc1.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Jyia9-0001Nz-HP for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 21 May 2008 00:17:53 -0700
Received: from harold.telenet-ops.be ([195.130.133.65])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1Jyia7-00046q-SD
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 21 May 2008 00:17:53 -0700
In-Reply-To: <20080520231121.a8fbecc1.krzysztof.h1@poczta.fm>
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
Cc: Linux-fbdev-devel <linux-fbdev-devel@lists.sourceforge.net>

On Tue, 20 May 2008, Krzysztof Helt wrote:
> I run into issue when two virtual consoles (tty1 and tty2) are set to different
> display modes: one with interlace and one without. When console is switched,
> the setting of the interlaced mode is not honoured, ie. 
> 
> tty1 (lace) -> tty2 (non-lace) -> tty1 (lace) -> tty2 (non-lace)
> 
> gives
> 
> tty1 (lace) -> tty2 (lace) -> tty1 (lace) -> tty2 (lace)
> 
> Of course, the refresh rate (and other timings) are not correct on the tty2 as
> the resolution and pixclock are preserved.

Interesting, I'll give it a try on my Amiga tonight...

> I found that root of the problem is that fbcon_switch copies the var.vmode 
> field from the previous console. If this copy is removed everything is alright, ie.
> 
> tty1 (lace) -> tty2 (non-lace) -> tty1 (lace) -> tty2 (non-lace)
> 
> Is this a correct solution to the problem? What is a purpose of copying vmode field?
> 
> The vmode field contains following settings:
> 
> #define FB_VMODE_INTERLACED     1       /* interlaced   */
> #define FB_VMODE_DOUBLE         2       /* double scan */
> #define FB_VMODE_ODD_FLD_FIRST  4       /* interlaced: top line first */
> #define FB_VMODE_MASK           255
> 
> #define FB_VMODE_YWRAP          256     /* ywrap instead of panning     */
> #define FB_VMODE_SMOOTH_XPAN    512     /* smooth xpan possible (internally used) */
> #define FB_VMODE_CONUPDATE      512     /* don't update x/yoffset       */
> 
> IMO, at least the first three should not be copied. I am not sure about YWRAP and 
> CONUPDATE/SMOOTH_XPAN.

As it copies [xy]offset, it probably needs YWRAP/SMOOTH_XPAN/CONUPDATE.
So I guess it should keep the bits under FB_VMODE_MASK.

> Regards,
> Krzysztof
> PS. The patch below is my fix:
> 
> diff -urp linux-old/drivers/video/console/fbcon.c linux-new/drivers/video/console/fbcon.c
> --- linux-old/drivers/video/console/fbcon.c	2008-05-12 19:27:04.305519626 +0200
> +++ linux-new/drivers/video/console/fbcon.c	2008-05-20 23:06:44.235878754 +0200
> @@ -2266,7 +2266,6 @@ static int fbcon_switch(struct vc_data *
>  	info->var.activate = var.activate;
>  	var.yoffset = info->var.yoffset;
>  	var.xoffset = info->var.xoffset;
> -	var.vmode = info->var.vmode;
>  	fb_set_var(info, &var);
>  	ops->var = info->var;

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft 
Defy all challenges. Microsoft(R) Visual Studio 2008. 
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
