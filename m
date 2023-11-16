Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UlpZ6oxs"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B4351B2
	for <linux-fbdev@vger.kernel.org>; Thu, 16 Nov 2023 02:47:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1700131636;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5yEL/wD+StFyQC4s/cL+meHosD/qpqp38NWuT149SCc=;
	b=UlpZ6oxszHQpCnk/lAcxuvwq6+zaokOnj5Ce2WUUz6Iv3xRBkssusfRs+fI6oVho1GWtK2
	zeSa4NDfpiw25Z/mJZXPvsfdTU5s1VUp2fIjokONa+kSTax4OtbuSUld3jl6QoBnvibP30
	RogrxrZrmvqD/kDeC7jI1tlZBnnPu2c=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-481-1UT_nxdfNeynXvBwwlhrPw-1; Thu, 16 Nov 2023 05:47:15 -0500
X-MC-Unique: 1UT_nxdfNeynXvBwwlhrPw-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-32f7cf9c33bso330788f8f.3
        for <linux-fbdev@vger.kernel.org>; Thu, 16 Nov 2023 02:47:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700131634; x=1700736434;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5yEL/wD+StFyQC4s/cL+meHosD/qpqp38NWuT149SCc=;
        b=RdrK4+Q4Ps33OnUXLJ7G6IqbXDC5J1rYk/90jm+qyn/4UR+SdTpTr6nIA6hIs8pdDG
         wUv6Fqr4yQ/OiIKJbrJaTPAXh4/vaokBaMATmnRp9hzxA1zS1u3Ue2nQ3RrACeG1NfX2
         M1oiWlTBKbuXiwyDuO/8faqiErFI5TOZzFTDvbHzApqE393WhKMJv7XD2UtRfveLMg9E
         VXw8gRTBz1nr4YLL0ZFWM0qNwpLysVVFXgUWfL5noKJ3Y1uCyKSyBU0N+q1rlJImf5xK
         ewPb6yHYmEaY0jSFOsx7U8wDCOdU3eWGxWFk/xcR4q92sFS0ymy7v88y+HTFmmd6/Tuc
         C5bA==
X-Gm-Message-State: AOJu0Yx/WVsCj+cOAMFTT2kf9u6zlRSJqX/7GPQ0nbyKU2VtZO7wKUEg
	mCSShh7PBWBIbBKggOpeZamnkxSCOrhspzRyTH+hwwjBbqS4UXWTrSM4YiuRRbW6svZkxRD+glH
	ufu5EeUSsCAuN7GjP8vSMCK1wNQMb+8s=
X-Received: by 2002:adf:e7cf:0:b0:31a:ed75:75df with SMTP id e15-20020adfe7cf000000b0031aed7575dfmr1513877wrn.15.1700131633890;
        Thu, 16 Nov 2023 02:47:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH8kXOyrbe6taaoWMuPRfW9sBNT0Ia7lg9iWuHQ6Z1tP0kTNiN7tYGMJGRRPFJbBjvV3DMVbA==
X-Received: by 2002:adf:e7cf:0:b0:31a:ed75:75df with SMTP id e15-20020adfe7cf000000b0031aed7575dfmr1513872wrn.15.1700131633719;
        Thu, 16 Nov 2023 02:47:13 -0800 (PST)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id j12-20020adfea4c000000b0031f82743e25sm13128518wrn.67.2023.11.16.02.47.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Nov 2023 02:47:13 -0800 (PST)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Thomas Zimmermann <tzimmermann@suse.de>, deller@gmx.de
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, Thomas
 Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH 16/32] fbdev/au1200fb: Set FBINFO_VIRTFB flag
In-Reply-To: <20231115102954.7102-17-tzimmermann@suse.de>
References: <20231115102954.7102-1-tzimmermann@suse.de>
 <20231115102954.7102-17-tzimmermann@suse.de>
Date: Thu, 16 Nov 2023 11:47:12 +0100
Message-ID: <87a5re3rgv.fsf@minerva.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Thomas Zimmermann <tzimmermann@suse.de> writes:

> The au1200fb driver operates on DMA-able system memory. Mark the
> framebuffer accordingly. Helpers operating on the framebuffer memory
> will test for the presence of this flag.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

