From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Fri, 21 Jun 2019 10:58:26 +0000
Subject: Re: [PATCH] video: fbdev: pvr2fb: fix link error for pvr2fb_pci_exit
Message-Id: <1628618a-7cf6-506e-9d87-c0966a99fbea@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20190617131645epcas1p3340c80f9e83af93bcbb4c68128b1ea44@epcas1p3.samsung.com>
        <20190617131624.2382303-1-arnd@arndb.de>
In-Reply-To: <20190617131624.2382303-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Arnd Bergmann <arnd@arndb.de>
Cc: YueHaibing <yuehaibing@huawei.com>, Ira Weiny <ira.weiny@intel.com>, Andrew Morton <akpm@linux-foundation.org>, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org


Hi,

On 6/17/19 3:16 PM, Arnd Bergmann wrote:
> When the driver is built-in for PCI, we reference the exit function
> after discarding it:
> 
> `pvr2fb_pci_exit' referenced in section `.ref.data' of drivers/video/fbdev/pvr2fb.o: defined in discarded section `.exit.text' of drivers/video/fbdev/pvr2fb.o
> 
> Just remove the __exit annotation as the easiest workaround.

Don't we also need to fix pvr2fb_dc_exit() for CONFIG_SH_DREAMCAST=y case? 

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

> Fixes: 0f5a5712ad1e ("video: fbdev: pvr2fb: add COMPILE_TEST support")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/video/fbdev/pvr2fb.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/video/fbdev/pvr2fb.c b/drivers/video/fbdev/pvr2fb.c
> index 299ea7db9220..cf9cfdc5e685 100644
> --- a/drivers/video/fbdev/pvr2fb.c
> +++ b/drivers/video/fbdev/pvr2fb.c
> @@ -990,7 +990,7 @@ static int __init pvr2fb_pci_init(void)
>  	return pci_register_driver(&pvr2fb_pci_driver);
>  }
>  
> -static void __exit pvr2fb_pci_exit(void)
> +static void pvr2fb_pci_exit(void)
>  {
>  	pci_unregister_driver(&pvr2fb_pci_driver);
>  }
