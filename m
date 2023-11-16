Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AvYveOlI"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A8FC181
	for <linux-fbdev@vger.kernel.org>; Thu, 16 Nov 2023 05:04:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1700139881;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=i5IVgqiEqoJ49lClny07bZ/gWmzQ0ruwNxmAm7UH1D8=;
	b=AvYveOlIaCeB9Q2yWoh6+7E2xZ1Vl8lqfNdtfqVZVjzf27Hwk/05iTC4kO7csgJGtMDEQl
	K08MRam53OqJ319qFUN45hYlFb4i48S2lc01KXKui9XmyCCoRLhnoXF6Y0bGeOopr4gDVQ
	sN1eepK/PP7GLIXkcBZ7fVBpH362DF0=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-122-HVEIkEiCNg2XQ_6r7BmnOw-1; Thu, 16 Nov 2023 08:04:40 -0500
X-MC-Unique: HVEIkEiCNg2XQ_6r7BmnOw-1
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-5082705f6dfso705439e87.2
        for <linux-fbdev@vger.kernel.org>; Thu, 16 Nov 2023 05:04:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700139879; x=1700744679;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i5IVgqiEqoJ49lClny07bZ/gWmzQ0ruwNxmAm7UH1D8=;
        b=XEwpmMi3iGu7888yrarhzraAikr8NkrdbbJ7yK0W6IEL69QcS9U/Ynvuqi2RVTMF3V
         xAqK76mCX5XldrIATQdGrPA6turi6eC6H/kDjwWYT2hmWNd69hvhm3K0BeazZcQoClP8
         UuyxdQPexUMrR6KDAzoNGIDjgp57YQq2J14km6LmSvYI7dbWJf9UIz8pa/OJwnrJvQHD
         IboUpQ8JR7fCRTbcB7UrcuziXknyIlSn05GQPqlaCfLKpir4abLmfYBWwiYEowHsL7HX
         LYPsiQfrB/Em/lNt+A45shWNUMdiPdVHWnD0XlyonWULL+AZBDp9CY+Mry3/SPjjt+ec
         PWkw==
X-Gm-Message-State: AOJu0YyF7iHetUrqPpGm0TZAH5mcRrvkCe4T9Bqjc8ADbaSWoslIRjqZ
	Dexm2Hpwtdyg8xJIj8ZqyqJoY20PFQBqW/Wz7fjku04sy1H6PlPqCU491MZGKMDCK6YpjUwcob+
	sbDKHZ8GYg/sfvuup+W7hFLA=
X-Received: by 2002:ac2:5e7b:0:b0:509:4bb5:ff96 with SMTP id a27-20020ac25e7b000000b005094bb5ff96mr10215988lfr.59.1700139878987;
        Thu, 16 Nov 2023 05:04:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IELaHWoKPOZd1awvlQQBLF29JOnWe+UNE8/3EFkQX8H5SVGYJQjhbk8K1U5KZLOF8g7ZMrIXw==
X-Received: by 2002:ac2:5e7b:0:b0:509:4bb5:ff96 with SMTP id a27-20020ac25e7b000000b005094bb5ff96mr10215973lfr.59.1700139878694;
        Thu, 16 Nov 2023 05:04:38 -0800 (PST)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id b11-20020a05600010cb00b0032f9688ea48sm13604491wrx.10.2023.11.16.05.04.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Nov 2023 05:04:38 -0800 (PST)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Thomas Zimmermann <tzimmermann@suse.de>, deller@gmx.de
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, Thomas
 Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH 29/32] fbdev: Push pgprot_decrypted() into mmap
 implementations
In-Reply-To: <20231115102954.7102-30-tzimmermann@suse.de>
References: <20231115102954.7102-1-tzimmermann@suse.de>
 <20231115102954.7102-30-tzimmermann@suse.de>
Date: Thu, 16 Nov 2023 14:04:37 +0100
Message-ID: <878r6x3l3u.fsf@minerva.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Thomas Zimmermann <tzimmermann@suse.de> writes:

> If a driver sets struct fb_ops.fb_mmap, the fbdev core automatically
> calls pgprot_decrypted(). But the default fb_mmap code doesn't handle
> pgprot_decrypted().
>
> Move the call to pgprot_decrypted() into each drivers' fb_mmap function.
> This only concerns fb_mmap functions for system and DMA memory. For
> I/O memory, which is the default case, nothing changes. The fb_mmap
> for I/O-memory can later be moved into a helper as well.
>
> DRM's fbdev emulation handles pgprot_decrypted() internally via the
> Prime helpers. Fbdev doesn't have to do anything in this case. In
> cases where DRM uses deferred I/O, this patch updates fb_mmap correctly.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

