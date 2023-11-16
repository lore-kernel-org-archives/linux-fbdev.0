Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LrButUDL"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A678187
	for <linux-fbdev@vger.kernel.org>; Thu, 16 Nov 2023 04:05:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1700136352;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WOSU9nPcc5buhfeYjOi7yXkwoaqROWwqoyQZ/1RMnoc=;
	b=LrButUDLlYX8Q7w4fnl6sLx0JNzekqevsQkl9N+USh4l/Uax2S/8ovx/Zmk0/nMwqxCR7j
	MtiEUvGXu9XIE6+QVghe2oiBlA1FBCR7qBsMvgkLt+DrXDpq5vBvlZPl/ZefYwLm0PIBb9
	6c0fVlKD9PIM7DAiy433wW5GcFClXhU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-562-51-oezCsMYC7yiSE88fFMA-1; Thu, 16 Nov 2023 07:05:49 -0500
X-MC-Unique: 51-oezCsMYC7yiSE88fFMA-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4093a561f7eso4042765e9.3
        for <linux-fbdev@vger.kernel.org>; Thu, 16 Nov 2023 04:05:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700136348; x=1700741148;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WOSU9nPcc5buhfeYjOi7yXkwoaqROWwqoyQZ/1RMnoc=;
        b=UlMK/XVQxs6z/TqepC+uGFxCt5Ij/yJwkzXpKFAJN1HLmgJRClIMdKrVdWLHKxqyYG
         ErgKcDyaYOB5Fsos6gKze9eFjzRbXBagAHZcqYECGiY5BDwXIP+n9Zzo7r0BWpYEsdKg
         Z8E5c5PKR/AqaRpk5Rg8j/fJ3pWA51sZacXP8Gkwgm4BG//0hmVde59SexZoZQ1s/Q+v
         oZxzD3vd31LogX/694DxvsZNOD1bKQDnSd4IffZyoIeCj8U67lqwPy7QMB1D6PyJAzJH
         iMNiuqPx6zxwPO+8Z/uYZyWJocfnvWx8bTQDI8injerIVPqHylZJqqk6pPBRF02Fclru
         nAog==
X-Gm-Message-State: AOJu0YywDpcXspx6KM8Ci8iQT4FFiAdTK3zkO6JoDAiaThv8QFnkR5XV
	SGBAw1eoAtliuxnhl71SlHi/k/qJfiu28nQbx/J/9SxS3xQ7T0Gfo+p8u/0eia154l10UUGbaD1
	bFouKx9uMPhe1BIBycno8XQE=
X-Received: by 2002:a05:600c:350a:b0:406:c6de:2bea with SMTP id h10-20020a05600c350a00b00406c6de2beamr12718848wmq.17.1700136348187;
        Thu, 16 Nov 2023 04:05:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHdWVhOqGTW375pLi3FYuX9g67/Iptv+/PMA1d+/llKPmaAQmCrDgOhPFR2NRaqiQaHtXiX+Q==
X-Received: by 2002:a05:600c:350a:b0:406:c6de:2bea with SMTP id h10-20020a05600c350a00b00406c6de2beamr12718834wmq.17.1700136347857;
        Thu, 16 Nov 2023 04:05:47 -0800 (PST)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id h38-20020a05600c49a600b004064ac107cfsm3277181wmp.39.2023.11.16.04.05.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Nov 2023 04:05:47 -0800 (PST)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Thomas Zimmermann <tzimmermann@suse.de>, deller@gmx.de
Cc: linux-fbdev@vger.kernel.org, Thomas Zimmermann <tzimmermann@suse.de>,
 dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 27/32] fbdev: Rename FB_SYS_FOPS token to FB_SYSMEM_FOPS
In-Reply-To: <20231115102954.7102-28-tzimmermann@suse.de>
References: <20231115102954.7102-1-tzimmermann@suse.de>
 <20231115102954.7102-28-tzimmermann@suse.de>
Date: Thu, 16 Nov 2023 13:05:47 +0100
Message-ID: <87bkbt3ntw.fsf@minerva.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Thomas Zimmermann <tzimmermann@suse.de> writes:

> Rename the token to harmonize naming among various helpers. For
> example, I/O-memory helpers use FB_IOMEM_FOPS.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---

I wonder if the object names should also be changed to fb_iomem_fops.o
and fb_sysmem_fops.o for consistency with the Kconfig symbols names.

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

