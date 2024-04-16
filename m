Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E5743771E
	for <linux-fbdev@vger.kernel.org>; Tue, 16 Apr 2024 12:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713271033; cv=none; b=Qy+3mqyl1VPtfyHMrUzpE4waIrTFo7upLM0MEmNNIL5A0l8SW63lMMaWWZwwPug63AyAzhzonALiwD83Oma5We6knM7qWmXkDFxg6vxRa1HcwiD7xSiv0al7THQVcPIUzCjnwKtNO3y1CWJzGz8FMdIqCrLXX9xmjDmZV9QhRSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713271033; c=relaxed/simple;
	bh=LpAXfyMmvgQYgn7qXVZ2Elf9WrbXofA9HFU37+TB9Cc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SkDguhBrSc1ogpbBiaoVQEmOGzyDc2xOWx2tqHtpArlQP/i+pHGJ+RDOYRnjyHtYOXTPTuTugZLRI5ZGNWYvIxTgZV0UVzfwUwIs+4LV4svQYB9wDraRXFiP+mc9xPTCh9SIU253ahIEV77ml1cofAqsuYgP2+X4prDRQ5ZzDbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AjjQE9UI; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AjjQE9UI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713271030;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=r7M4lJbOMB+MaRK2MWiYqIYz+E+U1SfQnC1Ii35vu+o=;
	b=AjjQE9UIhK+LfdgJutuJ4d/SwK7gD1y89dDS49C2V1hDDq02w/DUVrL+s0LNJpNzpyE5VY
	RhqzZA/TabxeHa5HCoX3r8+5WFiMQHexGTJJjw/nNVDKDAPN60SmbC88qdXkLKw9zib5+i
	LrDjTHTG2cwYN5bgDVhtDNbB1YRFTQU=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-355-0HpzNn2vPUaGIvDeBAIIJQ-1; Tue, 16 Apr 2024 08:37:08 -0400
X-MC-Unique: 0HpzNn2vPUaGIvDeBAIIJQ-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-343d7cd8f46so3073016f8f.2
        for <linux-fbdev@vger.kernel.org>; Tue, 16 Apr 2024 05:37:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713271027; x=1713875827;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r7M4lJbOMB+MaRK2MWiYqIYz+E+U1SfQnC1Ii35vu+o=;
        b=YejghqEFokxxjCfgFcXPITUrVBMEat0hpZd8//4lSkRU9AMd45CLjpCaK0As/ChR3H
         sGSI6Ks3DA3f/um5hL61GXMmrnnRgpderlKajIl6XHHrhI6GM7bAVPqXDzD53wJcCMpX
         NOZBzubBMU9cp4fIcptALFtlbmrmhJUBw4+SQ7YtBviVqhG7r3asXcdH25UJ4hQ/+eJK
         MyQJyaUmZHQzpLcKg0BLhft+uulSbNIOWr5ls3fpnvV+RMa94NvJMkmhEfq/JKbcp78+
         t4+KOqoQXRtwLcJgi1Tg7/xekUegwxSLPW6OrbxE+JFnx75aVSMj94BW6aprqv9objZj
         nD/w==
X-Forwarded-Encrypted: i=1; AJvYcCVbfrvna+aCH9OTLg8jbsZOJ8KGVM3MovQ0QdqszLPUf81a/lV5m/dlwmy2ivF1c9l9sSout3lABE4g/01ZBOA4fOhSSFswm7lMRL8=
X-Gm-Message-State: AOJu0YwBq9p/ZofzEGCkWQZI56jGjfDOWq2RWjuW43Yj7goAq1l5j6dg
	mAcQxQnMX8x+QzMMW4mQazV2R6ewHDVp/vjcSSj4Bqpqu7iwqIUZCYf5T41E+PTkZgCePZvai7O
	6uyEEJYdmkeAYXm4luIkK/rRl8PDwHxfGilnV2Jj0aqjktsaRSrtrRzP6TL/P
X-Received: by 2002:a5d:4490:0:b0:343:ad7e:5bc5 with SMTP id j16-20020a5d4490000000b00343ad7e5bc5mr8830986wrq.57.1713271027323;
        Tue, 16 Apr 2024 05:37:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHISOalX7TmxUo1ne2GIazBgoTXrzK9kZ/08C/F1XYqJbsMOd9NIlUm/mAKh3lYaCY7WVFnJA==
X-Received: by 2002:a5d:4490:0:b0:343:ad7e:5bc5 with SMTP id j16-20020a5d4490000000b00343ad7e5bc5mr8830975wrq.57.1713271027057;
        Tue, 16 Apr 2024 05:37:07 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id i2-20020adfe482000000b00343bd6716b3sm14753026wrm.99.2024.04.16.05.37.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 05:37:06 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Thomas Zimmermann <tzimmermann@suse.de>, deller@gmx.de,
 airlied@gmail.com, daniel@ffwll.ch
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, Thomas
 Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH v2 32/43] drm/tiny/hx8357d: Use fbdev-dma
In-Reply-To: <20240410130557.31572-33-tzimmermann@suse.de>
References: <20240410130557.31572-1-tzimmermann@suse.de>
 <20240410130557.31572-33-tzimmermann@suse.de>
Date: Tue, 16 Apr 2024 14:37:05 +0200
Message-ID: <87h6g15vri.fsf@minerva.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Thomas Zimmermann <tzimmermann@suse.de> writes:

> Implement fbdev emulation with fbdev-dma. Fbdev-dma now supports
> damage handling, which is required by hx8357d. Avoids the overhead of
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

