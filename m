Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HNo0nBPG"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2542C85
	for <linux-fbdev@vger.kernel.org>; Thu, 16 Nov 2023 03:28:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1700134110;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=v5/8ZzCVrCdsxMalmcenuz1AcsZBPFj3JQUIdn0FWWw=;
	b=HNo0nBPGIEfKef+m6jSI1jp1reT4brf5q/RVsYELjkDdrcz3tSDZqz2pPaNqcYNzK7kHxa
	Fg5gSPq1wReRlde8ePPOpoKWVnMda7EJe3i69oIFKH/KnpBGs4A8JKQ3fLRrM4qrf7YCo8
	39Mfo4twuK0Mr+0fYRCn9GQLia/4sfM=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-146-A5Gfe8ZaO5SSpZ-i_HY3fg-1; Thu, 16 Nov 2023 06:28:29 -0500
X-MC-Unique: A5Gfe8ZaO5SSpZ-i_HY3fg-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-32cef5f8af5so862829f8f.1
        for <linux-fbdev@vger.kernel.org>; Thu, 16 Nov 2023 03:28:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700134107; x=1700738907;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v5/8ZzCVrCdsxMalmcenuz1AcsZBPFj3JQUIdn0FWWw=;
        b=dhX7mBGBK12Ai6EAW6plDNLK7U1kK3g2fJy8gdj/TP8EhZBzIAbS30jyUfhnZPJ4Ge
         +Q0thx3hJ4+w88fX8Z3FGmYv9jqK4lT6ArN+AmZmy49ZKOM1ubtQyiNGw8wJChOdYmNI
         84pVwq5CGxvvD7gbE5vDPP2J8JL92sQYHdy62uThbegb/k3X7kcvsXb+U3yNz8EGg7I1
         7ily9pBhMF59g5e53g2m02GGDmzYHmAiBez3nloCFhWrkpTnw5SOxV44sKoG8KlcpZZF
         5AA5pKbgNLEOoXeV9jCzeezus7KelblBnpIJtsrTDTLLlRA0GDgzdjAeX8/hI7J3Mj1W
         B2IQ==
X-Gm-Message-State: AOJu0Yw+ay8zeUh99RH387ajqRzsZj9oXVMT+04+js2oMk1nytL8EQ+0
	+uc01qGQyFc07/ZFQVNiiEE+tWMFDIdh/Yr5CnfzpVKtKV8hqbPFm/TKTXPr/Lm0ZVj94AYg5Cx
	Mtk0CrgovzLIUuSN+PJ/paCmUnNwdT9A=
X-Received: by 2002:a5d:5987:0:b0:32f:8a45:937f with SMTP id n7-20020a5d5987000000b0032f8a45937fmr1746643wri.2.1700134106951;
        Thu, 16 Nov 2023 03:28:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHIcOMB0JSgLEWjYCwKqh/p/oabxJ7+9I26X5aSBxMMD1u1HUxMMcKxJBMQZRc3RqGkMwIVZg==
X-Received: by 2002:a5d:5987:0:b0:32f:8a45:937f with SMTP id n7-20020a5d5987000000b0032f8a45937fmr1746627wri.2.1700134106654;
        Thu, 16 Nov 2023 03:28:26 -0800 (PST)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id j9-20020a5d6049000000b0032710f5584fsm13320749wrt.25.2023.11.16.03.28.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Nov 2023 03:28:26 -0800 (PST)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Thomas Zimmermann <tzimmermann@suse.de>, deller@gmx.de
Cc: linux-fbdev@vger.kernel.org, Thomas Zimmermann <tzimmermann@suse.de>,
 dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 21/32] fbdev/clps711x-fb: Initialize fb_ops with fbdev
 macros
In-Reply-To: <20231115102954.7102-22-tzimmermann@suse.de>
References: <20231115102954.7102-1-tzimmermann@suse.de>
 <20231115102954.7102-22-tzimmermann@suse.de>
Date: Thu, 16 Nov 2023 12:28:25 +0100
Message-ID: <87v8a22azq.fsf@minerva.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Thomas Zimmermann <tzimmermann@suse.de> writes:

> Initialize the instance of struct fb_ops with fbdev initializer
> macros for framebuffers in I/O address space. Set the read/write,
> draw and mmap callbacks to the correct implementation and avoid
> implicit defaults. Also select the necessary helpers in Kconfig.
>
> The driver previously selected drawing ops for system memory
> although it operates on I/O memory. Fixed now.
>
> Fbdev drivers sometimes rely on the callbacks being NULL for a
> default I/O-memory-based implementation to be invoked; hence
> requiring the I/O helpers to be built in any case. Setting all
> callbacks in all drivers explicitly will allow to make the I/O
> helpers optional. This benefits systems that do not use these
> functions.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

