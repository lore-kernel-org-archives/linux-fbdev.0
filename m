From: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Date: Sun, 19 Feb 2012 22:44:15 +0000
Subject: Re: [PATCH 5/5] fbdev: s/#if CONFIG/#ifdef CONFIG/
Message-Id: <4F417B3F.2050307@gmx.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1329664319-3128-1-git-send-email-geert@linux-m68k.org> <1329664319-3128-5-git-send-email-geert@linux-m68k.org>
In-Reply-To: <1329664319-3128-5-git-send-email-geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Jiri Kosina <trivial@kernel.org>, linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org

On 02/19/2012 03:11 PM, Geert Uytterhoeven wrote:
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Cc: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>

Acked-by: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
(I assume you want that to go mainline via Jiri's tree)


Best regards,

Florian Tobias Schandinat

> Cc: linux-fbdev@vger.kernel.org
> ---
>  drivers/video/au1100fb.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/video/au1100fb.c b/drivers/video/au1100fb.c
> index de9da67..4da1895 100644
> --- a/drivers/video/au1100fb.c
> +++ b/drivers/video/au1100fb.c
> @@ -532,7 +532,7 @@ static int __devinit au1100fb_drv_probe(struct platform_device *dev)
>  	for (page = (unsigned long)fbdev->fb_mem;
>  	     page < PAGE_ALIGN((unsigned long)fbdev->fb_mem + fbdev->fb_len);
>  	     page += PAGE_SIZE) {
> -#if CONFIG_DMA_NONCOHERENT
> +#ifdef CONFIG_DMA_NONCOHERENT
>  		SetPageReserved(virt_to_page(CAC_ADDR((void *)page)));
>  #else
>  		SetPageReserved(virt_to_page(page));

