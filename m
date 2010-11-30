From: Paul Mundt <lethal@linux-sh.org>
Date: Tue, 30 Nov 2010 06:13:57 +0000
Subject: Re: [PATCH v4+] viafb: I2C/DDC LCD detection for VIA framebuffer
Message-Id: <20101130061357.GE17114@linux-sh.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <4CED3DD5.5080405@bspu.unibel.by>
In-Reply-To: <4CED3DD5.5080405@bspu.unibel.by>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Wed, Nov 24, 2010 at 06:31:17PM +0200, Dzianis Kahanovich wrote:
> I2C/DDC LCD detection for VIA framebuffer
> 
> Adding legacy I2C/DDC support for VIA framebuffer, used to fix LCD
> panel size and (if "via_active_dev" is empty default) force LCD
> detection. This solving at least defaults on Chrome9 video
> on HP mini 2133 notebook, but must be good in other cases,
> include double-LCD. Also related bugfixes.
> 
> v2->v3 patch: original viafb_find_i2c_adapt() code is unsafe (nowere used).
> 
> v3->v4 patch: viafbinfo1 is not initilalized if !viafb_dual_fb
> and may cause problems with dual separated LCD. Now dual & SAMM
> code looks safe (will no generate errors).
> +formatting change
> 
> Signed-off-by: Dzianis Kahanovich <mahatma@eu.by>
> ---
> diff -pruN a/drivers/video/via/via-core.c b/drivers/video/via/via-core.c
> --- a/drivers/video/via/via-core.c	2010-11-24 00:12:22.000000000 +0200
> +++ b/drivers/video/via/via-core.c	2010-11-24 17:04:00.749999967 +0200
> @@ -2,6 +2,7 @@
>   * Copyright 1998-2009 VIA Technologies, Inc. All Rights Reserved.
>   * Copyright 2001-2008 S3 Graphics, Inc. All Rights Reserved.
>   * Copyright 2009 Jonathan Corbet <corbet@lwn.net>
> + * Copyright 2010 Dzianis Kahanovich <mahatma@eu.by>
>   */
> 
>  /*
> @@ -16,6 +17,8 @@
>  #include <linux/interrupt.h>
>  #include <linux/platform_device.h>
> 
> +extern char *viafb_active_dev;
> +
This belongs in viafbdev.h.

> diff -pruN a/drivers/video/via/viafbdev.c b/drivers/video/via/viafbdev.c
> --- a/drivers/video/via/viafbdev.c	2010-11-21 11:34:11.000000000 +0200
> +++ b/drivers/video/via/viafbdev.c	2010-11-24 00:14:48.070000002 +0200
> @@ -43,7 +43,7 @@ static int viafb_second_size;
>  static int viafb_accel = 1;
> 
>  /* Added for specifying active devices.*/
> -char *viafb_active_dev;
> +char *viafb_active_dev = NULL;
> 

This you can just drop.

Since viafb has an active tree, I'll leave this for the viafb folks to
pick up at their leisure.
