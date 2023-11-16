Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ri19zgFf"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41E0AD1
	for <linux-fbdev@vger.kernel.org>; Thu, 16 Nov 2023 02:46:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1700131617;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+mneAN+O3HdG8FQxpQR7zP/PBFf56Dx1XY7777+VaPU=;
	b=Ri19zgFfVhUogLVGJ/yWPXKujsw53rcwez1xMMRQjOT6o0uy4tLEHz8Z561dq6+kQFWpgr
	iefNVni5SjXxmvr5Qw48Q6ttMk4VN4RKW1bRRzskN/qtGmwVLI/18ML263K2eqsAiHUnN7
	sTicPh5/5Q0fwVmm2EVr5xfd/VK7ELw=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-247-035aJhhhNNaCIYMhjH0a9g-1; Thu, 16 Nov 2023 05:46:55 -0500
X-MC-Unique: 035aJhhhNNaCIYMhjH0a9g-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-32da39f7f2bso304241f8f.0
        for <linux-fbdev@vger.kernel.org>; Thu, 16 Nov 2023 02:46:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700131614; x=1700736414;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+mneAN+O3HdG8FQxpQR7zP/PBFf56Dx1XY7777+VaPU=;
        b=Xd9odboCltaxDnSrrxLWdb3yeY9lVsjZfTqH0hkwLqpDidaGt/dnZeZOgnMUZQQ7g/
         F/rDVFVLQVT+ioi2pj0Hpr9yOdHE8w31vkz0c6fz2FSVkHIP15QeorSa2he4CXJknFVi
         NtGsEBM9vF7AHHFs1Mu+v3ytlYJvURzYGhmZXga13rUoRckmVok+qtSxpWBPKG/uCVFL
         jjtO697cWDl7oRz8YOUAvRm06xUREHbdcovd8QzDn5s9iIooTbBCbBOU6BrD+4GGoV8y
         YLXmrHN3ngBaH0nbloLa9t2es39Tb5X8Ky8VdvnvImvQbWUMPos3lKz9KlGyCk1EY77S
         vHJQ==
X-Gm-Message-State: AOJu0YwQG/KMbqzbVVDrNYhPrI3QaFnCtuVAU5r6HQK5ezkKt1LNYySb
	PrfBAkJ9iirSC0kRfG2Tu7yuJT5Roz0jsedHGi9tTHt8XqXKsGxXVUeGFD/WPS9sByriOpnZUu4
	or0HX/cdu839mqRgp0ckVY+8=
X-Received: by 2002:a5d:5888:0:b0:32f:7d50:62ef with SMTP id n8-20020a5d5888000000b0032f7d5062efmr12951186wrf.13.1700131614503;
        Thu, 16 Nov 2023 02:46:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGAs6+6iy0Dt/lOmxHJQefZHE92U1Biwcc/qBBdf7doNIMGHO/Iod5CVM74R3HcwWPPe6TRCA==
X-Received: by 2002:a5d:5888:0:b0:32f:7d50:62ef with SMTP id n8-20020a5d5888000000b0032f7d5062efmr12951175wrf.13.1700131614223;
        Thu, 16 Nov 2023 02:46:54 -0800 (PST)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id j16-20020a056000125000b0032f983f7306sm13152500wrx.78.2023.11.16.02.46.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Nov 2023 02:46:54 -0800 (PST)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Thomas Zimmermann <tzimmermann@suse.de>, deller@gmx.de
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, Thomas
 Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH 15/32] fbdev/udlfb: Select correct helpers
In-Reply-To: <20231115102954.7102-16-tzimmermann@suse.de>
References: <20231115102954.7102-1-tzimmermann@suse.de>
 <20231115102954.7102-16-tzimmermann@suse.de>
Date: Thu, 16 Nov 2023 11:46:53 +0100
Message-ID: <87cywa3rhe.fsf@minerva.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Thomas Zimmermann <tzimmermann@suse.de> writes:

> The driver uses deferred I/O. Select the correct helpers via
> FB_SYSMEM_HELPERS_DEFERRED in the Kconfig file.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

