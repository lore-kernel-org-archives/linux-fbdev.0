Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29E673A2E00
	for <linux-fbdev@vger.kernel.org>; Mon,  1 Jun 2026 11:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780312762; cv=none; b=VR456m1xSccdG+AlKlU/Qp9TJz7/j2VRdKwKUSkct5Gi5TySiW5XNEt+n87S07cTtlHAS+Mpnam+5DiCsIIoQRe/F+D8oRiit0fIE4tR3pZiY0zLgjrI6FH/gRTgLsj8K5FY0smFo5PGf8fy3bR6cV1LCxlH4PQmMvLb/2xzDIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780312762; c=relaxed/simple;
	bh=LBeAgGXN9DeqPFRA3jWITJt8FVXfB280YLfc0k7DRiM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JKFh+c9zx951KGYHFLpg3nF66F4vNN/rEIBfm5qMb2dpVKytGis0yOp1QnUj2kRzGHdtqE5TcslwHTu+QZpfg+amjMKGFP+a+ofxk2dTNdirBsI3zwnz8ffUA3pDtFaIAcK43A0fkNqye6KnqOWX2Vj7D+JdQw9ig3ZIZ/qn8ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=L/LiVARy; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=LrTKS4Iu; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L/LiVARy";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="LrTKS4Iu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780312759;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GuGEK1SkcuHAPgz9gEDQStCi7pNGC+sChcUFL1++fKI=;
	b=L/LiVARyXdW0owASpM8S8EHxdOpQRST5UGFnJzrxrkIKEP8PDy3zKaHNCck199jWKmU2HF
	aloY16pjnSzKaR+rl/ns8pSI9dCg4u1BQLLuPEydxp+YuQPltGAya9JbKqLZHlC+LrmR2g
	OZNdY3mTODwN2GXIaeBslLjdCsfofk4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-342-WTe83pmhOXeTGuYa3CTvIQ-1; Mon, 01 Jun 2026 07:19:18 -0400
X-MC-Unique: WTe83pmhOXeTGuYa3CTvIQ-1
X-Mimecast-MFC-AGG-ID: WTe83pmhOXeTGuYa3CTvIQ_1780312758
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-490a767c7dcso9848325e9.2
        for <linux-fbdev@vger.kernel.org>; Mon, 01 Jun 2026 04:19:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1780312757; x=1780917557; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GuGEK1SkcuHAPgz9gEDQStCi7pNGC+sChcUFL1++fKI=;
        b=LrTKS4Iu3OxR6jNqPy3QbG/5HwHaEJKITNIRY7Ya0+JTRnRGF80/vhp6xWnqzex0od
         e0m54GPDyP1AYYENPUkPCTVyL30ehCrM+0anCATZbSH/MBh+Hu4qnrdwpwK2cMDFvAId
         btdmKOKUNu4lt2gfnuaAM+3YepbyYmkrydwrKvfJszMuYTGUZWfFikQv4DbwVQ6HkkQM
         mVJqRQ2IykS2spUieESIgZ0+oshMNPieVHVZ3YiUBnFjoMQtFv2C+qOr7UQHjtBMERnT
         OMYwQYFDCJCgy5OxJtt93fvpG30qghGGRs+GB8lsTwIU+vNSUlrTog2c/aXaEZRsS2vn
         BYJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780312757; x=1780917557;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GuGEK1SkcuHAPgz9gEDQStCi7pNGC+sChcUFL1++fKI=;
        b=JiD6vHg2wDf5XfWwTxulNxNBV9fNbHH8+T40RPHlpwmV+Ie6ZPfPIRhNiDc8l51iHt
         KAoVg/8IHavx98g0pIa7ZYyn930uKzuEwd3WPX5TPJaRSiyWPlf9maFDa4dzZnT9aLm+
         siB4uHGSP4KIdXct8MotbkWMazr/kcq7RWc7wIACL+6RmXZFcX08IcIiiPf7/FkR97Mh
         3qtDR8vG1LzzL1WiYAGn8263TMTfy1RyFpQccJcFqOpMBtvkD7OaD4yrvQaNxZNLyX5j
         En/nuYRR57+3qGBmnvh0MQ3oOKJabUNAmVJ9Z02fPmeNHMEwqJqFYk17xX4eKJj7kQZP
         d8mQ==
X-Forwarded-Encrypted: i=1; AFNElJ+OBAkz8GGze7q+oa9VN7g07n/Zj5py+hQWoM3yEip3PMVJZwKc8hhnaD77lYJLprrgDnn7wZbiFsKTZg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxniafRlQL33C5DkukKUZ/uk5AbsEf5YNqwE+djDLkgFDC5nXmx
	oMwOjA99Bkigl3L3/LyrnxbpsdBiObahyRCSjpuidZtXTihNfuwKgZswdC2UCtDN2x8YBRgqLWx
	q+nhPN8y/9WIwNnQ9YPD7YKcE+UkBE80MS6IxIMSqA6GEzQABXzyQYpPKeqOzK4tw
X-Gm-Gg: Acq92OHsLhHF5dxz26PZ719/8t+tGXKjGwHls5LblOm8yqc6L6JQNvx8weH5bkVU5Rn
	MjSeH4+K4gov1bhUSzDr8LQQokao5eG3SgH2m08J3o2vm1pwIv3o1TNs2AUSJL5LKHcjnzfOT++
	Ss1hDvvOEc+QCjjUfyhLPKIPu8AeW3Z24Unm+zXAHWkC/3FDlxI65caBzm74LOt1RTqMEWTAxef
	ukFjKMZXzjd9IbHTnZA6kgKKCD2Oqcj4lgr1syM64vcl4zeG5bhMl+FIqajgSpZFz/cnfZGiflr
	keCKb7ou7XN6qWbj3fU6XDq8689Vm/eDMFO9mX+FBbR85hPDVwCl5lqwi2u7Tg9xJ0ij5bd/tNQ
	YYzMSw2u0zLjR+ZV/+7zDEMbUa9kmvTudV0CR8TGqbY9OeeRQEjUkrCT8FFLtixY5RgH4i+xN
X-Received: by 2002:a05:600c:1d2a:b0:490:a964:14f8 with SMTP id 5b1f17b1804b1-490a9641586mr78813415e9.8.1780312756560;
        Mon, 01 Jun 2026 04:19:16 -0700 (PDT)
X-Received: by 2002:a05:600c:1d2a:b0:490:a964:14f8 with SMTP id 5b1f17b1804b1-490a9641586mr78811755e9.8.1780312755336;
        Mon, 01 Jun 2026 04:19:15 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:c:37e0:ec71:10ae:399e:d3c8? ([2a01:e0a:c:37e0:ec71:10ae:399e:d3c8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4909c0e8c1bsm100153935e9.3.2026.06.01.04.19.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Jun 2026 04:19:14 -0700 (PDT)
Message-ID: <864d92ed-3f54-45c4-8000-167ccc343f11@redhat.com>
Date: Mon, 1 Jun 2026 13:19:13 +0200
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] drm/client: log: Look up glyph shape with font helper
To: Thomas Zimmermann <tzimmermann@suse.de>, javierm@redhat.com,
 deller@gmx.de, maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 airlied@gmail.com, simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
References: <20260529140759.529929-1-tzimmermann@suse.de>
 <20260529140759.529929-3-tzimmermann@suse.de>
Content-Language: en-US, fr
From: Jocelyn Falempe <jfalempe@redhat.com>
In-Reply-To: <20260529140759.529929-3-tzimmermann@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 29/05/2026 16:01, Thomas Zimmermann wrote:
> Look up glyph shapes with font_data_glyph_buf(). Handle non-existing
> glyphs gracefully. Enable extended ASCII by casting to unsigned char.

Thanks, it looks good to me.

Reviewed-by: Jocelyn Falempe <jfalempe@redhat.com>
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---
>   drivers/gpu/drm/clients/drm_log.c | 10 ++++++----
>   1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/clients/drm_log.c b/drivers/gpu/drm/clients/drm_log.c
> index 8d21b785bead..e3e02c84a4cf 100644
> --- a/drivers/gpu/drm/clients/drm_log.c
> +++ b/drivers/gpu/drm/clients/drm_log.c
> @@ -122,10 +122,12 @@ static void drm_log_draw_line(struct drm_log_scanout *scanout, const char *s,
>   	iosys_map_incr(&map, r.y1 * fb->pitches[0]);
>   	for (i = 0; i < len && i < scanout->columns; i++) {
>   		u32 color = (i < prefix_len) ? scanout->prefix_color : scanout->front_color;
> -		src = drm_draw_get_char_bitmap(font, s[i], font_pitch);
> -		drm_log_blit(&map, fb->pitches[0], src, font_pitch,
> -			     scanout->scaled_font_h, scanout->scaled_font_w,
> -			     px_width, color);
> +		src = font_data_glyph_buf(font->data, font->width, font->height,
> +					  (unsigned char)s[i]);
> +		if (src)
> +			drm_log_blit(&map, fb->pitches[0], src, font_pitch,
> +				     scanout->scaled_font_h, scanout->scaled_font_w,
> +				     px_width, color);
>   		iosys_map_incr(&map, scanout->scaled_font_w * px_width);
>   	}
>   

