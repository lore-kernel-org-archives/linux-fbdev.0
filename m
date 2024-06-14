Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2C91192B7A
	for <linux-fbdev@vger.kernel.org>; Fri, 14 Jun 2024 09:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718358288; cv=none; b=W2HD4rJB3xeekeY6+W6PyRBAHBnOX6ndxvdt7SS5x9BbjXmezxiKfDi/Jjy5EnPOQmEW1jkPcelGPMUJMtL4owD+Y8sI4aZ1xRNYFLxc7noga54lr0JHnVo2aPcv1+ggeQ64UugkJuM+OmPOKlDk96b4xZarq9KjLmQpcVMraeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718358288; c=relaxed/simple;
	bh=g/f72YAwlJRl5+TqCMfPxZhhoWQoVckQUyPxOW4TmSw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BtN/mThh/saTueYiVRtdzQhQaHpvnH+vCnIAplASyMiuQANdGIZQnqi/PvYRH49anRKZCYyfhc8tBtMGnqZj3HwbKa8lXvYW7LChkzmzKgHFJzrJ9DjtWwJ0jkmidUOoXhUH/eXv6MHqoJKuQhMsxv+q0vCROaqHaUDdWQ4z1+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Lk2mnNYM; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Lk2mnNYM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718358285;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CshieQQIH4mKg/EiA3AsDpWQdSbrKh64nojN+WE88yY=;
	b=Lk2mnNYM99945qjIV2r5OCuQIAyyz4TAhXx8gohIHr5rvJPWv0BErC1MMISWmSLMQiCcEI
	hVz2PG4s2Al5J2AAJ+XSk9MnNRZ5ApR2HfZ8BjJMs4paSBHZUJ+kBf1yhq3X4NjDWRn+WY
	ZeWmcjkp6c0Bo+RUK8FYtdF6wqrN0LQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-126-CVtvb-DNMnehmybNT2R-Dg-1; Fri, 14 Jun 2024 05:44:43 -0400
X-MC-Unique: CVtvb-DNMnehmybNT2R-Dg-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-42117a61bccso15579805e9.0
        for <linux-fbdev@vger.kernel.org>; Fri, 14 Jun 2024 02:44:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718358282; x=1718963082;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CshieQQIH4mKg/EiA3AsDpWQdSbrKh64nojN+WE88yY=;
        b=HwNs5rCWlOeDGHBfnx6QNjEP73/AJXLp2wnlobiBvKWfE+1fgx6BE6k58zLTmVjTn6
         jLWg8rPBkuBcF034Aokfx1sHeK/JXJ+q8eBcPONEqw4MBqI6ETnVlo4U0FWvPAm0B4/i
         Nkg9KaO/SDonNCOMEstfham6AakdXgAXcdyjCdyIR9V37nXq2GLHUJNA09qkecYU/ZrN
         4fvM5MrdozhVI/UfIdpQtSDBK80e2i6F151rGlYfobZGUIRbyQgDPfo8ZWC6+Na9nJSd
         CW+08pCi+F/toa6KmAEO9fSp2rrX3hqHT00WCK4CslRxFMYFHb6oeP7zpBnYUK10OIk/
         C4og==
X-Forwarded-Encrypted: i=1; AJvYcCUYJ8bbkrrMe9KAa9g6QD1JxO5iakNfqIsgi/+YUYTO7NZxXq3R2oW4tcirhP2tdgDV2dUiOQOQm2dDQlI7aalZHG67WIrNnR6xa3Y=
X-Gm-Message-State: AOJu0YzYc7cXpShiweyK+wBL4uowZrACQkrHJrX4DDovhJedjRQonO+U
	c35kUCG394O9aZEaqFWPf1iK4dmUBRInf0wW0p5tPas2I9/2v1VD/LRTDxDC8LUutyOo8Dv9Y+B
	bTSVURNFhbvPucNclg0oNYQ+yg0iObqcRrCoJ6bxgSFIGj9jTe8xdI3xJYf5I
X-Received: by 2002:a05:600c:4e52:b0:421:7296:ba3f with SMTP id 5b1f17b1804b1-423048309d5mr22183415e9.22.1718358282304;
        Fri, 14 Jun 2024 02:44:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHol7Fxpqc45AcQb9iiSor1fKX+OLVhNrRP3nOxOGjpSELqoTURxJjSrSWvYixqw/xO488Sfw==
X-Received: by 2002:a05:600c:4e52:b0:421:7296:ba3f with SMTP id 5b1f17b1804b1-423048309d5mr22183125e9.22.1718358281948;
        Fri, 14 Jun 2024 02:44:41 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:c:37e0:38da:a7d9:7cc9:db3e? ([2a01:e0a:c:37e0:38da:a7d9:7cc9:db3e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-422f602e802sm53742615e9.11.2024.06.14.02.44.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Jun 2024 02:44:41 -0700 (PDT)
Message-ID: <16ded77c-a506-4672-ab74-ca1a7aaf21aa@redhat.com>
Date: Fri, 14 Jun 2024 11:44:40 +0200
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/7] drm/panic: Convert to drm_fb_clip_offset()
To: Geert Uytterhoeven <geert+renesas@glider.be>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>
Cc: Helge Deller <deller@gmx.de>, dri-devel@lists.freedesktop.org,
 linux-fbdev@vger.kernel.org, linux-renesas-soc@vger.kernel.org
References: <cover.1718305355.git.geert+renesas@glider.be>
 <3121082eb4beb461773ebb6f656ed9b4286967ee.1718305355.git.geert+renesas@glider.be>
Content-Language: en-US, fr
From: Jocelyn Falempe <jfalempe@redhat.com>
In-Reply-To: <3121082eb4beb461773ebb6f656ed9b4286967ee.1718305355.git.geert+renesas@glider.be>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 13/06/2024 21:18, Geert Uytterhoeven wrote:
> Use the drm_fb_clip_offset() helper instead of open-coding the same
> operation.

Thanks, it's a nice cleanup.

Reviewed-by: Jocelyn Falempe <jfalempe@redhat.com>

> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> DRM_PANIC already selects DRM_KMS_HELPER.
> 
> v2:
>    - New.
> ---
>   drivers/gpu/drm/drm_panic.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_panic.c b/drivers/gpu/drm/drm_panic.c
> index 814ef5c20c08ee42..5b0acf8c86e402a8 100644
> --- a/drivers/gpu/drm/drm_panic.c
> +++ b/drivers/gpu/drm/drm_panic.c
> @@ -285,7 +285,7 @@ static void drm_panic_blit(struct drm_scanout_buffer *sb, struct drm_rect *clip,
>   		return drm_panic_blit_pixel(sb, clip, sbuf8, spitch, fg_color);
>   
>   	map = sb->map[0];
> -	iosys_map_incr(&map, clip->y1 * sb->pitch[0] + clip->x1 * sb->format->cpp[0]);
> +	iosys_map_incr(&map, drm_fb_clip_offset(sb->pitch[0], sb->format, clip));
>   
>   	switch (sb->format->cpp[0]) {
>   	case 2:
> @@ -373,7 +373,7 @@ static void drm_panic_fill(struct drm_scanout_buffer *sb, struct drm_rect *clip,
>   		return drm_panic_fill_pixel(sb, clip, color);
>   
>   	map = sb->map[0];
> -	iosys_map_incr(&map, clip->y1 * sb->pitch[0] + clip->x1 * sb->format->cpp[0]);
> +	iosys_map_incr(&map, drm_fb_clip_offset(sb->pitch[0], sb->format, clip));
>   
>   	switch (sb->format->cpp[0]) {
>   	case 2:

