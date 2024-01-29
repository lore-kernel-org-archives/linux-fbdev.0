Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9B9D3C689
	for <linux-fbdev@vger.kernel.org>; Mon, 29 Jan 2024 11:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706528310; cv=none; b=QkNvoAx6iYwMr8ON1eThH0y0Hk+wSLE+pzfePBbwHdLZGe5u+fYdnANrswdimsriWKDXLc/tD+F8H9eFWRtdUgb3YUUlLM/Q3RPd4DfQsOvJEVERL7afJvJdGMvsFfp2ZPYibGBK6yY/KQ2XHYJGoZY9mR4/oIADo/VEoqtfqEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706528310; c=relaxed/simple;
	bh=d+h3+acNz1FHtD1U8Fn0JHVlY/KaDiYkTb600vrAVBc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gf5VDW2CDq913XggXXMB4R3xh5rJDfsnp+NnwiZ6OkIRIrJha4P0zXeSwQ0z1iDqfRgtoKho93mTPquZ8TjrYcsjaLE/bNYrb7fWVYJYlDitLtnFeGJnAMJ+LfY4hIormDls+3we8zTODykeR2MyeMmsU+TK1W7MAYvi2nvoX58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BMo6d6VJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BMo6d6VJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706528307;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MapLRoPeuEFrrH0tJJpiZIJsI8BXc3+tcezhCX1GwpY=;
	b=BMo6d6VJgVrvU1osAqY6mOkiRLBWxrY4bQg5W24nDkoRYvvqHVj7SmQJNc1GWfHC4YYK6i
	slEFuBhCilPoZEV8kxm/y/CdqkFvpA4LcCASJ1c+zktxf2e0h8rTgZebAurMYN/yR0mukZ
	c1+Su/0h55gUQ5l/uuWyl3I+1Sgxdg0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-674-meYMT3LeNde4_TI7-pRoxQ-1; Mon, 29 Jan 2024 06:38:25 -0500
X-MC-Unique: meYMT3LeNde4_TI7-pRoxQ-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-40efbba82c8so1002775e9.0
        for <linux-fbdev@vger.kernel.org>; Mon, 29 Jan 2024 03:38:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706528304; x=1707133104;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MapLRoPeuEFrrH0tJJpiZIJsI8BXc3+tcezhCX1GwpY=;
        b=MMW+v7JDePQ2/InVohB17QtHLALkYKszZ/Ob5nNGybj8No4WB1arTOD9mp/GKLNr8x
         x2IVl7dNB4zV2jkGI1TWE/n/+a1h3uFGMVDmUR5tYE8lp6eb/kFzhOtBQt1sO9jFabKt
         OWKIYsr9fYOoXgoKWeXYM0W3CG+dtfn6El/wjh6DplhQaDdpJyAd1Q/5TsRptBG+rLMz
         TqgTLzRgRcXpEABoiKPIAL8q6VMW76atEBI8hKwJDdtu/YEO+VpvYqH7jHzG834oo5ki
         c++xEI87vFWQvF/UMKpS1+9Zx5UGlGXR+hNpbEqVRdkr0k+U00ViZfrRdE7YA6sG57Lf
         HTrw==
X-Gm-Message-State: AOJu0Yw8Bw+YKTWpde38twSgG6OWuLS4ALwU3onldQvnf+IkqAa5EFRP
	jVB81cDNtKWLYzQXaXEextka0zKaIOHvi0XotkeqtGJwUNzBRsav7YgS8XF7fsIyZCcmLu7jQhx
	hqAW1FQUFjIRDylVA5Pk0yRuBOlI6iQs4UbdGKwROZw34jeiH2cM6Q2GI9hHT
X-Received: by 2002:a05:600c:4f11:b0:40d:9057:41f0 with SMTP id l17-20020a05600c4f1100b0040d905741f0mr4912033wmq.8.1706528304698;
        Mon, 29 Jan 2024 03:38:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFkfybKQE+/gcxapqh/FqbHFBr8PruLoUynoBGLGAl6tJpemFut/QmnhuNabpStubh/jkMPNg==
X-Received: by 2002:a05:600c:4f11:b0:40d:9057:41f0 with SMTP id l17-20020a05600c4f1100b0040d905741f0mr4912017wmq.8.1706528304394;
        Mon, 29 Jan 2024 03:38:24 -0800 (PST)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id t5-20020a05600c450500b0040e9d507424sm9886873wmo.5.2024.01.29.03.38.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 03:38:24 -0800 (PST)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Thomas Zimmermann <tzimmermann@suse.de>, pjones@redhat.com,
 deller@gmx.de, ardb@kernel.org
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, Thomas
 Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH 6/8] fbdev/efifb: Do not track parent device status
In-Reply-To: <20240117125527.23324-7-tzimmermann@suse.de>
References: <20240117125527.23324-1-tzimmermann@suse.de>
 <20240117125527.23324-7-tzimmermann@suse.de>
Date: Mon, 29 Jan 2024 12:38:23 +0100
Message-ID: <87il3cv07k.fsf@minerva.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Thomas Zimmermann <tzimmermann@suse.de> writes:

> There will be no EFI framebuffer device for disabled parent devices
> and thus we never probe efifb in that case. Hence remove the tracking
> code from efifb.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---

Nice cleanup.

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

