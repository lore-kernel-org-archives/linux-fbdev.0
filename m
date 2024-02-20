Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D23F5F544
	for <linux-fbdev@vger.kernel.org>; Tue, 20 Feb 2024 09:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708420658; cv=none; b=SQCtZtJJ4ew28JNnJGj7He7AUIXE5zhjCGhLJIlSWt9PG7WiLbPaT8RFhkYYcdzV+r1WYsh4aXBrZBSXkGdOQkUYCJUzGnNksr3ypu6mhOiRu4kcRAV+MEnXZPx0qhGaVgXrupU00qYN0EpSllcjMx/E0Z4D4r2QMMiRwmRyGB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708420658; c=relaxed/simple;
	bh=nkf5Q/o2N6uxU/krrkxMdk5G+u0NWrK1OwF42W4+exU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=sVcuLn8mYG2u6F/xUa7sN2YE+H1qiRh90CT+Yduu4ZCg9eH0zgdd+SmJQTteFE8p3stcyPPNkrmWLQooRlY/IdOPJd3KtPR+TeeP5ThRo+Ez4X9AF7kUK1z9X+seus+Ft2/MQKxssUyC2+Aybw6zz8sRzKr7oL3AvEQwFhm6nuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iDr2UPuq; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iDr2UPuq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708420655;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QdkBCPYDeheTT+uzHIWpGEdO4JJdk+hRLV0yR8IOegg=;
	b=iDr2UPuqSmqV1pN+Y21cU4GThe5oUZm58FpuUsKR23GoECXUPKvMDRIABRNNMriv5ecAo8
	XEIUAQYaA2vGSw7pt8k++p4FocMwjvFWRVcfYzjzuuYGSjFrixo4fNSDo0IN8PO9mM/VCp
	wLcmTeguPPD6G2P4kfJJ4I+QcjemMpk=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-686-PyGm2Kw5Pcy1PNMgt0UE1g-1; Tue, 20 Feb 2024 04:17:34 -0500
X-MC-Unique: PyGm2Kw5Pcy1PNMgt0UE1g-1
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-2d244967778so7021021fa.2
        for <linux-fbdev@vger.kernel.org>; Tue, 20 Feb 2024 01:17:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708420652; x=1709025452;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QdkBCPYDeheTT+uzHIWpGEdO4JJdk+hRLV0yR8IOegg=;
        b=ErIKXXVi9Einwqm0kEiqoVx+XEZUMmwFUB6gS4a0nT/SgHxlllHfF1ruZewKIrFgF0
         J+F/FQQQccU9Olnyujlxl5Drt/EjWyaYLa3MjDkCZEaSiiH6I4UTLmAzqtqNouSqMPar
         vG6HflR1Pjwhk0JM/qa6F6JkmQTUoMNFPvhbZgFawYgZWPbBC4PbB5EMx48Kha6mWB5i
         y5lmRCJHiHpWYWxgUaii7wLMr6Q7J5uo/JXjXY8MXXdzr7BEHC3oz6Ypqtzqiw+ylxws
         nu8fDF4Yk+ufxhOFstOQXOtLWm5Ndva5OjF/4kiY51ruumeJNzrhgA1pN/YZ92d44xQ7
         tRvw==
X-Forwarded-Encrypted: i=1; AJvYcCXbPUW1G8essVbyyAqXRfJpPWcxnkedifY62jnguGsDe8JHm/BXiTgC7ebrsls2n790xWUMEOeJ0+85HXU1aB8omhyZiXLvHKPhP50=
X-Gm-Message-State: AOJu0YzUcqGjI/sbOqBMUyEjwjz+1erm/+g1Ujk6FNp9ekKTMDq6TzGW
	9ZBrTw+vkxg9UPykxSiKyI9EACTo38yw9VGjy4g5WXwA5Y40TXZ2/LItgW4vV/56qQStGTRs3Nl
	foNCY+x5iDXuo9qu6kCh6hPvj3RvtUDmS235qLDNn3pDLNnP3DRpjDm1MipVK
X-Received: by 2002:ac2:5e62:0:b0:512:a93a:f5a5 with SMTP id a2-20020ac25e62000000b00512a93af5a5mr4159540lfr.19.1708420652692;
        Tue, 20 Feb 2024 01:17:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGAJvY45CWeh5zWa4RXaJeTqSuMBy6I0QeL2Im2jjuR1AxRWVjKK6LynUjbfe5DTheoNd69ag==
X-Received: by 2002:ac2:5e62:0:b0:512:a93a:f5a5 with SMTP id a2-20020ac25e62000000b00512a93af5a5mr4159530lfr.19.1708420652349;
        Tue, 20 Feb 2024 01:17:32 -0800 (PST)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id s6-20020a05600c45c600b00412696bd7d9sm4074941wmo.41.2024.02.20.01.17.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 01:17:32 -0800 (PST)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Thomas Zimmermann <tzimmermann@suse.de>, lee@kernel.org,
 daniel.thompson@linaro.org, jingoohan1@gmail.com, deller@gmx.de
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
 linux-input@vger.kernel.org, linux-pwm@vger.kernel.org, Thomas Zimmermann
 <tzimmermann@suse.de>
Subject: Re: [PATCH 01/10] backlight: Match backlight device against struct
 fb_info.bl_dev
In-Reply-To: <20240212162645.5661-2-tzimmermann@suse.de>
References: <20240212162645.5661-1-tzimmermann@suse.de>
 <20240212162645.5661-2-tzimmermann@suse.de>
Date: Tue, 20 Feb 2024 10:17:31 +0100
Message-ID: <87bk8bjxzo.fsf@minerva.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Thomas Zimmermann <tzimmermann@suse.de> writes:

Hello Thomas,

> Framebuffer drivers for devices with dedicated backlight are supposed
> to set struct fb_info.bl_dev to the backlight's respective device. Use
> the value to match backlight and framebuffer in the backlight core code.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---
>  drivers/video/backlight/backlight.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/video/backlight/backlight.c b/drivers/video/backlight/backlight.c
> index 86e1cdc8e3697..48844a4f28ad3 100644
> --- a/drivers/video/backlight/backlight.c
> +++ b/drivers/video/backlight/backlight.c
> @@ -98,7 +98,8 @@ static int fb_notifier_callback(struct notifier_block *self,
>  {
>  	struct backlight_device *bd;
>  	struct fb_event *evdata = data;
> -	int node = evdata->info->node;
> +	struct fb_info *info = evdata->info;
> +	int node = info->node;
>  	int fb_blank = 0;
>  
>  	/* If we aren't interested in this event, skip it immediately ... */
> @@ -110,8 +111,12 @@ static int fb_notifier_callback(struct notifier_block *self,
>  
>  	if (!bd->ops)
>  		goto out;
> -	if (bd->ops->check_fb && !bd->ops->check_fb(bd, evdata->info))
> +	else if (bd->ops->check_fb && !bd->ops->check_fb(bd, info))
>  		goto out;
> +#if IS_ENABLED(CONFIG_FB_BACKLIGHT)
> +	else if (info->bl_dev && info->bl_dev != bd)

If the driver doesn't provide a struct backlight_ops .check_fb callback, I
think that having an info->bl_dev should be mandatory ? Or at least maybe
there should be a warning if info->bl_dev isn't set ?

The would be a driver bug, right ?

Regardless, the change makes sense to me.

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

