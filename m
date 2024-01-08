Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B38BA1170B
	for <linux-fbdev@vger.kernel.org>; Mon,  8 Jan 2024 09:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ci3sW0DC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704706051;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zUbxtUWHK+UVvc38nQ4ZugcC7K2U909xpxfpjqV/w1A=;
	b=ci3sW0DC3u6eQea0p4Vh6TKysN/wUfeSUOH3tEP//UFucm2JY+7Op8c5clf11nqI1K4PoG
	ofcg2di2CRWR+hfGaj02HS7nU1f2/GaG/YoqQ+/nXzxB2Poj2HDWXbuY4NKYn3j1JWnOfD
	hyyIeGRH5l4OTPBsST/6XeGi9/UF52I=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-227-ReXA0qFTOguhV2Q5Pbiwfg-1; Mon, 08 Jan 2024 04:27:29 -0500
X-MC-Unique: ReXA0qFTOguhV2Q5Pbiwfg-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-40e43889bbcso8322725e9.3
        for <linux-fbdev@vger.kernel.org>; Mon, 08 Jan 2024 01:27:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704706048; x=1705310848;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zUbxtUWHK+UVvc38nQ4ZugcC7K2U909xpxfpjqV/w1A=;
        b=f+7AtP2FiVu7f1tYWB4sANOmJmRnXcut1VIPbrSd2avLCA1qBC5KFCMNpEOFnnu/R1
         8mZygybQbXIkB9qdtWR3OQyZFkHGC2iZZxPgN3yNdtJUZ8csdVWTYpexN4wuj286LF35
         CbnnhnVZym6OcycQwD1cwh0r0gv+5PGSElGZveQeNxjlQRsmuOuvZVbOxxoDIupTq7tZ
         SULmdCdnlTrOZZydRXMGSmDGRJfU2Ann2aDX7QjDB25gjmL+Uf0hwYjO4A2uqKNP2s/F
         H3skClzuGvze0e9E0u1QeYzSHMUYPcMlukHki4vQkufzpQX/2RY3Q+BdNVFbp+rRaVRz
         /USg==
X-Gm-Message-State: AOJu0YxcLLTvtI5tRDKxvalLTQKmLnKFcQSKsvPr8Cix5s+P9PNBnfwl
	yWL07Yaul/MFkpMXZFJDTljHIVjUJ9e5yrpmmBqm7ffZUygwyK/eoQxGCFJbq4S1WsvDbz1OQNL
	29T0jcP/rZfDOjR/PoydxAg3H6o8qIFc=
X-Received: by 2002:a05:600c:3b14:b0:40d:5cd1:1786 with SMTP id m20-20020a05600c3b1400b0040d5cd11786mr1571515wms.174.1704706048551;
        Mon, 08 Jan 2024 01:27:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEJwTzEktgmk13wBG4wM5BWE4ZTFCnOS+vrwmv7XAHVX+yfsAAMJxd3rfnXO3a3bF11iERhJA==
X-Received: by 2002:a05:600c:3b14:b0:40d:5cd1:1786 with SMTP id m20-20020a05600c3b1400b0040d5cd11786mr1571507wms.174.1704706048095;
        Mon, 08 Jan 2024 01:27:28 -0800 (PST)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id g11-20020a05600c4ecb00b0040d2d33312csm10353376wmq.2.2024.01.08.01.27.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jan 2024 01:27:27 -0800 (PST)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Thomas Zimmermann <tzimmermann@suse.de>, drawat.floss@gmail.com,
 deller@gmx.de, decui@microsoft.com, wei.liu@kernel.org,
 haiyangz@microsoft.com, kys@microsoft.com, daniel@ffwll.ch,
 airlied@gmail.com
Cc: linux-hyperv@vger.kernel.org, linux-fbdev@vger.kernel.org,
 dri-devel@lists.freedesktop.org, Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH 2/4] fbdev/hyperv_fb: Remove firmware framebuffers with
 aperture helpers
In-Reply-To: <20240103102640.31751-3-tzimmermann@suse.de>
References: <20240103102640.31751-1-tzimmermann@suse.de>
 <20240103102640.31751-3-tzimmermann@suse.de>
Date: Mon, 08 Jan 2024 10:27:27 +0100
Message-ID: <877ckkdvk0.fsf@minerva.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Thomas Zimmermann <tzimmermann@suse.de> writes:

> Replace use of screen_info state with the correct interfaces from
> the aperture helpers. The state is only for architecture and firmware
> code. It is not guaranteed to contain valid data. Drivers are thus
> not allowed to use it.
>
> For removing conflicting firmware framebuffers, there are aperture
> helpers. Hence replace screen_info with the correct functions that will
> remove conflicting framebuffers for the hypervfb driver. For GEN1 PCI
> devices, the driver reads the framebuffer base and size from the PCI
> BAR, and uses the range for removing the firmware framebuffer. For
> GEN2 VMBUS devices no range can be detected, so the driver clears all
> firmware framebuffers.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

