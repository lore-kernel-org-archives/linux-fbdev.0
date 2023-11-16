Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gjywyrj8"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E47611AE
	for <linux-fbdev@vger.kernel.org>; Thu, 16 Nov 2023 02:53:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1700132013;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tuX86pnoqOc9Lm4Xg+0oGA/Hd0KoSUsDWQB7iIHvV00=;
	b=gjywyrj8hvJx6px8JYsBAtgV4baarzZpYIaolmPmXdtyylTRTY3NY5NECgBfhJIQZ50CLG
	B1yHXaJwQDCwEW1Gi7ZCn3io9ewg8ek4eQU2VzwE62wAQwDxqSPhIW+d1i97iL/eQTw/y7
	JJKvHt7yGKG/uXTO7YfcoqXLXCoSNSc=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-144-4nupMvgjPRWb0LBxL4CT1w-1; Thu, 16 Nov 2023 05:53:31 -0500
X-MC-Unique: 4nupMvgjPRWb0LBxL4CT1w-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-408374a3d6bso3479995e9.0
        for <linux-fbdev@vger.kernel.org>; Thu, 16 Nov 2023 02:53:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700132010; x=1700736810;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tuX86pnoqOc9Lm4Xg+0oGA/Hd0KoSUsDWQB7iIHvV00=;
        b=KalR44t3z7I41vxMruv1eWR9n+XbXAXNbtQa7RWLw6uLggzB5cNcJXNvyuQiAq/6u4
         WMSBQfGouNqqxle2bBhLRXIUAugvo5bZbzwRYa3fiMUDmEDE42rINxjJSHRaZ6p2J4YN
         zS2NWioMPD3Bj61VPzmPj9uBkskR1HX+iWLu29KibNb4DliEl4KTmvCTdjdgSXRrpFW0
         s5D6QZAC/qgp0G6Modwm4e4lLqRBlsUSk8CiROJCEax/BIUjE3yNrEft72TC0+cJ8pmE
         DJhAwWmj9VqmlvncsoCG3L9bZQj2ZgBeO35WommoZDpWJl9XJawCPaqbn2aC0ekF2+VV
         6a+w==
X-Gm-Message-State: AOJu0Yy/b8gjkhUlEuo8Oroiq39NZ0wdyyhi8SGqIterVEH+5xL5/UcH
	PlN3lKe6U4OQF5ap0BkC/s/4/NK0wNYU8z7avSkl5wqyx0CkPq7mNdX2VP2UcCjxFS6EXFNnI3v
	K8eZMgMVHV+hDcOxqE6OMIro=
X-Received: by 2002:a05:600c:524c:b0:3fd:2e89:31bd with SMTP id fc12-20020a05600c524c00b003fd2e8931bdmr1701737wmb.14.1700132010303;
        Thu, 16 Nov 2023 02:53:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGxYqt6JEW+U1HNFI57UlEcmFdgsubjyvb53Do4Fx+Au2XkUvyLPoKV7okM0NVKFoXjgldOnw==
X-Received: by 2002:a05:600c:524c:b0:3fd:2e89:31bd with SMTP id fc12-20020a05600c524c00b003fd2e8931bdmr1701718wmb.14.1700132009917;
        Thu, 16 Nov 2023 02:53:29 -0800 (PST)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id s9-20020a05600c45c900b0040651505684sm3086548wmo.29.2023.11.16.02.53.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Nov 2023 02:53:29 -0800 (PST)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Thomas Zimmermann <tzimmermann@suse.de>, deller@gmx.de
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, Thomas
 Zimmermann <tzimmermann@suse.de>, Michael Ellerman <mpe@ellerman.id.au>,
 Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy
 <christophe.leroy@csgroup.eu>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 19/32] fbdev/ps3fb: Initialize fb_ops with fbdev macros
In-Reply-To: <20231115102954.7102-20-tzimmermann@suse.de>
References: <20231115102954.7102-1-tzimmermann@suse.de>
 <20231115102954.7102-20-tzimmermann@suse.de>
Date: Thu, 16 Nov 2023 11:53:29 +0100
Message-ID: <871qcq3r6e.fsf@minerva.mail-host-address-is-not-set>
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
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Nicholas Piggin <npiggin@gmail.com>
> Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
> Cc: linuxppc-dev@lists.ozlabs.org
> ---
>  drivers/video/fbdev/Kconfig | 5 +----
>  drivers/video/fbdev/ps3fb.c | 7 ++-----
>  2 files changed, 3 insertions(+), 9 deletions(-)
>

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

