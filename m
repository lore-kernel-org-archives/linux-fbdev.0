Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E86D01A270
	for <linux-fbdev@vger.kernel.org>; Tue, 24 Sep 2024 11:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727176873; cv=none; b=JrsVMgBanzDmvv0XzCPCgvyh0BWmaESUZ7t2Dx+un1PLpeqIe9eLJcsDNa6LyUdjrUJUcpEq+dgroU5eyfxK/5j+wkVviQIa/cOw+6zpVCTLZx+hh7HpLqERRwHznWJN3yr6RJer6oSO/MgDRuHXMNfU48vPafW6G3oj/8XeCfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727176873; c=relaxed/simple;
	bh=x3nzE69kooUvru/SVRffVta3usJvojT0d9lA+v0KX1Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YNBWcms63t2RWuyh+sSDSeSitchn0OpJtVJb25cqbsxwP0CsCpOReqB08c/9uqIpE8Rh9yOzjZmxLpt6XSlVu4lbCsILezGMVbiFWL5MWiOZIOSlvYsK4u6CQoyMV5J4SQv+bLiP42AXpjy0IUqN3dBy6+agaDjfuHdX1750y3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch; spf=none smtp.mailfrom=ffwll.ch; dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b=QwxpHtL8; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="QwxpHtL8"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5c3d2f9f896so7518808a12.1
        for <linux-fbdev@vger.kernel.org>; Tue, 24 Sep 2024 04:21:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1727176870; x=1727781670; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gYQ/IDmT9gcN7gYfq5hChxVJK5hUzJ0xEOoEvIgK6x0=;
        b=QwxpHtL811lD/byP31JUvE8NX5L8iK5hHodqWMETaHnUvCdUNpagfCnzYUI0YuLmsH
         sARNiacptXn+oucPXGGyH4Lx1X3SBsne4MDfC+gE/X+9jenkswNqYYloM/c3IQg7wXrn
         oWnRiDEYbQiiuP9mpmh8IoWqov+wtoi/QGCus=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727176870; x=1727781670;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gYQ/IDmT9gcN7gYfq5hChxVJK5hUzJ0xEOoEvIgK6x0=;
        b=hik2NSNu7E7bIT4VfggQm11m/jB7zpUQ2XmU62CfA+N7VtjTIl2gkcsXm2V0j/jH2l
         vLOxhwo+q91I+N7AL6opndGOto3CTv9JT3l8CmFs6OqMz2wtxDl4Cdv7LH+CTErs9XYc
         oNi7O0OqPXH14Bi3OEtLATU1Yztrkvs4zjUTCzLIYN1h+GiVlZP5uBxEO15oJmqmxhei
         f5r+YIuh7f0jYJQpsjgtAtjLquz0PaC+Az9g40/E7+DUlMY5drt2rADTduVLHre9CeI9
         7zCbG8thDKC1mMNbCsfT92W8JP5Fbcse0+u0S3HuqHiArKfjiWe6yJWTB3pH5Ijz4mMS
         9mwA==
X-Forwarded-Encrypted: i=1; AJvYcCW/Clr2PRn/88w8sOBfStQYtFTLECff+5s/UwbRihuVU8t0zgQAVqUqG3XM/Qp+Kun3C0sz7BHz16TTyA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1iIyPr5oKTA/UTowV6cgbDtl8ibW0QwDam0fVAOTMRgl+BGfI
	0MlnQYcQiBRo4hMZDG4/I2PoA/5Cy7gsvwbL8AkGTYf7J7XooXLI7Khw/+sTGlE=
X-Google-Smtp-Source: AGHT+IG+0CZhC8lhSSWIeyvYwrLQI4O0OQvh1Pjvq9SkGlKqyG/ISsZIxeuv8w2ijkNznz0YfWr6pw==
X-Received: by 2002:a17:906:794c:b0:a86:7199:af37 with SMTP id a640c23a62f3a-a90d51601d9mr1727612666b.58.1727176869474;
        Tue, 24 Sep 2024 04:21:09 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:5485:d4b2:c087:b497])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a93930f7b90sm72287366b.175.2024.09.24.04.21.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Sep 2024 04:21:09 -0700 (PDT)
Date: Tue, 24 Sep 2024 13:21:07 +0200
From: Simona Vetter <simona.vetter@ffwll.ch>
To: linux@treblig.org
Cc: lee@kernel.org, daniel.thompson@linaro.org, jingoohan1@gmail.com,
	hdegoede@redhat.com, dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] backlight: Remove notifier
Message-ID: <ZvKgo8RUImafDRPE@phenom.ffwll.local>
Mail-Followup-To: linux@treblig.org, lee@kernel.org,
	daniel.thompson@linaro.org, jingoohan1@gmail.com,
	hdegoede@redhat.com, dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240919232758.639925-1-linux@treblig.org>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240919232758.639925-1-linux@treblig.org>
X-Operating-System: Linux phenom 6.10.6-amd64 

On Fri, Sep 20, 2024 at 12:27:58AM +0100, linux@treblig.org wrote:
> From: "Dr. David Alan Gilbert" <linux@treblig.org>
> 
> backlight_register_notifier and backlight_unregister_notifier have
> been unused since
>   commit 6cb634d0dc85 ("ACPI: video: Remove code to unregister acpi_video
> backlight when a native backlight registers")
> 
> With those not being called, it means that the backlight_notifier
> list is always empty.
> 
> Remove the functions, the list itself and the enum used in the
> notifications.
> 
> Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>

Reviewed-by: Simona Vetter <simona.vetter@ffwll.ch>

I think Lee Jones or Daniel Thompson will pick this up.
-Sima

> ---
>  drivers/video/backlight/backlight.c | 42 -----------------------------
>  include/linux/backlight.h           | 20 --------------
>  2 files changed, 62 deletions(-)
> 
> diff --git a/drivers/video/backlight/backlight.c b/drivers/video/backlight/backlight.c
> index a82934694d05..f699e5827ccb 100644
> --- a/drivers/video/backlight/backlight.c
> +++ b/drivers/video/backlight/backlight.c
> @@ -65,7 +65,6 @@
>  
>  static struct list_head backlight_dev_list;
>  static struct mutex backlight_dev_list_mutex;
> -static struct blocking_notifier_head backlight_notifier;
>  
>  static const char *const backlight_types[] = {
>  	[BACKLIGHT_RAW] = "raw",
> @@ -467,9 +466,6 @@ struct backlight_device *backlight_device_register(const char *name,
>  	list_add(&new_bd->entry, &backlight_dev_list);
>  	mutex_unlock(&backlight_dev_list_mutex);
>  
> -	blocking_notifier_call_chain(&backlight_notifier,
> -				     BACKLIGHT_REGISTERED, new_bd);
> -
>  	return new_bd;
>  }
>  EXPORT_SYMBOL(backlight_device_register);
> @@ -539,9 +535,6 @@ void backlight_device_unregister(struct backlight_device *bd)
>  	mutex_unlock(&pmac_backlight_mutex);
>  #endif
>  
> -	blocking_notifier_call_chain(&backlight_notifier,
> -				     BACKLIGHT_UNREGISTERED, bd);
> -
>  	mutex_lock(&bd->ops_lock);
>  	bd->ops = NULL;
>  	mutex_unlock(&bd->ops_lock);
> @@ -566,40 +559,6 @@ static int devm_backlight_device_match(struct device *dev, void *res,
>  	return *r == data;
>  }
>  
> -/**
> - * backlight_register_notifier - get notified of backlight (un)registration
> - * @nb: notifier block with the notifier to call on backlight (un)registration
> - *
> - * Register a notifier to get notified when backlight devices get registered
> - * or unregistered.
> - *
> - * RETURNS:
> - *
> - * 0 on success, otherwise a negative error code
> - */
> -int backlight_register_notifier(struct notifier_block *nb)
> -{
> -	return blocking_notifier_chain_register(&backlight_notifier, nb);
> -}
> -EXPORT_SYMBOL(backlight_register_notifier);
> -
> -/**
> - * backlight_unregister_notifier - unregister a backlight notifier
> - * @nb: notifier block to unregister
> - *
> - * Register a notifier to get notified when backlight devices get registered
> - * or unregistered.
> - *
> - * RETURNS:
> - *
> - * 0 on success, otherwise a negative error code
> - */
> -int backlight_unregister_notifier(struct notifier_block *nb)
> -{
> -	return blocking_notifier_chain_unregister(&backlight_notifier, nb);
> -}
> -EXPORT_SYMBOL(backlight_unregister_notifier);
> -
>  /**
>   * devm_backlight_device_register - register a new backlight device
>   * @dev: the device to register
> @@ -767,7 +726,6 @@ static int __init backlight_class_init(void)
>  
>  	INIT_LIST_HEAD(&backlight_dev_list);
>  	mutex_init(&backlight_dev_list_mutex);
> -	BLOCKING_INIT_NOTIFIER_HEAD(&backlight_notifier);
>  
>  	return 0;
>  }
> diff --git a/include/linux/backlight.h b/include/linux/backlight.h
> index ea9c1bc8148e..f5652e5a9060 100644
> --- a/include/linux/backlight.h
> +++ b/include/linux/backlight.h
> @@ -66,24 +66,6 @@ enum backlight_type {
>  	BACKLIGHT_TYPE_MAX,
>  };
>  
> -/**
> - * enum backlight_notification - the type of notification
> - *
> - * The notifications that is used for notification sent to the receiver
> - * that registered notifications using backlight_register_notifier().
> - */
> -enum backlight_notification {
> -	/**
> -	 * @BACKLIGHT_REGISTERED: The backlight device is registered.
> -	 */
> -	BACKLIGHT_REGISTERED,
> -
> -	/**
> -	 * @BACKLIGHT_UNREGISTERED: The backlight revice is unregistered.
> -	 */
> -	BACKLIGHT_UNREGISTERED,
> -};
> -
>  /** enum backlight_scale - the type of scale used for brightness values
>   *
>   * The type of scale used for brightness values.
> @@ -421,8 +403,6 @@ void devm_backlight_device_unregister(struct device *dev,
>  				      struct backlight_device *bd);
>  void backlight_force_update(struct backlight_device *bd,
>  			    enum backlight_update_reason reason);
> -int backlight_register_notifier(struct notifier_block *nb);
> -int backlight_unregister_notifier(struct notifier_block *nb);
>  struct backlight_device *backlight_device_get_by_name(const char *name);
>  struct backlight_device *backlight_device_get_by_type(enum backlight_type type);
>  int backlight_device_set_brightness(struct backlight_device *bd,
> -- 
> 2.46.1
> 

-- 
Simona Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
