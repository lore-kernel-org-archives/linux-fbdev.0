Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CF79344029
	for <linux-fbdev@vger.kernel.org>; Mon, 29 Jun 2026 10:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782728011; cv=none; b=U+o0Erpu8BgVws70k3Fd1YLrq5p5lpyOmrTvE4k5ioy1JZl+dxziuYuF4DHsRFjdn/FH7Rx6F8NKz/Jw1QWzvdEPPyStAnJ/YV8ho03S8QOCIAMHKfxtz5iEkQZjlCbhIeea4T2IOypV7IoGJcSQDv+dPb927/9RKp/hYrWuHPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782728011; c=relaxed/simple;
	bh=q5jIXaSxCjuxSv6Etj3isb1WoEQFQTRoZE/y/N6SYms=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Gc02LeJsMTAVWXwvmVYtQMW6YOlFiJXvsIW14PVraeweWj029/ja/qqsBh8Pao4FWG29I1MepJOUFGQ9AVYui6uFhZGVQWEY1f7cVI8+/kEUO4nrbtyxxsyO3xc+94pNtThA3rWiMsJHux/d6MM1aHrynMYi7RhAxGNbUdqlzc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=D/drcOTe; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ux9Rdt89; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D/drcOTe";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ux9Rdt89"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782728009;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xm3lnF8OGUYYjPMf1XDMCVfIs1+U/YDcq+T0Pc20cjo=;
	b=D/drcOTeMth0uxGeaihuQGZll0SbVNu1KnCSULdUvTTXQsOTWRwmd5jy4pze52WFojNaxt
	Pj1NhNsxLvrktmTumR+743cBkwIR9k8WTDAvY4S3tQsuZIm8OjugToUnH/41CsOv7WzE2B
	ClfntYZcTybKiZWqJQXkJngRp60KFm8=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-691-v1owirBJMl6VnalfwEJrNg-1; Mon, 29 Jun 2026 06:13:27 -0400
X-MC-Unique: v1owirBJMl6VnalfwEJrNg-1
X-Mimecast-MFC-AGG-ID: v1owirBJMl6VnalfwEJrNg_1782728007
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-473bc66c837so589184f8f.0
        for <linux-fbdev@vger.kernel.org>; Mon, 29 Jun 2026 03:13:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1782728006; x=1783332806; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=xm3lnF8OGUYYjPMf1XDMCVfIs1+U/YDcq+T0Pc20cjo=;
        b=Ux9Rdt898vLTFDGDzWsLNWO4o4J1o8nxzfpHYj6NOtDnZd/diBY0W2dXGGqa8rFMp4
         QLKY6O/kLwAlCmQsaFgMAcdMF/tLObMfLleAkntkI/XlRW8qDX3lbSD70tn+1OAhoW2U
         YoPd5Hl1hz23MiXcS+9ww0IbpeXcouaBqTiLqzA79a7XMNfVB77x/zWgkMqpdPLhOEx7
         g/1SL+6rHg3BZoMWDfgpQvavhOwdfNN/oOrf2UyZU+prnFtQilqckM2ZSQPuJDm50iW8
         ZRKfeWDf694WLZ+R3goW5oP92Jrz0Ev90kTAfaKdbLXnN+3n/xYZYNYwqJhasXfnB2L+
         appg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782728006; x=1783332806;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xm3lnF8OGUYYjPMf1XDMCVfIs1+U/YDcq+T0Pc20cjo=;
        b=C1hSwqzXmJqs8NE3jPkl3V1wj9gbL2Zs5cl1XL21vrt8EdVPCz7kVcRpycm04SV9Tn
         YLpMI1ZAfBFbiLyHf8J92CkYsD6vtZFdUYC379MaTS6I9FoGIfSsQU5SdvOsyK4jA1dZ
         kXmXTgYmGJtcO2lPgvvdJ9WCsREQY2PIUsyzk5Hp9OtWJf3MxAUkIkSgKuplai5RPlNp
         NJwG+zyKSiaX1ndvBlR17oS0JjUKyA70adwL0MFj2uSZfKnlkrWaCwmUv6XqpK+mTRt0
         y8CRRQ+w7VJ3hlslarUW1EW8IOyELxoPhF03IN0u/7sD43qID1wkPVAINLgF2mJBVqWM
         D2jA==
X-Forwarded-Encrypted: i=1; AFNElJ9O9x7P3nxSO3Q0xlNPxwDXPkue2tOOo8xcTjizNPJBFd0BafI/DfIiqAER3SyXrGbRVpJQVPpbgFoIGw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9K8mkh5MXz81IGTBv88YED8vOw/peKWl2Zu+QvoUdJmWSa1EJ
	m9T1c+32IqgzienGG+2iI/xTG8jw7+3xXnGSAUGrChGfAxJjr/WU02sud3KiU4GHNZau652SSPy
	qSPH25VDr+myyaRc4ANxIn/G2Mxm93W3ZeYzESON+QIX/Vgiqq03Uce6hUUJcRXz+
X-Gm-Gg: AfdE7cl3Zj5y0AErwUCpzfAdWs9xPCQb8OJAosuFeroUWakYBdxo44Rnt7+rsmQI/7P
	xtSMpaBB6nmHJpZTwxCPrNueBw2sb/UqLsU24ae9bW7zNOD7+pWdjUa8fRCEAaDaDcxmSRV6riQ
	Yk1sICiaE3qwLfx/CqIwfuOkNGN/Kqy6DIe/Oxvr4s9S84QZZxzRWdLOrM69IUR2mxWpaUGLq0b
	iAQgvEQaw0hbNtechmZzq3oBxVzIzt61PgnFtobZvC8TtnsZQR90e95zEx6qfRG4ch/0SR3Yf/3
	iM1jrIAGdjJMyfoPGm5x0PMKtCGs1AlWKAy9dpRYTSV0dFwsgQCRvrvy6hdUvXy/PRCZi1huQ1z
	HngyBVGGuRh9xfL17ZWDzIVg92FCVNFjyJBey84ycB/y4oEwdIw8kdY3tNFu2GC/PZUDy0A==
X-Received: by 2002:a05:600c:6218:b0:492:700b:deea with SMTP id 5b1f17b1804b1-493b71a21c5mr1717715e9.13.1782728006532;
        Mon, 29 Jun 2026 03:13:26 -0700 (PDT)
X-Received: by 2002:a05:600c:6218:b0:492:700b:deea with SMTP id 5b1f17b1804b1-493b71a21c5mr1717385e9.13.1782728006067;
        Mon, 29 Jun 2026 03:13:26 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4734df60acesm11346521f8f.25.2026.06.29.03.13.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 03:13:25 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Amit Barzilai <amit.barzilai22@gmail.com>,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, andy@kernel.org,
 gregkh@linuxfoundation.org, deller@gmx.de
Cc: azuddinadam@gmail.com, chintanlike@gmail.com,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
 linux-staging@lists.linux.dev, Amit Barzilai <amit.barzilai22@gmail.com>
Subject: Re: [PATCH v2 2/4] drm/ssd130x: Add RGB565 support to SSD133X family
In-Reply-To: <20260622152506.78627-3-amit.barzilai22@gmail.com>
References: <20260622152506.78627-1-amit.barzilai22@gmail.com>
 <20260622152506.78627-3-amit.barzilai22@gmail.com>
Date: Mon, 29 Jun 2026 12:13:24 +0200
Message-ID: <87jyrhd58b.fsf@ocarina.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Amit Barzilai <amit.barzilai22@gmail.com> writes:

Hello Amit,

Thanks for doing a re-spin and adding the SSD1351 support to the
ssd130x driver. This is much closer to what I had in mind than v1.

[...]

>  
>  const struct ssd130x_deviceinfo ssd130x_variants[] = {
> @@ -206,6 +212,7 @@ const struct ssd130x_deviceinfo ssd130x_variants[] = {
>  	[SSD1331_ID] = {
>  		.default_width = 96,
>  		.default_height = 64,
> +		.format_rgb565 = 1,
>  		.family_id = SSD133X_FAMILY,
>  	}

[...]

>  
>  	iosys_map_set_vaddr(&dst, data_array);
> -	drm_fb_xrgb8888_to_rgb332(&dst, &dst_pitch, vmap, fb, rect, fmtcnv_state);
> +	if (ssd130x->device_info->format_rgb565)
> +		drm_fb_xrgb8888_to_rgb565be(&dst, &dst_pitch, vmap, fb, rect, fmtcnv_state);
> +	else
> +		drm_fb_xrgb8888_to_rgb332(&dst, &dst_pitch, vmap, fb, rect, fmtcnv_state);
>

Since you are changing the SSD1331_ID to use .format_rgb565, what's the
value of keeping the RGB323 support ? It's not used by any other Solomon
family supported by the driver.

Ideally, we would like the driver to expose native formats besides the
virtualized XRGB8888. Geert posted some patches for SSD1301 some time ago:

https://lists.freedesktop.org/archives/dri-devel/2023-August/419937.html

but that never landed.

If that was the case, then SSD130X could expose DRM_FORMAT_XRGB8888 and
DRM_FORMAT_R1; SSD132X would expose DRM_FORMAT_XRGB8888 and DRM_FORMAT_R4 and
SSD133X expose DRM_FORMAT_XRGB8888, DRM_FORMAT_RGB332 and DRM_FORMAT_RGB565.

Given that we don't have that, I suppose that we could just get rid of the
DRM_FORMAT_RGB332 support for SSD133X and just default to DRM_FORMAT_RGB565.

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

