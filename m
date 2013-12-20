From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 20 Dec 2013 15:27:07 +0000
Subject: Re: [PATCH] video/logo: don't look for the logo after system boot
Message-Id: <CAMuHMdXG3VKGngq6a_7LGOa5RbByBa8=Jv-g+GWKjjEhPjwH5w@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1387549460-18501-1-git-send-email-bigeasy@linutronix.de>
In-Reply-To: <1387549460-18501-1-git-send-email-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Fri, Dec 20, 2013 at 3:24 PM, Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
> If the primary GPU driver has been loaded _after_ system as a module
> then this logo memory is no longer valid.
> Managed to crash the system by booting a box without a GPU and then
> hotpluggin => BOOM.

Which GPU driver is this?

drivers/video/fbmem.c:fb_prepare_logo() has protection against this:

        if (info->flags & FBINFO_MISC_TILEBLITTING ||
            info->flags & FBINFO_MODULE)
                return 0;

> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  drivers/video/logo/logo.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/video/logo/logo.c b/drivers/video/logo/logo.c
> index 080c35b..a26bb16 100644
> --- a/drivers/video/logo/logo.c
> +++ b/drivers/video/logo/logo.c
> @@ -36,6 +36,9 @@ const struct linux_logo * __init_refok fb_find_logo(int depth)
>         if (nologo)
>                 return NULL;
>
> +       if (system_state != SYSTEM_BOOTING)
> +               return NULL;
> +
>         if (depth >= 1) {
>  #ifdef CONFIG_LOGO_LINUX_MONO
>                 /* Generic Linux logo */

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
