Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04E43376F5
	for <linux-fbdev@vger.kernel.org>; Mon, 18 Mar 2024 12:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710763600; cv=none; b=ie9cMry9SLgJZyi9GffuP6roBq15u4tJKTlL7BjFqI16SKVvlfaKmlBKSmKx5EtBQuKPLRyZNA94G0drmD2Fv9BLniwpvTFkPMD6FFO6HwWp7irbPZA7dRfC3HZyM7twwcK4LyevE2OFPrhxRlmguZqswEWROey0pAza+41cjxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710763600; c=relaxed/simple;
	bh=5FQe1aiH0qWj6oZI7Tk9LlLy4zlqbVeJd6fRNtSR/AA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TfL03dXMrcOn2vEuxJsxppdv+2AZ3KvY7Jm24tNHkWwWON1zpZtC0Keh+Qm4fKb1RU4GxdBjVqyOPkuphte/6/Q0/5p4wBwd8bPOo5C50tvDRbaO+1Ym3w3BL1dfqFP1q2EwgmCq/A1uvHLwadq03NyTYKlmaML1kXzfY2pxVMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zZtMDr3L; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zZtMDr3L"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3416df43cabso638949f8f.3
        for <linux-fbdev@vger.kernel.org>; Mon, 18 Mar 2024 05:06:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710763595; x=1711368395; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eHGPA8dgPTqYeKubjV9R4JW3cUfS+CCAqVnDiKpMYxc=;
        b=zZtMDr3LXRfDL8c2/97NUiNknUzhH8vCmjZyivYKC+9sZM6sP7tSzTo9E2UWdUyR1U
         xpqSqXnTUJLCvmpjARQMFM8TRdJe5m3/6+3sQbyUG0ApOxiLN8XDBoZz652PC794QT3M
         spC27Q3VN4x/mxFzWE2rUP2vwnj3OaEjb06/G+O+X85HpVdXuz6dfiHVtaWIVD0gxSUP
         It5iMZGl7YZ+cMI4f5b2x36H78XON0hO83ZPbiQRUiLNk69m/urjctDbJACxy1MselLO
         tMZhBCLenCnmSBX5C2oQ5GUWVgPkW3XtsvErVjBCICJlfF41TIhV4+W/C+DntIScuP3/
         ZE7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710763595; x=1711368395;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eHGPA8dgPTqYeKubjV9R4JW3cUfS+CCAqVnDiKpMYxc=;
        b=I33x6gcZgP5RKogNPA0p1ghSIGydmHNI1UgtA63g9n25L5agrF3pce4DSAAdIJPJLW
         KXRP4E2PXipWkEWiIsSBSZz5wrx73QpUqkestRrSgJf0AigjgATAd/1qm74L8mBPrJG0
         lUkvU8Gf3e/xoirqQ6ReZwaQKiAPacB5iV+CZl/bMRZFeHV5O1xN4HUc+0fvWbwrzn2N
         qAtkjl4McyYFDfQNJS69qW2irdZ0hJFkiZEnhFIETW/MeESvzfSSA6Ldx79qRzkVs/MQ
         ANMxXDdPgA6BZaTTEROijD34+ykvb35VUzq6sUZPhin0BJeVuqkp7eCbggj2P8BqOAcL
         xFGg==
X-Forwarded-Encrypted: i=1; AJvYcCU3lzI1fcSNTFWQ1svFGyLkTu8Fo7xrJl1YdPgQgEhydScdPCCaDYn8R5wV5W9w5+qA5RYykSu/VzIN0j1iMsxN8aIX/UTsGm3yALY=
X-Gm-Message-State: AOJu0Yyhmw8C0cIcdbqmO7yYTDX21d84JqLkLPMAttQpZGzeLdo5a+tl
	BDZ65q/1opS/NS6ePcKJuOG+GdDKYGrkKFPPK7jvj0uS5Ip26nJzzsk+hsxjloI=
X-Google-Smtp-Source: AGHT+IEMesT0g6EwJo8XKWWsj5lGZcP15znRyUjF4kLCBSkASIwGULeoWki8V8Svi3DzX0aQUU2RlQ==
X-Received: by 2002:adf:fd4d:0:b0:33e:9b42:b9f with SMTP id h13-20020adffd4d000000b0033e9b420b9fmr9549400wrs.4.1710763595268;
        Mon, 18 Mar 2024 05:06:35 -0700 (PDT)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id v18-20020adfe4d2000000b0033ec9936909sm9636114wrm.39.2024.03.18.05.06.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Mar 2024 05:06:34 -0700 (PDT)
Date: Mon, 18 Mar 2024 12:06:32 +0000
From: Daniel Thompson <daniel.thompson@linaro.org>
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: lee@kernel.org, jingoohan1@gmail.com, deller@gmx.de,
	dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev
Subject: Re: [PATCH 3/6] backlight/omap1-bl: Replace FB_BLANK_ states with
 simple on/off
Message-ID: <20240318120632.GD16260@aspen.lan>
References: <20240313154857.12949-1-tzimmermann@suse.de>
 <20240313154857.12949-4-tzimmermann@suse.de>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240313154857.12949-4-tzimmermann@suse.de>

On Wed, Mar 13, 2024 at 04:45:02PM +0100, Thomas Zimmermann wrote:
> The backlight is on for fb_blank eq FB_BLANK_UNBLANK, or off for
> any other value in fb_blank. But the field fb_blank in struct
> backlight_properties is deprecated and should not be used any
> longer.
>
> Replace the test for fb_blank in omap's backlight code with a
> simple boolean parameter and push the test into the update_status
> helper. Instead of reading fb_blank directly, decode the backlight
> device's status with backlight_is_blank().
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---
>  drivers/video/backlight/omap1_bl.c | 46 ++++++++++++++----------------
>  1 file changed, 21 insertions(+), 25 deletions(-)
>
> diff --git a/drivers/video/backlight/omap1_bl.c b/drivers/video/backlight/omap1_bl.c
> index 84d148f385951..3fd8bbb7f5877 100644
> --- a/drivers/video/backlight/omap1_bl.c
> +++ b/drivers/video/backlight/omap1_bl.c
> @@ -9,7 +9,6 @@
>  #include <linux/kernel.h>
>  #include <linux/init.h>
>  #include <linux/platform_device.h>
> -#include <linux/fb.h>
>  #include <linux/backlight.h>
>  #include <linux/slab.h>
>  #include <linux/platform_data/omap1_bl.h>
> @@ -20,7 +19,7 @@
>  #define OMAPBL_MAX_INTENSITY		0xff
>
>  struct omap_backlight {
> -	int powermode;
> +	bool power;

The new name is hard to read in several of the conditionals below (which
were previously "documented" by the comparisons to constants.

This boolean effectively controls what we send to omapbl_send_enable().
On that basis I'd rather it was called something like "enabled".


>  	int current_intensity;
>
>  	struct device *dev;
> @@ -37,21 +36,14 @@ static inline void omapbl_send_enable(int enable)
>  	omap_writeb(enable, OMAP_PWL_CLK_ENABLE);
>  }
>
> -static void omapbl_blank(struct omap_backlight *bl, int mode)
> +static void omapbl_power(struct omap_backlight *bl, bool on)

As above omapbl_enable would be better.


>  {
> -	switch (mode) {
> -	case FB_BLANK_NORMAL:
> -	case FB_BLANK_VSYNC_SUSPEND:
> -	case FB_BLANK_HSYNC_SUSPEND:
> -	case FB_BLANK_POWERDOWN:
> -		omapbl_send_intensity(0);
> -		omapbl_send_enable(0);
> -		break;
> -
> -	case FB_BLANK_UNBLANK:
> +	if (on) {
>  		omapbl_send_intensity(bl->current_intensity);
>  		omapbl_send_enable(1);
> -		break;
> +	} else {
> +		omapbl_send_intensity(0);
> +		omapbl_send_enable(0);
>  	}
>  }
>
> @@ -61,7 +53,7 @@ static int omapbl_suspend(struct device *dev)
>  	struct backlight_device *bl_dev = dev_get_drvdata(dev);
>  	struct omap_backlight *bl = bl_get_data(bl_dev);
>
> -	omapbl_blank(bl, FB_BLANK_POWERDOWN);
> +	omapbl_power(bl, false);
>  	return 0;
>  }
>
> @@ -70,33 +62,37 @@ static int omapbl_resume(struct device *dev)
>  	struct backlight_device *bl_dev = dev_get_drvdata(dev);
>  	struct omap_backlight *bl = bl_get_data(bl_dev);
>
> -	omapbl_blank(bl, bl->powermode);
> +	omapbl_power(bl, bl->power);
>  	return 0;
>  }
>  #endif
>
> -static int omapbl_set_power(struct backlight_device *dev, int state)
> +static void omapbl_set_power(struct backlight_device *dev, bool on)

May also like a new name...


>  {
>  	struct omap_backlight *bl = bl_get_data(dev);
>
> -	omapbl_blank(bl, state);
> -	bl->powermode = state;
> -
> -	return 0;
> +	omapbl_power(bl, on);
> +	bl->power = on;
>  }
>
>  static int omapbl_update_status(struct backlight_device *dev)
>  {
>  	struct omap_backlight *bl = bl_get_data(dev);
> +	bool power;
>
>  	if (bl->current_intensity != dev->props.brightness) {
> -		if (bl->powermode == FB_BLANK_UNBLANK)
> +		if (bl->power)
>  			omapbl_send_intensity(dev->props.brightness);
>  		bl->current_intensity = dev->props.brightness;
>  	}
>
> -	if (dev->props.fb_blank != bl->powermode)
> -		omapbl_set_power(dev, dev->props.fb_blank);
> +	if (backlight_is_blank(dev))
> +		power = false;
> +	else
> +		power = true;

I'd be happy with:

    enable = !backlight_is_blank()


Daniel.
