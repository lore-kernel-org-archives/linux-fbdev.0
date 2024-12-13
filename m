Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8702A6F30F
	for <linux-fbdev@vger.kernel.org>; Fri, 13 Dec 2024 07:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734075867; cv=none; b=Gmak9clKbjNQ75pv5kMCxiaoA/EgZve767X2zIIsRSH3tM0TYUWp3cjTQzl/YkPmqOku7Q17J8pqUWazAoCK9eS/ZKf479olKZdmTCuqQNRTXfEYY+m9faZzQnhzaLzQ1fC16t9cy7XqOgB6D5nfJvQicwyk2eaK0LkoTc+quYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734075867; c=relaxed/simple;
	bh=nDLDOBovM7Ftcmuq16OEXTBLYUMV2JgM6X7Tr14E1BE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mywz+7hwIn455/yDQYqSQzrRMtzuvEt+UVoISKmLoAhKHo6bVVIOjQlG764JWBO44bO6G3US1GvXlL1OMekd4MdYp5AHzldHL3LSBx/iudTXCJHgLKdvsJtEsA5b9wnQpZGGYUEV8xEnhhyqFUSF8J/BzD/BpSCKYVdtPeGQhGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4Y8hDk74H4z9stv;
	Fri, 13 Dec 2024 08:44:22 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NjS4Zc5qZafH; Fri, 13 Dec 2024 08:44:22 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4Y8hDk5dmMz9sts;
	Fri, 13 Dec 2024 08:44:22 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id AEA558B773;
	Fri, 13 Dec 2024 08:44:22 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id aCRMBn4qewz9; Fri, 13 Dec 2024 08:44:22 +0100 (CET)
Received: from [192.168.232.97] (unknown [192.168.232.97])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 2720D8B763;
	Fri, 13 Dec 2024 08:44:22 +0100 (CET)
Message-ID: <8403f989-c1de-48c9-ab48-83c1abb9e6f2@csgroup.eu>
Date: Fri, 13 Dec 2024 08:44:21 +0100
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] fbdev: Fix recursive dependencies wrt
 BACKLIGHT_CLASS_DEVICE
To: Thomas Zimmermann <tzimmermann@suse.de>, javierm@redhat.com,
 arnd@arndb.de, deller@gmx.de, simona@ffwll.ch, airlied@gmail.com
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
 linux-staging@lists.linux.dev, linuxppc-dev@lists.ozlabs.org
References: <20241212100636.45875-1-tzimmermann@suse.de>
 <20241212100636.45875-2-tzimmermann@suse.de>
Content-Language: fr-FR
From: Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <20241212100636.45875-2-tzimmermann@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 12/12/2024 à 11:04, Thomas Zimmermann a écrit :
> Do not select BACKLIGHT_CLASS_DEVICE from FB_BACKLIGHT. The latter
> only controls backlight support within fbdev core code and data
> structures.
> 
> Make fbdev drivers depend on BACKLIGHT_CLASS_DEVICE and let users
> select it explicitly. Fixes warnings about recursive dependencies,
> such as
> 
> error: recursive dependency detected!
> 	symbol BACKLIGHT_CLASS_DEVICE is selected by FB_BACKLIGHT
> 	symbol FB_BACKLIGHT is selected by FB_SH_MOBILE_LCDC
> 	symbol FB_SH_MOBILE_LCDC depends on FB_DEVICE
> 	symbol FB_DEVICE depends on FB_CORE
> 	symbol FB_CORE is selected by DRM_GEM_DMA_HELPER
> 	symbol DRM_GEM_DMA_HELPER is selected by DRM_PANEL_ILITEK_ILI9341
> 	symbol DRM_PANEL_ILITEK_ILI9341 depends on BACKLIGHT_CLASS_DEVICE
> 
> BACKLIGHT_CLASS_DEVICE is user-selectable, so making drivers adapt to
> it is the correct approach in any case. For most drivers, backlight
> support is also configurable separately.
> 
> v2:
> - s/BACKLIGHT_DEVICE_CLASS/BACKLIGHT_CLASS_DEVICE (Helge)
> - Fix fbdev driver-dependency corner case (Arnd)
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---
>   drivers/auxdisplay/Kconfig       |  2 +-
>   drivers/macintosh/Kconfig        |  1 +
>   drivers/staging/fbtft/Kconfig    |  1 +
>   drivers/video/fbdev/Kconfig      | 18 +++++++++++++-----
>   drivers/video/fbdev/core/Kconfig |  3 +--
>   5 files changed, 17 insertions(+), 8 deletions(-)

Build fails which pmac32_defconfig :

   LD      .tmp_vmlinux1
powerpc64-linux-ld: drivers/macintosh/via-pmu-backlight.o: in function 
`pmu_backlight_init':
via-pmu-backlight.c:(.init.text+0xc0): undefined reference to 
`backlight_device_register'
make[2]: *** [scripts/Makefile.vmlinux:77: vmlinux] Error 1
make[1]: *** [/home/chleroy/linux-powerpc/Makefile:1225: vmlinux] Error 2


> 
> diff --git a/drivers/auxdisplay/Kconfig b/drivers/auxdisplay/Kconfig
> index 21545ffba065..8934e6ad5772 100644
> --- a/drivers/auxdisplay/Kconfig
> +++ b/drivers/auxdisplay/Kconfig
> @@ -489,7 +489,7 @@ config IMG_ASCII_LCD
>   
>   config HT16K33
>   	tristate "Holtek Ht16K33 LED controller with keyscan"
> -	depends on FB && I2C && INPUT
> +	depends on FB && I2C && INPUT && BACKLIGHT_CLASS_DEVICE
>   	select FB_SYSMEM_HELPERS
>   	select INPUT_MATRIXKMAP
>   	select FB_BACKLIGHT
> diff --git a/drivers/macintosh/Kconfig b/drivers/macintosh/Kconfig
> index fb38f684444f..bf3824032d61 100644
> --- a/drivers/macintosh/Kconfig
> +++ b/drivers/macintosh/Kconfig
> @@ -120,6 +120,7 @@ config PMAC_MEDIABAY
>   config PMAC_BACKLIGHT
>   	bool "Backlight control for LCD screens"
>   	depends on PPC_PMAC && ADB_PMU && FB = y && (BROKEN || !PPC64)
> +	depends on BACKLIGHT_CLASS_DEVICE
>   	select FB_BACKLIGHT
>   	help
>   	  Say Y here to enable Macintosh specific extensions of the generic
> diff --git a/drivers/staging/fbtft/Kconfig b/drivers/staging/fbtft/Kconfig
> index 77ab44362f16..dcf6a70455cc 100644
> --- a/drivers/staging/fbtft/Kconfig
> +++ b/drivers/staging/fbtft/Kconfig
> @@ -3,6 +3,7 @@ menuconfig FB_TFT
>   	tristate "Support for small TFT LCD display modules"
>   	depends on FB && SPI
>   	depends on FB_DEVICE
> +	depends on BACKLIGHT_CLASS_DEVICE
>   	depends on GPIOLIB || COMPILE_TEST
>   	select FB_BACKLIGHT
>   	select FB_SYSMEM_HELPERS_DEFERRED
> diff --git a/drivers/video/fbdev/Kconfig b/drivers/video/fbdev/Kconfig
> index de035071fedb..55c6686f091e 100644
> --- a/drivers/video/fbdev/Kconfig
> +++ b/drivers/video/fbdev/Kconfig
> @@ -649,6 +649,7 @@ config FB_S1D13XXX
>   config FB_ATMEL
>   	tristate "AT91 LCD Controller support"
>   	depends on FB && OF && HAVE_CLK && HAS_IOMEM
> +	depends on BACKLIGHT_CLASS_DEVICE
>   	depends on HAVE_FB_ATMEL || COMPILE_TEST
>   	select FB_BACKLIGHT
>   	select FB_IOMEM_HELPERS
> @@ -660,7 +661,6 @@ config FB_ATMEL
>   config FB_NVIDIA
>   	tristate "nVidia Framebuffer Support"
>   	depends on FB && PCI
> -	select FB_BACKLIGHT if FB_NVIDIA_BACKLIGHT
>   	select FB_CFB_FILLRECT
>   	select FB_CFB_COPYAREA
>   	select FB_CFB_IMAGEBLIT
> @@ -700,6 +700,8 @@ config FB_NVIDIA_DEBUG
>   config FB_NVIDIA_BACKLIGHT
>   	bool "Support for backlight control"
>   	depends on FB_NVIDIA
> +	depends on BACKLIGHT_CLASS_DEVICE=y || BACKLIGHT_CLASS_DEVICE=FB_NVIDIA
> +	select FB_BACKLIGHT
>   	default y
>   	help
>   	  Say Y here if you want to control the backlight of your display.
> @@ -707,7 +709,6 @@ config FB_NVIDIA_BACKLIGHT
>   config FB_RIVA
>   	tristate "nVidia Riva support"
>   	depends on FB && PCI
> -	select FB_BACKLIGHT if FB_RIVA_BACKLIGHT
>   	select FB_CFB_FILLRECT
>   	select FB_CFB_COPYAREA
>   	select FB_CFB_IMAGEBLIT
> @@ -747,6 +748,8 @@ config FB_RIVA_DEBUG
>   config FB_RIVA_BACKLIGHT
>   	bool "Support for backlight control"
>   	depends on FB_RIVA
> +	depends on BACKLIGHT_CLASS_DEVICE=y || BACKLIGHT_CLASS_DEVICE=FB_RIVA
> +	select FB_BACKLIGHT
>   	default y
>   	help
>   	  Say Y here if you want to control the backlight of your display.
> @@ -934,7 +937,6 @@ config FB_MATROX_MAVEN
>   config FB_RADEON
>   	tristate "ATI Radeon display support"
>   	depends on FB && PCI
> -	select FB_BACKLIGHT if FB_RADEON_BACKLIGHT
>   	select FB_CFB_FILLRECT
>   	select FB_CFB_COPYAREA
>   	select FB_CFB_IMAGEBLIT
> @@ -960,6 +962,8 @@ config FB_RADEON_I2C
>   config FB_RADEON_BACKLIGHT
>   	bool "Support for backlight control"
>   	depends on FB_RADEON
> +	depends on BACKLIGHT_CLASS_DEVICE=y || BACKLIGHT_CLASS_DEVICE=FB_RADEON
> +	select FB_BACKLIGHT
>   	default y
>   	help
>   	  Say Y here if you want to control the backlight of your display.
> @@ -975,7 +979,6 @@ config FB_RADEON_DEBUG
>   config FB_ATY128
>   	tristate "ATI Rage128 display support"
>   	depends on FB && PCI
> -	select FB_BACKLIGHT if FB_ATY128_BACKLIGHT
>   	select FB_IOMEM_HELPERS
>   	select FB_MACMODES if PPC_PMAC
>   	help
> @@ -989,6 +992,8 @@ config FB_ATY128
>   config FB_ATY128_BACKLIGHT
>   	bool "Support for backlight control"
>   	depends on FB_ATY128
> +	depends on BACKLIGHT_CLASS_DEVICE=y || BACKLIGHT_CLASS_DEVICE=FB_ATY128
> +	select FB_BACKLIGHT
>   	default y
>   	help
>   	  Say Y here if you want to control the backlight of your display.
> @@ -999,7 +1004,6 @@ config FB_ATY
>   	select FB_CFB_FILLRECT
>   	select FB_CFB_COPYAREA
>   	select FB_CFB_IMAGEBLIT
> -	select FB_BACKLIGHT if FB_ATY_BACKLIGHT
>   	select FB_IOMEM_FOPS
>   	select FB_MACMODES if PPC
>   	select FB_ATY_CT if SPARC64 && PCI
> @@ -1040,6 +1044,8 @@ config FB_ATY_GX
>   config FB_ATY_BACKLIGHT
>   	bool "Support for backlight control"
>   	depends on FB_ATY
> +	depends on BACKLIGHT_CLASS_DEVICE=y || BACKLIGHT_CLASS_DEVICE=FB_ATY
> +	select FB_BACKLIGHT
>   	default y
>   	help
>   	  Say Y here if you want to control the backlight of your display.
> @@ -1528,6 +1534,7 @@ config FB_SH_MOBILE_LCDC
>   	depends on FB && HAVE_CLK && HAS_IOMEM
>   	depends on SUPERH || COMPILE_TEST
>   	depends on FB_DEVICE
> +	depends on BACKLIGHT_CLASS_DEVICE
>   	select FB_BACKLIGHT
>   	select FB_DEFERRED_IO
>   	select FB_DMAMEM_HELPERS
> @@ -1793,6 +1800,7 @@ config FB_SSD1307
>   	tristate "Solomon SSD1307 framebuffer support"
>   	depends on FB && I2C
>   	depends on GPIOLIB || COMPILE_TEST
> +	depends on BACKLIGHT_CLASS_DEVICE
>   	select FB_BACKLIGHT
>   	select FB_SYSMEM_HELPERS_DEFERRED
>   	help
> diff --git a/drivers/video/fbdev/core/Kconfig b/drivers/video/fbdev/core/Kconfig
> index 0ab8848ba2f1..d554d8c543d4 100644
> --- a/drivers/video/fbdev/core/Kconfig
> +++ b/drivers/video/fbdev/core/Kconfig
> @@ -183,9 +183,8 @@ config FB_SYSMEM_HELPERS_DEFERRED
>   	select FB_SYSMEM_HELPERS
>   
>   config FB_BACKLIGHT
> -	tristate
> +	bool
>   	depends on FB
> -	select BACKLIGHT_CLASS_DEVICE
>   
>   config FB_MODE_HELPERS
>   	bool "Enable Video Mode Handling Helpers"

