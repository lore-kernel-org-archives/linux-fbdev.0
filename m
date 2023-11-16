Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C5grN2Y/"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4756018B
	for <linux-fbdev@vger.kernel.org>; Thu, 16 Nov 2023 02:48:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1700131686;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5rw/Y06vMJw+yRqzRy2b73TtPoc6ulI8+aEjabQdVw8=;
	b=C5grN2Y/unsvs2FPDeuZqtWm6xwE8FeMle97WWKPJghLKS6gNEfEdaZYH1PB4TSsecsQob
	WSrqpy6oD2J4ZnoEttCyEBCRpjR67kdP+OWzYe/Bqfemf9aPOWy+ywPVpRLckg1FcO+09q
	AofwePwLU+8CE6alqKGdxOsvXZ921pg=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-479-6vhKkn11P9a8RMd25Njt0w-1; Thu, 16 Nov 2023 05:48:05 -0500
X-MC-Unique: 6vhKkn11P9a8RMd25Njt0w-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-32f820c471fso364295f8f.0
        for <linux-fbdev@vger.kernel.org>; Thu, 16 Nov 2023 02:48:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700131684; x=1700736484;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5rw/Y06vMJw+yRqzRy2b73TtPoc6ulI8+aEjabQdVw8=;
        b=K0uOAoVodPOuvOBqlnWy4K3siDIujcLvQ8Di42UfuO8eh8J/oYeSuNE1ERCbygMRuL
         pL1lAEXg9gLuoJD4k9AUrOuIfQZ58pAJuHx/DXhtZ7B6uN+w6S6WAJpErhHE0YlKRGG3
         xn2jYRq/+I1HS4u+eNMLEPlyn3HH4HDiNBnFfMzDls2P0MPGaI4kuftovzqdU4FMsUg+
         dmRRjwfAsMJx1nhKarB4ySFUXg2wJZp6dHkt64SzSEsLzXAn6GE/ezVNt8laIO21ED4k
         e2iNUEXPJTfmg+UPIrbnLPvllvmjx3dvldiocijyRTuX9nHQ2qTLzSa/Kr7QB2vbgEfk
         sGig==
X-Gm-Message-State: AOJu0Yznaat41EmahTC/4wdPZf0eBxaaXGqDey+1lIrJ4Ww7OxQWzOeN
	Z0xZ7x8AwS4gPlTpI5J4EYDz1eCtZf97Z1v3dNP+d7CRIMjaEsTaamTXUBR2zo9WvpM87zWFDHt
	quyhPN7klrrQL+n3xsgLLSDs=
X-Received: by 2002:adf:a310:0:b0:32f:c3d0:89db with SMTP id c16-20020adfa310000000b0032fc3d089dbmr9434876wrb.27.1700131684001;
        Thu, 16 Nov 2023 02:48:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHzSwHObq9d2iGtBdyJvnvCw1ejJvbv41YXOcU6exTztiExEie1pplMm3wL0yTYDrysaHHJBw==
X-Received: by 2002:adf:a310:0:b0:32f:c3d0:89db with SMTP id c16-20020adfa310000000b0032fc3d089dbmr9434865wrb.27.1700131683682;
        Thu, 16 Nov 2023 02:48:03 -0800 (PST)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id e2-20020adfa442000000b0032f7eaa6e43sm13345872wra.79.2023.11.16.02.48.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Nov 2023 02:48:03 -0800 (PST)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Thomas Zimmermann <tzimmermann@suse.de>, deller@gmx.de
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, Thomas
 Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH 17/32] fbdev/au1200fb: Initialize fb_ops with fbdev macros
In-Reply-To: <20231115102954.7102-18-tzimmermann@suse.de>
References: <20231115102954.7102-1-tzimmermann@suse.de>
 <20231115102954.7102-18-tzimmermann@suse.de>
Date: Thu, 16 Nov 2023 11:48:02 +0100
Message-ID: <877cmi3rfh.fsf@minerva.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Thomas Zimmermann <tzimmermann@suse.de> writes:

> Initialize the instance of struct fb_ops with fbdev initializer
> macros for framebuffers in DMA-able virtual address space. Set the
> read/write, draw and mmap callbacks to the correct implementation
> and avoid implicit defaults. Also select the necessary helpers in
> Kconfig.
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

