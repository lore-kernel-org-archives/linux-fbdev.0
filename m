From: Wan ZongShun <mcuos.com@gmail.com>
Date: Mon, 15 Jul 2013 02:41:45 +0000
Subject: Re: [PATCH] video: nuc900fb: fix to pass correct device identity to free_irq()
Message-Id: <CAKT61h-yRxHk6uQqp7hXNQcnRv7WOUQsi21SnCANhSECCW4nYw@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CAPgLHd_mMOOeMecVJbTQjiK+xJD+-8jvgH6oAFqTHK_uSpWOJw@mail.gmail.com>
In-Reply-To: <CAPgLHd_mMOOeMecVJbTQjiK+xJD+-8jvgH6oAFqTHK_uSpWOJw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

2013/7/12 Wei Yongjun <weiyj.lk@gmail.com>:
> From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
>
> free_irq() expects the same device identity that was passed to
> corresponding request_irq(), otherwise the IRQ is not freed.
>
> Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

Sorry, repost.

Hi Yongjun,

(1)  ret = request_irq(irq, nuc900fb_irqhandler, 0,
              pdev->name, fbinfo);

(2)  static irqreturn_t nuc900fb_irqhandler(int irq, void *dev_id)
{
    struct nuc900fb_info *fbi = dev_id;
    void __iomem *regs = fbi->io;

From (1) and (2), we should consider the wrong with passing 'fbinfo'
to 'nuc900fb_irqhandler', it should pass the 'fbi' instead as
following codes:

ret = request_irq(irq, nuc900fb_irqhandler, 0,
              pdev->name, fbi);

So if we fix this wrong,' free_irq(irq, fbi);' would be ok, right?

Thanks!
Vincent Wan.


> ---
>  drivers/video/nuc900fb.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/video/nuc900fb.c b/drivers/video/nuc900fb.c
> index 8c527e5..ebd5501 100644
> --- a/drivers/video/nuc900fb.c
> +++ b/drivers/video/nuc900fb.c
> @@ -661,7 +661,7 @@ release_clock:
>         clk_disable(fbi->clk);
>         clk_put(fbi->clk);
>  release_irq:
> -       free_irq(irq, fbi);
> +       free_irq(irq, fbinfo);
>  release_regs:
>         iounmap(fbi->io);
>  release_mem_region:
> @@ -702,7 +702,7 @@ static int nuc900fb_remove(struct platform_device *pdev)
>         iounmap(fbi->io);
>
>         irq = platform_get_irq(pdev, 0);
> -       free_irq(irq, fbi);
> +       free_irq(irq, fbinfo);
>
>         release_resource(fbi->mem);
>         kfree(fbi->mem);
>



--
Wan ZongShun.
www.mcuos.com
