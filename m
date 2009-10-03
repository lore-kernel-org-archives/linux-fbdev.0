From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: Re: [Linux-fbdev-devel] [PATCH 1/7] [ARM] s3c-fb: Added colorkey
	support
Date: Sat, 3 Oct 2009 07:25:08 +0200
Message-ID: <20091003072508.2f868a83.krzysztof.h1@poczta.fm>
References: <E4D3F24EA6C9E54F817833EAE0D912AC0771185D58@bssrvexch01.BS.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <E4D3F24EA6C9E54F817833EAE0D912AC0771185D58@bssrvexch01.BS.local>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>, 
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>, 
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Pawel Osciak <p.osciak@samsung.com>
Cc: "linux-fbdev-devel@lists.sourceforge.net" <linux-fbdev-devel@lists.sourceforge.net>, "adaplas@gmail.com" <adaplas@gmail.com>, =?UTF-8?Q?=EB=B0=95=EA=B2=BD?= =?UTF-8?Q?=EB=AF=BC?= <kyungmin.park@samsung.com>, "ben-linux@fluff.org" <ben-linux@fluff.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Marek Szyprowski <m.szyprowski@samsung.com>

On Fri, 11 Sep 2009 20:04:48 +0200
Pawel Osciak <p.osciak@samsung.com> wrote:

> Reviewed-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Reviewed-by: Kyungmin Park <kyungmin.park@samsung.com>
> Signed-off-by: Pawel Osciak <p.osciak@samsung.com>
> 
> 
> ---
>  arch/arm/plat-s3c/include/plat/regs-fb.h |    3 +
>  arch/arm/plat-s3c/include/plat/s3c-fb.h  |   45 ++++++++
>  drivers/video/s3c-fb.c                   |  164 ++++++++++++++++++++++++++++++
>  3 files changed, 212 insertions(+), 0 deletions(-)
>  create mode 100644 arch/arm/plat-s3c/include/plat/s3c-fb.h
> 
> diff --git a/arch/arm/plat-s3c/include/plat/regs-fb.h b/arch/arm/plat-s3c/include/plat/regs-fb.h
> index 8048cae..8d3071d 100644
> --- a/arch/arm/plat-s3c/include/plat/regs-fb.h
> +++ b/arch/arm/plat-s3c/include/plat/regs-fb.h
> @@ -323,6 +323,7 @@
>  
>  /* Window colour-key control registers */
>  
> +#define WxKEYCON0(_x)				(0x140 + ((_x-1) * 8))
>  #define WxKEYCON0_KEYBL_EN			(1 << 26)
>  #define WxKEYCON0_KEYEN_F			(1 << 25)
>  #define WxKEYCON0_DIRCON			(1 << 24)
> @@ -330,6 +331,8 @@
>  #define WxKEYCON0_COMPKEY_SHIFT			(0)
>  #define WxKEYCON0_COMPKEY_LIMIT			(0xffffff)
>  #define WxKEYCON0_COMPKEY(_x)			((_x) << 0)
> +
> +#define WxKEYCON1(_x)				(0x144 + ((_x-1) * 8))
>  #define WxKEYCON1_COLVAL_MASK			(0xffffff << 0)
>  #define WxKEYCON1_COLVAL_SHIFT			(0)
>  #define WxKEYCON1_COLVAL_LIMIT			(0xffffff)
> diff --git a/arch/arm/plat-s3c/include/plat/s3c-fb.h b/arch/arm/plat-s3c/include/plat/s3c-fb.h
> new file mode 100644
> index 0000000..0aebc40
> --- /dev/null
> +++ b/arch/arm/plat-s3c/include/plat/s3c-fb.h
> @@ -0,0 +1,45 @@
> +/*
> + * include/linux/s3c/s3c-fb.h
> + *
> + * Copyright 2009 Samsung Electronics Co., Ltd.
> + * Author:  Pawel Osciak <p.osciak@samsung.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#ifndef __LINUX_S3C_FB_H__
> +#define __LINUX_S3C_FB_H__
> +
> +#include <linux/types.h>
> +
> +struct s3c_fb_color {
> +	__u32 a : 8;
> +	__u32 r : 8;
> +	__u32 g : 8;
> +	__u32 b : 8;
> +} __attribute__((__packed__));
> +
> +typedef enum s3c_fb_color_key_mode {
> +	S3CFB_COLORKEY_MODE_BG = 0,
> +	S3CFB_COLORKEY_MODE_FG = 1
> +} s3c_fb_color_key_mode_t;
> +

Typedef here is also not needed (is it used at all?).

Regards,
Krzysztof

 
----------------------------------------------------------------------
Nie dla nich ciepla praca za biurkiem.
Sprawdz >>> http://link.interia.pl/f2383
