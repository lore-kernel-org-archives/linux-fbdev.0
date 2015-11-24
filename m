From: Timur Tabi <timur@tabi.org>
Date: Tue, 24 Nov 2015 16:12:30 +0000
Subject: Re: [PATCH] video: fbdev: fsl: fix kernel crash when diu_ops is not implemented
Message-Id: <CAOZdJXVvKnwjU33BroueohW3yCYFK=_bka99e=6krVObKRVdRQ@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1448346450-47403-1-git-send-email-dongsheng.wang@freescale.com>
In-Reply-To: <1448346450-47403-1-git-send-email-dongsheng.wang@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

 On Tue, Nov 24, 2015 at 1:27 AM, Dongsheng Wang
<dongsheng.wang@freescale.com> wrote:
> @@ -1697,6 +1700,9 @@ static int fsl_diu_probe(struct platform_device *pdev)
>         unsigned int i;
>         int ret;
>
> +       if (!diu_ops.set_pixel_clock)
> +               return -ENODEV;
> +
>         data = dmam_alloc_coherent(&pdev->dev, sizeof(struct fsl_diu_data),
>                                    &dma_addr, GFP_DMA | __GFP_ZERO);
>         if (!data)

This doesn't make any sense.  If set_pixel_clock() is not defined,
then the whole driver aborts the probe.  When could that ever happen?
If the platform code does not exist, then don't let the driver be
probed.
