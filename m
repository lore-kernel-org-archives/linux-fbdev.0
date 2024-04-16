Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8952412A174
	for <linux-fbdev@vger.kernel.org>; Tue, 16 Apr 2024 12:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713271058; cv=none; b=hQyI2X7SrdIBDxpn39d5Ec4d/sC2kf8Sd1SvuKXZWK7utzYqZMSnqKy/QTXdqJw0IAZZsJBzYk9R/pDTknKnue4MNtf8jaiCzaGbRYcNlEbPwRuayNyKrzXKpqmoqyxqaWv9nKIhSVlYzrlZuIdhMhs8GipceiRmlpLldaGT1Yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713271058; c=relaxed/simple;
	bh=68RdZ5P+VtWYQztng1dhaEYs78MHHUMQYfNp+N9kIMs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nijBh4F7XRVKMdM7AN3PlqHYZdvqrKCe9GHUZgpTZwENPlWJLPeiRhNwbC6DIqtTstT7VaP+rzIjgkC0JbX8blFoxCxuhrQtCcPFGrSSUV2DRUEzRNj+Gfy+8h9TIKaEadvDb+etwAUQ+hBDGdoosvbJQRjGAFUqZTe2EFC5vkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eV0py2Cn; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eV0py2Cn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713271056;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0ud3ijrfjplDarV9TLJPxsmDvriDToUgUKj0vhRoph4=;
	b=eV0py2CnqbtCdlEIyX6Ye6qEwV1qMc+KmeqLSqT+YY8FlsaH5GS2Bg9LskzYytMrjeFme7
	EanqDxIVdcBkOiCBsYVxY+dbPkAQKq5wGXcOhfSeLCmhlMQxTyGp3p0OVHJA0uBkynO5rt
	nTaLBCwRAtT/3EZ/sEEMhrzMiLDOMeU=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-372-zs-VQ_CROwuKteGF_XvtAw-1; Tue, 16 Apr 2024 08:37:35 -0400
X-MC-Unique: zs-VQ_CROwuKteGF_XvtAw-1
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-516d92389e0so3847095e87.3
        for <linux-fbdev@vger.kernel.org>; Tue, 16 Apr 2024 05:37:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713271054; x=1713875854;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0ud3ijrfjplDarV9TLJPxsmDvriDToUgUKj0vhRoph4=;
        b=eBKdx7YAZlWa6DYiOqomjCFyvkaXTrPZYvC4ATiO5pAnTZkmUeKXfSYKfZawHoOYkq
         15vnyuy/opZib5EevHWN9jyzlcq+TKwE1q2QMZdytTeivfFHANggfdGUGZTNTLj5LaN8
         DkLehunpHOgcnn5fvhsBAgEZkh95aDI+pLdNz+P4N2zmbzGh5xLbPT724GVaV8bnLJf3
         EizTPw7WTKC7l+rF+rB8Wij3QLnoQfMBAp0arjoeye+la93qNAoxd2bfTOt7XjgQxnOj
         asBxz5d8pVDeo5O4wyzrq53YiZkAWEYEhWhJRpMLQBar5krCL70Q0FrFR1EVA3CG9zAt
         HhjQ==
X-Forwarded-Encrypted: i=1; AJvYcCVI+oGfy9zSxalr7gWBiwq/s7leeFrYnGFdNyOF8qTGbtZhkxyqgi1pnYMqDChnJSy7DNpHxpaa5mJ2ntQo74m6gp37ajZR1sJ/MmM=
X-Gm-Message-State: AOJu0YxzAG2sQ6AfYjL+qGp6SC/V8Dqyzi90TqzYJkVO5WvayMBl8GGi
	0gqCbLi4vzncr9V+GIkP/RPWEAuzA0LuqfaDFFNK7gzInekhcS9/lwD1yaXgXlyI8vs/3+6ktgX
	o274y+0B9GlAZUvxdqOmiRz2o66DVKwR91DbR+6bNgZVYhxQ1NHHpkqryCULH
X-Received: by 2002:a05:6512:48cf:b0:516:d47d:34b9 with SMTP id er15-20020a05651248cf00b00516d47d34b9mr7499597lfb.22.1713271053852;
        Tue, 16 Apr 2024 05:37:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGED1Mc4BtvceNGbCcF6kDEVs71CuWIOUPAUsCf/78LW6WWtjHnKqmejEA9mlBsBmW/kiIYiw==
X-Received: by 2002:a05:6512:48cf:b0:516:d47d:34b9 with SMTP id er15-20020a05651248cf00b00516d47d34b9mr7499581lfb.22.1713271053329;
        Tue, 16 Apr 2024 05:37:33 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id dl5-20020a0560000b8500b00345fb949c28sm14750918wrb.100.2024.04.16.05.37.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 05:37:33 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Thomas Zimmermann <tzimmermann@suse.de>, deller@gmx.de,
 airlied@gmail.com, daniel@ffwll.ch
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, Thomas
 Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH v2 33/43] drm/tiny/ili9163: Use fbdev-dma
In-Reply-To: <20240410130557.31572-34-tzimmermann@suse.de>
References: <20240410130557.31572-1-tzimmermann@suse.de>
 <20240410130557.31572-34-tzimmermann@suse.de>
Date: Tue, 16 Apr 2024 14:37:31 +0200
Message-ID: <87edb55vqs.fsf@minerva.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Thomas Zimmermann <tzimmermann@suse.de> writes:

> Implement fbdev emulation with fbdev-dma. Fbdev-dma now supports
> damage handling, which is required by ili9163. Avoids the overhead of
> fbdev-generic's additional shadow buffering. No functional changes.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

