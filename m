Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2F9E22541B
	for <linux-fbdev@vger.kernel.org>; Fri, 27 Jun 2025 07:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751010742; cv=none; b=JRYt3SYsy+7fs1ia6EHLpWZWjiyzieT/XNKIAXzOgtUPo1lzIk62FDttaiRQWeBH2gfbtnSpxOQZrOcHdM+5zZmtK+D6WcBRfQZqtqZkV5fr+qeoP9TJm12jNrReS3a2Uk8i3c8zRIQPPPZsNkgeDQuccrll81Y1QtK2c03TxQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751010742; c=relaxed/simple;
	bh=LZ8XvF7Mxx6us22Wtq1V0lH/iTurIql0J+590VcfcQU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=TMeFpqC+G/rsxgc5kTwOmuyiIjwOALjRbnzEMB8WBEb+B6dbTpBe0JqNvRzItjwxjcDvm8hI4P7H7xFlUY5qkVbhN1bruQCnMGW8HnaUbZlznlB9H1nGQNqda9aLHm3V9A+mmMLhq/1nBNxod92+cCRYqiWboblUDbbAaPZUq40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dzbt/qIZ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dzbt/qIZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751010740;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wP3Am+ANc8SurwHR78cTMLjrIEmhW8vePBXR1xmw9wg=;
	b=dzbt/qIZhtnDd4haCauvOn/KPsCVyec6aSq+WEd6iF+gQJS3S30Wg43Khuv+CLVT8Ed7Iu
	BNjqtGLeuDpPR9ydvqmDDgFx/tzcPwSyrzT42D+cguR6tm+jxM1Xqt9a2yps24sqMeekN7
	3FIO9L0IieovEUD986COr+rkrPz84IY=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-90-WS-oCo5dNiCfEtRRwHRpWQ-1; Fri, 27 Jun 2025 03:52:18 -0400
X-MC-Unique: WS-oCo5dNiCfEtRRwHRpWQ-1
X-Mimecast-MFC-AGG-ID: WS-oCo5dNiCfEtRRwHRpWQ_1751010738
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3a4edf5bb4dso1206723f8f.0
        for <linux-fbdev@vger.kernel.org>; Fri, 27 Jun 2025 00:52:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751010737; x=1751615537;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wP3Am+ANc8SurwHR78cTMLjrIEmhW8vePBXR1xmw9wg=;
        b=eFRAolOqjPtMfvoGvOytTM/eL2yPiL2KMvDk9TUQAQAh+4dHR95WdFCsL3IVaHsWwn
         1jOStTpPsbGdcwYx/iqXpBZ+Y6GblBewY32z5RTduMtykXKBiqQ8nAnxLs7y0VjcXykl
         0f4VWBsYBAdmHi8RfVVPT1NVnrrQD8RkO/nxlYO6/psfbx71+GEAfqw/b3f7tQIRaBzn
         F/56MAOwOmTXTD+m82qAOUwOT33g9i4nKFdBgE0qf6MbVP1baDlzIsCkGimQH8wyQo2E
         yHpRp1ZksQvEzax9Y137jZxU+Q1GXIuE4hxg9CrYN6dVO4bjwVFfaPiiIMFEoFQYvSrm
         5gqQ==
X-Gm-Message-State: AOJu0YymiWEMwc1izglogEyMfxZWpOCfcWIWe4BPjKXSJbTnccmXwJc/
	skihWxi8V55WoCmm3sDknhtTyj75M7e2s4isvVpxeTOFZYFBKRSjPg/45zXGPCje6T4MdjglT1d
	quVAjIq3ImojECDRfJn/YiVbXwn/UqC4Rfn/W1FUqwvcLIu5+bBGiNR0MN/T6DgOJ
X-Gm-Gg: ASbGncu4l4aGOXQgE27COuiynff0TRe7wA3U/Mq8dqWr+3znXkES9O0mJQ+s8MO/+w4
	jnEK+kMhvj9L2Fdoe3cVT2QmfINwEO3Lu3IpmXrKktr4y8A0uUuE480fvBIlUFkc0+USZ1BrvQm
	/QR+TVF5wvql3RY347ffU8gOUmuSh8Zf65IS0BnmLs0sKjQHRKaexWfDehiW2mcx4dNhTuziUdf
	q4hSR83oqqm1wK2wNqhLfwP9OJ7NbeObfGfO+4AmquIs5eucnil93mzKS1cGjOmEw9oorFhtgx/
	BRKecQXx19sWZMA6wz45QWStii1Qf3fFRzkuJAzEtQ4n5U+gcIQq4P0qINYQy5SQkkpxWGWHSAm
	O2N5q
X-Received: by 2002:a5d:5189:0:b0:3a4:ffec:ee8e with SMTP id ffacd0b85a97d-3a917603a8amr1417639f8f.36.1751010737556;
        Fri, 27 Jun 2025 00:52:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG7ntZFEdWDDOOUlWvZHIMomkMQZ1SFGsR8HVEbSnA9rjXNcpfTHf2xPjxO564UD5YkGxL3rA==
X-Received: by 2002:a5d:5189:0:b0:3a4:ffec:ee8e with SMTP id ffacd0b85a97d-3a917603a8amr1417618f8f.36.1751010737151;
        Fri, 27 Jun 2025 00:52:17 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a88c7fadf3sm2001410f8f.34.2025.06.27.00.52.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jun 2025 00:52:16 -0700 (PDT)
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
Subject: Re: [PATCH v2 4/5] fbdev/simplefb: Sort headers correctly
In-Reply-To: <20250623-simple-drm-fb-icc-v2-4-f69b86cd3d7d@fairphone.com>
References: <20250623-simple-drm-fb-icc-v2-0-f69b86cd3d7d@fairphone.com>
 <20250623-simple-drm-fb-icc-v2-4-f69b86cd3d7d@fairphone.com>
Date: Fri, 27 Jun 2025 09:52:15 +0200
Message-ID: <87o6u9d3kg.fsf@minerva.mail-host-address-is-not-set>
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

