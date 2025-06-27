Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C055621C195
	for <linux-fbdev@vger.kernel.org>; Fri, 27 Jun 2025 07:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751010070; cv=none; b=Le4aynJjent/F1703GnoSvJc1cHyPgRIuFYgIEqkZ7dvo+t/gNlkp967Vnl9ugl12YLHdVfsuAsoIIwOi4Gmutbyfo+/clKOSaOZl84e9WOLBcRTPa5PD6EyLrX2Pi8UTJXikOvX9PMUacSl4Fte93d8V64K+AFw1Op4wHIO4Zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751010070; c=relaxed/simple;
	bh=LZ8XvF7Mxx6us22Wtq1V0lH/iTurIql0J+590VcfcQU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GGafGBF+X/I7+qTzganTRAJKyWSKMIOm6zo8vwtA5enHgTKKnF0xi/XqFvs4vuDRz05cvFnkSARSX6IK7pT6LO1pUWCZEKIBst1JcTbtaOiA/Oq+Bfi6fV3SoqRKZOH9jGegqL3dnMmznfwCcxcv8tA9Qo7FIqytZWWO1gnT9Xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZQ3Lz3Hu; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZQ3Lz3Hu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751010067;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wP3Am+ANc8SurwHR78cTMLjrIEmhW8vePBXR1xmw9wg=;
	b=ZQ3Lz3HuuUwwRovy9KGldd6Wed6Dx2Xp96VCMdvhDrAZvIygqwG9oN2ijzmFgQHHsyaf5L
	t8pwk/zg3u4l5yXrneGiwYuXlXsl8o4gpm2tMJ8nqIg/2yAtoEsmDpEG5H5RYYQst2P9re
	wxr2G/Y3owS1VJc0zhW325W+byyAjn0=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-447-4TkqKu1tPzGn5fVfX80Tzg-1; Fri, 27 Jun 2025 03:41:06 -0400
X-MC-Unique: 4TkqKu1tPzGn5fVfX80Tzg-1
X-Mimecast-MFC-AGG-ID: 4TkqKu1tPzGn5fVfX80Tzg_1751010065
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3a5281ba3a4so807765f8f.0
        for <linux-fbdev@vger.kernel.org>; Fri, 27 Jun 2025 00:41:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751010065; x=1751614865;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wP3Am+ANc8SurwHR78cTMLjrIEmhW8vePBXR1xmw9wg=;
        b=cNesxX3qqumuXVyHwBXa97848tJ66GyKkxAYX6iIE0B8s06IZvyiA2iTwMV/QhUQ9l
         iFVm1tBjzqNfSKNlQtA0986TIfB9m/ZDqTvroB/eYlCbuo+SJX+r8r/XHmjeUO1o+Aok
         NYXlMEpoNk400K12S8FuQRdvVnqhoRrlBnDa1Sq7+8eENipEY3+hGvA0vjfBwO6hP4se
         pbdGhtNaDlfQyUFtmXQ1NjIehmPDkZvmuDOaP2XXGQ5IZ/T7zMgJ3/f4c1tKZKAH/A4o
         DOP/8NuRFphVLADmpxfFO0Wy4IbpZRWsz+ra+rlXTrFAglzbgOYJp+7E8jeTJe7jo2Mq
         CmMQ==
X-Gm-Message-State: AOJu0YwsTos5eijOTn8WqeDEcfmP+DB0lZVxULIxcVsjLDsq1vJ+HlhN
	pd926KqtiDtzrc7VO6d2SMBbQuTu/fg3LDsZaDD90TvrPaTrDu1oaCFtzIA5lj8bWxkuHMg8pgV
	RrBzKI3YNUsGw96mIcIWJ+Bd+58qUsQIZKzXZEKo4K7YLEwwwxXrwGR7UuBr8+kVf
X-Gm-Gg: ASbGnctiF5mX9ZWRlmze/CBNViGzi16VlGr89YZ5dyMYkAfnm3g4JxKy+YsKcjo41K6
	h8Wn/KOOEmstxuMokoCxr95G3JI13Yqk7bIRR9hvQ+prQzM3ZruKlJ5QhNZBx2J0Wf9IlPwafia
	A9smVySlQk14AVSPXEp0V8AIT7nEOwZ01uYHI3wmk+Geo6njIptAs5P2/joBFzjP0Jl0RWXVOfG
	rtonLg6o4FmoBuY1wQj4JpE5rvmOQomFHjZahofVst079SMOub6dQ+UY90BgLfTN1Uc5fWVoF/E
	ByLeAiRhY48ZkhRdUq112lwbhdGXo4qhty8R74X6ITHAUjRwHrKpL8sHSVnQ1PUYaer1uA+xvNw
	dJCWY
X-Received: by 2002:a05:6000:23c2:b0:3a3:6991:dcbb with SMTP id ffacd0b85a97d-3a8fdb2abe0mr1344026f8f.12.1751010064955;
        Fri, 27 Jun 2025 00:41:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IETMdv3eRrEgFX+6vBwltJ/r+6ntnIOfFnB39tunb/PTwDz2TLiyLlcS2Z8MbRYWj+B7lKx0g==
X-Received: by 2002:a05:6000:23c2:b0:3a3:6991:dcbb with SMTP id ffacd0b85a97d-3a8fdb2abe0mr1344015f8f.12.1751010064572;
        Fri, 27 Jun 2025 00:41:04 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a88c7ec69dsm1911505f8f.6.2025.06.27.00.41.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jun 2025 00:41:04 -0700 (PDT)
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
Subject: Re: [PATCH v2 2/5] drm/sysfb: simpledrm: Sort headers correctly
In-Reply-To: <20250623-simple-drm-fb-icc-v2-2-f69b86cd3d7d@fairphone.com>
References: <20250623-simple-drm-fb-icc-v2-0-f69b86cd3d7d@fairphone.com>
 <20250623-simple-drm-fb-icc-v2-2-f69b86cd3d7d@fairphone.com>
Date: Fri, 27 Jun 2025 09:41:02 +0200
Message-ID: <87tt41d435.fsf@minerva.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Luca Weiss <luca.weiss@fairphone.com> writes:

> Make sure the headers are sorted alphabetically to ensure consistent
> code.
>
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

