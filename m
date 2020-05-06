From: Sam Ravnborg <sam@ravnborg.org>
Date: Wed, 06 May 2020 17:48:49 +0000
Subject: Re: [PATCH] video: fbdev: w100fb: Fix a potential double free.
Message-Id: <20200506174849.GG19296@ravnborg.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20200427091945.57534-1-christophe.jaillet@wanadoo.fr>
In-Reply-To: <20200427091945.57534-1-christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: kstewart@linuxfoundation.org, akpm@osdl.org, linux-fbdev@vger.kernel.org, arnd@arndb.de, b.zolnierkie@samsung.com, jani.nikula@intel.com, gregkh@linuxfoundation.org, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, rpurdie@rpsys.net, adaplas@pol.net, tglx@linutronix.de

Hi Christophe
On Mon, Apr 27, 2020 at 11:19:45AM +0200, Christophe JAILLET wrote:
> Some memory is vmalloc'ed in the 'suspend' function and freed in the
> 'resume' function.
> However, it is also freed in the remove function.
> 
> In order to avoid a potential double free, set the corresponding pointer
> to NULL once freed in the 'resume' function.

The changelog talks about a suspend and a resume function.
But the code has a w100fb_save_vidmem() and a w100fb_restore_vidmem()
functions.

> 
> Fixes: aac51f09d96a ("[PATCH] w100fb: Rewrite for platform independence")
This "Fixes" should be followed by:
Cc: Richard Purdie <rpurdie@rpsys.net>
Cc: Antonino Daplas <adaplas@pol.net>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: <stable@vger.kernel.org> # v2.6.14+

This is the output of "dim fixes" - that does some magic to provide
the above list.
I filtered a few candidates out that should not be there.

Please fix both issues and resend.

Thanks,

	Sam


> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
>  drivers/video/fbdev/w100fb.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/video/fbdev/w100fb.c b/drivers/video/fbdev/w100fb.c
> index 2d6e2738b792..d96ab28f8ce4 100644
> --- a/drivers/video/fbdev/w100fb.c
> +++ b/drivers/video/fbdev/w100fb.c
> @@ -588,6 +588,7 @@ static void w100fb_restore_vidmem(struct w100fb_par *par)
>  		memsize=par->mach->mem->size;
>  		memcpy_toio(remapped_fbuf + (W100_FB_BASE-MEM_WINDOW_BASE), par->saved_extmem, memsize);
>  		vfree(par->saved_extmem);
> +		par->saved_extmem = NULL;
>  	}
>  	if (par->saved_intmem) {
>  		memsize=MEM_INT_SIZE;
> @@ -596,6 +597,7 @@ static void w100fb_restore_vidmem(struct w100fb_par *par)
>  		else
>  			memcpy_toio(remapped_fbuf + (W100_FB_BASE-MEM_WINDOW_BASE), par->saved_intmem, memsize);
>  		vfree(par->saved_intmem);
> +		par->saved_intmem = NULL;
>  	}
>  }
>  
> -- 
> 2.25.1
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
