Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W8wK7+LB"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00A04173E
	for <linux-fbdev@vger.kernel.org>; Fri,  1 Dec 2023 00:54:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701420852;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4Pbr1Dv1dvhQFSASepFeXXLAmwvC8VYXypnppxj7crc=;
	b=W8wK7+LBTBEa8LkFPS5coT5sQNJNN3BDRFw+/juwKy97oPjlFGTEh2LqUPoWsoQa9NR3uB
	PH5Y2Zq3+mDH3nQQl9bRoYO6fq16XuFyMSpBMgR2Fp6XlEq/SSPCGE9x0U/K7TUC7HdKzj
	WTy6Oh9QdBFc3yP8zjsE8Rfuz7xKZ5A=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-463-qb4rrWWnPMa9SMlIplS3Jw-1; Fri, 01 Dec 2023 03:54:10 -0500
X-MC-Unique: qb4rrWWnPMa9SMlIplS3Jw-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-332e61e2480so1587057f8f.0
        for <linux-fbdev@vger.kernel.org>; Fri, 01 Dec 2023 00:54:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701420850; x=1702025650;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4Pbr1Dv1dvhQFSASepFeXXLAmwvC8VYXypnppxj7crc=;
        b=mnbvF+yp7hzoWtrZl5THd7Y5Yya2BXsn9fwG8pE7rCONv7c69xbIVaeJkT9qwZ3hTD
         p6Wq4vdRXWxU4t0AIQ/oZ1EJfLolx7NKQWemBOYLSIAQuS8B5o+PZQSUw4a4g+D2z/7o
         YLAG2ZuM0+cvAsYawTbADPP7w4xgj32ojCEDNW1lPCpnNL5KvpMz2J9Lf9w8xFzJt/mL
         ziS5C/MCEb2YVTQJ3qazZKfynzrWNpbC3NuYvqIm4FQbSEsNRHxFHVrQO30yndpmWf1o
         AUpK01KlIHGxmmqW+3nGDr43LnuDargrtZs+vqG7agdUNdrNz9j4co3waeASDmIB9ETC
         9xoA==
X-Gm-Message-State: AOJu0YxPKByUDVm28wZN7Zj6C6oXV5aTPLxgNjYUsCo5aLigDjfJROPV
	dUd/zz5KP7TSJXZx8TgmIeKNu5mReP41w/FxV39xyIAQDaq3PACeWwcQEWvikNDu1G2vGKjbNfs
	KgGn4p0DP08rTPudq0AZH8gE=
X-Received: by 2002:a05:600c:198d:b0:40b:5e21:bdc6 with SMTP id t13-20020a05600c198d00b0040b5e21bdc6mr219057wmq.85.1701420849843;
        Fri, 01 Dec 2023 00:54:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG+m+mUUxd+MdEV6NuzsUIPWLqYPAU1I5t3ON2imSsU+wNGGrRr0d8jVur/P8FuaIggJYX+HA==
X-Received: by 2002:a05:600c:198d:b0:40b:5e21:bdc6 with SMTP id t13-20020a05600c198d00b0040b5e21bdc6mr219051wmq.85.1701420849516;
        Fri, 01 Dec 2023 00:54:09 -0800 (PST)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id p5-20020a5d4585000000b0033314c63881sm3659797wrq.22.2023.12.01.00.54.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 00:54:09 -0800 (PST)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Thomas Zimmermann <tzimmermann@suse.de>, deller@gmx.de, pjones@redhat.com
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, Thomas
 Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH 2/4] fbdev/efifb: Use screen_info pointer from device
In-Reply-To: <20231129155218.3475-3-tzimmermann@suse.de>
References: <20231129155218.3475-1-tzimmermann@suse.de>
 <20231129155218.3475-3-tzimmermann@suse.de>
Date: Fri, 01 Dec 2023 09:54:08 +0100
Message-ID: <87v89il2vj.fsf@minerva.mail-host-address-is-not-set>
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
> code. Duplicated the screen_info data, so that efifb can modify it at
> will.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---

[...]

> +	si = dev_get_platdata(&dev->dev);
> +	if (!si)

I would add a comment that this platform data is set when the device is
registered by sysfb.

> +		return -ENODEV;
> +	si = devm_kmemdup(&dev->dev, si, sizeof(*si), GFP_KERNEL);
> +	if (!si)
> +		return -ENOMEM;
> +

Why a copy? In any case maybe the global screen_info should be duplicated
when is set as the device platform data in sysfb_init() ?

I agree with the direction of the patch though, so whatever you decide:

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

