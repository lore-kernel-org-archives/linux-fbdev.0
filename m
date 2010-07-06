From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 06 Jul 2010 20:23:17 +0000
Subject: Re: [PATCH 1/3] FB: Add some members for CPU Interface.
Message-Id: <AANLkTikDxVCC2LC82T7hj41Gd4Ws3sZZEj84N-_LSsqQ@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <AANLkTilgB3s8hy5Qg7IYpyBzwHCgK_GswVZqpxhryU5L@mail.gmail.com>
In-Reply-To: <AANLkTilgB3s8hy5Qg7IYpyBzwHCgK_GswVZqpxhryU5L@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: linux-fbdev@vger.kernel.org

On Tue, Jul 6, 2010 at 17:30, James Simmons <jsimmons@infradead.org> wrote:
>
> CPU interface needs cs, wr setup, wr act and hold delay.
> I added some members for them to common framework.
>
> Signed-off-by: InKi Dae <inki.dae@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
>
> diff --git a/drivers/video/modedb.c b/drivers/video/modedb.c
>
> index 0a4dbdc..74122d1 100644
> --- a/drivers/video/modedb.c
> +++ b/drivers/video/modedb.c
> @@ -759,6 +759,27 @@ void fb_videomode_to_var(struct fb_var_screeninfo *var,
>  }
>
>  /**
> + * fb_cpumode_to_var - convert fb_cpumode to fb_var_screeninfo
         ^^^
> + * @var: pointer to struct fb_var_screeninfo
> + * @mode: pointer to struct fb_cpumode
> + */
> +void fb_cmdmode_to_var(struct fb_var_screeninfo *var,
           ^^^

cpu vs cmd?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
