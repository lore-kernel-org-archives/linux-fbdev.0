Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P3DaPKNd"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64C32D49
	for <linux-fbdev@vger.kernel.org>; Thu, 16 Nov 2023 03:57:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1700135855;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=d0x9UvS/AGzYjlZ/Z2zNd3aI+mpUR93ucZIMrrtEjbM=;
	b=P3DaPKNdVSNLQmXBIq6QsXC5XSBKuyQXcnTCioWXQ80VCorMGZRxp+dNzBKbpX39KmBQXS
	CSWscRcWSQ0ofHyPGip1V1j+bGwlboG98lvrjqWZhG+rinQ2jF6Pb9Ktl7n3SBzFBZrQ6B
	4heoXWweYVwii+mXVquz5M00GIGiIOA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-44-XH8kUjAWPjy2Cc2HdWX1mw-1; Thu, 16 Nov 2023 06:57:34 -0500
X-MC-Unique: XH8kUjAWPjy2Cc2HdWX1mw-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4083fec2c30so4005545e9.1
        for <linux-fbdev@vger.kernel.org>; Thu, 16 Nov 2023 03:57:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700135853; x=1700740653;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d0x9UvS/AGzYjlZ/Z2zNd3aI+mpUR93ucZIMrrtEjbM=;
        b=RmAVPSqfcKv2S24PM92cl4G3SAZonWNepgOgjI16QLTFDjTzaY3zyui2lAxZnCB91R
         CndL6PB36QLgNi0PkPp8CtBX+XdxLdwX/jA+7veEEzC/EflJT+vgUEBbsLcMiq6Vuy3u
         Z5fY6GaLMAGvyaW6BFRmOQRBfHsRwjuXoETSSUxEi+F7RVPc5LCAfedyJC0UL7tDnzbY
         AOV7IKEZdPhke8yBivte1TUTMVK2NQmkUUsj4C3OoKse3b+ylr9/+jO5CliJP/wyQLX2
         mDDYhLdlbhtmYHf0Ydt7uAhdil9JXFumF5Cq1jgq0HatIEmLAMQiUAdPkPrB6QdnhYMl
         86Xw==
X-Gm-Message-State: AOJu0YxpjIx5/zRWuRlDJOC/d4tGkONhGfU6KPFaEdC30kfH3AOE5sxE
	kpRHknQfpmgVDeFSp7I9JkGJsXxcTzih5o6CtA31OFMSRFnStAJbs9IX71KINtoOZFFKB+9P5ru
	ontNNnBPeircB/0XDdVAiQok=
X-Received: by 2002:a05:600c:45cb:b0:407:4944:76d1 with SMTP id s11-20020a05600c45cb00b00407494476d1mr13758924wmo.17.1700135852900;
        Thu, 16 Nov 2023 03:57:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFm26jbjrnNx5RwuUbvEv4kZjrhk1hAedzBux3U2jDdTSsXmQhUUYJ6Mw3sAUj+R0Hgu6ZZMQ==
X-Received: by 2002:a05:600c:45cb:b0:407:4944:76d1 with SMTP id s11-20020a05600c45cb00b00407494476d1mr13758914wmo.17.1700135852559;
        Thu, 16 Nov 2023 03:57:32 -0800 (PST)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id j6-20020adff006000000b0033142b1a1eesm13008753wro.87.2023.11.16.03.57.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Nov 2023 03:57:32 -0800 (PST)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Thomas Zimmermann <tzimmermann@suse.de>, deller@gmx.de
Cc: linux-fbdev@vger.kernel.org, Teddy Wang <teddy.wang@siliconmotion.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-staging@lists.linux.dev, dri-devel@lists.freedesktop.org, Thomas
 Zimmermann <tzimmermann@suse.de>, Sudip Mukherjee
 <sudipm.mukherjee@gmail.com>
Subject: Re: [PATCH 26/32] staging/sm750fb: Initialize fb_ops with fbdev macros
In-Reply-To: <20231115102954.7102-27-tzimmermann@suse.de>
References: <20231115102954.7102-1-tzimmermann@suse.de>
 <20231115102954.7102-27-tzimmermann@suse.de>
Date: Thu, 16 Nov 2023 12:57:31 +0100
Message-ID: <87h6ll3o7o.fsf@minerva.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Thomas Zimmermann <tzimmermann@suse.de> writes:

> Initialize all instances of struct fb_ops with fbdev initializer
> macros for framebuffers in I/O address space. Set the read/write,
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
> Cc: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
> Cc: Teddy Wang <teddy.wang@siliconmotion.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: linux-staging@lists.linux.dev
> ---
>  drivers/staging/sm750fb/sm750.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

