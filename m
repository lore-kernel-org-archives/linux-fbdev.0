Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RN3wkecH"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49C82196
	for <linux-fbdev@vger.kernel.org>; Thu, 16 Nov 2023 01:46:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1700128016;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GUnAkharhaI3GMz15hJttOkxbY1QE99PMsSD7T59uqo=;
	b=RN3wkecHy01Cn6ZclSSpgwbRTJ65vHWFyLb9p1Jz8MF05BPAwb/7wyMsRdtZP1m2cvBdtI
	HUBDPFEaFxi44IkWa6Mj/GfKidKgoIgyKw5jbyfW9KO4ZAJ+76Yc4Du89j3HUDWns+g5iF
	IvFTqfG/9uKj5B2SMfAZjOGz0uNSNbs=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-628-tn33DCSwOOKkbRYiWHGqXQ-1; Thu, 16 Nov 2023 04:46:55 -0500
X-MC-Unique: tn33DCSwOOKkbRYiWHGqXQ-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-32d83fd3765so280820f8f.3
        for <linux-fbdev@vger.kernel.org>; Thu, 16 Nov 2023 01:46:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700128013; x=1700732813;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GUnAkharhaI3GMz15hJttOkxbY1QE99PMsSD7T59uqo=;
        b=Qoyq9DBnowotq0qXtDoKCUucGuRihm7HKAGHw0CfayQ2gTc8Y9hETM0kg/LV3o94wo
         AT2rqU5PKn8mMehdWKAZsrA39kNEop+UTS69nLAZyDXnYm1WwJJNqYEgW13924KQxFgl
         p3UX3WhO4iHK/WOCSYX4PlJEVR9vTGeNREFQiU6jSluIpGUnGafw9kc+Bd5UHb6HTg3n
         OGLdSmFYhWykqqlci7PsJ0T4S+WUa7RgLVz02iYv0MYMor0Z7qHOg7ygcSjX5qqHtc1D
         KuHJ6hVMYcwSFL80IihlEHjyjN3WghhaFDPV7uheNjIHh4bqFzRzOzCF0+6XmbS/+s5K
         jw8Q==
X-Gm-Message-State: AOJu0YxEFCXS5xWmVd6u1tM4oUggyUTw1DMjyG+S1CBwFR9XcvC7iyb5
	j57sJKtvk9i6PeVjcC0JTVmL3QSP8MF96JWa0jX9MMug7tlkDVJDFyZWjKteHQP/98vK9kwdT7T
	qdDyeRNLKRpkd/m9VeNtO0sALWPGjMwI=
X-Received: by 2002:adf:d1c7:0:b0:32d:a10d:90dd with SMTP id b7-20020adfd1c7000000b0032da10d90ddmr13048193wrd.50.1700128013572;
        Thu, 16 Nov 2023 01:46:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEo/GoeXnzkXSs+8oHstaaykO4BVH3SjALigbkXo0pwn68Vaum7b6oJA+SZlF0dwNkE6vhExQ==
X-Received: by 2002:adf:d1c7:0:b0:32d:a10d:90dd with SMTP id b7-20020adfd1c7000000b0032da10d90ddmr13048173wrd.50.1700128013245;
        Thu, 16 Nov 2023 01:46:53 -0800 (PST)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id z12-20020a056000110c00b0032db8cccd3asm13041667wrw.114.2023.11.16.01.46.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Nov 2023 01:46:52 -0800 (PST)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Thomas Zimmermann <tzimmermann@suse.de>, deller@gmx.de
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, Thomas
 Zimmermann <tzimmermann@suse.de>, Sudip Mukherjee
 <sudipm.mukherjee@gmail.com>, Teddy Wang <teddy.wang@siliconmotion.com>,
 Sam Ravnborg <sam@ravnborg.org>, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 02/32] fbdev/sm712fb: Use correct initializer macros for
 struct fb_ops
In-Reply-To: <20231115102954.7102-3-tzimmermann@suse.de>
References: <20231115102954.7102-1-tzimmermann@suse.de>
 <20231115102954.7102-3-tzimmermann@suse.de>
Date: Thu, 16 Nov 2023 10:46:52 +0100
Message-ID: <87edgq58tv.fsf@minerva.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Thomas Zimmermann <tzimmermann@suse.de> writes:

> Only initialize mmap and draw helpers with macros; leave read/write
> callbacks to driver implementations. Fixes the following warnings:
>
>   CC [M]  drivers/video/fbdev/sm712fb.o
>   sm712fb.c:1355:25: warning: initialized field overwritten [-Woverride-init]
>   1355 |         .fb_fillrect  = cfb_fillrect,
>        |                         ^~~~~~~~~~~~
>   sm712fb.c:1355:25: note: (near initialization for 'smtcfb_ops.fb_fillrect')
>   sm712fb.c:1356:25: warning: initialized field overwritten [-Woverride-init]
>   1356 |         .fb_imageblit = cfb_imageblit,
>        |                         ^~~~~~~~~~~~~
>   sm712fb.c:1356:25: note: (near initialization for 'smtcfb_ops.fb_imageblit')
>   sm712fb.c:1357:25: warning: initialized field overwritten [-Woverride-init]
>   1357 |         .fb_copyarea  = cfb_copyarea,
>        |                         ^~~~~~~~~~~~
>   sm712fb.c:1357:25: note: (near initialization for 'smtcfb_ops.fb_copyarea')
>   sm712fb.c:1358:25: warning: initialized field overwritten [-Woverride-init]
>   1358 |         .fb_read      = smtcfb_read,
>        |                         ^~~~~~~~~~~
>   sm712fb.c:1358:25: note: (near initialization for 'smtcfb_ops.fb_read')
>   sm712fb.c:1359:25: warning: initialized field overwritten [-Woverride-init]
>   1359 |         .fb_write     = smtcfb_write,
>        |                         ^~~~~~~~~~~~
>   sm712fb.c:1359:25: note: (near initialization for 'smtcfb_ops.fb_write')
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Fixes: 586132cf1d38 ("fbdev/sm712fb: Initialize fb_ops to fbdev I/O-memory helpers")
> Cc: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: Javier Martinez Canillas <javierm@redhat.com>
> Cc: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
> Cc: Teddy Wang <teddy.wang@siliconmotion.com>
> Cc: Sam Ravnborg <sam@ravnborg.org>
> Cc: Helge Deller <deller@gmx.de>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: linux-fbdev@vger.kernel.org
> ---
>  drivers/video/fbdev/sm712fb.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

