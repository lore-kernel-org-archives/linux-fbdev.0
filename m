From: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
Date: Tue, 16 Feb 2016 16:55:42 +0000
Subject: Re: [PATCH v2] xen kconfig: don't "select INPUT_XEN_KBDDEV_FRONTEND"
Message-Id: <alpine.DEB.2.02.1602161655350.27008@kaball.uk.xensource.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1455278707-2008263-1-git-send-email-arnd@arndb.de>
 <56C20552.8030305@citrix.com>
 <alpine.DEB.2.02.1602151708110.27008@kaball.uk.xensource.com>
 <2479546.WgivMO2bp2@wuerfel>
In-Reply-To: <2479546.WgivMO2bp2@wuerfel>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Tue, 16 Feb 2016, Arnd Bergmann wrote:
> The Xen framebuffer driver selects the xen keyboard driver, so the latter
> will be built-in if XEN_FBDEV_FRONTEND=y. However, when CONFIG_INPUT
> is a loadable module, this configuration cannot work. On mainline kernels,
> the symbol will be enabled but not used, while in combination with
> a patch I have to detect such useless configurations, we get the
> expected link failure:
> 
> drivers/input/built-in.o: In function `xenkbd_remove':
> xen-kbdfront.c:(.text+0x2f0): undefined reference to `input_unregister_device'
> xen-kbdfront.c:(.text+0x30e): undefined reference to `input_unregister_device'
> 
> This removes the extra "select", as it just causes more trouble than
> it helps. In theory, some defconfig file might break if it has
> XEN_FBDEV_FRONTEND in it but not INPUT_XEN_KBDDEV_FRONTEND. The Kconfig
> fragment we ship in the kernel (kernel/configs/xen.config) however
> already enables both, and anyone using an old .config file would
> keep having both enabled.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Suggested-by: David Vrabel <david.vrabel@citrix.com>
> Fixes: 36c1132e34bd ("xen kconfig: fix select INPUT_XEN_KBDDEV_FRONTEND")

Acked-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>


> diff --git a/drivers/video/fbdev/Kconfig b/drivers/video/fbdev/Kconfig
> index 8ea45a5cd806..d889ef2048df 100644
> --- a/drivers/video/fbdev/Kconfig
> +++ b/drivers/video/fbdev/Kconfig
> @@ -2246,7 +2246,6 @@ config XEN_FBDEV_FRONTEND
>  	select FB_SYS_IMAGEBLIT
>  	select FB_SYS_FOPS
>  	select FB_DEFERRED_IO
> -	select INPUT_XEN_KBDDEV_FRONTEND if INPUT_MISC
>  	select XEN_XENBUS_FRONTEND
>  	default y
>  	help
> 
