Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11B7C1BC30
	for <linux-fbdev@vger.kernel.org>; Sun, 17 Mar 2024 13:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710681604; cv=none; b=hpXDPLVvM4JMs48N02iMCowZ2W4QZJTHkpLl5IESxqXWPfRa8PZ9IhGsjL6tQ/sRvXgQRFLeaWyv6ByTmAi6j1IoQ1rZYdWv34hi1+ThuBpUrXr19HxzwRjfb2eqfOQ6y3pnZrzuGarQsnQTNSt6rAObp6tzEPBfeRIBk479u44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710681604; c=relaxed/simple;
	bh=4rCCn4OaXE2LLr27qrFm7gmTB45MMmwW9hXpr/f+7jY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=o6dZaCuzKg2uY//45lQI5w/oR3HTGLWR9eRC6jQGNWOCE54bVn4PBBT5WPedeoYTE0FN1qUQkV7o7oNINIJqsr8qTYQHVLMOvIEVQUxQVDZB5+GQs1/nlurWwaQ6V+xDDJgkDgO2qJVXVMhLw/M7KCAwqcKBOoUzMbg0yBy1ELE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=W8cVglSx; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W8cVglSx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710681602;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bGVhRz5lNimAIwrUb1iGb99fEkx7qvbMYYAmyQTnrRc=;
	b=W8cVglSxtOAenDf3xJj/dEYfL72Sun3CDZWCrgV7UhJ/azoCamUgM7342f8E6rLBgl2MN/
	mOmP/Ikkig10GXC9sEnE913uLkpOpB+RaOZ0/knuqec4/cC8UGeolG2xazXe91k/ytzsn/
	btplGd4nc+pIx6nrCaJzUee6XLD7f6k=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-460-boIt1jAJM9a0iW2rSqpEgQ-1; Sun, 17 Mar 2024 09:20:00 -0400
X-MC-Unique: boIt1jAJM9a0iW2rSqpEgQ-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4140225e68aso9546845e9.1
        for <linux-fbdev@vger.kernel.org>; Sun, 17 Mar 2024 06:19:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710681599; x=1711286399;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bGVhRz5lNimAIwrUb1iGb99fEkx7qvbMYYAmyQTnrRc=;
        b=cxyRq1tMjhouSgcPGotIUQGCC1oTtk6i8vWg0iSmTJqP1NJbnX2llhyL1pS/v6u1Af
         IWHA2B7pVllO+Qt8+TRKjac2/StQDIcNq4fUUFWr70JE3DTPMXc21MfSHzHX+zLwdlWN
         ad+QyaSuTtHb4jrIiwuQ6QDozTUbYHsmtY0NF+vhPCVMMdJ3swAK2lVZdNDfxyJJ0WPL
         g5Lm8xuqVJd9eyGM5gKa8hNBskZVk81FF5qJAPhklW+yVmmSsiiqCHcUOp3fjFwElGn2
         uZSzDPeW31ESCHOPxlCzHYS6lzTT3Zjq3X47ZLizntHL3SI9/U5+MRRFNHUN7as8jfzv
         9zOg==
X-Gm-Message-State: AOJu0YwykS2DwscprBUfcghPmPm4nDcAeeHG9PC/L9jZ79qBBXcg7itP
	jC0uMJwMqZLY0F0LBv4DsTvpsFsPuxG6BYTxF5Qd34a3XykuFYrOvA7y3ggY++QHyWzkDJtVuVZ
	XcBtQ8Nu1WaVZ9dhpByOAwS76lCMawAipkFqNDnCwLiU+D3HmLdnB4BgB2Ry2
X-Received: by 2002:a05:600c:548c:b0:413:27d0:45f4 with SMTP id iv12-20020a05600c548c00b0041327d045f4mr7513162wmb.6.1710681598931;
        Sun, 17 Mar 2024 06:19:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEoJbLPQhurxakyY8FSDOFcA4PV8aHZ0hWGaEZpsyYD0QMoE2S/+U+mNJt3Vgk+p18B9gOXGg==
X-Received: by 2002:a05:600c:548c:b0:413:27d0:45f4 with SMTP id iv12-20020a05600c548c00b0041327d045f4mr7513151wmb.6.1710681598476;
        Sun, 17 Mar 2024 06:19:58 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id j16-20020a05600c191000b00413f035d58esm11714773wmq.10.2024.03.17.06.19.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Mar 2024 06:19:58 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Thomas Zimmermann <tzimmermann@suse.de>, daniel@ffwll.ch,
 airlied@gmail.com, deller@gmx.de
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, Thomas
 Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH 03/43] fbdev/deferred-io: Clean up pageref on lastclose
In-Reply-To: <20240312154834.26178-4-tzimmermann@suse.de>
References: <20240312154834.26178-1-tzimmermann@suse.de>
 <20240312154834.26178-4-tzimmermann@suse.de>
Date: Sun, 17 Mar 2024 14:19:56 +0100
Message-ID: <874jd5gflv.fsf@minerva.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Thomas Zimmermann <tzimmermann@suse.de> writes:

> Clean up the pageref state as part of the lastclose helper. This
> only requirs to clear the page's mapping field. The pageref and

requires

> page can stay in place for the next opened instance of the frame-
> buffer file.
>
> With the change in the clean-up logic, here's no further need

there's

> to lookup pages during the lastclose cleanup. The code instead
> uses the existing pagerefs in its look-up table. It also avoids
> using smem_len, which some driver might not set correctly.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

