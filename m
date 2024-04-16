Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00A9A5FEE3
	for <linux-fbdev@vger.kernel.org>; Tue, 16 Apr 2024 12:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713271306; cv=none; b=Hf1Uj9u2Aq/e5gfYFSEd7KXzZHzhOksgM0zrq5a73Wck3driIfjzTH5nBoOrL5xxCEB4BKZJDRfUrNTos19ROl+ktaFKJRj50CRzqPmUmqmlAXJdM1egHObZe01yLSjJ5nk+onN24zm3n++FwgtgLMJycKHPIN9Ct7dfX5a3VoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713271306; c=relaxed/simple;
	bh=mi/HypBQnEgYf8IQkrjQqofRoBdId29EW1lpuyx3X7E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GBk+0FFnpSIhNcb9JTAWuypmcIF8NuxBzAJXY9EVHnrGIAy6wKtoZi9UDK37gqlBdP6e1LCttbSXmHlKTm012Zt9ytwK9EoPfKoyEcIyYGbcshG5Me66P7MksaayZdI+YmQFUa1Y9e1KSpL99EgLwqNkrnK7jR00n6W+2hkQqRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eX2jnkHE; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eX2jnkHE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713271303;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JEzqBt99V/qjK/q3dhyjW2ywFnVT6g8gHK8Q3RaZPnU=;
	b=eX2jnkHERL29Fg/WZdSsJyleqdrXU8mMhubZ9M1KIbIOjtKk8eEfO9FWB2X09/cSGMZsHw
	Q7wr60zfAd+0vGSFDp/jhpBykhg0m83cYn1nMg4tst5OYdJoddhzk3IoAPguxtZ7aMmXhE
	5pmxC+gSfqoquMh9yBgnOmBSBqQkvLo=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-609-T9N7NJ8WOLOI8s0yhf5PLg-1; Tue, 16 Apr 2024 08:41:42 -0400
X-MC-Unique: T9N7NJ8WOLOI8s0yhf5PLg-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-346d3020e08so2918323f8f.2
        for <linux-fbdev@vger.kernel.org>; Tue, 16 Apr 2024 05:41:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713271301; x=1713876101;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JEzqBt99V/qjK/q3dhyjW2ywFnVT6g8gHK8Q3RaZPnU=;
        b=n7p3enTrFl+0947xG+ffXv68OvduoXPgjoSzDCONEsdYD+ssxRFLUudMim+ZG8IfKB
         Uy9QLmN1nxGqmMgD9Au5YdXLDuIYWLVvPR//0ct1QnTSAd4xa7JLmioVGngbbKhvNT0k
         iwYcLtMGXBsbNisJdQgswQ7cU/WJS2Tolfa6tvCQUQ7v7uXpjzYztgL87OOWpFlg4nJo
         76lGgnvC08lW0oZhFEhs1Sp6x/8oqurBgQ0ZtO1KfSgzDmiFKWbc7/qm+hQENncg7lsB
         cC3AgRcCV4Z1GeRfSEWd/aGCE5JtiaqSect6Jg1O7mw7gdcKMRUnqTXVwn9jofO0YmJw
         uHlQ==
X-Forwarded-Encrypted: i=1; AJvYcCVtiDsRSUIqwM/MW7F3jbkBo4MHhEJuaSdOcrJN3K4K4Oq9LwR5NYDl7qTBunVe5Ff9XAReI4HtWofl/cMeD5RCHPr3L2zaiIYVx+E=
X-Gm-Message-State: AOJu0YwNYHF7rO+457oAOnt3L/eErsI3qBGWigdiGJF0KOmBOyMVpMLz
	xdfC9XO0QCdUEn/jHp/eJrCclCFOQMcB1vDwSz4YXGPSiDeNEMPSHsBYJ8F5v5rtgYWs4iCatzH
	nhKdsu1yyKuq3lOZyoVjaW1HpFkg6Hn5kJ5q2wXNnkglUvmPGs7lIW1LHXB5ydMBMtYOA
X-Received: by 2002:a05:600c:5251:b0:418:1e00:12d with SMTP id fc17-20020a05600c525100b004181e00012dmr5861485wmb.17.1713271301243;
        Tue, 16 Apr 2024 05:41:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH1+v/UZupgeBk6llFP+UkLAmWoQ5iO5NgJ3iL3Z/guXwO+xwUxUldecOPPuQfhEXYpVwgZew==
X-Received: by 2002:a05:600c:5251:b0:418:1e00:12d with SMTP id fc17-20020a05600c525100b004181e00012dmr5861475wmb.17.1713271300868;
        Tue, 16 Apr 2024 05:41:40 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id m16-20020a05600c3b1000b004182b87aaacsm12528502wms.14.2024.04.16.05.41.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 05:41:40 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Thomas Zimmermann <tzimmermann@suse.de>, deller@gmx.de,
 airlied@gmail.com, daniel@ffwll.ch
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, Thomas
 Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH v2 42/43] drm/fbdev-generic: Convert to fbdev-ttm
In-Reply-To: <20240410130557.31572-43-tzimmermann@suse.de>
References: <20240410130557.31572-1-tzimmermann@suse.de>
 <20240410130557.31572-43-tzimmermann@suse.de>
Date: Tue, 16 Apr 2024 14:41:39 +0200
Message-ID: <875xwh5vjw.fsf@minerva.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Thomas Zimmermann <tzimmermann@suse.de> writes:

> Only TTM-based drivers use fbdev-generic. Rename it to fbdev-ttm and
> change the symbol infix from _generic_ to _ttm_. Link the source file
> into TTM helpers, so that it is only build if TTM-based drivers have
> been selected. Select DRM_TTM_HELPER for loongson.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

