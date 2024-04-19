Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F10053B298
	for <linux-fbdev@vger.kernel.org>; Fri, 19 Apr 2024 07:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713510276; cv=none; b=btk3VNomON2eiv7JxLnqje/9/4Csqhu5Zz2OgDj7GR2TabO8abnV19B8xGY3Wff00hvHtbiRDn93RNJh5b0R6+2GhH55MzamgZO+l7XXUbUExfHMs9+lqqlWlhg6vtTmTpmi3TiN+cwOCdQPYSROrVuz2qmdSaa79+UVXk9szuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713510276; c=relaxed/simple;
	bh=D3bCX/xFBmsBY4vO29ByYH7PONTtoAd9kcgiim7C5Uc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=X6rWe98Wg12Dxz7rmhDOxhw/MsW60myKZt/rsmYEkBO3XCD4jQ3G3hLUfdvNpZGjLruzlkC8BTEnCsDnzfbfktp68rvE60mxlqSRpm3vd2eckZwrZNIC/hm25YZZOFHiB80hwN6D29hmlNCpLNR5a/JMcr7c5LzDZsmueygQI1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QE+b5leQ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QE+b5leQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713510273;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RrF53ndQa9Sgu43CWLxXlJZq6iA0dd4wA/lH76Cjdg8=;
	b=QE+b5leQxVrQ2iwm760KN44GOl5RNHFsGfHHsK6jFrpdkOnX5kzHTNLOT1QzOGS15+tpcf
	CTvmosOYjilDOl18XV/m8u9iHdU0kYW4jbsaSzfo3y1QIK7vRlVsF3Z+tYMyuY3KEVGZHc
	Hc8hAp5ChG0kl0vkFmc64vnjy9FWIDk=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-498-1FmDetXeOAyOe9ZDU3e--A-1; Fri, 19 Apr 2024 03:04:32 -0400
X-MC-Unique: 1FmDetXeOAyOe9ZDU3e--A-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-346c08df987so931690f8f.0
        for <linux-fbdev@vger.kernel.org>; Fri, 19 Apr 2024 00:04:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713510271; x=1714115071;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RrF53ndQa9Sgu43CWLxXlJZq6iA0dd4wA/lH76Cjdg8=;
        b=VatBLdx4Hhvd5pw4YCvka16mYk2k/XfU/5TLv1hxQTbaPKSqGB7AiNomW6nuz9IF6L
         xi5FtJU+d7Z0DgvLekOkxw/N92aEQvef0WjsMawv4mHBn/rfoaas/lgM/tU4aw7Iyv9Z
         eVLu+A8fjrud1iOPlDy8ET+vgny0EsC0EOw1HwptNNPjxO9a6mGlMhUu0uq/QHbv3KQ/
         bilFL9o1a0PZvCHcdhuyikc4u7X+oMlRXn02HEwZ9FLnZfoHphMY1n6elIpWBXRaL/PC
         /p/o6YoIiioQIW52tqBgZP8BnIzyFhhdrS1IoND7IjsF2/BWMKwfUpXxN9wcV7k1K1l/
         I3Zw==
X-Forwarded-Encrypted: i=1; AJvYcCWr3bEqz3VMHD66UwU642vvj02k/MZYWRCH7amORDyrw8nai1F3rJqKD5BwIwckK2iiCuMASJu4T+PSW9mk/RWCini/+xkNCzLyzMo=
X-Gm-Message-State: AOJu0Yyju/fl+sR61mGvUChQICwXwzezG5hLRW6auCYuAncLFV3quw+v
	MxHe0Cb9D5npMh45/kQb8g/Hj4F0lLiLwRQ1rxcij6CDOpqfFGduhjEPR23SSt7l4cxV2lPD8iz
	wK/6Vjs7gnGfEkXQzrJ+ohLgo8esvXhSTo5cxUjkVqHr8O+MXxkrrkmtAxBJP
X-Received: by 2002:a05:6000:1868:b0:349:af80:9b67 with SMTP id d8-20020a056000186800b00349af809b67mr3789505wri.30.1713510270821;
        Fri, 19 Apr 2024 00:04:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFPpkcAcvPPXH0B3Lun7mewkPmrcqy/fRLjlykJWcvyGXZveMZJ9WqJmQsdTv0gouAOu6XXhw==
X-Received: by 2002:a05:6000:1868:b0:349:af80:9b67 with SMTP id d8-20020a056000186800b00349af809b67mr3789487wri.30.1713510270437;
        Fri, 19 Apr 2024 00:04:30 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id u24-20020a05600c00d800b004185be4baefsm7724246wmm.0.2024.04.19.00.04.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Apr 2024 00:04:30 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Thomas Zimmermann <tzimmermann@suse.de>, deller@gmx.de,
 airlied@gmail.com, daniel@ffwll.ch
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, Thomas
 Zimmermann <tzimmermann@suse.de>, Biju Das <biju.das.jz@bp.renesas.com>
Subject: Re: [PATCH v2 29/43] drm/renesas/rz-du: Use fbdev-dma
In-Reply-To: <20240410130557.31572-30-tzimmermann@suse.de>
References: <20240410130557.31572-1-tzimmermann@suse.de>
 <20240410130557.31572-30-tzimmermann@suse.de>
Date: Fri, 19 Apr 2024 09:04:29 +0200
Message-ID: <875xwdesua.fsf@minerva.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Thomas Zimmermann <tzimmermann@suse.de> writes:

> Implement fbdev emulation with fbdev-dma. Fbdev-dma now supports
> damage handling, which is required by rz-du. Avoids the overhead of
> fbdev-generic's additional shadow buffering. No functional changes.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: Biju Das <biju.das.jz@bp.renesas.com>
> Tested-by: Biju Das <biju.das.jz@bp.renesas.com>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

