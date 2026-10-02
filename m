Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 999D41F5825
	for <linux-fbdev@vger.kernel.org>; Fri,  2 Oct 2026 12:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790945467; cv=none; b=bRbiL7koEwQX9hwwXgq1cJs2aYVjJn9XVd6OyANOO9N5ecRZYbz3ywD6CPKqIgzhEf1fbMFLcyuhuakBZ0De5BdLOk8OCK+b0wLIvu3XbFKR/Y9V9hkHzlgGQpt56I42+S5No6egtVew6BgXx+PaiIuxZykybg3JGORIUk4PseU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790945467; c=relaxed/simple;
	bh=OmxZCWplAWwOsu5V/M1uyWdSkiEaQLSRhrieiV1vD1g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YzDMEDrV68Y9V17NrOs7AwLYzCzAZU0CmQ6vqbbznDppBtnhEFgKTzjcD6DVJH8jkRsWG88ypKgO4mhm2o05W79IfkZf0VGuAu/BAvt7aIQNmLKAXU4xpZJuAB+otrFVyergqs1E4VX4nLVMh/7GUzsHMdw3jS/H+tdSTWFewRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IjaP78s2; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=B6wiJHuc; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IjaP78s2";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="B6wiJHuc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790945464;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uT1TzvdktEC1eT/y91LI9yVzdqB1qQfdlDD+ACCdd3I=;
	b=IjaP78s2zYtq5ZRLduP3gSoVUAV6s0jFAkTpOPueiHzIQKylJ05Wif3BRFwibWSwgchzMu
	IAdIPStuPoGXEtBOkSfGNemsto2YpDHHCilpfcIGmabqm3ieJTQAIc7OAhsif/9Em6Rncg
	x3ROL1sYZaIdkFzocK16ZDh9iPTxudE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-610-YPe-rIO5NJGxMaUpUyzHiQ-1; Fri, 02 Oct 2026 08:51:03 -0400
X-MC-Unique: YPe-rIO5NJGxMaUpUyzHiQ-1
X-Mimecast-MFC-AGG-ID: YPe-rIO5NJGxMaUpUyzHiQ_1790945462
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4a024bce773so20486865e9.0
        for <linux-fbdev@vger.kernel.org>; Fri, 02 Oct 2026 05:51:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1790945462; x=1791550262; darn=vger.kernel.org;
        h=content-type:mime-version:message-id:date:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uT1TzvdktEC1eT/y91LI9yVzdqB1qQfdlDD+ACCdd3I=;
        b=B6wiJHucA7utfZblKwUs0kDpPnbA3Akm5XpFb98zSz6zjURWrZDkOP/UhRRVPXvi14
         keLzEHSR+tbo+H60ybG6I9+MMExo8lfS3zEhjUxQhWHGbK/1okdPn9HujZyPP8hZ579s
         eg+4O7qZeK7tcfECjAvRk+tltVCrXs34HiW2khuwnIni1776Mq9Haph+GNackLX/fMnm
         6jYCGAfCssnhiaOoWGQL5MHo/W129GbNjgSA8QoIRvmKZhF6+SxkzQ1MD+8AyMrcBlZp
         QIva2+dmaI0ha1snDgTgQm2UKxjHHwW6hlC+sMwNM4wynE+GunENlnLkcuJwVvd6DE7M
         jNfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790945462; x=1791550262;
        h=content-type:mime-version:message-id:date:references:in-reply-to
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=uT1TzvdktEC1eT/y91LI9yVzdqB1qQfdlDD+ACCdd3I=;
        b=jDw4agQ1/VH4U4vEy9R6dhauXEU/nFeFv+9UZSJCzCT+AfyL9jEt9o88CuB4uE9iH7
         71KPwNYryCxqDY5MK7oQshJ0Ad1nqU5Lde03umve9JveYthq4xxE2/gVLt0twN4U0b7p
         prIdIKqwkrK0BJAkIVTC9gaWnqHwvqW6llRj91EAs5usD11wF8/orIU/BzKC6lshdvYk
         ChM2UjlTzA4srJblW+kaKgbZCS6Labe1p2yBFbqPuu0ucgf0R1O40vtWAJjldBi9cmnH
         QvQf0kpCNzeBwl5Cu8IWz9Me9ZA8MpHdv1X//otJmo098ceHtrXg/DDYCBUXO1NqTyWj
         z+0Q==
X-Forwarded-Encrypted: i=1; AKwUvBxW143KifF8KfJFiYWbUd3/sGvXe36x29/vJjKx2Dyert+mRHRxej+w2KOYIS8VCB5Q/KjNWq7bkNFhMA==@vger.kernel.org
X-Gm-Message-State: AFuF++mXx71IXnNj2NJ76Lec+9yXSr0i2SNEiACJWHdiFC0meWT4A5os
	TBpDBaZADwz8yr27QqWvfaZkVFhL8GQH3+ueH8SDyF/SdL0SmeXsvRbfl9WRVsIiuRm46rqwcUE
	WsauyfGm+y4WWDUNHmJYPvV29oroXZXbjUn4uql7VpRQD3Dq+r7tkFOWCR3jGh5FG
X-Gm-Gg: AYBFou0lkvNZBmWHETmeBVxaqDoL+Lr2ZdqbKWB08YSuqHo1IulAgcIvnN4VTFxfTSy
	QvLQlN8IJQOmgiV/Nlus2/VpwI0x1C1w71w0Mnk0tpvXRJRcKZcYtQl6WCrUBc479ZFd4qFK/U3
	51CwltDX/+4J4o/JaOJMOSh22HT4HNA0Drbmy0pGIsPsl6QdJPkT8BDoNLTrhvNOqdkrEncEqd6
	a/OOewISOkEB4o3U1xu6XjjlENSdFkVrMOe7ZQBouY4Y/2tcZnrZbDfLPSaj7TSYQfAzv65VKc2
	luMYk1NE1qrjQh/m/eXXKGq6p4Ribm92A9F8ONFdmY2iqscD8hewSZT0TOwO97FWyp/0TYnlZ48
	zG/Poplfl1mueXA9b9me1jFlTqauu3N/PL0MngERNEL3XL2MXzmFY1KQnElqxgygiwA==
X-Received: by 2002:a05:600c:5306:b0:4a0:1feb:de6a with SMTP id 5b1f17b1804b1-4a0275863cemr44975935e9.30.1790945462145;
        Fri, 02 Oct 2026 05:51:02 -0700 (PDT)
X-Received: by 2002:a05:600c:5306:b0:4a0:1feb:de6a with SMTP id 5b1f17b1804b1-4a0275863cemr44975435e9.30.1790945461642;
        Fri, 02 Oct 2026 05:51:01 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a0280bfafasm82137655e9.8.2026.10.02.05.51.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 05:51:01 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Thomas Zimmermann <tzimmermann@suse.de>,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, airlied@gmail.com,
 simona@ffwll.ch, decui@microsoft.com, ssengar@linux.microsoft.com,
 andy@kernel.org, gregkh@linuxfoundation.org
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
 sashiko-reviews@lists.linux.dev, Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH v2 3/7] drm/bridge: Do not include
 <drm/drm_simple_kms_helper.h>
In-Reply-To: <20261002124456.741011-4-tzimmermann@suse.de>
References: <20261002124456.741011-1-tzimmermann@suse.de>
 <20261002124456.741011-4-tzimmermann@suse.de>
Date: Fri, 02 Oct 2026 14:51:00 +0200
Message-ID: <xlv1h5j46zbf.fsf@fmartine-thinkpadx1carbongen12.rmtes.csb>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Thomas Zimmermann <tzimmermann@suse.de> writes:

> The bridge code does not require anything from the simple-kms
> header. Do not include it.
>
> Suggested-by: Javier Martinez Canillas <javierm@redhat.com>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

