Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81DAC171A4
	for <linux-fbdev@vger.kernel.org>; Sun, 17 Mar 2024 12:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710679438; cv=none; b=dkqk5Dva9T2Bps1O6eVPjTiSwmaBEYNSUJr2V44JouExPHH0iAmg5HB+KQ1MMhjS9xqUkla+WoHRBHsbDI3Q2v8i7iKLnKUN31Uu/WasYl6U2NZyehlR8OEuNC/uDLGuongQsk+v3BWizkD2PX1b2gC8zib/+YkPIPr9XvpOFNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710679438; c=relaxed/simple;
	bh=WKiTALtlDL7QY+Y8Ji4R5ehoxoGydHZf4GaXq6b4fI8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NCcGdHPLDrByX5p6mEgnUKGf32M9vXK43s06zEMCxA263MqMr8iw5g3Yaiq+K/gfLgTCfmr3Cpg38siOTnr6EavhLPwxNo4znWC3iO4/v7kFSOiLH8TFGsLE5sQV5M30Luy8Rnyx/wLxO2Ciqn0RoeysN3TPoOdurGazHB3fpu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YeSKGQjq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YeSKGQjq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710679435;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=g97Ft8nUAWlVJEyr5loNfYtK+BYJCYuBkpmr21j3gu4=;
	b=YeSKGQjqWJbPRB1kQJbo+hbsYv+Xvg9m/HJ2qYiTUoxrAttEGMhAdsdCKKSKIDS3mEji0D
	vXmSIZxxa2O9JI8/SftM5Ys3AIBQgkhaBAuaJsQhfo77KtSYzuheTiLZUU1P8jMIG2YyJt
	aMsfcb2tl4/xByr28FMKgIEzq1NhYtk=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-45-WRoocMjVO7elvajTu9wumA-1; Sun, 17 Mar 2024 08:43:53 -0400
X-MC-Unique: WRoocMjVO7elvajTu9wumA-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-341726a5f6cso87491f8f.3
        for <linux-fbdev@vger.kernel.org>; Sun, 17 Mar 2024 05:43:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710679432; x=1711284232;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g97Ft8nUAWlVJEyr5loNfYtK+BYJCYuBkpmr21j3gu4=;
        b=moP2i68q06pTH8dvFnQp1Lo8ulIdK6kKvao1NukfoAipuvbxe26/6cfKpfjiWQmSZQ
         mmLYSGcm9WsyJNTS2qnJt2Nr6VHnQw8PlbgCoHtEw7cNJgw3ysV6vtr+AmCI/yTlA5vR
         u247M5ehvjbRjpjaPDfpJliIXWQgO73m9yS3eku+l6amCC3kV14yGktSJWNXRhLN9/cc
         P1eSdodQaKj1vQD3D7xdHXqc7bNYIeEDVob6LjNR5GOlrqH6SOCU5KRugtm6o8vMDMMp
         kOfV0xt8jregigYJDDQh8f+stvEhX/Idzq0NwOs8Shx55obVpTWWxXfftvebewVhREsb
         f+RQ==
X-Gm-Message-State: AOJu0YylCYiZ1iDb05Ox9rKnZOJj5W3mrLtIz3f0tGNZYBBtSkbSo0YB
	3XqxZmJfDvVwFrFExunSPLJ5mBbL739KNm7uhC/JqopPXw9kpp3T7e8tfVjPiS3MoiNzlPB8FjM
	r4IJPWVTcKrMOJZZR5AzQHUOZOlVqFCHcRJNd5J7EyBV1zHTN5HPJ/tFW7rZs
X-Received: by 2002:adf:ec11:0:b0:33e:bdea:629e with SMTP id x17-20020adfec11000000b0033ebdea629emr6419951wrn.37.1710679432555;
        Sun, 17 Mar 2024 05:43:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEb8z95q6yjzbWmLdjxBFXe9pJhFiak8PYhL/obq1KoS1/orvJFLwJ2wJ3LLVi5KBSwFjnBaA==
X-Received: by 2002:adf:ec11:0:b0:33e:bdea:629e with SMTP id x17-20020adfec11000000b0033ebdea629emr6419935wrn.37.1710679432123;
        Sun, 17 Mar 2024 05:43:52 -0700 (PDT)
Received: from localhost (231.red-83-48-46.staticip.rima-tde.net. [83.48.46.231])
        by smtp.gmail.com with ESMTPSA id bk28-20020a0560001d9c00b0033e22a7b3f8sm2503074wrb.75.2024.03.17.05.43.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Mar 2024 05:43:51 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Thomas Zimmermann <tzimmermann@suse.de>, daniel@ffwll.ch,
 airlied@gmail.com, deller@gmx.de
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, Thomas
 Zimmermann <tzimmermann@suse.de>, Zack Rusin <zackr@vmware.com>, Maarten
 Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH 01/43] drm/fbdev-generic: Do not set physical
 framebuffer address
In-Reply-To: <20240312154834.26178-2-tzimmermann@suse.de>
References: <20240312154834.26178-1-tzimmermann@suse.de>
 <20240312154834.26178-2-tzimmermann@suse.de>
Date: Sun, 17 Mar 2024 13:43:51 +0100
Message-ID: <87a5mxgha0.fsf@minerva.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Thomas Zimmermann <tzimmermann@suse.de> writes:

Hello Thomas,

> Framebuffer memory is allocated via vmalloc() from non-contiguous

It's vmalloc() true, but through vzmalloc() so I would mention that
function instead in the commit message.

> physical pages. The physical framebuffer start address is therefore
> meaningless. Do not set it.
>
> The value is not used within the kernel and only exported to userspace
> on dedicated ARM configs. No functional change is expected.
>

How's that info used? Does user-space assumes that the whole memory range
is contiguous in physical memory or just cares about the phyisical start
address ?

> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Fixes: a5b44c4adb16 ("drm/fbdev-generic: Always use shadow buffering")
> Cc: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: Javier Martinez Canillas <javierm@redhat.com>
> Cc: Zack Rusin <zackr@vmware.com>
> Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> Cc: Maxime Ripard <mripard@kernel.org>
> Cc: <stable@vger.kernel.org> # v6.4+
> ---
>  drivers/gpu/drm/drm_fbdev_generic.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/drm_fbdev_generic.c b/drivers/gpu/drm/drm_fbdev_generic.c
> index d647d89764cb9..b4659cd6285ab 100644
> --- a/drivers/gpu/drm/drm_fbdev_generic.c
> +++ b/drivers/gpu/drm/drm_fbdev_generic.c
> @@ -113,7 +113,6 @@ static int drm_fbdev_generic_helper_fb_probe(struct drm_fb_helper *fb_helper,
>  	/* screen */
>  	info->flags |= FBINFO_VIRTFB | FBINFO_READS_FAST;
>  	info->screen_buffer = screen_buffer;
> -	info->fix.smem_start = page_to_phys(vmalloc_to_page(info->screen_buffer));
>  	info->fix.smem_len = screen_size;
>  

Makes sense:

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

What about drivers/gpu/drm/drm_fb_helper.c btw? Since the memory range
allocated may not be physically contiguous if a platform uses an IOMMU ?

Asking because I don't really know how these exported values are used...
I just know that is when the CONFIG_DRM_FBDEV_LEAK_PHYS_SMEM is enabled.

--
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

