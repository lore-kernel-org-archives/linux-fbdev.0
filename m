Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32A3E1170B
	for <linux-fbdev@vger.kernel.org>; Mon,  8 Jan 2024 09:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VvN70p+1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704705995;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6YTWyI9pnmCGgMl9btSzC0QrUqFEx74j7BArMXqCJjM=;
	b=VvN70p+1NQDWxDayHvy4WqHFz8YrtbFdWIfYN6w61vUcneL1afCeA8cKSyLXfMLgDfgn3L
	7T+2m66Rafuu2CDsm822gUi8J2NP9Knv8lfT1quK2ivuIuH/W/SjWMHqGiyf+vBa5EKuZG
	A9+//VA09get4jWZ3OVcCaSxT/GrD4U=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-444-KlcT4VWiN4yRcSbYJIz79A-1; Mon, 08 Jan 2024 04:26:33 -0500
X-MC-Unique: KlcT4VWiN4yRcSbYJIz79A-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-337707db5b1so76924f8f.1
        for <linux-fbdev@vger.kernel.org>; Mon, 08 Jan 2024 01:26:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704705992; x=1705310792;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6YTWyI9pnmCGgMl9btSzC0QrUqFEx74j7BArMXqCJjM=;
        b=azbKERBCYKwV/F3+DPYOrvy1i8wjs/2F8K2luk8FS1Y+oU5sv4vKYCgvl29skZvP6O
         Jmvu8LVT+h3KhOXFxkLIfIm1lYHOkomXzoumUwvHtOJoMlpHCYtsktjGrAPKEPwvWag2
         KCc39HnHTzFoMO8oXTUhd/aebQaLPuAvSiLVmJfLGTdd3SZw6orQoNlR+BSrGybl914M
         wJZYSrj/AOFk9KnVhAFfL2+NCPSJ4/t/uqS3P7LssCuvHrsK0IMYIP05JPFAZ863p4/g
         dMFdZzGjNNjBJV5gYtFvB56HqGkQtB0zfah75XnMomPqFmjaXV5Fqx4c6TzlbC2/QD1+
         UeUw==
X-Gm-Message-State: AOJu0YyOQs93DzyXJWblBhQ2TU4JpTnSNeDjIEVx/iu+xhrtccVpRgb0
	U6jKpCmET4vBkaCvKzj8hg6PgN+easFLEhrNEFE/vKY6CFez2aHF8NGnYrDLfom01v3L/xTNf0g
	+PTpNRTtt7zV1092JoGydTcO2RMpW5f8=
X-Received: by 2002:adf:f6cd:0:b0:336:8767:2e2f with SMTP id y13-20020adff6cd000000b0033687672e2fmr1627251wrp.7.1704705992339;
        Mon, 08 Jan 2024 01:26:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IElQ85E5AG8DGOKkrtDXTZaOebM+TMHkse/0Vdzz+KyAM6wy4odUSkHjozFDOl2/e8dH60OhQ==
X-Received: by 2002:adf:f6cd:0:b0:336:8767:2e2f with SMTP id y13-20020adff6cd000000b0033687672e2fmr1627242wrp.7.1704705992051;
        Mon, 08 Jan 2024 01:26:32 -0800 (PST)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id o14-20020adfeace000000b0033690139ea5sm7289677wrn.44.2024.01.08.01.26.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jan 2024 01:26:31 -0800 (PST)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Thomas Zimmermann <tzimmermann@suse.de>, drawat.floss@gmail.com,
 deller@gmx.de, decui@microsoft.com, wei.liu@kernel.org,
 haiyangz@microsoft.com, kys@microsoft.com, daniel@ffwll.ch,
 airlied@gmail.com
Cc: linux-hyperv@vger.kernel.org, linux-fbdev@vger.kernel.org,
 dri-devel@lists.freedesktop.org, Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH 1/4] drm/hyperv: Remove firmware framebuffers with
 aperture helper
In-Reply-To: <20240103102640.31751-2-tzimmermann@suse.de>
References: <20240103102640.31751-1-tzimmermann@suse.de>
 <20240103102640.31751-2-tzimmermann@suse.de>
Date: Mon, 08 Jan 2024 10:26:30 +0100
Message-ID: <87a5pgdvll.fsf@minerva.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Thomas Zimmermann <tzimmermann@suse.de> writes:

Hello Thomas,

> Replace use of screen_info state with the correct interface from
> the aperture helpers. The state is only for architecture and firmware
> code. It is not guaranteed to contain valid data. Drivers are thus
> not allowed to use it.
>
> For removing conflicting firmware framebuffers, there are aperture
> helpers. Hence replace screen_info with the correct function that will
> remove conflicting framebuffers for the hyperv-drm driver. Also
> move the call to the correct place within the driver.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

