Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Hi0obuai"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACA41B0
	for <linux-fbdev@vger.kernel.org>; Thu, 16 Nov 2023 03:57:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1700135870;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VPqGFXVhoOJAOGmkOh+AVOaUjN8gAwNLcy8Vd+Rk03g=;
	b=Hi0obuaiSoFU5adR0AvrnKGZ7lgc0OG+1TS4MN/XTbtxDN/dLuIFEv4MMz9L1mZ3dZE5AG
	7dLiiJUIvJ2HmkcBFmDW90ogoYV6SKqGlz1N1MEFAaq/0//wG+Ta4a1ES9Q52TPEtAaXCa
	AFNDXHXKoabsqMR5UbEegs9XqFrp2Lw=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-606-VdXhv2ZuMpGXwlZ-Nq4T9g-1; Thu, 16 Nov 2023 06:57:49 -0500
X-MC-Unique: VdXhv2ZuMpGXwlZ-Nq4T9g-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-32f798bc811so358050f8f.1
        for <linux-fbdev@vger.kernel.org>; Thu, 16 Nov 2023 03:57:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700135868; x=1700740668;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VPqGFXVhoOJAOGmkOh+AVOaUjN8gAwNLcy8Vd+Rk03g=;
        b=gnAIgwi3I3s3OEi3SSl44VcZlN5j6tGeHPKq2ltlcdoPBUFXRc+oKDDpF/5+kF0waG
         BrB+/NqmprsJfr1jihB8tqAyWUr+bQBn/HRAqArqEjD5hdMYgASpR6890PDEswEVcbO8
         9Ea0IFOEMwciHkJA6SprFZq4mUen1VtWKSM7bO46Y/TSlxKzuwnLqzzmTME8+GFpbKyR
         MV7Fa6W0y6/YUV1SDSpAi1Qflpfs8VnmyFOyy6+VatMcYVRCDlXoGuggN6lWI+I6t93F
         +JTdy87yf39O19MIEYxP+4WZp8HmJxm+hE5U/PAZtvxjhHxrOhtro+gmElbshqffiKv7
         PuKw==
X-Gm-Message-State: AOJu0YwKeasu46lLIGIsX8bfHzfw19WHrh/FfBQ6P18gTz/XH/3JlB03
	w8kAdZujOBP131eLBhFLr3qyOcIA8pAtw2Pkby6UXSjHWSAH3k7pp1uUxJ3/qlaXrRxgzLyILSy
	55QxDSLM3andDQe5EIJruW7U=
X-Received: by 2002:a05:6000:2c1:b0:32f:7d50:267e with SMTP id o1-20020a05600002c100b0032f7d50267emr15968016wry.9.1700135868660;
        Thu, 16 Nov 2023 03:57:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFSgGBwWSGgKgB90lpexnyrsMqam+5f5ZdNROWqRD1U0tE9001rNzCx3BSnj2QBkH6SdjRCWw==
X-Received: by 2002:a05:6000:2c1:b0:32f:7d50:267e with SMTP id o1-20020a05600002c100b0032f7d50267emr15967998wry.9.1700135868352;
        Thu, 16 Nov 2023 03:57:48 -0800 (PST)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id e17-20020adfe391000000b0032fb7b4f191sm13384655wrm.91.2023.11.16.03.57.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Nov 2023 03:57:48 -0800 (PST)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Thomas Zimmermann <tzimmermann@suse.de>, deller@gmx.de
Cc: linux-fbdev@vger.kernel.org, Thomas Zimmermann <tzimmermann@suse.de>,
 dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 28/32] fbdev: Remove trailing whitespaces
In-Reply-To: <20231115102954.7102-29-tzimmermann@suse.de>
References: <20231115102954.7102-1-tzimmermann@suse.de>
 <20231115102954.7102-29-tzimmermann@suse.de>
Date: Thu, 16 Nov 2023 12:57:47 +0100
Message-ID: <87edgp3o78.fsf@minerva.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Thomas Zimmermann <tzimmermann@suse.de> writes:

> Fix coding style. No functional changes.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

