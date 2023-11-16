Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FTznIlyy"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 801ADCE
	for <linux-fbdev@vger.kernel.org>; Thu, 16 Nov 2023 05:15:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1700140505;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lhqQ5BsbU492ZArPjoM5H4h5bLkzseqSxtuMUFrb25I=;
	b=FTznIlyyc+rJQFCp5hJFzlh0xrqrAN4QCRwGaQr5cuy75CSTnvJMnW2pNCVUOUBO86HGmq
	+zYAH8/VykCwhqpv5pp6FM81fCPP0WQWcWXNoKSYGmBwXmo2biTA8HhYyQF7b8C3Xeu4T+
	GYhU6JM7AVnhCLzlfKicjO4xmYQXgeg=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-647-13eMivwQPpCEooE_FCG4bA-1; Thu, 16 Nov 2023 08:15:04 -0500
X-MC-Unique: 13eMivwQPpCEooE_FCG4bA-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-40839252e81so4456605e9.3
        for <linux-fbdev@vger.kernel.org>; Thu, 16 Nov 2023 05:15:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700140503; x=1700745303;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lhqQ5BsbU492ZArPjoM5H4h5bLkzseqSxtuMUFrb25I=;
        b=NXdCZ3dW+hkQQSnPWNCRSz4e3PZwVu+IlF9x5dYmVubQR2YmktVMtf1e9t7oLKVk3P
         KFrQRHsX9KJPTCmCgPm/fvICQYxmMmifvnrDl3QO7blcPjVTyYLuJ5g7S6TcDRa31Zud
         cEYgTq/pCIC6RZufvi9+754LWxwS9KvoN3Nmt+JWjH1Z70AsZw+46Li5Oet03apNxxnu
         Jocb7vYhCL+3BJifg+XiBDGdzVMSRPGjrGM9aC1dSQ/iqxIhjfC4FWQQEsNL0mTNbGfF
         6B2ka4tqPXx5Fytx96uLjwjpeG7pEC7elGMjxHeXcltGfAky3DVWh9mZbiOsYLJ8NbTD
         wz2w==
X-Gm-Message-State: AOJu0YxYJyj7UNT1Vo9efcs+8269SVem8CuWqUiRAumOUVHnVVHE1V+Z
	9YeqPfo2GfYbxNyOX2eUqDRjYbtR2q8t32lD0WqVeGbKdyhSa8/pzO8QqKLvnbbK4Xo3wjuoWS3
	3+LMEba2JstbUS4H0MfsOj1w=
X-Received: by 2002:a05:600c:154a:b0:401:bdd7:49ae with SMTP id f10-20020a05600c154a00b00401bdd749aemr13426301wmg.18.1700140503077;
        Thu, 16 Nov 2023 05:15:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IELI8sW+MIxOxGgPKrkQ0OehkuAbYn7qHMcKqTARz4KGdq/TLndhUJZcAFE/gym1FScs/FZTQ==
X-Received: by 2002:a05:600c:154a:b0:401:bdd7:49ae with SMTP id f10-20020a05600c154a00b00401bdd749aemr13426286wmg.18.1700140502784;
        Thu, 16 Nov 2023 05:15:02 -0800 (PST)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id l6-20020a05600c4f0600b004068495910csm3609186wmq.23.2023.11.16.05.15.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Nov 2023 05:15:02 -0800 (PST)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Thomas Zimmermann <tzimmermann@suse.de>, deller@gmx.de
Cc: linux-fbdev@vger.kernel.org, Thomas Zimmermann <tzimmermann@suse.de>,
 dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 32/32] fbdev: Remove default file-I/O implementations
In-Reply-To: <20231115102954.7102-33-tzimmermann@suse.de>
References: <20231115102954.7102-1-tzimmermann@suse.de>
 <20231115102954.7102-33-tzimmermann@suse.de>
Date: Thu, 16 Nov 2023 14:15:01 +0100
Message-ID: <87zfzd2622.fsf@minerva.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Thomas Zimmermann <tzimmermann@suse.de> writes:

> Drop the default implementations for file read, write and mmap
> operations. Each fbdev driver must now provide an implementation
> and select any necessary helpers. If no implementation has been
> set, fbdev returns an errno code to user space. The code is the
> same as if the operation had not been set in the file_operations
> struct.
>
> This change makes the fbdev helpers for I/O memory optional. Most
> systems only use system-memory framebuffers via DRM's fbdev emulation.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---

[...]

> @@ -34,13 +34,13 @@ static ssize_t fb_read(struct file *file, char __user *buf, size_t count, loff_t
>  	if (!info)
>  		return -ENODEV;
>  
> +	if (!info->fbops->fb_read)
> +		return -EINVAL;
> +

Can we also add a warn here? In case that it was missed to set a driver
callback. Probably can be figured out from the -EINVAL but better to be
explicit about the issue to make finding that easier.

And same for the other fops.

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

