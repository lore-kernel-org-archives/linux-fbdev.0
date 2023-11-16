Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cqY6Wsb8"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D03EC1AB
	for <linux-fbdev@vger.kernel.org>; Thu, 16 Nov 2023 02:45:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1700131516;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ekjp6Qw4GqreWi+hdESCK5ioDUqlNBXiY58gfjfFY0g=;
	b=cqY6Wsb8qqCZ91GEnmDXXhiSF+aB74MVGCk0J8CimJvnjrml05hUm/Rdgkd8NBxrxgQSPd
	Jnj/NlUBHaMqQQ+lTcqiwicMri2phYJjKXZbAzn2W+hJeb/FSMKDm3qtw01t4jQn3Yq58C
	trstWXzCVlX6bSQgW19b1pz8//X6rcM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-444-zVvv6SXiOM6ZHtqLSstdSA-1; Thu, 16 Nov 2023 05:45:14 -0500
X-MC-Unique: zVvv6SXiOM6ZHtqLSstdSA-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4092164eceeso3700715e9.2
        for <linux-fbdev@vger.kernel.org>; Thu, 16 Nov 2023 02:45:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700131512; x=1700736312;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ekjp6Qw4GqreWi+hdESCK5ioDUqlNBXiY58gfjfFY0g=;
        b=Uf6Xefm8QYCAe89HbMKTFh88ZdYXWPAO9lr4BznVD2x60ioIUkrOWSnY7hX8ztoqSf
         kN0Rkb8tcrfer/+HMlniJOuz6jnOtU0yzcqp2dE38RVpy9g+x29uE3Ue/ZESwixS/yUW
         xcn17jOAo1ikQlPnrbLJ8gvs5+b93eRVau9R1YWRtd1U6AoM4j+bC4FECo+BYR5Wl0el
         xIAaNKMBUREje5eAkF+SGne1ISQi2SURuBsmCuM9zGU+iMb3gngka07ep4zKE95zZv7E
         lCBnbCeJOLjGXKeWm897fA/w2CGwZ/2xW6Ox7ZX1cOetLgxXXEcKpvW7h0W9dDH/q8eR
         u7MA==
X-Gm-Message-State: AOJu0Yz1iP0Ay9JeIznGoGXrtbNKJRPKyMBY5dyjGz2azSypQoV9zFk/
	QdkV1WtlHpFhQbGINcs3NzVAVCqoaZPJChPnEnXCOzEZM2lymHEpxryfwEQpBbgdeaM+HjSSUPs
	RCJkRp8yyCCEttu+R9/ehPuH31ZIKya0=
X-Received: by 2002:a05:600c:602a:b0:405:3ae6:2413 with SMTP id az42-20020a05600c602a00b004053ae62413mr11953377wmb.25.1700131512671;
        Thu, 16 Nov 2023 02:45:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGAq3MAO+9d9bKj+7E5Zz+JyoZGWlumRiADKSViRJXoB8t+ePziwl5543tthNcB39pcWIUaYQ==
X-Received: by 2002:a05:600c:602a:b0:405:3ae6:2413 with SMTP id az42-20020a05600c602a00b004053ae62413mr11953365wmb.25.1700131512320;
        Thu, 16 Nov 2023 02:45:12 -0800 (PST)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id m10-20020a05600c4f4a00b00407460234f9sm3097588wmq.21.2023.11.16.02.45.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Nov 2023 02:45:12 -0800 (PST)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Thomas Zimmermann <tzimmermann@suse.de>, deller@gmx.de
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, Thomas
 Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH 13/32] fbdev/sh_mobile_lcdcfb: Initialize fb_ops with
 fbdev macros
In-Reply-To: <20231115102954.7102-14-tzimmermann@suse.de>
References: <20231115102954.7102-1-tzimmermann@suse.de>
 <20231115102954.7102-14-tzimmermann@suse.de>
Date: Thu, 16 Nov 2023 11:45:11 +0100
Message-ID: <87il623rk8.fsf@minerva.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Thomas Zimmermann <tzimmermann@suse.de> writes:

> Initialize the instance of struct fb_ops with fbdev initializer
> macros for framebuffers in DMA-able virtual address space. Set the
> read/write, draw and mmap callbacks to the correct implementation
> and avoid implicit defaults. Also select the necessary helpers in
> Kconfig.
>
> The driver uses a mixture of DMA helpers and deferred I/O. That
> probably needs fixing by a driver maintainer.
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

