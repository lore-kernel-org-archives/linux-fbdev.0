From: Jingoo Han <jg1.han@samsung.com>
Date: Mon, 18 Mar 2013 03:13:13 +0000
Subject: Re: [PATCH v2 2/8] drivers: ata: use module_platform_driver_probe()
Message-Id: <018c01ce2386$86c8f5f0$945ae1d0$%han@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1363280978-24051-1-git-send-email-fabio.porcedda@gmail.com>
 <1363280978-24051-3-git-send-email-fabio.porcedda@gmail.com>
In-Reply-To: <1363280978-24051-3-git-send-email-fabio.porcedda@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Friday, March 15, 2013 2:10 AM, Fabio Porcedda wrote:
> 
> This patch converts the drivers to use the
> module_platform_driver_probe() macro which makes the code smaller and
> a bit simpler.
> 
> Signed-off-by: Fabio Porcedda <fabio.porcedda@gmail.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Jeff Garzik <jgarzik@pobox.com>
> Cc: linux-ide@vger.kernel.org
> ---
>  drivers/ata/pata_at32.c | 13 +------------
>  1 file changed, 1 insertion(+), 12 deletions(-)

I already submitted the patch 2 weeks ago.

http://www.spinics.net/lists/linux-ide/msg45141.html

Best regards,
Jingoo Han

> 
> diff --git a/drivers/ata/pata_at32.c b/drivers/ata/pata_at32.c
> index 36f189c..8d493b4 100644
> --- a/drivers/ata/pata_at32.c
> +++ b/drivers/ata/pata_at32.c
> @@ -393,18 +393,7 @@ static struct platform_driver pata_at32_driver = {
>  	},
>  };
> 
> -static int __init pata_at32_init(void)
> -{
> -	return platform_driver_probe(&pata_at32_driver, pata_at32_probe);
> -}
> -
> -static void __exit pata_at32_exit(void)
> -{
> -	platform_driver_unregister(&pata_at32_driver);
> -}
> -
> -module_init(pata_at32_init);
> -module_exit(pata_at32_exit);
> +module_platform_driver_probe(pata_at32_driver, pata_at32_probe);
> 
>  MODULE_LICENSE("GPL");
>  MODULE_DESCRIPTION("AVR32 SMC/CFC PATA Driver");
> --
> 1.8.1.5
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-fbdev" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

