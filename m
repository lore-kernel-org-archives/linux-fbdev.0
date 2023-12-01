Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VZk6Fes+"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E6C71713
	for <linux-fbdev@vger.kernel.org>; Fri,  1 Dec 2023 00:55:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701420950;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7FboWkjzC+XEr3tqHBpbn40rzt87gmx7n3Z3iOLEN/w=;
	b=VZk6Fes++YHAPBqbFXpS+TSB45rlZiLslw+S7GvSid1pke9bMvOTHJr/L9TdL42wfkGTzb
	QtaoGDSyUFYehWadhn2Oe4fo5DUUn+eIpqUEGh0jtz32D6xyVqZRBk6SG/8qitgUhQe7pO
	Nqj+1Qo7Pwb7s7c7UCwNwiiViDEpzZs=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-484-DSJwQ8qCMwecozejWNVOWQ-1; Fri, 01 Dec 2023 03:55:49 -0500
X-MC-Unique: DSJwQ8qCMwecozejWNVOWQ-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-40b52a1f56dso12188835e9.1
        for <linux-fbdev@vger.kernel.org>; Fri, 01 Dec 2023 00:55:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701420948; x=1702025748;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7FboWkjzC+XEr3tqHBpbn40rzt87gmx7n3Z3iOLEN/w=;
        b=eervXg/PnIISSR7Bwk0vMlZQBUFpMDtKOqEqxMpxJo7Bc9CkQvpCKpn7oj+j7M9Fdc
         5EpaG0gRg2/X0FFs0d2qcgPuSV360Riypv3I97x/noE0TfHGUad9DSUCDO7BV/7crVmq
         40bn3TkyQupqApzqRu1hO7sb5JJJ/yxGsHuNu4t9Keo7A/avyvi3j1TrwSowih1Mhx9N
         NV2nDj0hwFwiiK5mi2VBieFplNtM3EZcZUdD5a++PanxcCzx4whocWamyZU9bWG20mbc
         sU+mRo44ovQ3tX0k8547MYKK4LaQx/FIZZIOEHcmWi61hCo0KiUApXFXCcSqYODMAzqe
         jdvA==
X-Gm-Message-State: AOJu0YyXEKazjW2YzLNvkf5z0sqjkMmrezXDLbNS7gqFywkicNTltnHv
	NSap0hNWIanTISMkdXjTosVyLGXSRo2NdF86tab0KktSO2Z6y27NG3wk9xShoaJyom1Lu1Ijpsj
	+eGMSehUO9xA3HilGkyjnb2E=
X-Received: by 2002:a05:600c:1d0a:b0:40b:5e26:2386 with SMTP id l10-20020a05600c1d0a00b0040b5e262386mr452204wms.55.1701420948353;
        Fri, 01 Dec 2023 00:55:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFoi4moS+jvnBF+9D0n2hMCl1cGAFj+B8S0b/YU8hBrPaYnPay/t502w4csLY4P6e9uigE5fw==
X-Received: by 2002:a05:600c:1d0a:b0:40b:5e26:2386 with SMTP id l10-20020a05600c1d0a00b0040b5e262386mr452198wms.55.1701420948050;
        Fri, 01 Dec 2023 00:55:48 -0800 (PST)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id i1-20020a05600c354100b0040588d85b3asm8290967wmq.15.2023.12.01.00.55.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 00:55:47 -0800 (PST)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Thomas Zimmermann <tzimmermann@suse.de>, deller@gmx.de, pjones@redhat.com
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, Thomas
 Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH 4/4] fbdev/vesafb: Use screen_info pointer from device
In-Reply-To: <20231129155218.3475-5-tzimmermann@suse.de>
References: <20231129155218.3475-1-tzimmermann@suse.de>
 <20231129155218.3475-5-tzimmermann@suse.de>
Date: Fri, 01 Dec 2023 09:55:47 +0100
Message-ID: <87plzql2ss.fsf@minerva.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Thomas Zimmermann <tzimmermann@suse.de> writes:

> Use the screen_info instance from the device instead of dereferencing
> the global screen_info state. Decouples the driver from per-architecture
> code. Duplicated the screen_info data, so that vesafb can modify it at
> will.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---

Same comments that in patch #2. But regardless:

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

