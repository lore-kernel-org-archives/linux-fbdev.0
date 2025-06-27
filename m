Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 178EE218E96
	for <linux-fbdev@vger.kernel.org>; Fri, 27 Jun 2025 07:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751010046; cv=none; b=fjJdy1BUeCk3Zzj8E7b8hjYacrh4drltkeaO5mg+VGVomptpG4YbvtarE1g8pCK8PRaMWudys1rbQ93wh6SvIdXgHKZfPD5KkOSTiNOYHp2MZZidDXXDeggRn+/L06bhaAqqUXHYGqmFYdRWROYFYf6dfSMs/3Ly3CCUW+OELd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751010046; c=relaxed/simple;
	bh=gN5pAE2IubpyXdGdukqbjuNT7itxOBgkgX1Y5EtimiM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=B3yJRr4mRrM05VbpdhiuYiCBZQ0Q650SVc08iH2WZ2jgmQlquNZxMiSKZI6tfR2xcBQ2C2865o3452Q2tyYlFrdVQsK3PfuXsNnKxWXCvngE1S3iWLid+cS+meX8IVkb8LV/ShFkcctH1WEaxYPPJM2ER1MyQ6AjeRhEq6Vty1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Z1D2b5jX; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z1D2b5jX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751010043;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rBnCGbSfprcirqT5UrYZ51B5MHbuiPAu4AbyyIVx9XA=;
	b=Z1D2b5jXp0BTZbpvEEVaY16eBUQPRnRFABFzBshcA25E3pcI2r67TjRnqaNPujdcGS8kkP
	n2VSz9ai6v0MT5BLXdagDGRMle27qUZbkZBIoRd46f/blrwnH+6JLtcvLxWyE/ubnfha1a
	U0N7H8A1QiNs2f8DsDnIvZHqhdugOm4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-621-bvduoFNyNX-QZVctio6T9g-1; Fri, 27 Jun 2025 03:40:41 -0400
X-MC-Unique: bvduoFNyNX-QZVctio6T9g-1
X-Mimecast-MFC-AGG-ID: bvduoFNyNX-QZVctio6T9g_1751010040
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-450de98b28eso13470775e9.0
        for <linux-fbdev@vger.kernel.org>; Fri, 27 Jun 2025 00:40:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751010040; x=1751614840;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rBnCGbSfprcirqT5UrYZ51B5MHbuiPAu4AbyyIVx9XA=;
        b=NqpwrkPeVen+rGEqAQTKZ+vocJZzEh46u2OJhhplxVbr21gKmTYPBI2LUcEJtkmBC5
         IJ0/p7tilZ1pOaRNQhYdKe/IZO1SftKfgnk/f2Gz1ri5mg6Plc0U/eFNrU2b9MFGCz2e
         t82sS4WPj8ZXeKy2yYojl3YN7uvcMYlR2T01YmhJd6no5o1/hAX2/sro+o4xCs35xOV7
         rmceouVf1CcK6IpNM0h6+Myt9/Ybq7terRpjvBWY6XMfbyjl5I4dBrAPYulUbMmtpp4e
         BZLKtZiKq1V5sw75SDAYcsHHxQxINeF+G1lkiNBexqCq9UlMuXK720ILY1YWXM9+mpSY
         0WPQ==
X-Gm-Message-State: AOJu0Yx1eZ+40f018jqBJhmchVTZA0kpPb48HatfN6jTdvwWqNCbRDOX
	BiQqrx8peVABjKSrr2dW5GQxPHOV0c4WreQ1nmFi6ZWlXy9YLtEB+kPWZ7kwJeiuakAGxmxldie
	zx2a345dWB9gO/U5WTulgTpWqHSj9am5PYASFTzjpgJgybBP3VIMpaOy8uXBOCELy
X-Gm-Gg: ASbGncsUYb2pkrmOLM1H2ym9wKToapsKDMMv4d0A+47JvLDvpdeMb5XoKIPg4U3Y7OF
	mMq57bYLfr9FnOn7n0CKoTi5CcXIPk/2iYYgKCCbR6GVh6bC4An5NjtzTZnV0EVjrZBadHEkxnk
	pvo3Z4IWM+zupqxFV4+28sLCnPCcl4sk3tBGc2zvoZ9TMwMGcjZvWUwJaOQ0f9lD/m3TwD0ixAV
	nm9Z+iZu0MHzz+VJrZJ7V8j/0Y7cQCy5w2cmamOL/4h/pFHrHfjJtNW7OxOCggYs5TDBNPaClDE
	yrulc3exKehNCWUxdH2Q5jj042fwVZuy7SZX8iYnIHNoID0y92Q+1HdM035YQANBGrflmRSWsXB
	MLaIr
X-Received: by 2002:a05:6000:21c5:b0:3a4:e238:6496 with SMTP id ffacd0b85a97d-3a6f312ded8mr3496373f8f.18.1751010040103;
        Fri, 27 Jun 2025 00:40:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHffkWr+tNQHcP3BKAqhEIUlPXtP0GPPD5lJm+uaf4h6Jumi+zY3AGg3kh3v10ckZG0pyurtQ==
X-Received: by 2002:a05:6000:21c5:b0:3a4:e238:6496 with SMTP id ffacd0b85a97d-3a6f312ded8mr3496353f8f.18.1751010039681;
        Fri, 27 Jun 2025 00:40:39 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a892e528a9sm1956705f8f.60.2025.06.27.00.40.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jun 2025 00:40:39 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Luca Weiss <luca.weiss@fairphone.com>, Hans de Goede
 <hdegoede@redhat.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Helge
 Deller <deller@gmx.de>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Luca Weiss
 <luca.weiss@fairphone.com>
Subject: Re: [PATCH v2 1/5] dt-bindings: display: simple-framebuffer: Add
 interconnects property
In-Reply-To: <20250623-simple-drm-fb-icc-v2-1-f69b86cd3d7d@fairphone.com>
References: <20250623-simple-drm-fb-icc-v2-0-f69b86cd3d7d@fairphone.com>
 <20250623-simple-drm-fb-icc-v2-1-f69b86cd3d7d@fairphone.com>
Date: Fri, 27 Jun 2025 09:40:37 +0200
Message-ID: <87wm8xd43u.fsf@minerva.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Luca Weiss <luca.weiss@fairphone.com> writes:

Hello Luca,

> Document the interconnects property which is a list of interconnect
> paths that is used by the framebuffer and therefore needs to be kept
> alive when the framebuffer is being used.
>
> Acked-by: Thomas Zimmermann <tzimmermann@suse.de>
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

