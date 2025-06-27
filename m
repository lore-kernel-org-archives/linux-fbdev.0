Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFC1414A82
	for <linux-fbdev@vger.kernel.org>; Fri, 27 Jun 2025 10:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751018567; cv=none; b=JOs725+Mz2f2OSwy32LMnZiD6iWUOcXkRvDyzAHB/c7ymrSs8mJdDBHMvk9PUCXt6yDwOozkSetb8FnCnmOr/irtsx2va5Q092HXPE6BC8iXSLdDsfH0KlaSsHDZ0t8+OxHl+9LIQyUqTX0yzhzQMuGpWAusyAGG0Qf58bG+COA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751018567; c=relaxed/simple;
	bh=uND1zTsLbRfA156loyQQTWvczGvRZ/u+6QtGYINO3Bs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=eoGjtihK20FQSvA/QQ5NzOhoc+UilOulYCszJPZtUq2oq1py8HzYRWF/aWgKv/xI5OJE5SPE8bgSFsvY71gXr2SMF+roWnwJfmm3lsg004AwQNqEns0EJxcMkeSbgTnfqIa0tM1FKEfJnxJpI4ixT6MK0l7O3STLTprtLK8p8ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=H2ULDXco; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H2ULDXco"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751018564;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JruzEJIRQhce3mYeDqfrw5tsAk7gf7uEqexFvMHB+aQ=;
	b=H2ULDXcoYSxzfJDMT8q1mbApcDdV0OWNeLXRc8szkZvDqTyBaT6/NInzcMtySWjDRJ/5/H
	yoUzmkzoRD63b40sutekOFEGrk47See9ObBrms7WUqhjNroymBH+P49okx954IXzp9G7eZ
	sFdhXD3+QwyFIcapiPRnD0sGQuqSrrY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-636-GcQ894KlOESZ_arTCM1apA-1; Fri, 27 Jun 2025 06:02:43 -0400
X-MC-Unique: GcQ894KlOESZ_arTCM1apA-1
X-Mimecast-MFC-AGG-ID: GcQ894KlOESZ_arTCM1apA_1751018562
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4535ee06160so13585305e9.3
        for <linux-fbdev@vger.kernel.org>; Fri, 27 Jun 2025 03:02:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751018562; x=1751623362;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JruzEJIRQhce3mYeDqfrw5tsAk7gf7uEqexFvMHB+aQ=;
        b=qcCQJbZ6fkAwF295S1lr8asK6sDjoMrHtmyyfLk2FA30lEE8IR+DMtHeJaugarxk/p
         vIKqdhrzD+O3i0rmGlWNRqsewznb3Kc1l4z24PsxRN8ZjL0KH3M4JFlAUpfUZPPLcseY
         0jAautTkGpsnTLIRXkfFlc6VtoJ2fMD8ZUYHLDjXwj+0vwwY+4+wqTsMHZXgrX21ZUOH
         MOvf6OXnfbjKwu1Pamg9Wgthr1wIKjKsK995hI6ogOMgnLfhLRBfHCZA1sGXxbR1svgH
         2qLZN06xvDIujGiX+MBGyLC6kYUc8lcbAmuQKffIVsDyGhsqSYJDrB0xbzk/r4KH8CoR
         iufw==
X-Gm-Message-State: AOJu0YyVw5aiUOyRa7x1p72L+I8T+e78BVdSYhngK8ahw5zfAWpXEU5n
	vVeDn8k93GJ4P+2Qphr4R68HGwgwQIbDRnD3bDrr7VYaB4SdVl9D7fUyd5X3y6Ly/zfbu/uIT+3
	/Bp63g6lhjCrKVFDy1jHeoCQHksK/7ojRgcpuDww9tuzAzvZ4/wmeNvTp1h9gYAlK
X-Gm-Gg: ASbGncuI7T+3lFFWyDuJeg1v3ux8QUtZsb9pD6sndMbnp9yJrZF+iVXhNQRe3LPFxj+
	OmCxxareit/vLd38wBZV4jP7HQobDMA/S5K23VNdGd7fJhIhlFjz5OECfV9Qla0kssz3y5lqk1s
	4uvP2/3lEJ5UsPd82RqMfyoEaXkDo87ZruYsT+9YanQxY/bffMKdaM22F7kk2Jr7Q3DUqKvlhtm
	sGf+Ta7yf+L5kkuh3S5sH28q/qLy74x/ByJK7NzDimlr6+8GVjEpnfNvpeR8Sex0SK/E30ycBKX
	mvD82EFGswSYgNLr8dtl+AygQT1GwzSGaidkwmaddB1OqgFVkUbfFHAgzQkqtiUjYwMmQDlSaLx
	xNyn4
X-Received: by 2002:a05:600c:1388:b0:453:6146:1182 with SMTP id 5b1f17b1804b1-4538ee81e72mr24527135e9.32.1751018561967;
        Fri, 27 Jun 2025 03:02:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEwb9GAheZs7CdFHttEfxVdyFchwFX9maJhmXPPUtAcTAKpVIiwYykxGlnMkLxlaLZoZwT/uQ==
X-Received: by 2002:a05:600c:1388:b0:453:6146:1182 with SMTP id 5b1f17b1804b1-4538ee81e72mr24526645e9.32.1751018561487;
        Fri, 27 Jun 2025 03:02:41 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4538a3fe0efsm45121195e9.24.2025.06.27.03.02.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jun 2025 03:02:40 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Luca Weiss <luca.weiss@fairphone.com>, Hans de Goede
 <hdegoede@redhat.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Helge Deller <deller@gmx.de>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/5] fbdev/simplefb: Add support for interconnect paths
In-Reply-To: <DAX814DZF6AT.31N8TZWL5LMDT@fairphone.com>
References: <20250623-simple-drm-fb-icc-v2-0-f69b86cd3d7d@fairphone.com>
 <20250623-simple-drm-fb-icc-v2-5-f69b86cd3d7d@fairphone.com>
 <87ldpdd3dn.fsf@minerva.mail-host-address-is-not-set>
 <DAX814DZF6AT.31N8TZWL5LMDT@fairphone.com>
Date: Fri, 27 Jun 2025 12:02:38 +0200
Message-ID: <87qzz5biyp.fsf@minerva.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Luca Weiss" <luca.weiss@fairphone.com> writes:

> On Fri Jun 27, 2025 at 9:56 AM CEST, Javier Martinez Canillas wrote:

[...]

>> These two functions contain the same logic that you are using in the
>> simpledrm driver. I wonder if could be made helpers so that the code
>> isn't duplicated in both drivers.
>
> I believe most resource handling code (clocks, regulators,
> power-domains, plus now interconnect) should be pretty generic between
> the two.
>

Yeah.

>>
>> But in any case it could be a follow-up of your series I think.
>
> To be fair, I don't think I'll work on this, I've got plenty of Qualcomm
> SoC-specific bits to work on :)
>

That's OK :) It was just a drive by comment, but as said I don't think
that this code duplication should be a blocker for this patch series.
-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

