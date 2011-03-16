From: Eric Miao <eric.y.miao@gmail.com>
Date: Wed, 16 Mar 2011 13:16:29 +0000
Subject: Re: [PATCH 2/4] ARM: PXA: PXAFB: Fix plane Z-ordering problem
Message-Id: <AANLkTi=7pCyv5Dif36ynNbhJkz54CoTr5FYeThHbT7dj@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <201103060030.59584.anarsoul@gmail.com>
	<1299835250-11095-1-git-send-email-anarsoul@gmail.com>
	<1299835250-11095-2-git-send-email-anarsoul@gmail.com>
In-Reply-To: <1299835250-11095-2-git-send-email-anarsoul@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: linux-arm-kernel@lists.infradead.org

Applied.

On Fri, Mar 11, 2011 at 5:20 PM, Vasily Khoruzhick <anarsoul@gmail.com> wrote:
> pxafb_overlay_init is not right place to change Z-ordering,
> move it to main plane initialization.
>
> Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
> ---
>  drivers/video/pxafb.c |    8 ++++++--
>  1 files changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/video/pxafb.c b/drivers/video/pxafb.c
> index 0764759..e2f643e 100644
> --- a/drivers/video/pxafb.c
> +++ b/drivers/video/pxafb.c
> @@ -952,8 +952,6 @@ static void __devinit pxafb_overlay_init(struct pxafb_info *fbi)
>        /* mask all IU/BS/EOF/SOF interrupts */
>        lcd_writel(fbi, LCCR5, ~0);
>
> -       /* place overlay(s) on top of base */
> -       fbi->lccr0 |= LCCR0_OUC;
>        pr_info("PXA Overlay driver loaded successfully!\n");
>  }
>
> @@ -1843,6 +1841,12 @@ static struct pxafb_info * __devinit pxafb_init_fbinfo(struct device *dev)
>
>        pxafb_decode_mach_info(fbi, inf);
>
> +#ifdef CONFIG_FB_PXA_OVERLAY
> +       /* place overlay(s) on top of base */
> +       if (pxafb_overlay_supported())
> +               fbi->lccr0 |= LCCR0_OUC;
> +#endif
> +
>        init_waitqueue_head(&fbi->ctrlr_wait);
>        INIT_WORK(&fbi->task, pxafb_task);
>        mutex_init(&fbi->ctrlr_lock);
> --
> 1.7.4.1
>
>
