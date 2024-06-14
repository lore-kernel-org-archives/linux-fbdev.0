Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEEB21922C2
	for <linux-fbdev@vger.kernel.org>; Fri, 14 Jun 2024 09:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718357732; cv=none; b=JtPuwiy1VFKcJnLpVE/zAihbdUl3kHJZeQ9V9v/fUDxE5nf9npMxlJsCQ7OwVobRryQbqPaWkc1PHjSYhQe1jW0hXmzCQ3hxX/B2Ln3HvbHcBe4V1ZXw4GwkY3wd7VT/vSxbrSw1si6Ru6MkAt/DP07lL8jETCiRlqgtGKElkds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718357732; c=relaxed/simple;
	bh=Xd8AfhR+JUvJQlHghzmVxCjQeM7PevGLqZZUpot3QwM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XTEbxS/v6ZMDPFRzwpK6mrccqbmMMNWaPkChGLRfN7iHHSoPzUzbwAZrGslMlRkOfc+Kg0Z4D+UXmBnurZ2umJzS3mM/RwkqGRA1mPV+i9VMUZ+bI8wgyri7+WO8YAETuV9SP56Lc147YnNRW01sV7J9m/7GxVCu7enmQ4eO3Xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OGJcmdZA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OGJcmdZA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718357729;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xdJt7+cVLZ5M2lQzrTC0sFKbIvCszz8E/fHGwHxyvpM=;
	b=OGJcmdZApZ4/Blobt+GKweAfvxqlocp213B+3zQ4BwaisQbFscKQoljH5EnpzgF9OBVh2w
	QCNrV7yzO9lgZ6SX1lHUyGxgUc+fS2kch9Br9EgYbTgKvrUQvaeQ6TJCkfOM46D6wMBuM/
	Py+SKq/KlR4ha3BwrwWKCuAqu5keioY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-688-yXO-sJNAN4ezRH963Nfktw-1; Fri, 14 Jun 2024 05:35:24 -0400
X-MC-Unique: yXO-sJNAN4ezRH963Nfktw-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-42183fdd668so12720275e9.2
        for <linux-fbdev@vger.kernel.org>; Fri, 14 Jun 2024 02:35:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718357723; x=1718962523;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xdJt7+cVLZ5M2lQzrTC0sFKbIvCszz8E/fHGwHxyvpM=;
        b=PaXpT8JEO7GPsIpYdmgdTxdYVEApa+2Ob+BssZwtdvbYFuBw2Gj2W6AzN3s46CnGrV
         TP3q/QRXkp1tEzUVg9C1Yowr5lyE+0QGtXaeT1c4dk9CqVT2xa5+1gik7Tdfaxus3XUs
         tjCgJ/falefyJxwc/0pc5HHpwvwhD/6k+oH3cgYFLLsJHyIEEA1VeogdrZ7FJW4/aTXY
         8i2SVp54I5Z/ahy0kMKbG0gU78EL/LTmtSnfADCvreJyEvnFn6Mlv15L/F3RmWkDy2m6
         XwN1NPSxnzMfzrIyBPOYvmL68FJeSsExlVbVicqnCyzdh8LzKQ4QKsFI1ppZq9sSvd3V
         j+ug==
X-Forwarded-Encrypted: i=1; AJvYcCWJoLUWgTDlVam4g01w5ErnjEd2PGba5zj/oSpvyHIy64OCvPVoX+R0XcTrz2fTbQS/Rqvh1sTVl67dXxbAFPgrLKUYiMZrbhxxP0w=
X-Gm-Message-State: AOJu0YwOxBK2YmTXrmuK6Nh9J8g4K61RwLHQ09Ner3ZwMEi5iXMM2yHh
	bAzUTRDZ8PW5jsYPV0LJHNxHfHSqrooWnpQf4ptRSjajSGFR5kN2oLcicpX1yAcAJ6Xjyb1RZ4c
	9Sto1qPL4+6yjqnHDCfwiMhLB989JKpdRxf3dYba1teWsMUeOKyNDWhvFexXEsI4AWLIU
X-Received: by 2002:a7b:c41a:0:b0:421:7b9d:5b9b with SMTP id 5b1f17b1804b1-42304821171mr19059055e9.15.1718357723213;
        Fri, 14 Jun 2024 02:35:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGe9EHRho8FXo61eGrPv34AQ567+feP7sbnnVAIN5Dw0SEYP9TPPcNB5desjjcRmD8PIdslsg==
X-Received: by 2002:a7b:c41a:0:b0:421:7b9d:5b9b with SMTP id 5b1f17b1804b1-42304821171mr19058885e9.15.1718357722864;
        Fri, 14 Jun 2024 02:35:22 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:c:37e0:38da:a7d9:7cc9:db3e? ([2a01:e0a:c:37e0:38da:a7d9:7cc9:db3e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36075104c17sm3813405f8f.106.2024.06.14.02.35.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Jun 2024 02:35:22 -0700 (PDT)
Message-ID: <d2f7f2c2-242e-4521-a205-8b19999a565b@redhat.com>
Date: Fri, 14 Jun 2024 11:35:21 +0200
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/7] drm/panic: Fix uninitialized
 drm_scanout_buffer.set_pixel() crash
To: Geert Uytterhoeven <geert+renesas@glider.be>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>
Cc: Helge Deller <deller@gmx.de>, dri-devel@lists.freedesktop.org,
 linux-fbdev@vger.kernel.org, linux-renesas-soc@vger.kernel.org
References: <cover.1718305355.git.geert+renesas@glider.be>
 <4c250d21880ca0b97e41da7b6a101bdf07e9d015.1718305355.git.geert+renesas@glider.be>
Content-Language: en-US, fr
From: Jocelyn Falempe <jfalempe@redhat.com>
In-Reply-To: <4c250d21880ca0b97e41da7b6a101bdf07e9d015.1718305355.git.geert+renesas@glider.be>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 13/06/2024 21:17, Geert Uytterhoeven wrote:
> No implementations of drm_plane_helper_funcs.get_scanout_buffer() fill
> in the optional drm_scanout_buffer.set_pixel() member.  Hence the member
> may contain non-zero garbage, causing a crash when deferencing it during
> drm panic.
> 
> Fix this by pre-initializing the drm_scanout_buffer object before
> calling drm_plane_helper_funcs.get_scanout_buffer().

Good catch, I don't know how I didn't hit this bug before.
Thanks for the fix.

Reviewed-by: Jocelyn Falempe <jfalempe@redhat.com>

> 
> Fixes: 24d07f114e4ec760 ("drm/panic: Add a set_pixel() callback to drm_scanout_buffer")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> v2:
>    - New.
> ---
>   drivers/gpu/drm/drm_panic.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/drm_panic.c b/drivers/gpu/drm/drm_panic.c
> index 293d4dcbc80da7ba..fc04ed4e0b399f55 100644
> --- a/drivers/gpu/drm/drm_panic.c
> +++ b/drivers/gpu/drm/drm_panic.c
> @@ -582,7 +582,7 @@ static void draw_panic_dispatch(struct drm_scanout_buffer *sb)
>   
>   static void draw_panic_plane(struct drm_plane *plane)
>   {
> -	struct drm_scanout_buffer sb;
> +	struct drm_scanout_buffer sb = { };
>   	int ret;
>   	unsigned long flags;
>   

