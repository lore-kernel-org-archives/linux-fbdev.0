Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3948DC4332F
	for <linux-fbdev@archiver.kernel.org>; Wed,  9 Nov 2022 02:06:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229593AbiKICGM (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Tue, 8 Nov 2022 21:06:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiKICGL (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Tue, 8 Nov 2022 21:06:11 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A84C663E1
        for <linux-fbdev@vger.kernel.org>; Tue,  8 Nov 2022 18:06:09 -0800 (PST)
Received: from dggpeml500022.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4N6SxH1n6YzmVWB;
        Wed,  9 Nov 2022 10:05:55 +0800 (CST)
Received: from dggpeml500003.china.huawei.com (7.185.36.200) by
 dggpeml500022.china.huawei.com (7.185.36.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 9 Nov 2022 10:06:07 +0800
Received: from [10.174.177.173] (10.174.177.173) by
 dggpeml500003.china.huawei.com (7.185.36.200) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 9 Nov 2022 10:06:07 +0800
Message-ID: <59c98394-8dc9-0a2d-34e4-1cd95fe9f0e0@huawei.com>
Date:   Wed, 9 Nov 2022 10:06:07 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH] backlight: fix build error when CONFIG_ARCH_OMAP1_ANY=n
To:     <lee@kernel.org>, <deller@gmx.de>
CC:     <liwei391@huawei.com>, <linux-fbdev@vger.kernel.org>
References: <20221108113835.4135655-1-liaoyu15@huawei.com>
Content-Language: en-US
From:   Yu Liao <liaoyu15@huawei.com>
In-Reply-To: <20221108113835.4135655-1-liaoyu15@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.173]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpeml500003.china.huawei.com (7.185.36.200)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On 2022/11/8 19:38, Yu Liao wrote:
> If CONFIG_BACKLIGHT_OMAP1=y and CONFIG_ARCH_OMAP1_ANY=n, it leads a build
> error:
> 
> 	drivers/video/backlight/omap1_bl.o: In function `omapbl_probe':
> 	omap1_bl.c:(.text+0x198): undefined reference to `omap_cfg_reg'
> 
> Here is the link to the issue reported by kernel test bot:
> 
> https://lore.kernel.org/lkml/202211060819.fHDGmrB4-lkp@intel.com/
> 
> arch/arm/mach-omap1/mux.c where defines omap_cfg_reg() depends on
> CONFIG_ARCH_OMAP1_ANY, so make CONFIG_BACKLIGHT_OMAP1 depends on
> CONFIG_ARCH_OMAP1_ANY to fix it. ARCH_OMAP1_ANY depends on ARCH_OMAP1,
> so the following logic is equivalent:
> 
> ARCH_OMAP1_ANY && (ARCH_OMAP1 || COMPILE_TEST) = ARCH_OMAP1_ANY
> 
> Fixes: 7036440eab3e ("ARM: omap1: enable multiplatform")
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Yu Liao <liaoyu15@huawei.com>
> ---
>  drivers/video/backlight/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/video/backlight/Kconfig b/drivers/video/backlight/Kconfig
> index 936ba1e4d35e..ff66cfebe45a 100644
> --- a/drivers/video/backlight/Kconfig
> +++ b/drivers/video/backlight/Kconfig
> @@ -211,7 +211,7 @@ config BACKLIGHT_LOCOMO
>  
>  config BACKLIGHT_OMAP1
>  	tristate "OMAP1 PWL-based LCD Backlight"
> -	depends on ARCH_OMAP1 || COMPILE_TEST
> +	depends on ARCH_OMAP1_ANY
>  	default ARCH_OMAP1
>  	help
>  	  This driver controls the LCD backlight level and power for
Sorry, guys.

I realize this modification is wrong, BACKLIGHT_OMAP1 does not depend on
ARCH_OMAP1_ANY, please ignore this patch.

Thanks,
Yu
