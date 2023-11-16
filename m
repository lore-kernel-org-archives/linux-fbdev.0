Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="it3iQiuG"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6420E1A8
	for <linux-fbdev@vger.kernel.org>; Thu, 16 Nov 2023 02:23:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1700130234;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mZuQXo9gnkbNsHEOB2zSY3qjcWzrlb81dsj8lBIB1oQ=;
	b=it3iQiuGm4SZMuNN1x06MoymumAO2v7tVtX1KgT/EtIlauao4ewsBTgGMu9pZHn4UQyx8P
	3v1siaXSwMPtH54iaCFz56d0Z3+4HHK4a0au15rk3i7t92UkGwnXlizuAOfp33B9TAy3jj
	lqeTkB4jAeJVoPLUaUY4ph+6IPIXVqs=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-594-OVsb0sNvORq8eCqOTFI0Fw-1; Thu, 16 Nov 2023 05:23:53 -0500
X-MC-Unique: OVsb0sNvORq8eCqOTFI0Fw-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4084d0b171eso8747805e9.0
        for <linux-fbdev@vger.kernel.org>; Thu, 16 Nov 2023 02:23:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700130231; x=1700735031;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mZuQXo9gnkbNsHEOB2zSY3qjcWzrlb81dsj8lBIB1oQ=;
        b=UeLorvhCKUChASDR2uYh/BqynYH/l5fKNNw0OX7EA0ta7uk0nz8liX7bYH/KEDJWVO
         iuHrd6tJ5gmjgXSxl0RgZot54SAwFb228VF0j+hucGOdjAHi0X2K8xXbs6X2rAe+9dcx
         mHybBAfXhH6IWZcAODwsKm+/8H3rNLcMaDxn5L2NURkEwhHO4Ij6+HTReKPI4zXRffsD
         VfhEtcGmO2MmCEgw9D4UWOXyVOH66jU/KT7aD5+FRn/HUkSCrWY9lCecSUflgZtJ7uNf
         j4732uqb3oltYEUYAHYeEWAmfOVTUdpobwfBmntPOO9giYAhOwK6zc30yipjHnOZgrEy
         ITrQ==
X-Gm-Message-State: AOJu0YyMj9wh4JmpwL4dsMW5v+vKb4+Rwe/bw/SoJeYM1o7f2DY0x0b4
	kzG6+h/ja+dSdlAHjSgb8RKLFRunnqYhVZKYb4jcV8Dm6YQb60VNsNngwNgK2jkW7HUULbCCNpb
	8l5q08C0pdcXaZnperOJPwK8/YYCv0Dk=
X-Received: by 2002:a05:600c:1906:b0:409:6e0e:e95a with SMTP id j6-20020a05600c190600b004096e0ee95amr1138240wmq.19.1700130231654;
        Thu, 16 Nov 2023 02:23:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEAVDQkmo3j+8iWEwGwvFmLiS/SO/vAfk2hJXFP092iyiMamOm6OHU8ASafyrHF8vMvPKAMmg==
X-Received: by 2002:a05:600c:1906:b0:409:6e0e:e95a with SMTP id j6-20020a05600c190600b004096e0ee95amr1138222wmq.19.1700130231264;
        Thu, 16 Nov 2023 02:23:51 -0800 (PST)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id u5-20020a05600c138500b003fee6e170f9sm2986310wmf.45.2023.11.16.02.23.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Nov 2023 02:23:51 -0800 (PST)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Thomas Zimmermann <tzimmermann@suse.de>, deller@gmx.de
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, Thomas
 Zimmermann <tzimmermann@suse.de>, Miguel Ojeda <ojeda@kernel.org>, Robin
 van der Gracht <robin@protonic.nl>
Subject: Re: [PATCH 10/32] auxdisplay/ht16k33: Initialize fb_ops with fbdev
 macros
In-Reply-To: <20231115102954.7102-11-tzimmermann@suse.de>
References: <20231115102954.7102-1-tzimmermann@suse.de>
 <20231115102954.7102-11-tzimmermann@suse.de>
Date: Thu, 16 Nov 2023 11:23:50 +0100
Message-ID: <87r0kq3sjt.fsf@minerva.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Thomas Zimmermann <tzimmermann@suse.de> writes:

> Initialize the instance of struct fb_ops with fbdev initializer
> macros for framebuffers in virtual address space. Set the read/write,
> draw and mmap callbacks to the correct implementation and avoid
> implicit defaults. Also select the necessary helpers in Kconfig.
>
> Fbdev drivers sometimes rely on the callbacks being NULL for a
> default I/O-memory-based implementation to be invoked; hence
> requiring the I/O helpers to be built in any case. Setting all
> callbacks in all drivers explicitly will allow to make the I/O
> helpers optional. This benefits systems that do not use these
> functions.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: Miguel Ojeda <ojeda@kernel.org>
> Cc: Robin van der Gracht <robin@protonic.nl>
> ---
>  drivers/auxdisplay/Kconfig   | 5 +----
>  drivers/auxdisplay/ht16k33.c | 7 ++-----
>  2 files changed, 3 insertions(+), 9 deletions(-)
>

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

