Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2698C127B4E
	for <linux-fbdev@vger.kernel.org>; Tue, 16 Apr 2024 11:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713267808; cv=none; b=Q/zzMb69LwPv/BndUSyoAmD2wk+kywPnZhb9tcMChZM26oPKHeI2xyJjuDEJBeb4sj/GZulRjWy2kc3+b+I9P/hYY7ezF8AchFtHZXNuQewuEWkvbC4sZSfwQpfvQPrhK3Ottrpnm/hk8PgsnrXxR5r/UdnVftF0c+KPhETlWPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713267808; c=relaxed/simple;
	bh=nlBoBmZlIK2yBwYigFj7PRjo2Tt0Iwv+fEe0o7ikbf4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jWTjyegXMKOibROx01ZiRnXWZfVSVz9TIaYPeoo8Ief/U99ISv3f0Pf1IbUf/8uxLysueQBnSodO39vLpEsVwIoNWlbKJWxFt9NONXQqm3r9Sq9GR/sY/eu7Gp1aUqxvHUTwgLHfXNf5d7KVWtGQZ//4Xzwm+4or1GWnCcdyJwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MC4mVoS7; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MC4mVoS7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713267806;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Wb3JEx20zw4eUQGnsrErjLegQ+vx1DO/aEEtOUxHocU=;
	b=MC4mVoS7IvjErfGFYPRfqZzP2uxQbQLqRorS2xVTfdL+nJch8+jvXRbmHhxeVNzx3pgLMk
	YOMiDoNM5DVhuyOpQfFqWCU2jr5mdy8ww788J7r8/qQHKLQ3i2dpMuUWeuqhUmZYb4R446
	9awOitOjbtmmgXQG1ra84/45RXGUJMQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-638-iC4qbiZzPhO60gyEP37rPQ-1; Tue, 16 Apr 2024 07:43:24 -0400
X-MC-Unique: iC4qbiZzPhO60gyEP37rPQ-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-41634d6c008so14560655e9.1
        for <linux-fbdev@vger.kernel.org>; Tue, 16 Apr 2024 04:43:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713267803; x=1713872603;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Wb3JEx20zw4eUQGnsrErjLegQ+vx1DO/aEEtOUxHocU=;
        b=R1SskdD0JqXpoE4Quj8YMoyXm2qee4/KhyUHV3n0uRvolcarsfGupTrHFYfBwCF5X6
         TwMlpaSY7XVmYoNXYmZ1iVXuz2tQPjEmnOlrATFqew/6BJzWnPdrihosD7lX6vumBFYU
         hddS7XJQwNAf5vlnTtPE8rFeH020YobCmtuIduct3u2ixh2xOSSZOHSWspr/x4QwkaKs
         XIO7w3GHUfu8JK0oupwtz9KD6i9B6skPSLO8LM93/PVNDsOuRuTMa9hIJj33uJ0opU0/
         zFlsqwBMjum6nTPc5jwTZ0lTT80+fVEIp3Xtnn2wPDVwbj3Jc6y6Sc4zRAPl283nBbX2
         +5FQ==
X-Forwarded-Encrypted: i=1; AJvYcCWmHXmElK9X5D9YIf71u0Adb3hpxYr14xLX+Hr+8sBXtq02cGpYaZJcZnIk6YDF7DgDsFUH5haJFvSIJPZA+RfkdZrKvMJ/xGCRcm0=
X-Gm-Message-State: AOJu0YwHyw21EQSaNSlpjbjRs1qzPJIwyI4rx+TEqbJMjUjzlBCJ92Br
	qB/Lj74Q6XGB0uV60bHE2UBJpBzwcn6J6sAlVKPD+nzwmSmKhbV+IN3SZzla5/fdTaX4+sVRg8+
	K0m+foiNCb0JxsmA9uR7YhT4d1QjM/jkulUVLOsn/xXgncWUzIWFvNCXUQ1e6
X-Received: by 2002:a05:600c:511d:b0:417:eb6d:102f with SMTP id o29-20020a05600c511d00b00417eb6d102fmr10310756wms.8.1713267803652;
        Tue, 16 Apr 2024 04:43:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGBtrvHOAoUE4NrCXo5UkEG4yfvCaIFeUBgoM4ZVFIKyJcfP9ptInipYOdi1Z9Hr+WK2KNPRA==
X-Received: by 2002:a05:600c:511d:b0:417:eb6d:102f with SMTP id o29-20020a05600c511d00b00417eb6d102fmr10310730wms.8.1713267803111;
        Tue, 16 Apr 2024 04:43:23 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id p17-20020a05600c1d9100b00418a386c059sm610078wms.42.2024.04.16.04.43.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 04:43:22 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Thomas Zimmermann <tzimmermann@suse.de>, deller@gmx.de,
 airlied@gmail.com, daniel@ffwll.ch
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, Thomas
 Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH v2 16/43] drm/tiny/ofdrm: Use fbdev-shmem
In-Reply-To: <20240410130557.31572-17-tzimmermann@suse.de>
References: <20240410130557.31572-1-tzimmermann@suse.de>
 <20240410130557.31572-17-tzimmermann@suse.de>
Date: Tue, 16 Apr 2024 13:43:21 +0200
Message-ID: <87cyqp7cti.fsf@minerva.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Thomas Zimmermann <tzimmermann@suse.de> writes:

> Implement fbdev emulation with fbdev-shmem. Avoids the overhead of
> fbdev-generic's additional shadow buffering. No functional changes.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: Javier Martinez Canillas <javierm@redhat.com>
> ---
>  drivers/gpu/drm/tiny/ofdrm.c | 4 ++--

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

