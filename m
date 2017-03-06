From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 06 Mar 2017 19:34:07 +0000
Subject: Re: [PATCH 1/3] staging: sm750fb: fixes add blank line after function/struct/union/enum declarations
Message-Id: <CAMuHMdW3o0AjK1LVaiCrFWMUuUrB6dEuQ98w60Sch+cUePQuqg@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20170305112450.9066-1-arushisinghal19971997@gmail.com> <20170305112450.9066-2-arushisinghal19971997@gmail.com>
In-Reply-To: <20170305112450.9066-2-arushisinghal19971997@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Arushi Singhal <arushisinghal19971997@gmail.com>
Cc: Sudip Mukherjee <sudipm.mukherjee@gmail.com>, Teddy Wang <teddy.wang@siliconmotion.com>, outreachy-kernel@googlegroups.com, Greg KH <gregkh@linuxfoundation.org>, Linux Fbdev development list <linux-fbdev@vger.kernel.org>, driverdevel <devel@driverdev.osuosl.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>

Hi Arushi,

On Sun, Mar 5, 2017 at 12:24 PM, Arushi Singhal
<arushisinghal19971997@gmail.com> wrote:
> This patch fixes the warnings reported by checkpatch.pl
> for please use a blank line after function/struct/union/enum
> declarations.
>
> Signed-off-by: Arushi Singhal <arushisinghal19971997@gmail.com>
> ---
>  drivers/staging/sm750fb/ddk750_display.h | 1 +
>  drivers/staging/sm750fb/ddk750_mode.h    | 2 ++
>  drivers/staging/sm750fb/ddk750_power.h   | 1 +
>  drivers/staging/sm750fb/sm750_cursor.c   | 3 +++
>  4 files changed, 7 insertions(+)
>
> diff --git a/drivers/staging/sm750fb/ddk750_display.h b/drivers/staging/sm750fb/ddk750_display.h
> index e2a3f84ca4c5..8bf22e4f0d8b 100644
> --- a/drivers/staging/sm750fb/ddk750_display.h
> +++ b/drivers/staging/sm750fb/ddk750_display.h
> @@ -100,6 +100,7 @@ typedef enum _disp_output_t {
>         do_CRT_PRI = CRT_2_PRI | PRI_TP_ON | DPMS_ON | DAC_ON,
>         do_CRT_SEC = CRT_2_SEC | SEC_TP_ON | DPMS_ON | DAC_ON,
>  }
> +
>  disp_output_t;

That's a false positive. Actually "disp_output_t" should be on the
previous line,
after the closing curly brace, as variable types and names must not be split.

> --- a/drivers/staging/sm750fb/ddk750_mode.h
> +++ b/drivers/staging/sm750fb/ddk750_mode.h
> @@ -7,6 +7,7 @@ typedef enum _spolarity_t {
>         POS = 0, /* positive */
>         NEG, /* negative */
>  }
> +
>  spolarity_t;
>
>  typedef struct _mode_parameter_t {
> @@ -32,6 +33,7 @@ typedef struct _mode_parameter_t {
>         /* Clock Phase. This clock phase only applies to Panel. */
>         spolarity_t clock_phase_polarity;
>  }
> +
>  mode_parameter_t;

Likewise.

> --- a/drivers/staging/sm750fb/ddk750_power.h
> +++ b/drivers/staging/sm750fb/ddk750_power.h
> @@ -7,6 +7,7 @@ typedef enum _DPMS_t {
>         crtDPMS_SUSPEND = 0x2,
>         crtDPMS_OFF = 0x3,
>  }
> +
>  DPMS_t;

Likewise.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
