From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: Re: [PATCH] fbdev: don't allow to set a video mode via vga= if FB
 doesn't support it
Date: Mon, 22 Sep 2008 21:47:47 +0200
Message-ID: <20080922214747.c8bc57eb.krzysztof.h1@poczta.fm>
References: <20080921210219.GC21215@spock.one.pl>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753885AbYIVTuY@vger.kernel.org>
In-Reply-To: <20080921210219.GC21215@spock.one.pl>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"
To: spock@gentoo.org
Cc: linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net

On Sun, 21 Sep 2008 23:02:19 +0200
Michal Januszewski <spock@gentoo.org> wrote:

> From: Michal Januszewski <spock@gentoo.org>
> 
> Currently, it is possible to set a VESA graphics mode at boot time via
> the vga= parameter even when no framebuffer driver supporting this is
> configured.  This could lead to the system booting with a black screen,
> without a usable console.
> 

Right.

> ---
> diff --git a/arch/x86/boot/video-vesa.c b/arch/x86/boot/video-vesa.c
> index 401ad99..32a6045 100644
> --- a/arch/x86/boot/video-vesa.c
> +++ b/arch/x86/boot/video-vesa.c
> @@ -134,9 +131,13 @@ static int vesa_set_mode(struct mode_info *mode)
>  		/* It's a supported text mode */
>  		is_graphic = 0;
>  	} else if ((vminfo.mode_attr & 0x99) == 0x99) {
> +#if FB_SUPPORTS_BOOT_VESA
>  		/* It's a graphics mode with linear frame buffer */
>  		is_graphic = 1;
>  		vesa_mode |= 0x4000; /* Request linear frame buffer */
> +#else
> +		return -1;
> +#endif
>  	} else {
>  		return -1;	/* Invalid mode */
>  	}


This one could be simpler:

  		/* It's a supported text mode */
  		is_graphic = 0;
 +#if FB_SUPPORTS_BOOT_VESA
  	} else if ((vminfo.mode_attr & 0x99) == 0x99) {
  		/* It's a graphics mode with linear frame buffer */
  		is_graphic = 1;
  		vesa_mode |= 0x4000; /* Request linear frame buffer */
 +#endif
  	} else {
  		return -1;	/* Invalid mode */
  	}


Other than this, the patch is fine to me.

Acked-by: Krzysztof Helt <krzysztof.h1@wp.pl>

Regards,
Krzysztof

----------------------------------------------------------------------
Kredyt Hipoteczny w Banku Millennium - zdobywca Zlotego Lauru Klienta!
Sprawdz >> http://link.interia.pl/f1f15
