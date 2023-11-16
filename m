Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iaOScH2q"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBBC31A3
	for <linux-fbdev@vger.kernel.org>; Thu, 16 Nov 2023 05:10:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1700140216;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mrGmsjr48vvSt4Jlx14HfvIRMMMvtnKQ8EBuWRi5SBg=;
	b=iaOScH2qZDkCOJynmRmUq+iY8rqR2SOtgg6kfNhuXUSwO8ZaZ9Brj8ZA49JRMpMlrgnd4x
	NYsjV5YgbzlyFIQMWtPUuIr5JLy7I0972Ui6PokYj7Pwz16lEMkhpeoqiypphGCf0Qcvbm
	BrNhNFnPYTn6LNbO/MzlXob84YkyMDQ=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-284-ePS1GJzYOQ2e-OH1xAazyQ-1; Thu, 16 Nov 2023 08:10:14 -0500
X-MC-Unique: ePS1GJzYOQ2e-OH1xAazyQ-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-32f798bc811so393242f8f.1
        for <linux-fbdev@vger.kernel.org>; Thu, 16 Nov 2023 05:10:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700140213; x=1700745013;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mrGmsjr48vvSt4Jlx14HfvIRMMMvtnKQ8EBuWRi5SBg=;
        b=v+WW77OsnNBNYPuaqRkFFUZmDUbngMm/1B/HpLJHQBAIIP6P4uwuB5wFUEQZNB1lG6
         dSSLNLx41u1bllcEmhgwK4JkY90deQbLPzgvfrlxsIvND3sU/zP9KWMj7wtQ+BIxDUzn
         /4T3455Xn3p4OyIu8bOQaoq2RiE07X3VHQH3bggfXW6i8Dwihywpoa2DntT59C6CYFtJ
         2oxGp7A+3z0SfdiTlAaw54OaPjOm4DGwld6iTipsIDOKCZM1hfe4dGZhWVSIWY/7iJzx
         ha+DodXWyoy/4qbgre8rVGRMILfR5SXtSAJwhgRmAcFEFPsahOsU3E5m2mZq2UZWrS0E
         nOWQ==
X-Gm-Message-State: AOJu0YwEbv0CE88yD28PdskUB0qvT2BIXYcYbTUEimbuMvPPrqtH/nh3
	SW/Y7LsAGRfpJkVsWkKU6NOoKc3tt9gzTS87IBum4/WVXyqKh6GXCLo52Ho444g1a9Nw2C9wKXg
	yZWaREj+ZLZJyZgEcexvjzSE=
X-Received: by 2002:a5d:58e1:0:b0:32d:b289:4bda with SMTP id f1-20020a5d58e1000000b0032db2894bdamr11453149wrd.40.1700140213603;
        Thu, 16 Nov 2023 05:10:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF3TpPzho2RAiZPqL/bbKINoeN3Ay14lbtxiuo/KeGYqzEtW96hvu1Xrb1r+wGaH+lKpKTn4Q==
X-Received: by 2002:a5d:58e1:0:b0:32d:b289:4bda with SMTP id f1-20020a5d58e1000000b0032db2894bdamr11453129wrd.40.1700140213264;
        Thu, 16 Nov 2023 05:10:13 -0800 (PST)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id h6-20020adff4c6000000b0032fa66bda58sm13742368wrp.101.2023.11.16.05.10.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Nov 2023 05:10:13 -0800 (PST)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Thomas Zimmermann <tzimmermann@suse.de>, deller@gmx.de
Cc: linux-fbdev@vger.kernel.org, Thomas Zimmermann <tzimmermann@suse.de>,
 dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 30/32] fbdev: Move default fb_mmap code into helper
 function
In-Reply-To: <20231115102954.7102-31-tzimmermann@suse.de>
References: <20231115102954.7102-1-tzimmermann@suse.de>
 <20231115102954.7102-31-tzimmermann@suse.de>
Date: Thu, 16 Nov 2023 14:10:12 +0100
Message-ID: <875y213kuj.fsf@minerva.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Thomas Zimmermann <tzimmermann@suse.de> writes:

> Move the default fb_mmap code for I/O address spaces into the helper
> function fb_io_mmap(). The helper can either be called via struct
> fb_ops.fb_mmap or as the default if no fb_mmap has been set. Also
> set the new helper in __FB_DEFAULT_IOMEM_OPS_MMAP.
>
> In the mid-term, fb_io_mmap() is supposed to become optional. Fbdev
> drivers will initialize their struct fb_ops.fb_mmap to the helper
> and select a corresponding Kconfig token. The helper can then be made
> optional at compile time.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

