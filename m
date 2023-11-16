Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FYHURmUo"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A634B8
	for <linux-fbdev@vger.kernel.org>; Thu, 16 Nov 2023 02:46:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1700131602;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+mneAN+O3HdG8FQxpQR7zP/PBFf56Dx1XY7777+VaPU=;
	b=FYHURmUoasuKrEPkxTvyls3xK4h/Vy2qB48xMkW3EWxNkGiAktbaqXFIZiYfOWLQRqDrkp
	Z7MLv1OfAF0k4ZffEUu/dMXGrDkf1EaErvShe84SG0r7+AO38KXSxHFx38vY8FrrV8AaxZ
	k88MYKKX9PTO1PIPvliZxW+7e0efQ5k=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-397-N1b_dXF9NsmzkM7G2u0ulw-1; Thu, 16 Nov 2023 05:46:40 -0500
X-MC-Unique: N1b_dXF9NsmzkM7G2u0ulw-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-408534c3ec7so3700325e9.1
        for <linux-fbdev@vger.kernel.org>; Thu, 16 Nov 2023 02:46:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700131600; x=1700736400;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+mneAN+O3HdG8FQxpQR7zP/PBFf56Dx1XY7777+VaPU=;
        b=fV73lve9/AKRlcjHyJtfmGu3J1xil3fQZ7m3ANeAYfqNqW1UdUIQkHOZWWHNx7oXhK
         IGhqZqShHDNiilddJtCqIUXBGaK6RUoBLrSkg7NuNHKB3vbIe839yeGMM903zKMykkcS
         v23c5mrK5GZLazYs2Ozc0GKdYsuC3v7Y8luTFUravNEvZU36md3729jTDHdKbsqg7000
         ySeXhSg3vWVqBhQ9CBBfQQyCz7MaCYmZ0smOr0BmuvoBqOW10arWa7zXLMnA8vCX/6dU
         w3G3zkQWxSpSHEnNmnSeghgpwjxWoW6aPWloio7ECfkxXnjrSICKB/BfzCnoBVFgKDDh
         0B5w==
X-Gm-Message-State: AOJu0YwLoSQWQnF1p6hE/OZZ/eRwXnJ1R/64PX4G08fTQhpO+g929MVb
	WbccE0ZKdQYjpFFhJKYpSstvXWQR00fVfCK5haRVIWg+ANo2YsnD9okrKX1CHW6EbTReKeXyK6K
	GqBHflQ5PRkz/iBuT2acWz38=
X-Received: by 2002:a05:600c:2d8b:b0:406:4573:81d2 with SMTP id i11-20020a05600c2d8b00b00406457381d2mr13142562wmg.39.1700131599914;
        Thu, 16 Nov 2023 02:46:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEJvM8rhQKzWrZoagRxIFnr0SKSWCA5gH5y63+vsVbbw01jWkd/7p2tTGbqEixDkcdZKgAwmg==
X-Received: by 2002:a05:600c:2d8b:b0:406:4573:81d2 with SMTP id i11-20020a05600c2d8b00b00406457381d2mr13142547wmg.39.1700131599624;
        Thu, 16 Nov 2023 02:46:39 -0800 (PST)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id q9-20020a05600c330900b0040a3f9862e3sm2812796wmp.1.2023.11.16.02.46.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Nov 2023 02:46:39 -0800 (PST)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Thomas Zimmermann <tzimmermann@suse.de>, deller@gmx.de
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, Thomas
 Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH 14/32] fbdev/smscufx: Select correct helpers
In-Reply-To: <20231115102954.7102-15-tzimmermann@suse.de>
References: <20231115102954.7102-1-tzimmermann@suse.de>
 <20231115102954.7102-15-tzimmermann@suse.de>
Date: Thu, 16 Nov 2023 11:46:38 +0100
Message-ID: <87fs163rht.fsf@minerva.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Thomas Zimmermann <tzimmermann@suse.de> writes:

> The driver uses deferred I/O. Select the correct helpers via
> FB_SYSMEM_HELPERS_DEFERRED in the Kconfig file.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

