From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] Add fb_check_var() for fixed mode
 device.
Date: Fri, 29 Aug 2008 09:10:48 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0808290906370.22326@anakin>
References: <48B4E16C.4000107@renesas.com>
	<Pine.LNX.4.64.0808270855110.7910@anakin>
	<g94i4r$2hq$1@ger.gmane.org> <20080828074521.GO16680@sci.fi>
	<48B785DA.1030408@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KYy8M-0007qJ-84 for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 29 Aug 2008 00:11:02 -0700
Received: from monty.telenet-ops.be ([195.130.132.56])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1KYy8L-0003kX-94
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 29 Aug 2008 00:11:02 -0700
In-Reply-To: <48B785DA.1030408@renesas.com>
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
To: Takashi Yoshii <yoshii.takashi@renesas.com>
Cc: =?ISO-8859-1?Q?Ville_Syrj=E4l=E4?= <syrjala@sci.fi>, linux-fbdev-devel@lists.sourceforge.net

On Fri, 29 Aug 2008, Takashi Yoshii wrote:
> Sounds good.
> > 4. Provide a generic check_var() that does some basic sanity checking
> > against info->var (eg. check xres, yres and bits_per_pixel).
> How about this.
> Any comments? Expecially about what to check, what to restore.
> 
> Cheers,
> /yoshii # Restoring pixclock would be a workaround for Xorg issue :)
> 
> drivers/video/fbmem.c:fb_check_var()
>  New function for fixed mode device which doesn't provide its own
>  check_var function.
> 
> Signed-off-by: Takashi YOSHII <yoshii.takashi@renesas.com>
> 
> diff --git a/drivers/video/fbmem.c b/drivers/video/fbmem.c
> index c6b8e92..ff94eaf 100644
> --- a/drivers/video/fbmem.c
> +++ b/drivers/video/fbmem.c
> @@ -904,6 +904,56 @@ static int fb_check_caps(struct fb_info *info, struct fb_var_screeninfo *var,
>  	return err;
>  }
>  
> +/* Sanity check for drivers which can't change video mode */
> +static int
> +fb_check_var(struct fb_var_screeninfo *var, struct fb_info *info)
> +{
> +	struct fb_var_screeninfo *constant = &info->var;
> +        __u32 xoffset = var->xoffset;
> +	__u32 yoffset = var->yoffset;
> +	__u32 activate = var->activate;
> +	__u32 yres = (constant->vmode & FB_VMODE_YWRAP)? 0: var->yres; 
> +
> +	/* do round _up_ */
> +	if (var->xres_virtual < xoffset + var->xres)
> +		var->xres_virtual = xoffset + var->xres;
> +	if (var->yres_virtual < yoffset + yres)
> +		var->yres_virtual = yoffset + yres;

Why this part? var->[xy]res{,_virtual} will be overwritten by the
correct values later anyway.

> +	/* pan is acceptable only if we have fb_pan_display) */
> +	if ( (var->yoffset || var->xoffset) && !info->fbops->fb_pan_display )
> +		return -EINVAL;

You should validate var->[xy]offset against constant->[xy]res_virtual
and info->fix.[xy]{pan,wrap}step.

> +	/* copy most */
> +	*var = *constant;
> +	/* resotore some that are not a part of viede mode */
           ^^^^^^^^
	   restore
> +	var->xoffset = xoffset;
> +	var->yoffset = yoffset;
> +	var->activate = activate;
> +
> +	return 0;
> +}

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
