From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 18 Dec 2014 13:46:05 +0000
Subject: Re: [PATCH] video/logo: prevent use of logos after they have been freed
Message-Id: <CAMuHMdX9GB_ikDsGNLTgkDuAeRy81a-A9CVAFmX7Taab8_Z=oQ@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1418903842-22450-1-git-send-email-tomi.valkeinen@ti.com>
 <1418903842-22450-2-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1418903842-22450-2-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi Tomi,

On Thu, Dec 18, 2014 at 12:57 PM, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
> If the probe of an fb driver has been deferred due to missing
> dependencies, and the probe is later ran when a module is loaded, the
> fbdev framework will try to find a logo to use.
>
> However, the logos are __initdata, and have already been freed. This
> causes sometimes page faults, if the logo memory is not mapped,
> sometimes other random crashes as the logo data is invalid, and
> sometimes nothing, if the fbdev decides to reject the logo (e.g. the
> random value depicting the logo's height is too big).
>
> This patch adds a late_initcall function to mark the logos as freed. In
> reality the logos are freed later, and fbdev probe may be ran between
> this late_initcall and the freeing of the logos. In that case we will
> miss drawing the logo, even if it would be possible.
>
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
> ---
>  drivers/video/logo/logo.c | 17 ++++++++++++++++-
>  1 file changed, 16 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/video/logo/logo.c b/drivers/video/logo/logo.c
> index 940cd196eef5..10fbfd8ab963 100644
> --- a/drivers/video/logo/logo.c
> +++ b/drivers/video/logo/logo.c
> @@ -21,6 +21,21 @@ static bool nologo;
>  module_param(nologo, bool, 0);
>  MODULE_PARM_DESC(nologo, "Disables startup logo");
>
> +/*
> + * Logos are located in the initdata, and will be freed in kernel_init.
> + * Use late_init to mark the logos as freed to prevent any further use.
> + */
> +
> +static bool logos_freed;
> +
> +static int __init fb_logo_late_init(void)
> +{
> +       logos_freed = true;

Just set nologo to true?

> +       return 0;
> +}
> +
> +late_initcall(fb_logo_late_init);

Hmm...

> +
>  /* logo's are marked __initdata. Use __init_refok to tell
>   * modpost that it is intended that this function uses data
>   * marked __initdata.
> @@ -29,7 +44,7 @@ const struct linux_logo * __init_refok fb_find_logo(int depth)
>  {
>         const struct linux_logo *logo = NULL;
>
> -       if (nologo)
> +       if (nologo || logos_freed)

A long time ago (ibefore 2.1.124), we used to have a test on initmem_freed
here. But that variable no longer exists.

Perhaps you can check system_state? That's variable is changed from
SYSTEM_BOOTING to SYSTEM_RUNNING in kernel_init(), after freeing
initmem.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
