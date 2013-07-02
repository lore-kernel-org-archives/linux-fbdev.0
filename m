From: "Kim, Milo" <Milo.Kim@ti.com>
Date: Tue, 02 Jul 2013 23:24:42 +0000
Subject: Re: [PATCH] backlight: lp855x: set zero brightness at FBBLANK
Message-Id: <A874F61F95741C4A9BA573A70FE3998F82E7C42D@DQHE06.ent.ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1372767354-16499-1-git-send-email-oskar.andero@sonymobile.com>
In-Reply-To: <1372767354-16499-1-git-send-email-oskar.andero@sonymobile.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Oskar Andero <oskar.andero@sonymobile.com>, Shingo Nakao <shingo.x.nakao@sonymobile.com>
Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, "Valkeinen, Tomi" <tomi.valkeinen@ti.com>, Radovan Lekanovic <Radovan.Lekanovic@sonymobile.com>, Richard Purdie <rpurdie@rpsys.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>

> From: Shingo Nakao <shingo.x.nakao@sonymobile.com>
> 
> When backlight turns on early from display, a white line can be
> seen on the screen. Therefore make sure backlight is off when we
> are under an fb blank event.
> 
> Signed-off-by: Shingo Nakao <shingo.x.nakao@sonymobile.com>
> Cc: Milo Kim <milo.kim@ti.com>
> Cc: Richard Purdie <rpurdie@rpsys.net>
> Signed-off-by: Oskar Andero <oskar.andero@sonymobile.com>

Acked-by: Milo Kim <milo.kim@ti.com>

> ---
>  drivers/video/backlight/lp855x_bl.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/video/backlight/lp855x_bl.c b/drivers/video/backlight/lp855x_bl.c
> index a0e1e02..c0b41f1 100644
> --- a/drivers/video/backlight/lp855x_bl.c
> +++ b/drivers/video/backlight/lp855x_bl.c
> @@ -246,7 +246,7 @@ static int lp855x_bl_update_status(struct backlight_device *bl)
>  {
>         struct lp855x *lp = bl_get_data(bl);
> 
> -       if (bl->props.state & BL_CORE_SUSPENDED)
> +       if (bl->props.state & (BL_CORE_SUSPENDED | BL_CORE_FBBLANK))
>                 bl->props.brightness = 0;
> 
>         if (lp->mode = PWM_BASED) {
> --
> 1.8.1.5

