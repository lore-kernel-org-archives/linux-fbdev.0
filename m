Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59DC115ADBF
	for <linux-fbdev@vger.kernel.org>; Wed, 10 Apr 2024 13:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712755233; cv=none; b=lRQz0IsllZp/fcrZh3w05gJ0i8naby9VQKujLv5t1PW6ue0MrCgPnMsN/LP4tMDLiOTizm343QSSi6CY6Nmc+CDHDI/HILCNW87DRVymnVj1v3qUyHDKIic5hcwEGHX1T1G3KGVJzho8D8/1YLjvpSyDK5JRBx98kcg+TglaV3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712755233; c=relaxed/simple;
	bh=IazC08KWUmS5CVeSQmjA27k72dXXskalunGTAzUCRF0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eepzyR2+SFyeZFx9teNlYL/OI+lG6ltjdgZGLUagTGZzN3iSl2jZ+wBmFMveyCAGc9reHGORpEiqNrGi1b7ksI03uarOhNkgQ+swJFw10tAVFcnbD2NHxvCXQMJvK1KyR3Hiikc3tvjWtR2AtrOijQT0nGAKtmjZSRBB1X8kfKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eryf69YH; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eryf69YH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712755230;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4ETAJsDKvc5B7lB1rhXcx7y8Da9mQJUUywbUXeVTtPA=;
	b=eryf69YHD5BmzkRGlDPF8vN9wvGBBzqR+ObRj8mzw4dYpnSgOD+IUW9t+SsXDf5CsYjDtK
	wAhyclPwWKQ0po/yH5iouvB1n7kMvzW81vL/1r052nOiVBKZti7olq1CQhzjdYB/A7xWKy
	yyuKz98f60B/7rQP5uBV4wkyv77qRQw=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-368-VOqIQ8r7O1WkerQ-i9IDug-1; Wed, 10 Apr 2024 09:20:28 -0400
X-MC-Unique: VOqIQ8r7O1WkerQ-i9IDug-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a51b97efbb8so453577466b.1
        for <linux-fbdev@vger.kernel.org>; Wed, 10 Apr 2024 06:20:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712755227; x=1713360027;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4ETAJsDKvc5B7lB1rhXcx7y8Da9mQJUUywbUXeVTtPA=;
        b=X7E4N2zvRGSqL+yuterIcpB9SER5PnL70ScZmh1brk16WdC3Ti4ufVLP3ofaipkDhO
         pySWYO/tM7fiKHjSPohIrxoG4qcFWYV7RtPJmbPH9tYBG0baAxYK0Tl7dK+oHcF1tmqc
         lUCiOJKMAR9rKXLWlNgNGcy+CoQfe/tV6Zc8qH/5AuOS2FpfIY2eCBHZYjcNo5VMDScO
         CcXBvHvV4Z2eVBvj9Z+JJXI7RyLHZY1/XaxR/Y+Ds9NQMJ7/2JYgkGVpkOpzwexjL4Fv
         mUvUucyDaG40rAUrmG3gJSRoyB7KJ5ECri8QOLqxdQCk2a7EknzJ3sWKoBQTRqpKziFc
         1APw==
X-Forwarded-Encrypted: i=1; AJvYcCVD7wPOfaVN1UDZyG0udm6CWzGXCF70DWSsLT5uvIR/B/D5CNQ1RXP9wLVV/G/TPJwkBQlleVZeKBzTMgpR7iretqGSEEmrKBsKqAU=
X-Gm-Message-State: AOJu0YwjXPavG9orT1igchaUNGnulIp/Pb3OtJ5hPeDU+nJ49uCsyBkG
	P8GOwPUTOoQRS5hZJeXYoCXQSQ+3p63IW4E51KyvW7tkwOGXj1pZqrWuX8zgB2HqeWCZteJF9Dm
	zdhQHyY9SWRHxiTDCAi4kJ3GuRUjaS3GRNAxbaj+xxIYeXbCWWLp9TiYEUhdPNakTWVE3
X-Received: by 2002:a17:906:3503:b0:a51:fffa:c357 with SMTP id r3-20020a170906350300b00a51fffac357mr3276204eja.8.1712755226948;
        Wed, 10 Apr 2024 06:20:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFDjoGPH7+ZwwHniOhWTpD4SzAjPGhJL2COHyZPehGncID3cjxgZJxE+T0o+2qPZqTpiPpPQQ==
X-Received: by 2002:a17:906:3503:b0:a51:fffa:c357 with SMTP id r3-20020a170906350300b00a51fffac357mr3276183eja.8.1712755226541;
        Wed, 10 Apr 2024 06:20:26 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id jl7-20020a17090775c700b00a4e70ede2b7sm7018744ejc.174.2024.04.10.06.20.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Apr 2024 06:20:25 -0700 (PDT)
Message-ID: <feabcce4-44aa-4b30-ac1f-b2313ddfac15@redhat.com>
Date: Wed, 10 Apr 2024 15:20:24 +0200
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 15/43] drm/tiny/gm12u320: Use fbdev-shmem
To: Thomas Zimmermann <tzimmermann@suse.de>, javierm@redhat.com,
 deller@gmx.de, airlied@gmail.com, daniel@ffwll.ch
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
References: <20240410130557.31572-1-tzimmermann@suse.de>
 <20240410130557.31572-16-tzimmermann@suse.de>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20240410130557.31572-16-tzimmermann@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 4/10/24 3:02 PM, Thomas Zimmermann wrote:
> Implement fbdev emulation with fbdev-shmem. Avoids the overhead of
> fbdev-generic's additional shadow buffering. No functional changes.
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: Hans de Goede <hdegoede@redhat.com>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans



> ---
>  drivers/gpu/drm/tiny/gm12u320.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/tiny/gm12u320.c b/drivers/gpu/drm/tiny/gm12u320.c
> index 0187539ff5eaa..8b4efd39d7c41 100644
> --- a/drivers/gpu/drm/tiny/gm12u320.c
> +++ b/drivers/gpu/drm/tiny/gm12u320.c
> @@ -13,7 +13,7 @@
>  #include <drm/drm_damage_helper.h>
>  #include <drm/drm_drv.h>
>  #include <drm/drm_edid.h>
> -#include <drm/drm_fbdev_generic.h>
> +#include <drm/drm_fbdev_shmem.h>
>  #include <drm/drm_file.h>
>  #include <drm/drm_format_helper.h>
>  #include <drm/drm_fourcc.h>
> @@ -699,7 +699,7 @@ static int gm12u320_usb_probe(struct usb_interface *interface,
>  	if (ret)
>  		goto err_put_device;
>  
> -	drm_fbdev_generic_setup(dev, 0);
> +	drm_fbdev_shmem_setup(dev, 0);
>  
>  	return 0;
>  

