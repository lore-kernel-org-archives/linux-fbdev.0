Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B71AE17E908
	for <linux-fbdev@vger.kernel.org>; Wed, 17 Jul 2024 10:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721210749; cv=none; b=oGJxb1YRibI9EXKdz1rIvgzhysuIgW2mrYTRPeq93CZXs5eUVHkLjSGE/XKdWNBNhG0egI7a+QWOfqp/+lazSTQfCwuergr1iXEpDFJyxAMLyhacOwXNo7GTSeM6uDXQKum4g6KMDAYSdjJIUdrUrAeiFhIXRrNFJYHyiJ4UVm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721210749; c=relaxed/simple;
	bh=pzlczSgIwURpCz9vCGhpCop7+ZzG3dvlybeLgb8qzhQ=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XByakitSZM7O5160vmAEGlrOusou2NiHPTAAye14gh/rT4BESsYQob2wcM805hDmILB6DvwPOVse8bR8xX2hkrgCFN4dogylZArioDPg/gqGJk1D3JY5ivBYgFyOzxGjs+gnnQHWvYQcAHNFP0Ki/QtnKte16C2THWanrU3/LoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XJXu4GRj; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XJXu4GRj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721210746;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9XVOmJ5qZrjBzzyMjCpJUJSvkbzb7dNjfwAsLgNQSeI=;
	b=XJXu4GRjFMpicj9YFuDWop2HTBUs0rxxnGzqfrRPpNx2SRWr+dIFCdyFahTfo4Rl6P73tx
	LSi7dzo6qYyrtuZMbQRMn4PFOSKqpsmk6+8UWKboIFPLji+PwXoXEaawzwTy9gXMBKjiXg
	bnKJ+bBR6V4fM9q84G22PF0bjtFB/3Q=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-74-QAlJ1NyPPXuWs89zrwAHaw-1; Wed, 17 Jul 2024 06:05:45 -0400
X-MC-Unique: QAlJ1NyPPXuWs89zrwAHaw-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-367a3052cfaso5564152f8f.0
        for <linux-fbdev@vger.kernel.org>; Wed, 17 Jul 2024 03:05:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721210744; x=1721815544;
        h=mime-version:message-id:date:references:in-reply-to:subject:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9XVOmJ5qZrjBzzyMjCpJUJSvkbzb7dNjfwAsLgNQSeI=;
        b=nyfIKwEHrANIRayl5i2nZ6fGcTJhi2EqkOIZy5Aq5wP/DdE/2wSoNXQAQGCa2pUX8M
         okwU1PDnclASDD3wjob5BT/O6+ezVCYx8xA+rQb90Nmoid6qJBX+NwBu8rI8WG/zmBmV
         ZPcgOPaJDQcA6PM+dX2KYI8ftkEd5AoaQ9VAiYVnBpnPGFJKkviU5sYPiMls+DATxbOT
         0xJ05uVPxq/JnKn5WZk1CXuOFcwo8rKH2Xoqe77T+/AvPUc+KNyClXhFGDnUDQojPpch
         v7XfF5LB3cRDM1OcsEAHvoI92y4pD5lQhC8zsHdS/pcb554hOAPPcbUUewKFhjwHY7Ku
         FuPw==
X-Forwarded-Encrypted: i=1; AJvYcCU55G2fNENGHRJx6tyKURItK/bub5w3FObYpGrtng4Jq7Lb30JnteayZV7oRPxrHFnbL3AIdBdDnDU2g1Nj0v9yUlxP3PPyIrI/Z+Q=
X-Gm-Message-State: AOJu0Yy2MlpTBn/VZ9Q3eQ0TOt8BHWU8QqvEeNmmbULScTHs72NAG+ZJ
	wI2CgXuVp8/dtV5/B1K7kyoBKQ+Vt1NHKbfI3wFXhJbEQZHvMzoHsibn7xnv9PzowAMIJw6/KdA
	2IJbWt7M7c8aUZLfqnZt2PcgWdGESmUZ98OreoaeMvcKjiTN1zCCNto/USdDb
X-Received: by 2002:a05:6000:184a:b0:367:f054:620a with SMTP id ffacd0b85a97d-3683164e06bmr1376765f8f.30.1721210743908;
        Wed, 17 Jul 2024 03:05:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFFyrK5oxCiDB6/FrZj9Bduj3f7Nd98eJNJ/eqEUmn3jqfve7vxK7uYWjf+/MzztI+lNDC9JQ==
X-Received: by 2002:a05:6000:184a:b0:367:f054:620a with SMTP id ffacd0b85a97d-3683164e06bmr1376729f8f.30.1721210743535;
        Wed, 17 Jul 2024 03:05:43 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3680dafbe7csm11270820f8f.83.2024.07.17.03.05.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jul 2024 03:05:43 -0700 (PDT)
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
Subject: Re: [PATCH 1/3] drm/panic: Add drm_panic_is_enabled()
In-Reply-To: <20240717090102.968152-2-jfalempe@redhat.com>
References: <20240717090102.968152-1-jfalempe@redhat.com>
 <20240717090102.968152-2-jfalempe@redhat.com>
Date: Wed, 17 Jul 2024 12:05:42 +0200
Message-ID: <8734o85o5l.fsf@minerva.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jocelyn Falempe <jfalempe@redhat.com> writes:

Hello Jocelyn,

> It allows to check if the drm device supports drm_panic.
> Prepare the work to have better integration with fbcon and vtconsole.
>
> Signed-off-by: Jocelyn Falempe <jfalempe@redhat.com>
> ---
>  drivers/gpu/drm/drm_panic.c | 20 ++++++++++++++++++++
>  include/drm/drm_panic.h     |  2 ++
>  2 files changed, 22 insertions(+)
>
> diff --git a/drivers/gpu/drm/drm_panic.c b/drivers/gpu/drm/drm_panic.c
> index 948aed00595e..d9a25c2d0a65 100644
> --- a/drivers/gpu/drm/drm_panic.c
> +++ b/drivers/gpu/drm/drm_panic.c
> @@ -703,6 +703,26 @@ static void debugfs_register_plane(struct drm_plane *plane, int index)
>  static void debugfs_register_plane(struct drm_plane *plane, int index) {}
>  #endif /* CONFIG_DRM_PANIC_DEBUG */
>  
> +/**
> + * drm_panic_is_enabled
> + * @dev: the drm device that may supports drm_panic
> + *
> + * returns true if the drm device supports drm_panic
> + */
> +bool drm_panic_is_enabled(struct drm_device *dev)
> +{
> +	struct drm_plane *plane;
> +
> +	if (!dev->mode_config.num_total_plane)
> +		return false;
> +
> +	drm_for_each_plane(plane, dev)
> +		if (plane->helper_private && plane->helper_private->get_scanout_buffer)
> +			return true;
> +	return false;
> +}
> +EXPORT_SYMBOL(drm_panic_is_enabled);
> +

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

