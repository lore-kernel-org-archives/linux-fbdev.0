Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g1ZFXfql"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD965181
	for <linux-fbdev@vger.kernel.org>; Thu, 16 Nov 2023 02:22:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1700130162;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ILk4LaTMqfloIT4A6f9BFCoRSwM9uqmPYLbHgTtp30E=;
	b=g1ZFXfql0gyP5I69GSBODfao8Cs/EmmmjUVX41+1wDt1oC68N2xF5MF5HX+E30X3Vqc84e
	RWxSkDFRGi5pipL5fgqSjalA/i5ZE5jzubPJLYfL2OaOSh0CKDoOQdgeRXM7j/zRKVbffE
	HsjcjT/mui3gxhZEwIWREEQI62OCr4E=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-470-hntjNp6UPZCm5izzKSOHmA-1; Thu, 16 Nov 2023 05:22:39 -0500
X-MC-Unique: hntjNp6UPZCm5izzKSOHmA-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-32f820c471fso352573f8f.0
        for <linux-fbdev@vger.kernel.org>; Thu, 16 Nov 2023 02:22:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700130158; x=1700734958;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ILk4LaTMqfloIT4A6f9BFCoRSwM9uqmPYLbHgTtp30E=;
        b=wRs0D17CzdguaD6c8qZHL3uCJ85zycbIzCFsN5aPzU+m3afFpfsYnmi4VDHQoVXwwi
         j200in4SegqaWoTvXDQ23dC0e50TXPxeq7J8WSYzLzCHGfPJp9zUZIxuRhrm1OSFa3OJ
         /8TDuE5Jo4Xt/3wDPSjF+feSDLPUfAThFLKvbVxb0sgbyxe6sC2Ts6ml6lm8Rw8sI2YG
         Xd7Osr5WBAKsiVUArdESowo3GUo82ZUCABJydmQ3LXqq1b10jxRpfkCRPNSUCtykk+L2
         R4EAgAqHaw4uTyfsRxzWP5NQODVpCES6TIJdY/74mZ+wn9MhR/GZgwEU7yKVlnGabPgV
         31Rg==
X-Gm-Message-State: AOJu0Yy5MauOYSPmkS8F2zxCEjbg75rgNU0ejftdryS2bdMz4cQVgOHw
	PHe6U3eDYN+RUBudXjOa1UAcr0QJ4skuOivq/ozC7WHAZuApRBI+0AfoLYS/PdIJPZ704ifPA5r
	mfINqEaIJ1SS2qTwdRtSURMc=
X-Received: by 2002:a5d:6109:0:b0:32d:8830:cda1 with SMTP id v9-20020a5d6109000000b0032d8830cda1mr10322967wrt.63.1700130158090;
        Thu, 16 Nov 2023 02:22:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGT3XrJIjQEqYcBl+kSmEitL1eQ8ph9xj5ilQVUN21ATYrCVENuJjr3x8iWWUa+rgtgEpYnRA==
X-Received: by 2002:a5d:6109:0:b0:32d:8830:cda1 with SMTP id v9-20020a5d6109000000b0032d8830cda1mr10322956wrt.63.1700130157805;
        Thu, 16 Nov 2023 02:22:37 -0800 (PST)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id c10-20020a5d414a000000b0032f7d1e2c7csm13047798wrq.95.2023.11.16.02.22.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Nov 2023 02:22:37 -0800 (PST)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Thomas Zimmermann <tzimmermann@suse.de>, deller@gmx.de
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, Thomas
 Zimmermann <tzimmermann@suse.de>, Miguel Ojeda <ojeda@kernel.org>
Subject: Re: [PATCH 08/32] auxdisplay/cfag12864bfb: Initialize fb_ops with
 fbdev macros
In-Reply-To: <20231115102954.7102-9-tzimmermann@suse.de>
References: <20231115102954.7102-1-tzimmermann@suse.de>
 <20231115102954.7102-9-tzimmermann@suse.de>
Date: Thu, 16 Nov 2023 11:22:36 +0100
Message-ID: <87wmui3slv.fsf@minerva.mail-host-address-is-not-set>
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
> Cc: Miguel Ojeda <ojeda@kernel.org>
> ---
>  drivers/auxdisplay/Kconfig        | 5 +----
>  drivers/auxdisplay/cfag12864bfb.c | 7 ++-----
>  2 files changed, 3 insertions(+), 9 deletions(-)
>

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

