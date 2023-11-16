Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K8+ZCOnZ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97CD9D5A
	for <linux-fbdev@vger.kernel.org>; Thu, 16 Nov 2023 02:16:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1700129799;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uDwACU7dtp8fJ4WW5xK6PlRB4Fg6zXxs5sSrL3YNTGw=;
	b=K8+ZCOnZoRLCAtugB9jNGOc/NOEutGctEh9Y16wioBSZtP7/G1Hp61oy/MpS31Xo3CoHnp
	bhAGOZaTcRE9qH5u9mJqFyFwffhRononhP+dCD03G2E2PVdHSavFgTR2gK6LnLz3G2FcJO
	OKPA7RAawFrtAKxKrqNMLX2ZsQ8ic58=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-296-dueZEHF2MROTT90f6hmOdA-1; Thu, 16 Nov 2023 05:16:37 -0500
X-MC-Unique: dueZEHF2MROTT90f6hmOdA-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-32d9b520d15so283542f8f.3
        for <linux-fbdev@vger.kernel.org>; Thu, 16 Nov 2023 02:16:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700129797; x=1700734597;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uDwACU7dtp8fJ4WW5xK6PlRB4Fg6zXxs5sSrL3YNTGw=;
        b=nPtaTBRxzaTG/MpVs/GnsQQDr37PwxsgCtJ2zWdYXSjAtwvcl5xAgAL+zZvcZNWvsW
         oQhBY7wZxksbE18b7/fTmR2Otkxa+usYxdkH6izsv/WwILz5YT9xCsq7Q9s9TD0NWsg6
         dEU+h4pEe+NgOo2JOiqR4fOCcE9p1KytiB5KuBXMUOqJZH4tXGK/kHfJ04Bq7bPxJrKi
         XXVyud4jHWo+JpgDcAYvKSomIqFLvntLvu2cNxLowyWgiOzNaaxWRZylnZFbyWGKuzPk
         vYoDdZ+355ydR3RZrspNE+kRuTa14sVvbttd1AlrgKQgGROgetnYghoYOCqHRzz1ig5q
         GVNw==
X-Gm-Message-State: AOJu0YyXwbxnMYlRJ5XhLoBd/4DTQ1fDMHcNvZbKc0C5Z1X55jorWuIh
	ti72uoN69b59OiVa7rK5AFXztj2TRMf73F0L4VkpVhkwlO/59Cm3nyO35CnqoFmpoiDc1Afk390
	AIwSMEhnqJYv6OOIJMGNhGgU=
X-Received: by 2002:a5d:598b:0:b0:32f:77a6:52ea with SMTP id n11-20020a5d598b000000b0032f77a652eamr12512698wri.61.1700129796875;
        Thu, 16 Nov 2023 02:16:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHjM/ZjRb/J7PFHTr4EsIs7Wr3JSQTtPxs9S1xb4LRj7HRY0TPAX/UHfJmGKcDjv2BmCJjbGQ==
X-Received: by 2002:a5d:598b:0:b0:32f:77a6:52ea with SMTP id n11-20020a5d598b000000b0032f77a652eamr12512688wri.61.1700129796599;
        Thu, 16 Nov 2023 02:16:36 -0800 (PST)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id f13-20020a5d4dcd000000b0032f7c563ffasm13019302wru.36.2023.11.16.02.16.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Nov 2023 02:16:36 -0800 (PST)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Thomas Zimmermann <tzimmermann@suse.de>, deller@gmx.de
Cc: linux-fbdev@vger.kernel.org, Thomas Zimmermann <tzimmermann@suse.de>,
 dri-devel@lists.freedesktop.org, Jaya Kumar <jayalk@intworks.biz>
Subject: Re: [PATCH 06/32] fbdev/arcfb: Use generator macros for deferred I/O
In-Reply-To: <20231115102954.7102-7-tzimmermann@suse.de>
References: <20231115102954.7102-1-tzimmermann@suse.de>
 <20231115102954.7102-7-tzimmermann@suse.de>
Date: Thu, 16 Nov 2023 11:16:35 +0100
Message-ID: <8734x657gc.fsf@minerva.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Thomas Zimmermann <tzimmermann@suse.de> writes:

> Implement the driver's fops with the generator macros for deferred
> I/O. Only requires per-driver code for the on-scren scanout buffer.
> The generated helpers implement reading, writing and drawing on top
> of that. Also update the selected Kconfig tokens accordingly.
>
> Actual support for deferred I/O is missing from the driver. So
> writing to memory-mapped pages does not automatically update the
> scanout buffer.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: Jaya Kumar <jayalk@intworks.biz>
> ---
>  drivers/video/fbdev/Kconfig |   5 +-
>  drivers/video/fbdev/arcfb.c | 113 +++++++++---------------------------
>  2 files changed, 27 insertions(+), 91 deletions(-)
>

The patch looks good to me from a high level point of view but it's not
trivial so it would be good if Jaya Kumar can review / test it as well.

Acked-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

