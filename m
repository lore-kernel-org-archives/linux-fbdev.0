From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Sun, 22 Nov 2015 20:51:54 +0000
Subject: Re: [PATCH] fbdev: sm712fb: avoid unused function warnings
Message-Id: <CAMuHMdXCAG0N1KgqVeLvfCM_JgJYpLQXp8zkJPKEiN4YW6jthQ@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <4240710.SWINpxTKzN@wuerfel>
In-Reply-To: <4240710.SWINpxTKzN@wuerfel>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi Arnd,

On Fri, Nov 20, 2015 at 10:48 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> The sm712fb framebuffer driver encloses the power-management
> functions in #ifdef CONFIG_PM, but the smtcfb_pci_suspend/resume
> functions are only really used when CONFIG_PM_SLEEP is also
> set, as a frequent gcc warning shows:
>
> fbdev/sm712fb.c:1549:12: warning: 'smtcfb_pci_suspend' defined but not used
> fbdev/sm712fb.c:1572:12: warning: 'smtcfb_pci_resume' defined but not used
>
> The driver also avoids using the SIMPLE_DEV_PM_OPS macro when
> CONFIG_PM is unset, which is redundant.

Is it? AFAIK there's no dummy of SIMPLE_DEV_PM_OPS() for the !CONFIG_PM case
yet. May be a good idea to have, though.

> This changes the driver to remove the #ifdef and instead mark
> the functions as __maybe_unused, which is a nicer anyway, as it
> provides build testing for all the code in all configurations
> and is harder to get wrong.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>
> diff --git a/drivers/video/fbdev/sm712fb.c b/drivers/video/fbdev/sm712fb.c
> index 629bfa2d2f51..86ae1d4556fc 100644
> --- a/drivers/video/fbdev/sm712fb.c
> +++ b/drivers/video/fbdev/sm712fb.c
> @@ -28,9 +28,7 @@
>  #include <linux/console.h>
>  #include <linux/screen_info.h>
>
> -#ifdef CONFIG_PM
>  #include <linux/pm.h>
> -#endif
>
>  #include "sm712.h"
>
> @@ -1545,8 +1543,7 @@ static void smtcfb_pci_remove(struct pci_dev *pdev)
>         pci_disable_device(pdev);
>  }
>
> -#ifdef CONFIG_PM
> -static int smtcfb_pci_suspend(struct device *device)
> +static int __maybe_unused smtcfb_pci_suspend(struct device *device)
>  {
>         struct pci_dev *pdev = to_pci_dev(device);
>         struct smtcfb_info *sfb;
> @@ -1569,7 +1566,7 @@ static int smtcfb_pci_suspend(struct device *device)
>         return 0;
>  }
>
> -static int smtcfb_pci_resume(struct device *device)
> +static int __maybe_unused smtcfb_pci_resume(struct device *device)
>  {
>         struct pci_dev *pdev = to_pci_dev(device);
>         struct smtcfb_info *sfb;
> @@ -1610,20 +1607,13 @@ static int smtcfb_pci_resume(struct device *device)
>  }
>
>  static SIMPLE_DEV_PM_OPS(sm7xx_pm_ops, smtcfb_pci_suspend, smtcfb_pci_resume);
>
> -#define SM7XX_PM_OPS (&sm7xx_pm_ops)
> -
> -#else  /* !CONFIG_PM */
> -
> -#define SM7XX_PM_OPS NULL
> -
> -#endif /* !CONFIG_PM */
>
>  static struct pci_driver smtcfb_driver = {
>         .name = "smtcfb",
>         .id_table = smtcfb_pci_table,
>         .probe = smtcfb_pci_probe,
>         .remove = smtcfb_pci_remove,
> -       .driver.pm  = SM7XX_PM_OPS,
> +       .driver.pm  = &sm7xx_pm_ops,

Hence now there will always be a struct dev_pm_ops in the binary,
which contains 23 pointers, i.e 92 or 184 bytes.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
