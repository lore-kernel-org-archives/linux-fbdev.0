Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OHQ5zROe"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DA19D5A
	for <linux-fbdev@vger.kernel.org>; Thu, 16 Nov 2023 03:30:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1700134219;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5rw/Y06vMJw+yRqzRy2b73TtPoc6ulI8+aEjabQdVw8=;
	b=OHQ5zROevQ1gpbcfVurvbTjhevwDKl7e2Kfv2HcaMmJliJyHyt3kSlkcq9tHLVos84mCWN
	WuqwGaQlVYNeP4OEHbuF7EiyQuWR0ZQir49f1A1Sx9F0/Kb2Fdmfupn1fCodszEEidCpVw
	K6UspmpBm49ISfvhgwimJOFEEdhRZG4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-116-j3BOfdKwNcymWhyhdjOFIQ-1; Thu, 16 Nov 2023 06:30:17 -0500
X-MC-Unique: j3BOfdKwNcymWhyhdjOFIQ-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4084e263ec4so4010855e9.2
        for <linux-fbdev@vger.kernel.org>; Thu, 16 Nov 2023 03:30:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700134216; x=1700739016;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5rw/Y06vMJw+yRqzRy2b73TtPoc6ulI8+aEjabQdVw8=;
        b=g/K5RgazQuIRjm+Dkw8/BKItNOUm3CQxvveIiU3JB4EImg0sz2H/5ejtn8rfkzy9Pz
         PwFm5KdOwkccPyrxMEfkW6Cyqldl6PwYIEotwfaJ40XF1JwWv3BWDkINQNqfBp/YeMOr
         BXCP8Fsm71geWIUlNnE0sSXN8BkFKgJntNbCuBttIyTu/DA8q+xJv8oKp83woTUuGeyU
         YZ+0YPcZdMdUygFpviY0YK2lkWD+Yx8AtuJI+GzvQPtcWnRwzs29cf6OdcUYw9DcNO5G
         qbTXUX2HubfUo8Qt/g+n5Dhf4Id+hdTBmcz+5PqgqQDWI197T0oXbZpdaX24JTHrTxzM
         DEfg==
X-Gm-Message-State: AOJu0YwAolWmmANlabdF/LV/jh+YlF2vi+hUqRO5OhImW22bM/WtgJcO
	H56NFYLags/oEDlPRgKnSv5fV4W9KF2FafXq7/x2dmHbGhZU33wYsZ6wnoSAQLtjUjoZUSaCe3u
	LpTVXNAH1y2GCRNjQ1ulXLic=
X-Received: by 2002:a05:600c:4c12:b0:401:d803:6243 with SMTP id d18-20020a05600c4c1200b00401d8036243mr13123247wmp.32.1700134216708;
        Thu, 16 Nov 2023 03:30:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHNP8sm6GS9ICIgmN7ODvHC6GI3xgBmbOiDc1FWEffDy9qcOMp/L9eZ6d+g379RfR2Gz68HTg==
X-Received: by 2002:a05:600c:4c12:b0:401:d803:6243 with SMTP id d18-20020a05600c4c1200b00401d8036243mr13123233wmp.32.1700134216363;
        Thu, 16 Nov 2023 03:30:16 -0800 (PST)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id i19-20020a05600c355300b0040813e14b49sm3244058wmq.30.2023.11.16.03.30.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Nov 2023 03:30:16 -0800 (PST)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Thomas Zimmermann <tzimmermann@suse.de>, deller@gmx.de
Cc: linux-fbdev@vger.kernel.org, Thomas Zimmermann <tzimmermann@suse.de>,
 dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 22/32] fbdev/vt8500lcdfb: Initialize fb_ops with fbdev
 macros
In-Reply-To: <20231115102954.7102-23-tzimmermann@suse.de>
References: <20231115102954.7102-1-tzimmermann@suse.de>
 <20231115102954.7102-23-tzimmermann@suse.de>
Date: Thu, 16 Nov 2023 12:30:15 +0100
Message-ID: <87sf562awo.fsf@minerva.mail-host-address-is-not-set>
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

