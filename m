From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 22 Jul 2013 11:16:47 +0000
Subject: Re: [PATCH] drivers: video: fbmem: add signed type cast for comparation.
Message-Id: <CAMuHMdX6B6C9=dtJTUVSaO35rRzcTKrHD_Sx7EVD0W9qW2DdjA@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <51ECE851.4030002@asianux.com>
In-Reply-To: <51ECE851.4030002@asianux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Mon, Jul 22, 2013 at 10:07 AM, Chen Gang <gang.chen@asianux.com> wrote:
> For 'con2fb.framebuffer', it can be '-1' as an invalid value, so it
> need related type cast for its comparing.
>
> The related warning:
>
>   drivers/video/fbmem.c:1169:3: warning: comparison of unsigned expression < 0 is always false [-Wtype-limits]
>
>
> Signed-off-by: Chen Gang <gang.chen@asianux.com>
> ---
>  drivers/video/fbmem.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/video/fbmem.c b/drivers/video/fbmem.c
> index 36e1fe2..8e8225c 100644
> --- a/drivers/video/fbmem.c
> +++ b/drivers/video/fbmem.c
> @@ -1166,7 +1166,7 @@ static long do_fb_ioctl(struct fb_info *info, unsigned int cmd,
>                         return -EFAULT;
>                 if (con2fb.console < 1 || con2fb.console > MAX_NR_CONSOLES)
>                         return -EINVAL;
> -               if (con2fb.framebuffer < 0 || con2fb.framebuffer >= FB_MAX)
> +               if ((int)con2fb.framebuffer < 0 || con2fb.framebuffer >= FB_MAX)
>                         return -EINVAL;

Instead of adding the cast, you can also just remove the check, as it's useless.
If it's `-1' for invalid, after conversion to unsigned, it will
trigger the check
">= FB_MAX".

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
