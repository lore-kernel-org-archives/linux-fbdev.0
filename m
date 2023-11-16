Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NzzNiHUv"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D73F127
	for <linux-fbdev@vger.kernel.org>; Thu, 16 Nov 2023 03:35:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1700134525;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vHuYUuizMOXdym2WVrnt+tzD4LF9VF0OJSRnj/ZZhrU=;
	b=NzzNiHUvrxLWxTMB4yH/AJlyR5lng2ncOhxC3kNmBdgeFen3X23mvgKNHbawkeTXOXHBQV
	pUtz3ynfrUH03pqvx/77t1dtg/e1smLgHbijI4xDPM/XOJL94z/xnHhUlA2b2oVAie8mil
	S3UKfCn5vG/dEmIABQvsGO0gbrlbvLE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-283-mZJmv8wJPUOGu0dL-Prb2w-1; Thu, 16 Nov 2023 06:35:23 -0500
X-MC-Unique: mZJmv8wJPUOGu0dL-Prb2w-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-40a4c765d3bso3332655e9.0
        for <linux-fbdev@vger.kernel.org>; Thu, 16 Nov 2023 03:35:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700134523; x=1700739323;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vHuYUuizMOXdym2WVrnt+tzD4LF9VF0OJSRnj/ZZhrU=;
        b=LtcCM/958JP3k429tH/SBgMm83A3qYJdNUoVBwSp7ebmDmy//ve0IYmEfw7+2/NLdK
         +bJI9ihWk/yIDGe7rcYs3Ev8huUDaQ4PxJg1VbQmdPXLsq8B43Ci59gqoeZlHfeKPaFN
         s0SLgKZ05Ii7nNH6QtZYL/AO67+2DVsz7rliO8m12hSuj15i1RBb6FU4w9BUq8kJvyIj
         +pAlmeRSNcn+6C9hIx5h3M5jDl4Lbqkwbhiz6UR6aGHn0yHYNoHj30msMv69M2UjWZPr
         W6O+1HMFtUmKE3XOt3Ub15NKVOwpsFKKOnXxKLs6yGd8dVhn+Q2f+UduDraJKCpWXqmn
         FwuA==
X-Gm-Message-State: AOJu0YyJ7Ztk5zfllBiKknmlDRNl7zi+aTlzldRqUEK0Q8qwoKh1mIPa
	XeOAmm+g3UuLhrPZd0lo+eiyG/8iaTCKrMD6L9fFVYoz/BTdeMoIUtJ3YzQ6BZ84327tq1tSoMD
	RZKjQdBDsshKkXLxGJvPCgzY=
X-Received: by 2002:a05:600c:1f0e:b0:403:aced:f7f4 with SMTP id bd14-20020a05600c1f0e00b00403acedf7f4mr1397091wmb.12.1700134522814;
        Thu, 16 Nov 2023 03:35:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEXquGc9BBVzhA3pQ5y5VxKkb1ntqSX7uzGlTp88oTbLAi3A8LRxdPbW7vrN8FyN7RKFdG9Uw==
X-Received: by 2002:a05:600c:1f0e:b0:403:aced:f7f4 with SMTP id bd14-20020a05600c1f0e00b00403acedf7f4mr1397075wmb.12.1700134522532;
        Thu, 16 Nov 2023 03:35:22 -0800 (PST)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id v5-20020a05600c470500b0040a5290dceesm3348135wmo.0.2023.11.16.03.35.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Nov 2023 03:35:22 -0800 (PST)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Thomas Zimmermann <tzimmermann@suse.de>, deller@gmx.de
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, Thomas
 Zimmermann <tzimmermann@suse.de>, Russell King <linux@armlinux.org.uk>,
 linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 24/32] fbdev/cyber2000fb: Initialize fb_ops with fbdev
 macros
In-Reply-To: <20231115102954.7102-25-tzimmermann@suse.de>
References: <20231115102954.7102-1-tzimmermann@suse.de>
 <20231115102954.7102-25-tzimmermann@suse.de>
Date: Thu, 16 Nov 2023 12:35:21 +0100
Message-ID: <87msve2ao6.fsf@minerva.mail-host-address-is-not-set>
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
> Fbdev drivers sometimes rely on the callbacks being NULL for a
> default I/O-memory-based implementation to be invoked; hence
> requiring the I/O helpers to be built in any case. Setting all
> callbacks in all drivers explicitly will allow to make the I/O
> helpers optional. This benefits systems that do not use these
> functions.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: linux-arm-kernel@lists.infradead.org
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

