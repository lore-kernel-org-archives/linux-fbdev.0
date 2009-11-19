From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: i810fb: fix wrong pixclock for discrete
	mode selection
Date: Thu, 19 Nov 2009 14:17:11 -0800
Message-ID: <20091119141711.c7412dcc.akpm@linux-foundation.org>
References: <20091119185801.467fbaf8.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <akpm@linux-foundation.org>) id 1NBFJj-0007sI-Dd
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 19 Nov 2009 22:17:31 +0000
Received: from smtp1.linux-foundation.org ([140.211.169.13])
	by 29vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1NBFJb-0002UL-Qy
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 19 Nov 2009 22:17:31 +0000
In-Reply-To: <20091119185801.467fbaf8.krzysztof.h1@poczta.fm>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Krzysztof Helt <krzysztof.h1@poczta.fm>
Cc: Linux-fbdev-devel <linux-fbdev-devel@lists.sourceforge.net>

On Thu, 19 Nov 2009 18:58:01 +0100
Krzysztof Helt <krzysztof.h1@poczta.fm> wrote:

> From: Krzysztof Helt <krzysztof.h1@wp.pl>
> 
> If the i810fb driver is configured for use only predefined discrete video modes
> the wrong pixclock value is used. The par->regs.pixclock value is a value from
> the previous mode when a video mode is switched. It results in unreadable screen
> if the old video mode has higher resolution and the new mode with the old (high)
> pixclock is outside attached monitor's specs.
> 
> Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>
> ---
> I have noticed this testing the patch named "i810fb: Fix stack exploding".
> 
> This patch requires my patch send to Alan Cox and Andrew Morton 
> named "i810fb: Fix stack exploding".
> 
> --- drivers/video/i810/i810_dvt.c~	2009-11-17 19:38:11.002864450 +0100
> +++ drivers/video/i810/i810_dvt.c	2009-11-19 18:48:52.518846238 +0100

Please use `patch -p1' form.  That would be:

--- a/drivers/video/i810/i810_dvt.c
+++ a/drivers/video/i810/i810_dvt.c

> @@ -233,7 +233,7 @@ static int i810fb_find_best_mode(u32 xre
>  void i810fb_encode_registers(const struct fb_var_screeninfo *var,
>  			     struct i810fb_par *par, u32 xres, u32 yres)
>  {
> -	u32 i_best = i810fb_find_best_mode(xres, yres, par->regs.pixclock);
> +	u32 i_best = i810fb_find_best_mode(xres, yres, var->pixclock);
>  
>  	par->regs = std_modes[i_best];

Confused.  My drivers/video/i810/i810_dvt.c is quiet different from yours:

void i810fb_encode_registers(const struct fb_var_screeninfo *var,
			     struct i810fb_par *par, u32 xres, u32 yres)
{ 
	u32 diff = 0, diff_best = 0xFFFFFFFF, i = 0, i_best = 0; 
	u8 hfl;


------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
