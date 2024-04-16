Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6814A101D4
	for <linux-fbdev@vger.kernel.org>; Tue, 16 Apr 2024 12:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713270975; cv=none; b=txecGm4m+c/zpJuu4PPtTfsQSLurJFkBMeyrEWkURpVTOOoFSMvXeoGeRxfTalpCaTQuhBYayVHh4RX018tFrUy7k3dt3+opadNWZrHVgdCSIeTzuVUVGamwBy12awmiC03VFFmo937UDYa2Zpff2/G9EeG8VOcb3sbBP36zWbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713270975; c=relaxed/simple;
	bh=jxAObjSimRmjZtxD9vj/pPWK4bp2diY8Xk5mQ0PEsGU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lNKxYdTM8Ywc0J+bdqxQI9h+a9VoG44+jG32Kdy1nYhT4j7ZoiVGT3glUrfUnip5II4//BHFlT9UlGeTEF2KRTuMGLyp8mVYZtRPSzX5kGeqV3xYrbrBTTSaCrif6xApz+qiV4UKedDh+unvJx3z5KF0IRhnx15muoTS9FYreNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=F9axzXcG; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F9axzXcG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713270973;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4E2yQzFw0tRwPq3m+OASOzA8/elGwcx9OxMy90Dldfc=;
	b=F9axzXcGxwbwecsdk+jc/bhmv8qxuCPyBc7tHajHHp8121F42amvuStWYUSQEDb2KlxGix
	k4dSH7iwvFkCgqy1cJpi56aOD1a82LAmhaMVHVeUbin320nr1xSd3ONq/wirhBRjiFL6HQ
	tJsK32/4xWd2/d8I5jqRSqZ/n4Yhh0o=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-452-nJ_Yv5KmM3y8XdA_JxiGlg-1; Tue, 16 Apr 2024 08:36:11 -0400
X-MC-Unique: nJ_Yv5KmM3y8XdA_JxiGlg-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-346d3020e08so2914508f8f.2
        for <linux-fbdev@vger.kernel.org>; Tue, 16 Apr 2024 05:36:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713270970; x=1713875770;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4E2yQzFw0tRwPq3m+OASOzA8/elGwcx9OxMy90Dldfc=;
        b=J6ukk2oGgNV0OT4XfIkZWMzfYvFoReQniJ8jcB7U3s2vhadP67Fcm/3id2lkzoncnz
         HEGbmpAMjywDnADHr9LAoQmv5542EELCD8uerV5WL/QnPMKt3/E8Ccw6obgP/wXGwh2S
         W8KOwZG/TCWtyg8dB5kF6PqcGlRYXWhCdOEUNJjR0q4PFCHHqztHJkxgZGal0aKI83vk
         NayQN78xduE6kvvIloQdU69j1PpfQVYumQLIZBQBAzRGJmK9pyvcDPvaGOeNcP03FLr/
         PzvW9ttw+P2OwdjZMk1Ris/m5Bl3w+jkqEjTkNp/DZK84I0S75aQdrXVbp13BDNmctoW
         nTiw==
X-Forwarded-Encrypted: i=1; AJvYcCX0XmR4De5zPWrF3tV+brLR2H7DkxNF99khfcsixEjUKmuN3sEmELkJJeHgRmKKAHzfsltf4hYub+MCkb4souen9lYC37DVojgaifQ=
X-Gm-Message-State: AOJu0YwV0tNpEeNKSrvD8628YX/1qDaaaokPmCLjFlP5uN+AzwFAaV1I
	tCU3SDJk66kLQCqriVeD/BKXRpWmKK4dCl7WXpZGw/suSfM4IDXsFxpQBhCR1gkKNrJZfT+OjeV
	nox6+ZXwX2nsJBytO7g6y2ky/aQyOWmefuoC5IbwkvJ4t0tbts+r1oLJbhif9
X-Received: by 2002:a5d:6483:0:b0:347:9c4d:4e19 with SMTP id o3-20020a5d6483000000b003479c4d4e19mr5575590wri.70.1713270970442;
        Tue, 16 Apr 2024 05:36:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEOjnBD9YZr1IuDPEzQiyEvL0p/5MKtQssuqlXB/PTv8G5ulknmrqVK8CVSXBSXhre1om5ezg==
X-Received: by 2002:a5d:6483:0:b0:347:9c4d:4e19 with SMTP id o3-20020a5d6483000000b003479c4d4e19mr5575568wri.70.1713270970085;
        Tue, 16 Apr 2024 05:36:10 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id x9-20020adfcc09000000b0034997769ae4sm438219wrh.15.2024.04.16.05.36.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 05:36:09 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Thomas Zimmermann <tzimmermann@suse.de>, deller@gmx.de,
 airlied@gmail.com, daniel@ffwll.ch
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, Thomas
 Zimmermann <tzimmermann@suse.de>, Neil Armstrong
 <neil.armstrong@linaro.org>, Jessica Zhang <quic_jesszhan@quicinc.com>,
 Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH v2 27/43] drm/panel/panel-ilitek-9341: Use fbdev-dma
In-Reply-To: <20240410130557.31572-28-tzimmermann@suse.de>
References: <20240410130557.31572-1-tzimmermann@suse.de>
 <20240410130557.31572-28-tzimmermann@suse.de>
Date: Tue, 16 Apr 2024 14:36:08 +0200
Message-ID: <87mspt5vt3.fsf@minerva.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Thomas Zimmermann <tzimmermann@suse.de> writes:

> Implement fbdev emulation with fbdev-dma. Fbdev-dma now supports
> damage handling, which is required by panel-ilitek-9341. Avoids
> the overhead of fbdev-generic's additional shadow buffering. No
> functional changes.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: Neil Armstrong <neil.armstrong@linaro.org>
> Cc: Jessica Zhang <quic_jesszhan@quicinc.com>
> Cc: Sam Ravnborg <sam@ravnborg.org>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

