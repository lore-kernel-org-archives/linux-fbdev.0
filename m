From: Michael Ellerman <mpe@ellerman.id.au>
Date: Tue, 16 Oct 2018 23:52:08 +0000
Subject: Re: [PATCH -next] drivers/video/fbdev: remove set but not used variable 'size'
Message-Id: <87d0s9laaf.fsf@concordia.ellerman.id.au>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1539676794-40133-1-git-send-email-yuehaibing@huawei.com>
In-Reply-To: <1539676794-40133-1-git-send-email-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Daniel Vetter <daniel.vetter@ffwll.ch>, Christophe Leroy <christophe.leroy@c-s.fr>
Cc: kernel-janitors@vger.kernel.org, linux-fbdev@vger.kernel.org, YueHaibing <yuehaibing@huawei.com>, dri-devel@lists.freedesktop.org

YueHaibing <yuehaibing@huawei.com> writes:

> Fixes gcc '-Wunused-but-set-variable' warning:
>
> drivers/video/fbdev/chipsfb.c: In function 'chipsfb_pci_init':
> drivers/video/fbdev/chipsfb.c:352:22: warning:
>  variable 'size' set but not used [-Wunused-but-set-variable]
>
> It not used any more after commit
> 8c8709334cec ("[PATCH] ppc32: Remove CONFIG_PMAC_PBOOK")
>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  drivers/video/fbdev/chipsfb.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Looks good, thanks.

Should I merge this? Or otherwise:

Acked-by: Michael Ellerman <mpe@ellerman.id.au>

cheers

> diff --git a/drivers/video/fbdev/chipsfb.c b/drivers/video/fbdev/chipsfb.c
> index 40182ed..ca549e1 100644
> --- a/drivers/video/fbdev/chipsfb.c
> +++ b/drivers/video/fbdev/chipsfb.c
> @@ -349,7 +349,7 @@ static void init_chips(struct fb_info *p, unsigned long addr)
>  static int chipsfb_pci_init(struct pci_dev *dp, const struct pci_device_id *ent)
>  {
>  	struct fb_info *p;
> -	unsigned long addr, size;
> +	unsigned long addr;
>  	unsigned short cmd;
>  	int rc = -ENODEV;
>  
> @@ -361,7 +361,6 @@ static int chipsfb_pci_init(struct pci_dev *dp, const struct pci_device_id *ent)
>  	if ((dp->resource[0].flags & IORESOURCE_MEM) = 0)
>  		goto err_disable;
>  	addr = pci_resource_start(dp, 0);
> -	size = pci_resource_len(dp, 0);
>  	if (addr = 0)
>  		goto err_disable;
