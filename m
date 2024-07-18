Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5680C762D0
	for <linux-fbdev@vger.kernel.org>; Thu, 18 Jul 2024 07:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721286255; cv=none; b=CDNbkUHTj+M33IqWAmdjKL56TdWe2n5cogM3dBK7vsyUUsdMCuOgJMa3dImwO//UwUkTwpx80NymupQqYbGzrHijFbY54ILHd+1aFGKpRL2mHApigwFl7HBfza1h+HQ7pONAi/RxJZVmWVnVXxR4gCL8Uh4J1lGCuMzGD9pAGmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721286255; c=relaxed/simple;
	bh=Qy5XXJ89Ktic3Aa1K9odT3n9Ohijkwg0eluVKDn6+pM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=MTRg6j0PwGOuoAaFSKTlBMP45DLs/tTOBchrdnbh5RGMcjVhIt1CuxinQr7vPdQaffjyu5c7e2c9Vy0tb07pmDvFjGUfRsF0UUj1unF3/dJwTOlO8TwJasF8KyjuU+F/3KhZ0MCP+QxDwfGd5ptEr//Q0b4HeovF6p+ADV9PkOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=igvG32IN; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="igvG32IN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721286253;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yzJwnsiZ2ke6MzC/8F3MYwH+Ub1DtGJI2z59uDcufYU=;
	b=igvG32INRv8MmFVioxnoKG0vY0NUv85PZUTkmlchIZdI875/4cffKeEbL+2iNGIxcOcspk
	y1GmZF4+cQbqgYmwKw4e+9FZTtB/LVCffiQJfVTTpOtFBqDXZbOvy1WaGkBtGSjhUUyOWo
	Wtp9vnE3oe3+9JOYnAcF0/b7szu6S34=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-679-WQHsaoHaNZ-psbe88xEY4A-1; Thu, 18 Jul 2024 03:04:08 -0400
X-MC-Unique: WQHsaoHaNZ-psbe88xEY4A-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-42674318a4eso4359455e9.1
        for <linux-fbdev@vger.kernel.org>; Thu, 18 Jul 2024 00:04:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721286247; x=1721891047;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yzJwnsiZ2ke6MzC/8F3MYwH+Ub1DtGJI2z59uDcufYU=;
        b=wdasG13xNjamD73/FAw+6IDGgXxXyqkif6xxfHX8QKtE8aWgwL6/zXLgUSqnTZhsjX
         Z7QKcGwWZ/e/4DG5jURHhmCc9kbFNuvz9XHxEeWQvAab3fmq7eH0WNX24Yo+vnWFdX/j
         D/nPNslBo9msPm4dy6toTWWhL+KJ7L88lNNDLWr4h7BptePeUEP1n5txgj//eiV+BC1W
         /0hkW/Cb8REIIv13bljb/uZ9f4o1pFdgyNrmtTljVN7PQ8lvLTjC3rgwhN4fIRreOKuV
         gl/nLMNTtSG2UgPi+L+twIAmEEjDVXT9AVQMKs6Mh3dpHt/g8rgZi/kI8RbaP+npPP46
         RpbQ==
X-Forwarded-Encrypted: i=1; AJvYcCXx3Q/np9h33Ce1lnbquSkm/i6HsUN1KwWWmTrDsfBqdhit0RFeBEX4dCyCb2xx8iROf1+FAvGHYwjjAs/3yCLGaHx0zbVDpqQfPLU=
X-Gm-Message-State: AOJu0Ywm2ar8VlJ4cChi1CiPj//pZ5EnHW4Av4+eFhMjBVd+RnsKbbY2
	KuD1usUL3MUmBi7+kHcdPQ69DbwyVQagTlqCPRgb2x1IERQD5rVqjkVOiLiXfxqAeFrX8KRMW1/
	U16PwxTTc2G8oDOYkvSZqVtG6N1jyFXxOMVGt4xfIU+oboocM11bBf7P/PyT4
X-Received: by 2002:a05:600c:1f89:b0:425:64c5:5780 with SMTP id 5b1f17b1804b1-427c2cad7d5mr36509525e9.1.1721286247224;
        Thu, 18 Jul 2024 00:04:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF/KUVPhRm2HpDoAZJMxonN2aOgQWPFNeB5yzFSNwGye7MxC3l02lsOkLZOMlNf7V+jEkpGEg==
X-Received: by 2002:a05:600c:1f89:b0:425:64c5:5780 with SMTP id 5b1f17b1804b1-427c2cad7d5mr36509225e9.1.1721286246782;
        Thu, 18 Jul 2024 00:04:06 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:c:37e0:ced3:55bd:f454:e722? ([2a01:e0a:c:37e0:ced3:55bd:f454:e722])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427c77d810dsm23762885e9.26.2024.07.18.00.04.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jul 2024 00:04:06 -0700 (PDT)
Message-ID: <34305c58-38a6-4b5a-9777-69833aefa003@redhat.com>
Date: Thu, 18 Jul 2024 09:04:04 +0200
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] drm/panic: Add drm_panic_is_enabled()
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Helge Deller <deller@gmx.de>,
 "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Javier Martinez Canillas <javierm@redhat.com>,
 Samuel Thibault <samuel.thibault@ens-lyon.org>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-fbdev@vger.kernel.org
References: <20240717090102.968152-1-jfalempe@redhat.com>
 <20240717090102.968152-2-jfalempe@redhat.com>
 <ZpfeiMj48JQTQcOE@phenom.ffwll.local>
Content-Language: en-US, fr
From: Jocelyn Falempe <jfalempe@redhat.com>
In-Reply-To: <ZpfeiMj48JQTQcOE@phenom.ffwll.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 17/07/2024 17:08, Daniel Vetter wrote:
> On Wed, Jul 17, 2024 at 10:48:39AM +0200, Jocelyn Falempe wrote:
>> It allows to check if the drm device supports drm_panic.
>> Prepare the work to have better integration with fbcon and vtconsole.
>>
>> Signed-off-by: Jocelyn Falempe <jfalempe@redhat.com>
>> ---
>>   drivers/gpu/drm/drm_panic.c | 20 ++++++++++++++++++++
>>   include/drm/drm_panic.h     |  2 ++
>>   2 files changed, 22 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/drm_panic.c b/drivers/gpu/drm/drm_panic.c
>> index 948aed00595e..d9a25c2d0a65 100644
>> --- a/drivers/gpu/drm/drm_panic.c
>> +++ b/drivers/gpu/drm/drm_panic.c
>> @@ -703,6 +703,26 @@ static void debugfs_register_plane(struct drm_plane *plane, int index)
>>   static void debugfs_register_plane(struct drm_plane *plane, int index) {}
>>   #endif /* CONFIG_DRM_PANIC_DEBUG */
>>   
>> +/**
>> + * drm_panic_is_enabled
>> + * @dev: the drm device that may supports drm_panic
>> + *
>> + * returns true if the drm device supports drm_panic
>> + */
>> +bool drm_panic_is_enabled(struct drm_device *dev)
>> +{
>> +	struct drm_plane *plane;
>> +
>> +	if (!dev->mode_config.num_total_plane)
>> +		return false;
>> +
>> +	drm_for_each_plane(plane, dev)
>> +		if (plane->helper_private && plane->helper_private->get_scanout_buffer)
>> +			return true;
>> +	return false;
>> +}
>> +EXPORT_SYMBOL(drm_panic_is_enabled);
> 
> This feels like overkill since you currently only have one user in the
> fbdev emulation code, but maybe useful in some other places ...
> 
>> +
>>   /**
>>    * drm_panic_register() - Initialize DRM panic for a device
>>    * @dev: the drm device on which the panic screen will be displayed.
>> diff --git a/include/drm/drm_panic.h b/include/drm/drm_panic.h
>> index 73bb3f3d9ed9..c3a358dc3e27 100644
>> --- a/include/drm/drm_panic.h
>> +++ b/include/drm/drm_panic.h
>> @@ -148,11 +148,13 @@ struct drm_scanout_buffer {
>>   
>>   #ifdef CONFIG_DRM_PANIC
>>   
>> +bool drm_panic_is_enabled(struct drm_device *dev);
> 
> Since it's internal only, this should be in
> drivers/gpu/drm/drm_crtc_internal.h and not int he include for drivers.

Yes, that makes sense, drivers won't need that API.

> With that:
> 
> Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
> 
>>   void drm_panic_register(struct drm_device *dev);
>>   void drm_panic_unregister(struct drm_device *dev);
> 
> These two are only used in drm.ko. Can you please move them to
> drm_crtc_internal.h too and drop the EXPORT_SYMBOL in a follow-up patch?
> We're trying to limit the exported interface and official headers to
> really only the pieces drivers actually need.

Sure, I'll add this to my next drm_panic series.

> 
> Thanks, Sima
> 
>>   
>>   #else
>>   
>> +bool drm_panic_is_enabled(struct drm_device *dev) {return false; }
>>   static inline void drm_panic_register(struct drm_device *dev) {}
>>   static inline void drm_panic_unregister(struct drm_device *dev) {}
>>   
>> -- 
>> 2.45.2
>>
> 

Best regards,

-- 

Jocelyn

