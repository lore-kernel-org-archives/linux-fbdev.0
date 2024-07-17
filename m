Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84779315BA
	for <linux-fbdev@vger.kernel.org>; Wed, 17 Jul 2024 10:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721210993; cv=none; b=qLKjUH/wkOGUxLNHxi4NAbpawbvIxHkQhYaoGBjE75VUGcAx7dk0a4g/2mH33MjDp8FlBg4vzyLQy+fcb1Whvp/qavU6hOVXZ9CoipOWc8WXEwYw+glqgQd1vJDPu3QTM3pWnzzXBW3USOZcJmHzDr+3VFA5eAqI6B75scdPkCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721210993; c=relaxed/simple;
	bh=YzP3L1MpD9GNj1M3MDVMM9AG5cWfXEtMJxVSBk0hXRE=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bXHocMGe3pCxsQ8eHygxGB/F38q0PDyB+VGP+DYvDyygdzWKCSML/q8kQ2dv4G2KaWQ3qIQJUQ36FWotpELjhcQ1YQduQnbitQmM0VR0TSBArwMh646m+8Vd9bOuQ4a6h5QtS8YiQGaPIDmczKYtkhudbbJHfeeYyL855YEhyD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=A+j8HAU3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A+j8HAU3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721210990;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3fgHkqvfngesDByFlySmzTO1my6KcXoQjEWiFHxkIfE=;
	b=A+j8HAU32xEtw+RN7Ps01VmMBIO4HlLR4PPFGnYG55I2foHTYe/WBWVAiEn4SLl2nyxisw
	1/O6czDtjEjBeIFe6kSv/0KPs1aWCPZwHp/8laUVMeMpt0bODMeLP4Hzt1HfXlTH0z9ogc
	3rHxxK5CjHcLJjs+drijHSvZhcC6DPE=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-671-U-Cq76ygPxiAoVqJPO3ypw-1; Wed, 17 Jul 2024 06:09:49 -0400
X-MC-Unique: U-Cq76ygPxiAoVqJPO3ypw-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-36789dfcc8bso3982294f8f.3
        for <linux-fbdev@vger.kernel.org>; Wed, 17 Jul 2024 03:09:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721210988; x=1721815788;
        h=mime-version:message-id:date:references:in-reply-to:subject:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3fgHkqvfngesDByFlySmzTO1my6KcXoQjEWiFHxkIfE=;
        b=Zw8+ypLcF9i8eYucoV92qDWa6bY3b0rOi1dH02SRNWgetP65cLJHiu/iZSk5bDFKf8
         OStwfndKh5vam/j0qY+R4GIv+08j8/vRMigf9lk8xtOK3nGk4nfbBv3de/8PS+MofF/Z
         4zaL8sgdqDtr6hXZ+kc99DT9v7CidzbO7ox1A+nE72B3DbeCTJuVte4amMd12a5+MMsv
         UcLzSvvnOmkKY7Ij7NaxGWxxpyg8Qm0TFIJlXKyz8loQ8myLqlUH0LS7YVrKVHYK2Aws
         hHkwOJttBCVs/cZjbM1X+PrH9nX4GsLnTX+17iCpX3BBu934f58bPKRpANHOGQhpSwRO
         m0nA==
X-Forwarded-Encrypted: i=1; AJvYcCUhVxjxjf/FLvvkx9upjFHOiGjBp75XNB36gqrntucE5SDF0TeY8Lcib3EnE/6oCCTIOTo1trmHCcZ5qBAo7xppcPbk7I81bqWeYLQ=
X-Gm-Message-State: AOJu0Yy9+CP1pOq8IAZ3jUvaSSKn24rQQGvYNNlIi7nPeeByYIUAAPlF
	5LM16mK9PTvDlYX+yao8j6bS8DFholjr/dqzvyzijFm1/XBP9o2i7Cggt79Mj2559e1TzeiJPnt
	4oWnJDmF+iqqYzxg3tF5RuszfE8voA7lvOkgGT857dr/P+A5MZK7FCQf6OL5b
X-Received: by 2002:a05:6000:1e92:b0:367:98e6:362b with SMTP id ffacd0b85a97d-368316f85cdmr754686f8f.42.1721210987911;
        Wed, 17 Jul 2024 03:09:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF5Lz0mGct43oO7Dy78Pu2M8nlnZoQ28GtDeNJR5prCRw0WEetXSwvYy2HHKS7mxHnPOm5GIg==
X-Received: by 2002:a05:6000:1e92:b0:367:98e6:362b with SMTP id ffacd0b85a97d-368316f85cdmr754664f8f.42.1721210987514;
        Wed, 17 Jul 2024 03:09:47 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3680db038f4sm11142783f8f.94.2024.07.17.03.09.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jul 2024 03:09:47 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Jocelyn Falempe <jfalempe@redhat.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>, Helge Deller <deller@gmx.de>, "Jiri Slaby
 (SUSE)" <jirislaby@kernel.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Geert Uytterhoeven
 <geert+renesas@glider.be>, Samuel Thibault <samuel.thibault@ens-lyon.org>,
 Jocelyn Falempe <jfalempe@redhat.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org
Subject: Re: [PATCH 3/3] drm/panic: Remove build time dependency with
 FRAMEBUFFER_CONSOLE
In-Reply-To: <20240717090102.968152-4-jfalempe@redhat.com>
References: <20240717090102.968152-1-jfalempe@redhat.com>
 <20240717090102.968152-4-jfalempe@redhat.com>
Date: Wed, 17 Jul 2024 12:09:46 +0200
Message-ID: <87wmlk49ed.fsf@minerva.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jocelyn Falempe <jfalempe@redhat.com> writes:

> Now that fbcon has the skip_panic option, there is no more conflicts
> between drm_panic and fbcon.
> Remove the build time dependency, so they can be both enabled.
>
> Signed-off-by: Jocelyn Falempe <jfalempe@redhat.com>
> ---
>  drivers/gpu/drm/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
> index 6dd0016fc9cd..a22cab218004 100644
> --- a/drivers/gpu/drm/Kconfig
> +++ b/drivers/gpu/drm/Kconfig
> @@ -107,7 +107,7 @@ config DRM_KMS_HELPER
>  
>  config DRM_PANIC
>  	bool "Display a user-friendly message when a kernel panic occurs"
> -	depends on DRM && !(FRAMEBUFFER_CONSOLE && VT_CONSOLE)
> +	depends on DRM

This is great. Thanks for finding an alternative approach! I don't see any
issues this time, because there is no locking involved. But let's see what
others think about it.

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

