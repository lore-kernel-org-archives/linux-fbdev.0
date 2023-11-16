Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Iz9z0W8P"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83736C5
	for <linux-fbdev@vger.kernel.org>; Thu, 16 Nov 2023 02:00:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1700128834;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aix+qLa2JZVyx8zPyk76uQKCOlbsbX/nflXBJMLRqWk=;
	b=Iz9z0W8PPVROc+iPSan9Ozv7VU4UO35VfmT3UvD/AbuMHFRPZO8AWxcgrk/Nh92GOovjiE
	CK5ZEjMfSfKffRbtOpaZ5lR5loU5QxFrwgyT3XQnSV8l18FO4Kft1uX+0OXuDtJTrfmuRE
	oxK37JEGx4D2sy/u0K2wWlmWvseTMlA=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-541-0PAgcBmbODiXrFD_l0IEug-1; Thu, 16 Nov 2023 05:00:33 -0500
X-MC-Unique: 0PAgcBmbODiXrFD_l0IEug-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-32f820c471fso342909f8f.0
        for <linux-fbdev@vger.kernel.org>; Thu, 16 Nov 2023 02:00:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700128832; x=1700733632;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aix+qLa2JZVyx8zPyk76uQKCOlbsbX/nflXBJMLRqWk=;
        b=EYu2OMXGbL2F9fUnx2j8TjwygfweYCQUMN8gq/WLdnuUDXCpZIom100vmUtaTGVjxS
         BeHsHqot/Yav0aKO4ItiyZ66zywp39AeebjbjktPHgNgG6+OdkQ6o2L1w9C4uCsLwQfw
         y3ImNTCiFZ+rvnOyK5l8wkTIykIku35A8QaqxXR8oqaogrxfzVIO5yeYLEjTLSddChuv
         y3IAvrlhPO9UE5dt4aH8m8D3MZos56WFHUw4sHkrP2HLkj2aN0knRm7osTjeVs+VYjbL
         yovi8sXcka62B+Z/vOhPYDxBI0QikSH5Dn0uexLuTgpfl4oe3dhPrtg+W0yy695kNnlA
         J+yw==
X-Gm-Message-State: AOJu0YxC/eIIEyTKmFdq7XB4q4aXXhfwCwZrG39AKTdg0Po8+mQcPlda
	WhqxTQY0QP8AJaJaZhKSTjrvizrl3z5/XtxiofEKLG6jKO37VUigtErFctOoAlWERtrvXvexXmR
	tD2pWBOClgVOisI3GBjZxP+s=
X-Received: by 2002:adf:a347:0:b0:32d:a405:b6b7 with SMTP id d7-20020adfa347000000b0032da405b6b7mr11031370wrb.32.1700128832221;
        Thu, 16 Nov 2023 02:00:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGSAU15esNJuVx/9XqjnsNdvj/tNjNqHIRKF6duesUYhUqC5ezx9srKFBjRMBp8Pok7diS9hg==
X-Received: by 2002:adf:a347:0:b0:32d:a405:b6b7 with SMTP id d7-20020adfa347000000b0032da405b6b7mr11031355wrb.32.1700128831885;
        Thu, 16 Nov 2023 02:00:31 -0800 (PST)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id i16-20020a05600011d000b0033134ab9691sm12965840wrx.57.2023.11.16.02.00.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Nov 2023 02:00:31 -0800 (PST)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Thomas Zimmermann <tzimmermann@suse.de>, deller@gmx.de
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, Thomas
 Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH 03/32] fbdev/vfb: Set FBINFO_VIRTFB flag
In-Reply-To: <20231115102954.7102-4-tzimmermann@suse.de>
References: <20231115102954.7102-1-tzimmermann@suse.de>
 <20231115102954.7102-4-tzimmermann@suse.de>
Date: Thu, 16 Nov 2023 11:00:30 +0100
Message-ID: <87bkbu5875.fsf@minerva.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Thomas Zimmermann <tzimmermann@suse.de> writes:

> The vfb driver operates on system memory. Mark the framebuffer
> accordingly. Helpers operating on the framebuffer memory will test
> for the presence of this flag.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

