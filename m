Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f6YNp3ac"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32431C5
	for <linux-fbdev@vger.kernel.org>; Thu, 16 Nov 2023 02:04:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1700129096;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OaK1NuSdknOBZMR/nRsin3NxTgJL6ccp/7aJ3A6xaVo=;
	b=f6YNp3acU4Voqig3eMPRbJAYeXWl3VRsPr7CbXUaNNcK2bvtZmcgg0eCTN1dUdUM5wAe9S
	/x0KLOSdoXa9UriQk/FIn+iCa5ZtLx2VXIP0AF/FqpxKfJPLk6yjzFXlJ8PRHvvuw2jMvn
	uBcWcFGvK99e4YDQwc3BBp6FEXN8PLg=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-316-To61NhqiO7KmpyTX_VjCGw-1; Thu, 16 Nov 2023 05:04:55 -0500
X-MC-Unique: To61NhqiO7KmpyTX_VjCGw-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-32f820c471fso345193f8f.0
        for <linux-fbdev@vger.kernel.org>; Thu, 16 Nov 2023 02:04:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700129093; x=1700733893;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OaK1NuSdknOBZMR/nRsin3NxTgJL6ccp/7aJ3A6xaVo=;
        b=YfPyOJO//kkzF0soyIVN6trSt1WmEzqzG2R0NLofv9PZrvkqCEqvNCXgfEbxqHUOm6
         RrRVgwhyUFM/x8EU69KCuWf7s+ahdiOVxTWACnRdouQdY9N6LwzlSn/gVlD0AhCEB0bP
         AXL24lEzca02nkvpgmZYcbyyIV6wRRwZoROihcfUFYYqTNWYnRpZfCLdRZYQkeGCLxsv
         dZ3izPcV7Fo0FCjjBSFf4XmMZnZYX1BvTBOGFw/SDJfoQo6PXulYN7x3wkDyJtbx0XoU
         eyhzY04ddXp53fbwl2L0GkUCGX06vxX3FNpFjVXxNZlDHbz/WtEHyeCR7AzHRJk0ZYn/
         37qg==
X-Gm-Message-State: AOJu0YyoZbavVjG72IqaeU9uMqU7LO4ORfryWoZwlemLkABaD7lX/TlL
	kseGczJsW9HeJqoK/GI1V3Oay3SDgEgPhBx7jZsAgdWH3jmkAmbRz/F6NV7/VZFJSSS9tmPf1un
	YOLvRIEwGK0x1BMI8Vb02qch3M+HpZqA=
X-Received: by 2002:a5d:614d:0:b0:32f:b419:6ec2 with SMTP id y13-20020a5d614d000000b0032fb4196ec2mr8423786wrt.34.1700129093453;
        Thu, 16 Nov 2023 02:04:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHBdR/Qf20htP1IxZiF8zAwtCN0pAwhyRvoicluUpG8NwQk97ZggETQDD6qYQMOKadayZ4f5w==
X-Received: by 2002:a5d:614d:0:b0:32f:b419:6ec2 with SMTP id y13-20020a5d614d000000b0032fb4196ec2mr8423774wrt.34.1700129093112;
        Thu, 16 Nov 2023 02:04:53 -0800 (PST)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id n7-20020a5d4847000000b0032d88e370basm13050490wrs.34.2023.11.16.02.04.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Nov 2023 02:04:52 -0800 (PST)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Thomas Zimmermann <tzimmermann@suse.de>, deller@gmx.de
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, Thomas
 Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH 04/32] fbdev/vfb: Initialize fb_ops with fbdev macros
In-Reply-To: <20231115102954.7102-5-tzimmermann@suse.de>
References: <20231115102954.7102-1-tzimmermann@suse.de>
 <20231115102954.7102-5-tzimmermann@suse.de>
Date: Thu, 16 Nov 2023 11:04:52 +0100
Message-ID: <878r6y57zv.fsf@minerva.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Thomas Zimmermann <tzimmermann@suse.de> writes:

> Initialize the instance of struct fb_ops with fbdev initializer
> macros for framebuffers in virtual address space. Set the read/write,
> draw and mmap callbacks to the correct implementation and avoid
> implicit defaults. Also select the necessary helpers in Kconfig.
>
> Fbdev drivers sometimes rely on the callbacks being NULL for a
> default I/O-memory-based implementation to be invoked; hence
> requiring the I/O helpers to be built in any case. Setting all
> callbacks in all drivers explicitly will allow to make the I/O
> helpers optional. This benefits systems that do not use these
> functions.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

