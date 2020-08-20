From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Thu, 20 Aug 2020 07:49:32 +0000
Subject: Re: [PATCH RESEND] lib/fonts: add font 6x8 for oled display
Message-Id: <20200820074932.GA3834397@kroah.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20200820074214.30214-1-s.hauer@pengutronix.de>
In-Reply-To: <20200820074214.30214-1-s.hauer@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, kernel@pengutronix.de, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Sven Schneider <s.schneider@arkona-technologies.de>

On Thu, Aug 20, 2020 at 09:42:14AM +0200, Sascha Hauer wrote:
> From: Sven Schneider <s.schneider@arkona-technologies.de>
> 
> This font is derived from lib/fonts/font_6x10.c and is useful for small OLED
> displays.
> ---
> 

No signed-off-by: line?  :(

Always use scripts/checkpatch.pl on your patch to find stuff like this,
and other errors that this patch has.

> Hi All,
> 
> I am not sure any new fonts are desired in the kernel. If yes, please consider
> for inclusion, otherwise some "go away, there are enough fonts in the kernel
> already" would be nice as well so I can stop trying getting it in :)
> 
> Sascha
> 
>  include/linux/font.h |    4 +-
>  lib/fonts/Kconfig    |    7 +
>  lib/fonts/Makefile   |    1 +
>  lib/fonts/font_6x8.c | 2575 ++++++++++++++++++++++++++++++++++++++++++
>  lib/fonts/fonts.c    |    3 +
>  5 files changed, 2589 insertions(+), 1 deletion(-)
>  mode change 100644 => 100755 include/linux/font.h

You changed a .h file to be executable???

> diff --git a/lib/fonts/fonts.c b/lib/fonts/fonts.c
> index e7258d8c252b2..760f2e6893bdb 100644
> --- a/lib/fonts/fonts.c
> +++ b/lib/fonts/fonts.c
> @@ -57,6 +57,9 @@ static const struct font_desc *fonts[] = {
>  #ifdef CONFIG_FONT_TER16x32
>  	&font_ter_16x32,
>  #endif
> +#ifdef CONFIG_FONT_6x8
> +    &font_6x8,

Tabs please.

As for "do we take new fonts?", sure, why not?

thanks,

greg k-h
