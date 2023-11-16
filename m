Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QbhJ8aG6"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F9EBE0
	for <linux-fbdev@vger.kernel.org>; Thu, 16 Nov 2023 01:45:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1700127949;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zSzsA5SxyFLcplHAlbNRiGj1W1HdcMtXrU3K2DbJDWo=;
	b=QbhJ8aG6IlziRQ+07GJETFU0/FW+Ufnf4+WpPS0MlkNOTWG2TOytAzy1s6UtZVAcEfyjK2
	t73AO5eOqp9lUJDegpvaAozFvxdFFAZee1oi/e+yNa8nYpBEtEoqq8RkRJvP3egn6g+w+N
	WgvJqnuxVUSZWjfS3BWjoE37pL0n3kE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-626-IZS0LxNpPy6DR31qXreS4A-1; Thu, 16 Nov 2023 04:45:48 -0500
X-MC-Unique: IZS0LxNpPy6DR31qXreS4A-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-40845fe2d1cso3669045e9.0
        for <linux-fbdev@vger.kernel.org>; Thu, 16 Nov 2023 01:45:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700127947; x=1700732747;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zSzsA5SxyFLcplHAlbNRiGj1W1HdcMtXrU3K2DbJDWo=;
        b=WsanU0/zrwjSwAn91iiJgaNFxTf4ZvM98sb4V5WJcKxR5YXHfMaQU/J9xYTdJQQ9IM
         RJE5uET1sOZvD/g8Tc+yg1BlWdT2riboilX6g2lsNC9OGyfYZhjhrxzY0+V2Gf8rwBhr
         sSRvoHyIq3Z3IRM1mU7DGlpys9BKmJ1TFhJjwEyNlGnjoQoN9t/ZF25et5IDu/mk21k9
         8ax2MI43372jimOWX3nOdZs3957KdsbHxzp3z8YBccoeAbHuEFVICbI0R02NvJ3L9M0c
         nitkStrXDsna7KFhB90gS58jDa31z5poH/kCQltVnGKSlCRQhtxKrrdfbAsfmcBM3tjr
         qpGg==
X-Gm-Message-State: AOJu0YzvkV3jOlt0Q9MKR6m1YLRMBYLAIRKqcPuq/+Myox6Gw2DYbTNL
	Mh5Xk516QbE7+McLZHjgJYXbLgkj3/tK1094gSaoBUMZ9R9UVcPiNLTU3+czN+9L4LBinFuH2Fm
	ItBT7MavAzRSx+IZ/jL9HnnY=
X-Received: by 2002:a05:600c:46cf:b0:3f5:fff8:d4f3 with SMTP id q15-20020a05600c46cf00b003f5fff8d4f3mr13564634wmo.7.1700127947462;
        Thu, 16 Nov 2023 01:45:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHtLFlJthV6m1GTAAXrgTEAAU7vMTnuD+YdTz6edocexCaOzMz3U0re055aJeRbTrwW/zVrhw==
X-Received: by 2002:a05:600c:46cf:b0:3f5:fff8:d4f3 with SMTP id q15-20020a05600c46cf00b003f5fff8d4f3mr13564617wmo.7.1700127947117;
        Thu, 16 Nov 2023 01:45:47 -0800 (PST)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id je14-20020a05600c1f8e00b00405bbfd5d16sm2915620wmb.7.2023.11.16.01.45.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Nov 2023 01:45:46 -0800 (PST)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Thomas Zimmermann <tzimmermann@suse.de>, deller@gmx.de
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, Thomas
 Zimmermann <tzimmermann@suse.de>, Sam Ravnborg <sam@ravnborg.org>, Arnd
 Bergmann <arnd@arndb.de>, stable@vger.kernel.org
Subject: Re: [PATCH 01/32] fbdev/acornfb: Fix name of fb_ops initializer macro
In-Reply-To: <20231115102954.7102-2-tzimmermann@suse.de>
References: <20231115102954.7102-1-tzimmermann@suse.de>
 <20231115102954.7102-2-tzimmermann@suse.de>
Date: Thu, 16 Nov 2023 10:45:46 +0100
Message-ID: <87h6lm58vp.fsf@minerva.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Thomas Zimmermann <tzimmermann@suse.de> writes:

> Fix build by using the correct name for the initializer macro
> for struct fb_ops.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Fixes: 9037afde8b9d ("fbdev/acornfb: Use fbdev I/O helpers")
> Cc: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: Sam Ravnborg <sam@ravnborg.org>
> Cc: Helge Deller <deller@gmx.de>
> Cc: Javier Martinez Canillas <javierm@redhat.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: <stable@vger.kernel.org> # v6.6+
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

