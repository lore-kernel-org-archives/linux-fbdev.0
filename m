Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E1031D530
	for <linux-fbdev@vger.kernel.org>; Tue, 16 Apr 2024 12:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713270795; cv=none; b=DwxJIxZREppPI28w6VrlxoYARo7oi8DSB8nFqE4hDfRAZ2v9c3t4zwrf4lw6JWWGEYsd1tU9vZKHx3Ke8L82Qvdqk7QMTkGWlGMWSVm6e08TFrWbWH/pXExNmkHKhpQscWDZn7uYneISQFz+4LCaS4bJs4oUMLQMxIWKEnslAO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713270795; c=relaxed/simple;
	bh=71kAcH0Ruy7gzYqTjdqkkTTJv72Cwo3DCuopOV5ws5E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VeYjsc1TSat5MYgPLMVhHyQipheMaE51XjqB32xl081NGqr9Y28JiSKf3Pi/ZC1X50iijZOlw4ec7Jh88pFKMznVq2xYIdN34majZHWXEFiK3OB32/T8R9i8BlLz4npm5qedoUceisOSbgObZFz2OPCBQ8W2yBOMWwnTEVeJWo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Uucimjug; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Uucimjug"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713270792;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xteOWPcjWbwNGVchkja51XJnWeQI8eB6ajK9N4gBt+o=;
	b=UucimjugR9z9p6iPit+NatbTGKEDiuJM1Pe50qSrmfCjWZWB8fSE6L3zmwXG3xq5e4AMBW
	RDpLeA9zKCOiCnbBUuOd5KYQuaWgrdEOWSX7hgX5Mhsu9OVGel5SDaPTp+dtMWXHdhuxx4
	1K72qyKtxVQCYhMNZecIZ+JTGajOhMY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-683-VYnGWzABM6GIC95hTROiWA-1; Tue, 16 Apr 2024 08:33:10 -0400
X-MC-Unique: VYnGWzABM6GIC95hTROiWA-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-417bf71efb4so22960675e9.0
        for <linux-fbdev@vger.kernel.org>; Tue, 16 Apr 2024 05:33:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713270789; x=1713875589;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xteOWPcjWbwNGVchkja51XJnWeQI8eB6ajK9N4gBt+o=;
        b=U7OnMLBCrgT2ANilNhuUbLrOELoknNYcZiwM3jxkMswZQ8Uq1EViXNJRJ5BwDgBYWO
         MxJ0QUsBR3Tzk1PN3YLTLNyuevTIQSnswBe6pH+V69gGv6/U7BjO0pRChd1x9Dk0u/yq
         Wsd7MqwmYcnPlwkD4pDrito5PoYfjdw+pOIy9xA2cKDmDYGVr14ikzb0ZFjKu9nLmM+0
         XUNBdJUgQUV7eoipeL8cGFM1ReDCgFRQszh3rafUzMrhNGakJuAJxkA3Z6wKn9ZO9njt
         32cI/SjKGda7Ih2RuaeyGnFMd7HtsJ+5BO0LnSfaDYpjnDYH6732qTiBQgVrgWb8oGuP
         cTvQ==
X-Forwarded-Encrypted: i=1; AJvYcCVGDUXzt1U6AXbUnxqoRATPKTVH/GJbw5F/Cths8UOOsNDyIKBWOgrqPNqj3BhepdTzA3E5Y3ic3xsubVBICy2pEINxuaTonaPzpAw=
X-Gm-Message-State: AOJu0YymMub6gU0pN2/6ccpib8K58XMNFgKUMVQqQNNJfZD7FMt5e05R
	My3E7kwXOD9ZNZzfk/jU7HRKayU6IixsLqMZODhNrvDXG+gQVaXlOloEBMmNZcgf//OoJnxrBBo
	eB4KdQvFlAFrU5m87hjTynsZeGy1569LmffHlcvXaOB8E09lWc9lPLLil986I
X-Received: by 2002:a05:600c:1d22:b0:418:7ec1:7bdb with SMTP id l34-20020a05600c1d2200b004187ec17bdbmr2355533wms.5.1713270789572;
        Tue, 16 Apr 2024 05:33:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF6QlHuOYFx5st5AynBIsSw9LG3X1l/uiKueZt8fUqUQ3eyo5dEWcdcofbF7Vx3r0j/oQ4jGg==
X-Received: by 2002:a05:600c:1d22:b0:418:7ec1:7bdb with SMTP id l34-20020a05600c1d2200b004187ec17bdbmr2355502wms.5.1713270789093;
        Tue, 16 Apr 2024 05:33:09 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id p15-20020a05600c468f00b00417da22df18sm19407022wmo.9.2024.04.16.05.33.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 05:33:08 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Thomas Zimmermann <tzimmermann@suse.de>, deller@gmx.de,
 airlied@gmail.com, daniel@ffwll.ch
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, Thomas
 Zimmermann <tzimmermann@suse.de>, Xinliang Liu <xinliang.liu@linaro.org>,
 Tian Tao <tiantao6@hisilicon.com>, Xinwei Kong
 <kong.kongxinwei@hisilicon.com>, Sumit Semwal <sumit.semwal@linaro.org>,
 Yongqin Liu <yongqin.liu@linaro.org>, John Stultz <jstultz@google.com>
Subject: Re: [PATCH v2 23/43] drm/hisilicon/kirin: Use fbdev-dma
In-Reply-To: <20240410130557.31572-24-tzimmermann@suse.de>
References: <20240410130557.31572-1-tzimmermann@suse.de>
 <20240410130557.31572-24-tzimmermann@suse.de>
Date: Tue, 16 Apr 2024 14:33:07 +0200
Message-ID: <87v84h5vy4.fsf@minerva.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Thomas Zimmermann <tzimmermann@suse.de> writes:

> Implement fbdev emulation with fbdev-dma. Fbdev-dma now supports
> damage handling, which is required by kirin. Avoids the overhead of
> fbdev-generic's additional shadow buffering. No functional changes.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: Xinliang Liu <xinliang.liu@linaro.org>
> Cc: Tian Tao <tiantao6@hisilicon.com>
> Cc: Xinwei Kong <kong.kongxinwei@hisilicon.com>
> Cc: Sumit Semwal <sumit.semwal@linaro.org>
> Cc: Yongqin Liu <yongqin.liu@linaro.org>
> Cc: John Stultz <jstultz@google.com>
> ---
>  drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

