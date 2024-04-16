Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A02B21292F9
	for <linux-fbdev@vger.kernel.org>; Tue, 16 Apr 2024 11:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713267826; cv=none; b=j2UG9Kbn2b+rIF16E5Ld+hBtTUPgU6SqgMJGlrX+IgJbRcz/9yYiJ9FrjUUu3FJN279dzWKEwtwnjxnuCiS5eL5ki/40qwDkm54/l4q0KgjekfhL+fuPmHPtSCmEL77vsmF2v3BMO8knYadt/RsK62GS79Ap0o8yNCsqYR9iH1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713267826; c=relaxed/simple;
	bh=GQBVxlLlqXRR3iHIXIxnse8LLtjnNRfdqE+Eh47qxxM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=iWkk+XUkqSMMa8zadVegiBKIy880mf+RC1bZXS0651m3pFvGyObrAc96WUBixLdrvoNQMRXzEi/vzExzDIRDboTRzau/XWv8gevOJzVh8hs/rtTMmnr8AhXWNLR/jmj1Ox7o3XFXYdlNoZYqPihzch8Y6b0Al1BB2Opo3ZOqhF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PpnzDVpT; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PpnzDVpT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713267823;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9KoyNzqv6EO3Y9pWCSJdm5N+umIWz1ah07SpzPNr6A8=;
	b=PpnzDVpTZ84hGRpftWJ6YRzfiO11QoOTLFZSCCXPNcAeXZ0GdfervuchyCKCzwRV2GCmAV
	qOoFXIkBBrC2S92y8jqFX1ykuRJTUMapT7nTw9pQPzTkhTFQoq4GABHRkVL9booaphdAzj
	BGPkRZjvY9SW9OO6z+s8LJTlxFPkRCo=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-160-fDnvGMN1N76PXh_s1EWoCg-1; Tue, 16 Apr 2024 07:43:41 -0400
X-MC-Unique: fDnvGMN1N76PXh_s1EWoCg-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-343c7fa0dd5so2873362f8f.0
        for <linux-fbdev@vger.kernel.org>; Tue, 16 Apr 2024 04:43:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713267820; x=1713872620;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9KoyNzqv6EO3Y9pWCSJdm5N+umIWz1ah07SpzPNr6A8=;
        b=KqNfyRc0mAZ0Jaf0h+EHhYvtpYmMus1nRnuvOTgIL3qqCWk7CSqmO06UAkS3sCBQ1t
         VRfJ/K8EdSFDkhmZg/Au7yOUf3PFMHQEFTR+5GVKrRBvkPiCc7oOB5A2VUiIZmxkJrGF
         gvQGvRyy2POVwAnTXOyvY94Zu9a5CKs0dsgesXbw6ehqF80rrh44ty7Uukpi5d4fUZoz
         jKsDULi3NwC/CyuZzKBuOP7PvMyG43MNshSWnmAhs29lECAHqjZEylbNJ6UxShhhpz8o
         GPAcy7J/oSoa4TisZsTQiFYz3IffkquIU8LVfYwFoCRc67A5N1Y68PHshPtwKKM+DoX4
         otrA==
X-Forwarded-Encrypted: i=1; AJvYcCXm0uwnjI6ne14LVLGfLUAEelG2LAbBjgckN3FcFbw4Z3ZvsCvyWCUE34Dlc3EJL1iA7wVUCtiT2gypROyc8RPvJGSdq2OpkWepBaQ=
X-Gm-Message-State: AOJu0YxYOeW1G7J4p+j+7T/yd8szD6KjQ9pkZ9ZeE8FeyeTI0dBme4p7
	pb9XG/cUlMvhtodIlmDLquwLkn6IfP1AXe0Yuo2xDIN9hw6hAjo2M42Va/yyEUqGcGiQaZTfree
	cOMZX4MesP/Iaeon2W8dVQBoMjqSo0CfUn0HS3uq4lbBu/JFdN7kPjijK2Axt
X-Received: by 2002:a5d:60c5:0:b0:349:95dc:c233 with SMTP id x5-20020a5d60c5000000b0034995dcc233mr306449wrt.71.1713267820710;
        Tue, 16 Apr 2024 04:43:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEzFQ09EwHIHVaSu6FgHcHjKfv9jthELYDaHc23TfWuOhc6SOQ7o2ICvfc4X6hxrNhXOQAYhw==
X-Received: by 2002:a5d:60c5:0:b0:349:95dc:c233 with SMTP id x5-20020a5d60c5000000b0034995dcc233mr306432wrt.71.1713267820383;
        Tue, 16 Apr 2024 04:43:40 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id di7-20020a0560000ac700b003439d2a5f99sm14544902wrb.55.2024.04.16.04.43.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 04:43:40 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Thomas Zimmermann <tzimmermann@suse.de>, deller@gmx.de,
 airlied@gmail.com, daniel@ffwll.ch
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, Thomas
 Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH v2 17/43] drm/tiny/simpledrm: Use fbdev-shmem
In-Reply-To: <20240410130557.31572-18-tzimmermann@suse.de>
References: <20240410130557.31572-1-tzimmermann@suse.de>
 <20240410130557.31572-18-tzimmermann@suse.de>
Date: Tue, 16 Apr 2024 13:43:39 +0200
Message-ID: <87a5lt7ct0.fsf@minerva.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Thomas Zimmermann <tzimmermann@suse.de> writes:

> Implement fbdev emulation with fbdev-shmem. Avoids the overhead of
> fbdev-generic's additional shadow buffering. No functional changes.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: Javier Martinez Canillas <javierm@redhat.com>
> ---
>  drivers/gpu/drm/tiny/simpledrm.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

