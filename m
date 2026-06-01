Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A93E3A2E00
	for <linux-fbdev@vger.kernel.org>; Mon,  1 Jun 2026 11:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780312785; cv=none; b=pvxTgV2RGjaUaSAB+EN6hOFMEjNwXpnDN4KgrxPOlRLsHukU0/20zYx0gIm+ViiBpPDNyQDsHFobBi1uzot+76ZIrYSjVBqGaeKo+ccpybL6jMLFjTwCjtIvjjMlHRR9R+GsJ8HhF9DkX+5niyPnzBdfY1g1qEQq+d3RJTKK2eE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780312785; c=relaxed/simple;
	bh=eyBesLCqPk9h4NOFzG4PiF0VzIdhvWW/kPhNdNMmyf0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qJ5Q4QM9zOj0CaX9WDq61/uc3U1gceQAKX46NnxHEV+UpJrttAgWBXwPPHYMOMwCXi8V9phtK65bMkoSFwB4HBxuoU6zgfWuO5sjruPfnGF1FlyJLp2wcHBc3hxVPfSdJ8zGNcSjx/pDm7hr3V4g1lT4aKfrzmMhunZU/YjOuXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=P2dznWA4; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=lxfZ/fMA; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P2dznWA4";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="lxfZ/fMA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780312783;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rDdMHQ4QMIhEirSuORxkFsO4/PRX5BsSB4zaAcWgpLM=;
	b=P2dznWA4MbbgKI65B1lDfyvBbC+pAzcQgor3had1cEynNAlFWx29CxMRk24KjRDtKJHBi1
	RvuMSRkK9FXZEjJ66RwaQ+5DlQhH3d/mlnHvJR7JUmiLm9jENhj+FQIR2ZXDBcKSvE85iR
	dyUYXxigg9WifvdID/dGncFfXEhXjt0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-115-0T9Pys3jN6yFGS-o7LPyCw-1; Mon, 01 Jun 2026 07:19:41 -0400
X-MC-Unique: 0T9Pys3jN6yFGS-o7LPyCw-1
X-Mimecast-MFC-AGG-ID: 0T9Pys3jN6yFGS-o7LPyCw_1780312781
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-490a767c7dcso9862935e9.2
        for <linux-fbdev@vger.kernel.org>; Mon, 01 Jun 2026 04:19:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1780312780; x=1780917580; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rDdMHQ4QMIhEirSuORxkFsO4/PRX5BsSB4zaAcWgpLM=;
        b=lxfZ/fMAruZdmnV6Ogk+kHaJuF/DATpYff/bnvLoMQuOw4DkqHxyekodDu+tZpqXcp
         X6LFXnpKTIpK7dQH++jSsT4eTOdbOc1j9NBfeZGX05BMsQAFg5QebljDHBAIPTZ3Idtl
         8PrpO4jiotZ1bzMzliu6da8SOFJqa6N+FIsNNU3zcyLBdqgdsD1VnF9mdGVZe7GCBUJB
         M1gQIa10URIzLWhbNRvkM6UkwRHTAb0NagcA2HfDxHvB3Du+2rcitp6UVu+b/zPVju21
         e0E6aZ+3omejOodAhYMulGrtQLEB+AooqfS8XcvRp2FlS4x9SdWBjJV72e+2g9x0htGj
         YmHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780312780; x=1780917580;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rDdMHQ4QMIhEirSuORxkFsO4/PRX5BsSB4zaAcWgpLM=;
        b=PjRDZ3NZH8XE6es7/S8661vyXe7SV6TYaeKII41l9aa9Ot5oEO+TaKWWjem3+QY2lx
         Eszz8DKLgmx3Ovtzwq9pwHzeL+NQ7D3odu0FOC0tkOToOVXGn9M/SwKU4TYNS1Mf9zDj
         aHDw7niBTky6x4hr1XPHzTY0C1SX2TvpGa2sTaJ0iT4fPeLo0/97L/woftjsKkk6c9wM
         h2Emof9FWDHzTPF/FFWYMXI3W39iJi9b7n8Paq6D6H06m+rrPCQzgTbX+jYUgNCORQks
         rGuSsejTzayKsHs98HBcgk54S3Fxqa0pRngWeMeazBNx+/53i1fGxU63jvRUWuW7BiaW
         cnUQ==
X-Forwarded-Encrypted: i=1; AFNElJ/PgRtPY5KDUHGIZhg1DGoFX4lx9fyZwfM4LBAB+DSe+H8/NZ6LXWfb093fVSKh3xe9X2VSdIf9cK2p8g==@vger.kernel.org
X-Gm-Message-State: AOJu0YyRXawGQXNx9DFnpn9tOGrPDSkAWuD+D5r6qzTJeKtV7kJr3iNq
	iIy7Nsio4rqPG2h7e4vnKEIwx5JjnfsU3dZuRZMXDIyywM7OqQm4zW11OIaJkFjOGESNrSsVqiA
	NiEuhkVoUQ47zUTwPJGTOIMAg0i3cTW7X31r/ckfvR+j81O209Lly9XYx5nmyrwrw
X-Gm-Gg: Acq92OEzJ1Ar6LV2VDMPgaLPy0o8VlbUO0TiAbEoi+uG+iCxImPd2me0R0GSEVZbrZc
	X9uKbiYvZIz2mimlQ+EGwuJ+m1q/gWEdxxKRtfK/OzE8EglguWYMliYxP9G2HaC2vitLgZQk9Ta
	O0pJv4AQHbpR546XYeKrwU2AOiH0o6uGFnLakp5BoWyysryNbvpQ1m3ZlE1pvARxH1i1SAdmUej
	n1Ez0H+94gtTWpmjAJ5r9MQAjzVfQmL21PCYL6r9IdLxnkUoyvSIT1pHX+i8ubntslkOzRFmicr
	wiySBeexElHC6G5wH6le+qtKa5CUrSWo+blGsvzt1k+Ol7M1RPvkeTRe94OuvzbPfKQhqlA6VIz
	xnNQ/c+x4212aClwVwLzWHMP3HD6OKLzqcQ9LCmGIMDZ3wPb6NDRsQo5H7w+f5EIuEB8dW9/H
X-Received: by 2002:a05:600c:8b10:b0:490:5cb3:e94a with SMTP id 5b1f17b1804b1-490a2900d9dmr190001835e9.2.1780312780532;
        Mon, 01 Jun 2026 04:19:40 -0700 (PDT)
X-Received: by 2002:a05:600c:8b10:b0:490:5cb3:e94a with SMTP id 5b1f17b1804b1-490a2900d9dmr190001155e9.2.1780312780147;
        Mon, 01 Jun 2026 04:19:40 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:c:37e0:ec71:10ae:399e:d3c8? ([2a01:e0a:c:37e0:ec71:10ae:399e:d3c8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4909d68a925sm372611805e9.2.2026.06.01.04.19.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Jun 2026 04:19:39 -0700 (PDT)
Message-ID: <f66a0169-305b-4b72-a9bb-c114a81ed30e@redhat.com>
Date: Mon, 1 Jun 2026 13:19:38 +0200
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] drm/panic: Look up glyph shape with font helper
To: Thomas Zimmermann <tzimmermann@suse.de>, javierm@redhat.com,
 deller@gmx.de, maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 airlied@gmail.com, simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
References: <20260529140759.529929-1-tzimmermann@suse.de>
 <20260529140759.529929-4-tzimmermann@suse.de>
Content-Language: en-US, fr
From: Jocelyn Falempe <jfalempe@redhat.com>
In-Reply-To: <20260529140759.529929-4-tzimmermann@suse.de>
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
>   drivers/gpu/drm/drm_panic.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_panic.c b/drivers/gpu/drm/drm_panic.c
> index d6d3b8d85dea..e576c4791861 100644
> --- a/drivers/gpu/drm/drm_panic.c
> +++ b/drivers/gpu/drm/drm_panic.c
> @@ -443,9 +443,11 @@ static void draw_txt_rectangle(struct drm_scanout_buffer *sb,
>   			rec.x1 += (drm_rect_width(clip) - (line_len * font->width)) / 2;
>   
>   		for (j = 0; j < line_len; j++) {
> -			src = drm_draw_get_char_bitmap(font, msg[i].txt[j], font_pitch);
> +			src = font_data_glyph_buf(font->data, font->width, font->height,
> +						  (unsigned char)msg[i].txt[j]);
>   			rec.x2 = rec.x1 + font->width;
> -			drm_panic_blit(sb, &rec, src, font_pitch, 1, color);
> +			if (src)
> +				drm_panic_blit(sb, &rec, src, font_pitch, 1, color);
>   			rec.x1 += font->width;
>   		}
>   	}

