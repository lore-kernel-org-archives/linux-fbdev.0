From: Randy Dunlap <rdunlap@xenotime.net>
Subject: Re: +
 i810fb-module-parameter-mode_option-inconsistent-with-other-framebuffer-modules.patch
 added to -mm tree
Date: Tue, 5 Feb 2008 14:59:13 -0800
Message-ID: <20080205145913.5211982e.rdunlap@xenotime.net>
References: <200802010732.m117WKam001350@imap1.linux-foundation.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JMWlA-0001JP-Dw for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 05 Feb 2008 14:59:24 -0800
Received: from xenotime.net ([66.160.160.81])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1JMWl3-0004fH-0t
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 05 Feb 2008 14:59:19 -0800
In-Reply-To: <200802010732.m117WKam001350@imap1.linux-foundation.org>
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
To: linux-fbdev-devel@lists.sf.net
Cc: adaplas@pol.net, akpm@linux-foundation.org, krzysztof.h1@wp.pl

On Thu, 31 Jan 2008 23:32:39 -0800 akpm@linux-foundation.org wrote:

> 
> The patch titled
>      i810fb: module parameter 'mode_option' inconsistent with other framebuffer modules
> has been added to the -mm tree.  Its filename is
>      i810fb-module-parameter-mode_option-inconsistent-with-other-framebuffer-modules.patch
> 
> Before you just go and hit "reply", please:
>    a) Consider who else should be cc'ed
>    b) Prefer to cc a suitable mailing list as well
>    c) Ideally: find the original patch on the mailing list and do a
>       reply-to-all to that, adding suitable additional cc's
> 
> *** Remember to use Documentation/SubmitChecklist when testing your code ***
> 
> See http://www.zip.com.au/~akpm/linux/patches/stuff/added-to-mm.txt to find
> out what to do about this
> 
> The current -mm tree may be found at http://userweb.kernel.org/~akpm/mmotm/
> 
> ------------------------------------------------------
> Subject: i810fb: module parameter 'mode_option' inconsistent with other framebuffer modules
> From: Krzysztof Helt <krzysztof.h1@wp.pl>
> 
> Fix http://bugzilla.kernel.org/show_bug.cgi?id=9847
> 
>    While all other framebuffer modules use the option "mode=..." to specify
>    a modedb-style video mode, i810fb uses the non-standard "mode_option=..."
>    This breaks the use of "video=i810fb:<videomode>" boot parameter, such that
>    for instance "video=i810fb:1024x768" doesn't work.  The boot scripts parse
>    the "<videomode>" parameter internally and pass it to the correct module as
>    'mode=<videomode>'.
> 
> This patch changes the option "mode_option" into "mode".
> 
> Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>
> Reported-by: <miki@dds.nl>
> Cc: "Antonino A. Daplas" <adaplas@pol.net>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---
> 
>  drivers/video/i810/i810_main.c |   24 ++++++++++++------------
>  1 file changed, 12 insertions(+), 12 deletions(-)
> 
> diff -puN drivers/video/i810/i810_main.c~i810fb-module-parameter-mode_option-inconsistent-with-other-framebuffer-modules drivers/video/i810/i810_main.c
> --- a/drivers/video/i810/i810_main.c~i810fb-module-parameter-mode_option-inconsistent-with-other-framebuffer-modules
> +++ a/drivers/video/i810/i810_main.c
> @@ -132,7 +132,7 @@ static struct pci_driver i810fb_driver =
>  	.resume   =     i810fb_resume,
>  };
>  
> -static char *mode_option __devinitdata = NULL;
> +static char *mode     __devinitdata;

FYI, you could have left the internal variable named 'mode_option'
and used module_param_named(), just like uvesafb.c does:

module_param_named(mode, mode_option, charp, 0);

so in the source file the option is called 'mode_option', but
externally it is presented as "mode".
This would nuke most of the other source changes.


>  static int vram       __devinitdata = 4;
>  static int bpp        __devinitdata = 8;
>  static int mtrr       __devinitdata;
> @@ -1891,7 +1891,7 @@ i810_allocate_pci_resource(struct i810fb
>  
>  static void __devinit i810fb_find_init_mode(struct fb_info *info)
>  {
> -	struct fb_videomode mode;
> +	struct fb_videomode mode_new;
>  	struct fb_var_screeninfo var;
>  	struct fb_monspecs *specs = &info->monspecs;
>  	int found = 0;
> @@ -1902,7 +1902,7 @@ static void __devinit i810fb_find_init_m
>  #endif
>  
>  	INIT_LIST_HEAD(&info->modelist);
> -	memset(&mode, 0, sizeof(struct fb_videomode));
> +	memset(&mode_new, 0, sizeof(struct fb_videomode));
>  	var = info->var;
>  #ifdef CONFIG_FB_I810_I2C
>  	i810_create_i2c_busses(par);
> @@ -1928,23 +1928,23 @@ static void __devinit i810fb_find_init_m
>  
>  		if (xres && yres) {
>  			if ((m = fb_find_best_mode(&var, &info->modelist))) {
> -				mode = *m;
> +				mode_new = *m;
>  				found  = 1;
>  			}
>  		}
>  
>  		if (!found) {
>  			m = fb_find_best_display(&info->monspecs, &info->modelist);
> -			mode = *m;
> +			mode_new = *m;
>  			found = 1;
>  		}
>  
> -		fb_videomode_to_var(&var, &mode);
> +		fb_videomode_to_var(&var, &mode_new);
>  	}
>  #endif
> -	if (mode_option)
> -		fb_find_mode(&var, info, mode_option, specs->modedb,
> -			     specs->modedb_len, (found) ? &mode : NULL,
> +	if (mode)
> +		fb_find_mode(&var, info, mode, specs->modedb,
> +			     specs->modedb_len, (found) ? &mode_new : NULL,
>  			     info->var.bits_per_pixel);
>  
>  	info->var = var;
> @@ -1998,7 +1998,7 @@ static int __devinit i810fb_setup(char *
>  		else if (!strncmp(this_opt, "ddc3", 4))
>  			ddc3 = 3;
>  		else
> -			mode_option = this_opt;
> +			mode = this_opt;
>  	}
>  	return 0;
>  }
> @@ -2202,8 +2202,8 @@ MODULE_PARM_DESC(dcolor, "use DirectColo
>  		 " (default = 0 = TrueColor)");
>  module_param(ddc3, bool, 0);
>  MODULE_PARM_DESC(ddc3, "Probe DDC bus 3 (default = 0 = no)");
> -module_param(mode_option, charp, 0);
> -MODULE_PARM_DESC(mode_option, "Specify initial video mode");
> +module_param(mode, charp, 0);
> +MODULE_PARM_DESC(mode, "Specify initial video mode");
>  
>  MODULE_AUTHOR("Tony A. Daplas");
>  MODULE_DESCRIPTION("Framebuffer device for the Intel 810/815 and"


---
~Randy

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
