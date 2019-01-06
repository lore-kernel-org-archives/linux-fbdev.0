From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Sun, 06 Jan 2019 09:33:43 +0000
Subject: Re: [PATCH 2/2] fbdev: fbmem: add config option to center the bootup logo
Message-Id: <CAMuHMdVfoRP_yNL5HcmwwV3fn9GqnsbORtG_hOhWw3qUeMKFKQ@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20181126215725.2548-1-peda@axentia.se>
 <20181126215725.2548-3-peda@axentia.se>
In-Reply-To: <20181126215725.2548-3-peda@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Peter Rosin <peda@axentia.se>
Cc: "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Hi Peter,

On Mon, Nov 26, 2018 at 10:59 PM Peter Rosin <peda@axentia.se> wrote:
> If there are extra logos (CONFIG_FB_LOGO_EXTRA) the heights of these
> extra logos are not considered when centering the first logo vertically.
>
> Signed-off-by: Peter Rosin <peda@axentia.se>

> --- a/drivers/video/logo/Kconfig
> +++ b/drivers/video/logo/Kconfig
> @@ -10,6 +10,15 @@ menuconfig LOGO
>
>  if LOGO
>
> +config FB_LOGO_CENTER
> +       bool "Center the logo"
> +       depends on FB=y
> +       help
> +         When this option is selected, the bootup logo is centered both
> +         horizontally and vertically. If more than one logo is displayed
> +         due to multiple CPUs, the collected line of logos is centered
> +         as a whole.
> +

Isn't a kernel command line option more suitable to configure the position
of the logo?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
