Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A6455FEE3
	for <linux-fbdev@vger.kernel.org>; Tue, 16 Apr 2024 12:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713270916; cv=none; b=H+CPe0HgOVZDq9V0Cp1s9Ym27141UwLAaO3JzyCU8DNLqv2lbo2u6u3GWpVL2TaUi50UxNB+mB+2UtNf4q4B3sXiL1M1oWCR9lrUOMzqcKDbAXai7jYk9NtK+GxTyowy4mQAmMrew4ySGU48L9PEa/5pCSn+H6eYtMt+Sgx+Oqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713270916; c=relaxed/simple;
	bh=JFPko7ShUUMhnf9ee9Kd9PzcZO2qUI9pHKTWq49ZSb0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tlaXU83hThqu6IITXcK9IHDUTvz/V8xz0huCEimx0JU3KdVBJ/NbUjns2gmavR2AsZLdkDhAsOQRlwz7WXascq6I0Hbtr5b21TYojJTS8+/q90D/OzdvjUEBL2T5nhqns9FV5OS9eARG8pPG+7bCwny7iYsByVqsNMxHwfVdHvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KS1x59z/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KS1x59z/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713270914;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1YCoIwUmLzovUo4BmYd25Db359c9nGlD5mjqcEK7W2k=;
	b=KS1x59z/hGOZp8cUj0MfIwXQLNbKn8wydZ5hAe7ZGXCus7TD4DP5i6GsHdcTz2ISqMpQlE
	Dpm8S5xEXRn+n34Vt55JgRPXlPQR98gKUg/BrPDOse96tIOJjM50/g2ZjOrAdcJInML7Mw
	8xmecajtRKwPqe1M+yFssnf86QgPoSQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-645-G118nWLRMW2rVxqo8lgZpQ-1; Tue, 16 Apr 2024 08:35:13 -0400
X-MC-Unique: G118nWLRMW2rVxqo8lgZpQ-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-418671bb02cso8455625e9.0
        for <linux-fbdev@vger.kernel.org>; Tue, 16 Apr 2024 05:35:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713270911; x=1713875711;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1YCoIwUmLzovUo4BmYd25Db359c9nGlD5mjqcEK7W2k=;
        b=rW0hHdBklRcYKDTc1SDgXkWYQLRbFnt7YISxZ1Hv8AF2AOiDZ7PBJcPZvitgAow0gO
         pcjMlXUGMjli+1kED08GJr6B9UiF/kwuJh7TROGt4M26EhS9ZNCLXlb4aM5mDlcL8INq
         5HoaqzrLgb5+HwbJwM+42dZY5lS/LNZCZyG4hB/Kf+8+Q+I/cYcbks7aQ+56O2yHFkZF
         +HDYKBO13TamKGZXyKCSmb6gED5TF0hpSYjRh0uOn5I8x3KU7uUzG2a5cWPXRg+LFScq
         iuOI5agfaNzo4gnVz7vC1aO5RarLj81sdFL/+6+LWP5vlXTVEEWbFUVJHEGblJY20sm0
         tp/g==
X-Forwarded-Encrypted: i=1; AJvYcCV5gva84sV/bWqKkKpUdyb3b3ZScyq/tW0+J+pUXZYbINumgRgtxm7IomKYB4KixbF9T2XVGdgUeLo87+6nEILAk8G81Ht5cEVgHPM=
X-Gm-Message-State: AOJu0YxLFAgk7xG93mL13nhby3bbAxR5kHFAqR5MqClwe5CNdQi9+KmL
	ELnPxvO59aloDbhU8CGfGxUiIbeWJgrJyAjPQ9wpWeciQHmOctds8Otpsn5lKUBIJ4mWD6jpjWB
	PNlkWf7iP9dycNDc7+GuNi0P72Ed7io0fuVH7gWb5/rIfib+5ydcMRqqMyMUQ
X-Received: by 2002:a05:600c:3d08:b0:418:7e61:762f with SMTP id bh8-20020a05600c3d0800b004187e61762fmr2916043wmb.26.1713270911582;
        Tue, 16 Apr 2024 05:35:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEDbI6of2NRqQAiW2/9LLw8bGrHejGmoHcam6TOv4ECJ+kveLdl7v2vwyJUQlVBDPy9cDUMng==
X-Received: by 2002:a05:600c:3d08:b0:418:7e61:762f with SMTP id bh8-20020a05600c3d0800b004187e61762fmr2916027wmb.26.1713270911169;
        Tue, 16 Apr 2024 05:35:11 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id e1-20020a5d5941000000b0034722442e60sm11277729wri.61.2024.04.16.05.35.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 05:35:10 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Thomas Zimmermann <tzimmermann@suse.de>, deller@gmx.de,
 airlied@gmail.com, daniel@ffwll.ch
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, Thomas
 Zimmermann <tzimmermann@suse.de>, Chun-Kuang Hu <chunkuang.hu@kernel.org>,
 Philipp Zabel <p.zabel@pengutronix.de>
Subject: Re: [PATCH v2 26/43] drm/mediatek: Use fbdev-dma
In-Reply-To: <20240410130557.31572-27-tzimmermann@suse.de>
References: <20240410130557.31572-1-tzimmermann@suse.de>
 <20240410130557.31572-27-tzimmermann@suse.de>
Date: Tue, 16 Apr 2024 14:35:09 +0200
Message-ID: <87plup5vuq.fsf@minerva.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Thomas Zimmermann <tzimmermann@suse.de> writes:

> Implement fbdev emulation with fbdev-dma. Fbdev-dma now supports
> damage handling, which is required by ingenic. Avoids the overhead of
> fbdev-generic's additional shadow buffering. No functional changes.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: Chun-Kuang Hu <chunkuang.hu@kernel.org>
> Cc: Philipp Zabel <p.zabel@pengutronix.de>
> ---
>  drivers/gpu/drm/mediatek/mtk_drm_drv.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

