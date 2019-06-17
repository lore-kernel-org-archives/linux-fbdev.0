From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 17 Jun 2019 08:06:39 +0000
Subject: Re: [PATCH] staging: fbtft: Fix checkpatch ERROR: space prohibited before that close parenthesis ')'
Message-Id: <CAMuHMdW0iHNuS2Q1n4jynVGrgcnOPrLWX08ffWdT3GUGaidt-g@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190614023225.GA27938@t-1000>
In-Reply-To: <20190614023225.GA27938@t-1000>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Shobhit Kukreti <shobhitkukreti@gmail.com>
Cc: Andy Whitcroft <apw@canonical.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux Fbdev development list <linux-fbdev@vger.kernel.org>, Joe Perches <joe@perches.com>, DRI Development <dri-devel@lists.freedesktop.org>

Hi Shobhit,

Thanks for your patch!

On Fri, Jun 14, 2019 at 4:34 AM Shobhit Kukreti
<shobhitkukreti@gmail.com> wrote:
> Cleaned up code to resolve  the checkpatch error
> ERROR: space prohibited before that close parenthesis ')'
> from the file:
>
> fbtft/fbtft-bus.c

IMHO that is a bogus checkpatch error...

> Signed-off-by: Shobhit Kukreti <shobhitkukreti@gmail.com>
> ---
>  drivers/staging/fbtft/fbtft-bus.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/staging/fbtft/fbtft-bus.c b/drivers/staging/fbtft/fbtft-bus.c
> index 2ea814d..2b43bc2 100644
> --- a/drivers/staging/fbtft/fbtft-bus.c
> +++ b/drivers/staging/fbtft/fbtft-bus.c
> @@ -62,9 +62,9 @@ out:                                                                        \
>  }                                                                             \
>  EXPORT_SYMBOL(func);
>
> -define_fbtft_write_reg(fbtft_write_reg8_bus8, u8, u8, )
> +define_fbtft_write_reg(fbtft_write_reg8_bus8, u8, u8,)
>  define_fbtft_write_reg(fbtft_write_reg16_bus8, __be16, u16, cpu_to_be16)
> -define_fbtft_write_reg(fbtft_write_reg16_bus16, u16, u16, )
> +define_fbtft_write_reg(fbtft_write_reg16_bus16, u16, u16,)

... as the space is the (mandatory) separator between the comma and the
(empty) last parameter value.

Checkpatch has some limitations when parsing the C preprocessor macro
languagage.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
