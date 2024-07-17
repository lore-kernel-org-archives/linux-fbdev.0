Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E8AF3BBCB
	for <linux-fbdev@vger.kernel.org>; Wed, 17 Jul 2024 10:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721210915; cv=none; b=od35pYpKDgJwTVGucG/ofteaBRiWsM+gMBIpLvhZEMq6DYWLBhvbyYDEj6i+tPxNhM8dljqrR19vwLGuCRaWsEi90IBKEzec1yZRaWgsPxFQAmPpg56yBQNizBTx5E485JodnZJvd80TSKA/gie9tG/sVpUWj8/7GO6dJNRbds4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721210915; c=relaxed/simple;
	bh=VJzbhh46j8FTftQKVsWxLRGfCdvkS4wlIGN2br8arew=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VgqvnB8UUMQc+acnm38OU2lNA+NPouHNMA1YEvPrC/8NnlEsDqWnKDPRT+qd1bgBGz3MIok1RZVUZ34EHbM5gbnOTEwB1xpn4Ga5d2EK1TRwjocqWTqXXqo9suZTWjhpZ55Ql1PrV8FM7zA48mVLXblIf885ev8iCLWSIdngQE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GPFBRtuT; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GPFBRtuT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721210913;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xjkUyUot20NGrY9ZFrQg4iD0i6JztFTd/ok1J4HNwDY=;
	b=GPFBRtuTpOSrbMeooo40gYn8ZOc9XmwEUthWNQcqR3HYzs4xHY0LRrfOUmkJgGbxY8jbji
	dUVo+LN42DAMOg/9aCqZ//E6Lb+vJjyaQgR3Lc/DYnsKqemJrlArhYFkFow8y7WdY9jxOF
	Z3i3FrpqZlT8brfd0n+uybW1e5YUDEQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-128-0QG8KPv5M8S0Vi0gkh0Y0Q-1; Wed, 17 Jul 2024 06:08:32 -0400
X-MC-Unique: 0QG8KPv5M8S0Vi0gkh0Y0Q-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-426679bc120so49657695e9.1
        for <linux-fbdev@vger.kernel.org>; Wed, 17 Jul 2024 03:08:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721210911; x=1721815711;
        h=mime-version:message-id:date:references:in-reply-to:subject:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xjkUyUot20NGrY9ZFrQg4iD0i6JztFTd/ok1J4HNwDY=;
        b=MlF7GnnuUZSefM3Q5ixy37GnvCXG7X4XTDZBeuG54vVbiRx4jk04aOyXZzbDF7pPgL
         wO0IsdU7gSMgslN6j1FnofKfHn4QZPVr6PSPYr7FqIEyRbummoKoxN+bzl65KevIHC4S
         GVC477IGvDxuPqAtA7e7beLvqDriu+InYMLUovXS1qRrD53g67+1jzUDlbgTBJJG+qTM
         Mfqq+U5J0WGHC93OQTTyp7DkS9PxATN5y9PHq5oY4yZv16c7qDi3WH12ibJDjRzyUM5U
         KyH1bdicjxq6oICziRVFI9wgGRTTQJJwK8RR2aPq/0FF7lrjWHxzvW+7aas04diSjAt3
         U6lw==
X-Forwarded-Encrypted: i=1; AJvYcCXOngsRUt897ngp9n81o39fzU1R6NG6mXULaa/nzAWffVUmn5MaLno7HmWt1r2TJPC7wXLOTEG4PJhMG/Rk1HkJ7qiRd1jf/67byT4=
X-Gm-Message-State: AOJu0Yw3oGOFAJKg+2m3ZbQi1RlD1xsfykrwmaCAh5pgYu3ceppXSqHY
	A4hyMe2VqDabmXZBUv1rdmxWGRrbcdq0SDXF0mFoIzhQhTHJ85BqR1eZmbe9qAd4RqP6YZTpVos
	4i1CmwJM8Pt4uPfNWv77vJCtcYozvGRYsPABQar/QGmCYYQQV4FispvBYOU6k
X-Received: by 2002:a05:600c:1c21:b0:426:4f47:6037 with SMTP id 5b1f17b1804b1-427c2cc2f5bmr8604505e9.19.1721210910880;
        Wed, 17 Jul 2024 03:08:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHkUSxu2VeixFnYHEIPInPCJHTDc3WCGL4pCgRh1eLivnZ8ZCPxQEJHjlvcn3WW+HuqhF4hlA==
X-Received: by 2002:a05:600c:1c21:b0:426:4f47:6037 with SMTP id 5b1f17b1804b1-427c2cc2f5bmr8604225e9.19.1721210910486;
        Wed, 17 Jul 2024 03:08:30 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3680db038dbsm11135956f8f.95.2024.07.17.03.08.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jul 2024 03:08:30 -0700 (PDT)
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
Subject: Re: [PATCH 2/3] fbcon: Add an option to disable fbcon in panic.
In-Reply-To: <20240717090102.968152-3-jfalempe@redhat.com>
References: <20240717090102.968152-1-jfalempe@redhat.com>
 <20240717090102.968152-3-jfalempe@redhat.com>
Date: Wed, 17 Jul 2024 12:08:28 +0200
Message-ID: <87zfqg49gj.fsf@minerva.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jocelyn Falempe <jfalempe@redhat.com> writes:

> This is required to avoid conflict between DRM_PANIC, and fbcon. If
> a drm device already handle panic with drm_panic, it should set
> the skip_panic field in fb_info, so that fbcon will stay quiet, and
> not overwrite the panic_screen.
>
> Signed-off-by: Jocelyn Falempe <jfalempe@redhat.com>
> ---

This makes sense to me as well.

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

