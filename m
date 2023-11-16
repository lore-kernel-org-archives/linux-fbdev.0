Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q1AxUHV9"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B6631AE
	for <linux-fbdev@vger.kernel.org>; Thu, 16 Nov 2023 02:48:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1700131719;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ypSMusxu7iqOH9G9Y+yTp1W0QKNM3WZxsK2UxHgzZ+c=;
	b=Q1AxUHV9OFzU8yidm8+ZhAe7Hl3sFtCZFJ/U99vTi8pldzOLoESh1NbwdnCPP5YstHRHMq
	KugTAKZPZotpmBVk39D+il7KZ7gpOryis0GBh1SEQyoDjq1bHJzbhUtCEjFmL/IWOeQRr6
	lmSQ9QwCxcuG0SHxZuDE7g4UbaQpAQQ=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-363-qTy5LXG_OfeQgDe6nevdaA-1; Thu, 16 Nov 2023 05:48:35 -0500
X-MC-Unique: qTy5LXG_OfeQgDe6nevdaA-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-32de9f93148so332759f8f.2
        for <linux-fbdev@vger.kernel.org>; Thu, 16 Nov 2023 02:48:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700131714; x=1700736514;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ypSMusxu7iqOH9G9Y+yTp1W0QKNM3WZxsK2UxHgzZ+c=;
        b=OpYFnSF8L5tMjbJwY+QcWohCfC5VkXM6DxI8MwDbjEh7LLQ3RVW8/Gcl26CEFFwbvE
         zBmsN9nZQNsP82m9R+GN3kzTEJfsutwwyjjsZaHhTSBs0PCIuZwbybiKIIi2W7STwwxt
         54Ae2UMv+gpwG0L7ZLnJ92jH9ghFxYXP0UOMARskhzzc/quclBWJpGnNhkwcN2S+Kp2r
         d+z+hF6Fs5zEIfLnpBE39wVUuIRyswyG7lpLfzVVryWGiGE5juutS9HqXblPWz3+oHcD
         medYrh+U+ObIaWNPTWMDNkRdLPPInH/iKl2H2VXZPPZjvDTJv0Zc4LEjunbxOOwfHlSK
         LA8Q==
X-Gm-Message-State: AOJu0YztEDxhxhP8taAtLw0SlL2No9I1eK76+p+uw4NqN9itYMpEUvIh
	iqVWgnaS2Y/NPvebRYtOe44UtRQYS+ZS1+wMThhD0AiabtOFA7aea8wKK+1G4j28MLno+k0AYCm
	/jk1A/gB0gpuu8euvJTPS1ds=
X-Received: by 2002:a5d:5984:0:b0:331:3cec:2165 with SMTP id n4-20020a5d5984000000b003313cec2165mr2007874wri.8.1700131714566;
        Thu, 16 Nov 2023 02:48:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE7NsKKEAAjbY8zJdDPa65leIeCkC6dEdyIoSE7iJYMq/buhxbY80svcu2UXMWuNi65+e3tsw==
X-Received: by 2002:a5d:5984:0:b0:331:3cec:2165 with SMTP id n4-20020a5d5984000000b003313cec2165mr2007865wri.8.1700131714310;
        Thu, 16 Nov 2023 02:48:34 -0800 (PST)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id w7-20020adff9c7000000b0033130644c87sm13244575wrr.54.2023.11.16.02.48.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Nov 2023 02:48:34 -0800 (PST)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Thomas Zimmermann <tzimmermann@suse.de>, deller@gmx.de
Cc: linux-fbdev@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>,
 dri-devel@lists.freedesktop.org, Christophe Leroy
 <christophe.leroy@csgroup.eu>, Nicholas Piggin <npiggin@gmail.com>, Thomas
 Zimmermann <tzimmermann@suse.de>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 18/32] fbdev/ps3fb: Set FBINFO_VIRTFB flag
In-Reply-To: <20231115102954.7102-19-tzimmermann@suse.de>
References: <20231115102954.7102-1-tzimmermann@suse.de>
 <20231115102954.7102-19-tzimmermann@suse.de>
Date: Thu, 16 Nov 2023 11:48:33 +0100
Message-ID: <874jhm3rem.fsf@minerva.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Thomas Zimmermann <tzimmermann@suse.de> writes:

> The ps3fb driver operates on system memory. Mark the framebuffer
> accordingly. Helpers operating on the framebuffer memory will test
> for the presence of this flag.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Nicholas Piggin <npiggin@gmail.com>
> Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
> Cc: linuxppc-dev@lists.ozlabs.org
> ---
>  drivers/video/fbdev/ps3fb.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

