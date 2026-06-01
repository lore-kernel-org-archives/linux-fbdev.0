Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B83C38947F
	for <linux-fbdev@vger.kernel.org>; Mon,  1 Jun 2026 11:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780312805; cv=none; b=b5/usfaRIJouT55TP/vXFzBdxnoaHbyAssR9zkZrm8qjayH4YpQOgoyy6RQkGKaDV0lESj+0CkPW5LEqrOZWyLwowIG5PmDCM4SU2qrzcklWIudknrXgp1aafhi7AaKWfdruhg5SirfZM47BpRV2Kh+UFs3WY+S2qQNL9R6DSxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780312805; c=relaxed/simple;
	bh=+h2a+OLRmZuvgsB16pQERPj9uS4hrHDJA7M2CN/3/So=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GbIhmLDkHuVRvcJiEjLpsuk5egGtcvsIpImL778I0guf/MbH6+liXjIECaaWDt5y271R2aY2cOLIhX5e14qCA7k5LMklLpZhBwN5r+5Xmbv40j57qGIyitjedEZUboS5cLjI7rOeVvIa9FpLqMQhCEE+8d8GbNrUrGPdvvjgQXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HlwNkrI9; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=e9xSv6Pt; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HlwNkrI9";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="e9xSv6Pt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780312803;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Mw1aJssJMADYiwtop5nLysiutoOYtsyWQrC1VUIyR8M=;
	b=HlwNkrI9fAEPZc9v2bxlDFlQnAh9EbjAsHyQJW6hF3cDCiJOAqgjdfllBhnzgm0yPZWzJn
	6Z5ANs/n/pYeNZlgBaDJHfP5yVoGms7Rrx8zB8YYzryd4wYmgmIT4+R5JLai6q8KOEUch9
	9hdHXyGJko3DoaaDJ68WhFTdalygDyc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-608-CC6c2UXnOiaUwath_h6iXg-1; Mon, 01 Jun 2026 07:20:01 -0400
X-MC-Unique: CC6c2UXnOiaUwath_h6iXg-1
X-Mimecast-MFC-AGG-ID: CC6c2UXnOiaUwath_h6iXg_1780312800
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-490addd42bbso2851785e9.3
        for <linux-fbdev@vger.kernel.org>; Mon, 01 Jun 2026 04:20:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1780312800; x=1780917600; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Mw1aJssJMADYiwtop5nLysiutoOYtsyWQrC1VUIyR8M=;
        b=e9xSv6PtThK455ChNkoMn728xhqGBM6vIKguJUEjBqVRGzpLyCKKvtvY+PYLqbmaRf
         nzhvKovUSOBEAcAWXQZWuYBQueBxHJd/3VysfQDK08E3UatGL7SZpobN3jmQFEbXmCfI
         YrdzbIBiOnSbaknD32FXdF9zds8iAhsFALYlpRCD4/7n6/U7k358YHdoNLUq+9pEeq4K
         gwMP7Qt3KNVyKM2gEYbJNA1YoydIl29FV/pWhQnLJ2nEhAPhxcoioHHqIr7iqoKzJL7W
         pcqCRMe6sI2AUFbp7l4voxW5rTnBt6HSq4e/cOQ8fChWeqU5oS0nUMVaIYX+cJGbZL+F
         1m+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780312800; x=1780917600;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Mw1aJssJMADYiwtop5nLysiutoOYtsyWQrC1VUIyR8M=;
        b=SuKYXYNmyjI/Zl7zNXkAPdKl80QC3CyzZlLHp9zw72ERjMDr9IaGTGfqxaykH2M7x8
         YFzmVmjtONyZEgCgGeJO4KdStM+hljwCB1tXlxJ17uMqe4hHsUEW10ISza0zHu99XusI
         lCzyjq9ca/zVr1Jz64G0E7Q3m77IIx3K5oluOvR41/U+pQlRNv/cWNWzocQbr928tMqy
         IlLNDz8L9oCGCJm6XFh/pgQZpeS7NpPm0AmY2ubgEeLTuRLSY9AyD+6VrqVmzwa395J6
         k/eYB2d6yfEROJWqnjhCOfnWAGsykC9VAiyDcWVLVOE3q2JPE50JPXsGShCcsDY3yRdu
         H9Qg==
X-Forwarded-Encrypted: i=1; AFNElJ/WyB+eMYQhUP5JYEnte92FfnvfCvGGj98wCBr/KAOKznL30AtuZMnGsJ7rRWxyt8DxYv3KI21fMI3ZNw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxjGz2vplJNWekFIFSPJPUsjpg2uYxUoGAgejtWX/WC/9H9hz1V
	vcropAtcTFXRdo+J3NNgKSfU5SPZiUeCNXUfBpf6ansQNrEmi2aao+tc+ZmDr+FKCe5dEvLrVn4
	znrBABstYIw0uEHMCl9EjwAqDt/qi1/Vibt+45LKJXf/u8S5Uc1dOakoRzwkagrFE
X-Gm-Gg: Acq92OG5lpWYR2RpAzj/49370S+EcORIYgaljiABJgQU39Kf/vtSsBJdJt/3z7+7QOp
	KEfz/IMBb1Z7/V8VPfl7FAWD1KeUTsupyJV1tMxAz0bROql2RcENL5lePDcPzbcwFfekjWUtLgs
	tt+UqwutfHuupvoYBb7B+9DXxKeMIdW3nLu8I23mO/Y0wZDUaq+h7e2XAKZv38KxED1bYZyB0Y3
	dTn4n73AtCpbubEr+05gqV1x35JLyJl++wSHgwdQ8+mhgrv9QmzaXz+ik2uxJh3e77Aqy0eWffp
	d8UI815N7t2mv3rcTWXe+4hb1kDddrzxtreSQADaQs+xgfBAqxEuMnArydOSGvqLhXPkm0f7apb
	5gdEdnVCcfU8pCW27sQwBul4ILvuy8CCl8FN0oxIUPVYVIA4xPSC8zyUSZuiBDiVoeHokVb6T
X-Received: by 2002:a05:600c:8b71:b0:490:add9:7f88 with SMTP id 5b1f17b1804b1-490af395bffmr12333025e9.21.1780312800459;
        Mon, 01 Jun 2026 04:20:00 -0700 (PDT)
X-Received: by 2002:a05:600c:8b71:b0:490:add9:7f88 with SMTP id 5b1f17b1804b1-490af395bffmr12332645e9.21.1780312800101;
        Mon, 01 Jun 2026 04:20:00 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:c:37e0:ec71:10ae:399e:d3c8? ([2a01:e0a:c:37e0:ec71:10ae:399e:d3c8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4909d6eb3adsm244431395e9.11.2026.06.01.04.19.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Jun 2026 04:19:59 -0700 (PDT)
Message-ID: <f651bfc5-1a8e-4daa-bfae-49547c1e9aeb@redhat.com>
Date: Mon, 1 Jun 2026 13:19:58 +0200
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] drm/draw: Remove unused helper
 drm_draw_get_char_bitmap()
To: Thomas Zimmermann <tzimmermann@suse.de>, javierm@redhat.com,
 deller@gmx.de, maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 airlied@gmail.com, simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
References: <20260529140759.529929-1-tzimmermann@suse.de>
 <20260529140759.529929-5-tzimmermann@suse.de>
Content-Language: en-US, fr
From: Jocelyn Falempe <jfalempe@redhat.com>
In-Reply-To: <20260529140759.529929-5-tzimmermann@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 29/05/2026 16:01, Thomas Zimmermann wrote:
> Glyph-shape lookup has been integrated into the font-data interface
> and all callers have been updated. Remove the old helper.

Thanks, it looks good to me.

Reviewed-by: Jocelyn Falempe <jfalempe@redhat.com>

> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---
>   drivers/gpu/drm/drm_draw_internal.h | 7 -------
>   1 file changed, 7 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_draw_internal.h b/drivers/gpu/drm/drm_draw_internal.h
> index 261967145635..44ddcee4744c 100644
> --- a/drivers/gpu/drm/drm_draw_internal.h
> +++ b/drivers/gpu/drm/drm_draw_internal.h
> @@ -7,7 +7,6 @@
>   #ifndef __DRM_DRAW_INTERNAL_H__
>   #define __DRM_DRAW_INTERNAL_H__
>   
> -#include <linux/font.h>
>   #include <linux/types.h>
>   
>   struct iosys_map;
> @@ -18,12 +17,6 @@ static inline bool drm_draw_is_pixel_fg(const u8 *sbuf8, unsigned int spitch, in
>   	return (sbuf8[(y * spitch) + x / 8] & (0x80 >> (x % 8))) != 0;
>   }
>   
> -static inline const u8 *drm_draw_get_char_bitmap(const struct font_desc *font,
> -						 char c, size_t font_pitch)
> -{
> -	return font->data + (c * font->height) * font_pitch;
> -}
> -
>   bool drm_draw_can_convert_from_xrgb8888(u32 format);
>   
>   u32 drm_draw_color_from_xrgb8888(u32 color, u32 format);

