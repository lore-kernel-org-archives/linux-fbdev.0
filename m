Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AjNM8dm6"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 842FB19E
	for <linux-fbdev@vger.kernel.org>; Thu, 16 Nov 2023 02:05:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1700129122;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JSNlp1+/gXMtVqoR/aOQ3Vuht8AOWTyGnk7nVUalkfI=;
	b=AjNM8dm6XxtO01UvZUD1IAEN/BUYD1S+16XnOt3JWzhADiPnygMzno0XY/fEDHXbwxcGP8
	nnPsvgpV/+SE5zWHBQ+7Gq08W2LB4ZSIRKMFHK7S4+cUkpStj3zGeWXhUQyQJTWhXLsL/B
	0fJINqQYEsR+zZc4EeadMUxI+8Jgmx0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-270-I7K0i-r_O-yaWPC8J5MPug-1; Thu, 16 Nov 2023 05:05:20 -0500
X-MC-Unique: I7K0i-r_O-yaWPC8J5MPug-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4083c9b426fso3170675e9.2
        for <linux-fbdev@vger.kernel.org>; Thu, 16 Nov 2023 02:05:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700129119; x=1700733919;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JSNlp1+/gXMtVqoR/aOQ3Vuht8AOWTyGnk7nVUalkfI=;
        b=WpXN2KhrzhCmZojQzOJmqT/GNyeJDab4dKOseqIOJjx2aQD//NsEo5luvlWWBHYrb7
         1l4wXjCiFnwPfHfUlbyD/IKgjYa6diGjzpvFjkYZdiZNfP/CbyXJGzr66G8FXDuxIFsG
         qcrm1m020ckjVlh+K0hijyHJvXbg50qI5jqQVJWWK3rQhFIuxDQegcvNsceb4+GrDe5a
         OEBzMdE8Ug7kEyEIRqpVNGp7i1isMYNz4VGScEadFnZXfQrmSQlls0o9urvqjsTxudkp
         U2+dzPK/JxqbxiBKpCfR1+img0RonsaeNDyOJ8SAFjmapTNwFZFIjrel84z5rXc3h/qM
         PmEg==
X-Gm-Message-State: AOJu0YwaurPhu45qBxzcH/okfAU3ffTdlxEJT+g5C9zwNNPFbDeXYPuu
	y7bRndt27NgxOn16Azqul8XjgXtj4RPAMbH3UiE6UuJYwE3VuC5ct1fxystjMa33T7wndoAEGEd
	7F15XEC7GtlRF9fKpmRHgTCA=
X-Received: by 2002:a05:600c:35c2:b0:408:80bb:ae80 with SMTP id r2-20020a05600c35c200b0040880bbae80mr1643805wmq.7.1700129119545;
        Thu, 16 Nov 2023 02:05:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFxq1W8dzn6d2MNNVy3msexF8xkL5g5RWLNAmn7R8Fnb73BFw9CCJrcGUUn/q5NdHTcxCRO3A==
X-Received: by 2002:a05:600c:35c2:b0:408:80bb:ae80 with SMTP id r2-20020a05600c35c200b0040880bbae80mr1643785wmq.7.1700129119125;
        Thu, 16 Nov 2023 02:05:19 -0800 (PST)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id p6-20020a05600c358600b0040a45fffd27sm2953271wmq.10.2023.11.16.02.05.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Nov 2023 02:05:18 -0800 (PST)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Thomas Zimmermann <tzimmermann@suse.de>, deller@gmx.de
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, Thomas
 Zimmermann <tzimmermann@suse.de>, Jaya Kumar <jayalk@intworks.biz>
Subject: Re: [PATCH 05/32] fbdev/arcfb: Set FBINFO_VIRTFB flag
In-Reply-To: <20231115102954.7102-6-tzimmermann@suse.de>
References: <20231115102954.7102-1-tzimmermann@suse.de>
 <20231115102954.7102-6-tzimmermann@suse.de>
Date: Thu, 16 Nov 2023 11:05:18 +0100
Message-ID: <875y2257z5.fsf@minerva.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Thomas Zimmermann <tzimmermann@suse.de> writes:

> The arcfb driver operates on system memory. Mark the framebuffer
> accordingly. Helpers operating on the framebuffer memory will test
> for the presence of this flag.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: Jaya Kumar <jayalk@intworks.biz>
> ---
>  drivers/video/fbdev/arcfb.c | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

