From: Bartlomiej Zolnierkiewicz <b.zolnierkie@gmail.com>
Date: Wed, 21 Dec 2016 11:11:41 +0000
Subject: Re: [PATCH] video: use designated initializers
Message-Id: <CAGdkghWT7NqVDbcbDsXcmf0YMv6ZDvWgucFR0N4AxT9axSMWYA@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20161217010309.GA140492@beast>
In-Reply-To: <20161217010309.GA140492@beast>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Kees Cook <keescook@chromium.org>
Cc: linux-kernel@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@ti.com>, Sudip Mukherjee <sudipm.mukherjee@gmail.com>, linux-fbdev@vger.kernel.org

Hi,

On Sat, Dec 17, 2016 at 2:03 AM, Kees Cook <keescook@chromium.org> wrote:
> Prepare to mark sensitive kernel structures for randomization by making
> sure they're using designated initializers. These were identified during
> allyesconfig builds of x86, arm, and arm64, with most initializer fixes
> extracted from grsecurity.
>
> Signed-off-by: Kees Cook <keescook@chromium.org>

Please:
- fix patch subject line to "video: fbdev: matroxfb: ..."
- align the two columns vertically while at it

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

> ---
>  drivers/video/fbdev/matrox/matroxfb_DAC1064.c | 10 ++++++++--
>  drivers/video/fbdev/matrox/matroxfb_Ti3026.c  |  5 ++++-
>  2 files changed, 12 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/video/fbdev/matrox/matroxfb_DAC1064.c b/drivers/video/fbdev/matrox/matroxfb_DAC1064.c
> index a01147fdf270..5d896f879ff9 100644
> --- a/drivers/video/fbdev/matrox/matroxfb_DAC1064.c
> +++ b/drivers/video/fbdev/matrox/matroxfb_DAC1064.c
> @@ -1088,14 +1088,20 @@ static void MGAG100_restore(struct matrox_fb_info *minfo)
>
>  #ifdef CONFIG_FB_MATROX_MYSTIQUE
>  struct matrox_switch matrox_mystique = {
> -       MGA1064_preinit, MGA1064_reset, MGA1064_init, MGA1064_restore,
> +       .preinit = MGA1064_preinit,
> +       .reset = MGA1064_reset,
> +       .init = MGA1064_init,
> +       .restore = MGA1064_restore,
>  };
>  EXPORT_SYMBOL(matrox_mystique);
>  #endif
>
>  #ifdef CONFIG_FB_MATROX_G
>  struct matrox_switch matrox_G100 = {
> -       MGAG100_preinit, MGAG100_reset, MGAG100_init, MGAG100_restore,
> +       .preinit = MGAG100_preinit,
> +       .reset = MGAG100_reset,
> +       .init = MGAG100_init,
> +       .restore = MGAG100_restore,
>  };
>  EXPORT_SYMBOL(matrox_G100);
>  #endif
> diff --git a/drivers/video/fbdev/matrox/matroxfb_Ti3026.c b/drivers/video/fbdev/matrox/matroxfb_Ti3026.c
> index 68fa037d8cbc..0273351b2342 100644
> --- a/drivers/video/fbdev/matrox/matroxfb_Ti3026.c
> +++ b/drivers/video/fbdev/matrox/matroxfb_Ti3026.c
> @@ -738,7 +738,10 @@ static int Ti3026_preinit(struct matrox_fb_info *minfo)
>  }
>
>  struct matrox_switch matrox_millennium = {
> -       Ti3026_preinit, Ti3026_reset, Ti3026_init, Ti3026_restore
> +       .preinit = Ti3026_preinit,
> +       .reset = Ti3026_reset,
> +       .init = Ti3026_init,
> +       .restore = Ti3026_restore
>  };
>  EXPORT_SYMBOL(matrox_millennium);
>  #endif
> --
> 2.7.4
>
>
> --
> Kees Cook
> Nexus Security
