Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D6AA12BE85
	for <linux-fbdev@vger.kernel.org>; Thu, 15 Feb 2024 12:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707998560; cv=none; b=T2Si9c2rRLZUUE2IKBmKBa89tiwCgmILTK68JWFO8iC50z10s338g503SxZpSkFOv3XQvrmapM+SKGZPUQtoGRh1lV1nJx4HtK53BFk8hmT0sPx4aKyQbh614exvBpHIol7vc2gPxtGJjMd16qu6zMNRENBZ1fU3qPyxrO7pdq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707998560; c=relaxed/simple;
	bh=vbgRA2GMlce397fPZXf/sJUC3uP4O/JDU4BLWHn2As8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Om4McCNfCPL4uZL2Vjr/vmfv9Eyd/XaUE9LYXdqWdDLqKQa2+qzfZ0x5M6ssTUiGqk0scAnFTz44QVqXYcj/bED4hiaYMYeAzuXwqtvEA96y3JsL5wGlV+ijZmpxckVSdgyjwuz1A8dUvGRo4PJFcGTO6ALvYI6CRuB+/B9KtlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OsXwhnjD; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OsXwhnjD"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-33cddf4b4b5so564122f8f.0
        for <linux-fbdev@vger.kernel.org>; Thu, 15 Feb 2024 04:02:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707998557; x=1708603357; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vbgRA2GMlce397fPZXf/sJUC3uP4O/JDU4BLWHn2As8=;
        b=OsXwhnjDPFNVM5GLiZ0J0gJL5R+PQeoy7maGkeplncYqGcEqXpR0WYYO6wzGFQPvGE
         CSBv5XrWnYh4va0cWj+Rw28nlEUU8bohKN7lurdLy0i4Fpc4vkGjSM9DPd2ZvIiM4kSY
         zB+Ja5yP0M1QkDqHIcTkPh3GPbMyevli6gfyjtNQbRQ5fKjRCMTPyZMfBOH3XhuRVlCN
         akltg8uPN/4zw54CZ97TnEbL1xU2fpfSqHSH1lqPWlqjifRxdUIyKtxMm+LnQD4s1f88
         7+ajLJHMZnE2ByIbvcdxP9WsGlVUuFZ3zrHe59t7gPjABpNUv/bTOleJWL8OfqqBZDFE
         MBZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707998557; x=1708603357;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vbgRA2GMlce397fPZXf/sJUC3uP4O/JDU4BLWHn2As8=;
        b=p+a10XgneJONhxE3r1LLneJJ73bXQVRc9RV4gWFMN6BeGqbDaHdV9HJ5Hj9CfnLRsh
         pOrRmyvF65BFjKQ8K2j9M32/GI9071pdZhkhIeC83RQtB3dNIS4rzn5lHs9Me3PGUmgd
         4N8pPGYjB6U7Y0Ho21gMce6p4IRDR8E6eCnYXSDERwUwDQYLagehiIUdVZWCp23RmPj9
         hek4pbWaTNiPGnKPL2Urt5lDXUyx0xFPwtHRzakvRiK91JBbeJ12Ah+teKbemmK4amyo
         4fe633U5LxtYSFxZ06AvCSs9r0l1Wurfwh3btaPBbwH8XxjEkSc9eKj1On23eK8pxj3O
         2gWA==
X-Forwarded-Encrypted: i=1; AJvYcCVDJ1cX/ftKfXB9Z7sMgPDsU4BFpZsc45HvDAj3/KTiYXkDr+iT3Df+8lBPaZgdmuA6IT7vG/G/S1cOpul5FPXSOU18LkbhWITDLec=
X-Gm-Message-State: AOJu0YxeTZ8+TCH1lF9OlR/7gyf+Q+NslDpvcKpT0Dfx2hJVPIpUDku3
	QTIN4B7Pbq5Je9nAeKlyhxhtaIpOLT6nWb/S0Jxymk6NlEdWgm7fP4yiOk7p1UY=
X-Google-Smtp-Source: AGHT+IHkovjjm6uiGh8NEiN+5Igji2gmONxw1ozHtZ/fWfNAab/0bhMXeBul3IX7/uedCw8IfPnK6w==
X-Received: by 2002:adf:cf10:0:b0:33b:2884:edf2 with SMTP id o16-20020adfcf10000000b0033b2884edf2mr1196357wrj.56.1707998556956;
        Thu, 15 Feb 2024 04:02:36 -0800 (PST)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id bo2-20020a056000068200b0033cdbebfda7sm1407012wrb.14.2024.02.15.04.02.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Feb 2024 04:02:36 -0800 (PST)
Date: Thu, 15 Feb 2024 12:02:34 +0000
From: Daniel Thompson <daniel.thompson@linaro.org>
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: lee@kernel.org, jingoohan1@gmail.com, deller@gmx.de, javierm@redhat.com,
	dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
	linux-input@vger.kernel.org, linux-pwm@vger.kernel.org
Subject: Re: [PATCH 01/10] backlight: Match backlight device against struct
 fb_info.bl_dev
Message-ID: <20240215120234.GG9758@aspen.lan>
References: <20240212162645.5661-1-tzimmermann@suse.de>
 <20240212162645.5661-2-tzimmermann@suse.de>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240212162645.5661-2-tzimmermann@suse.de>

On Mon, Feb 12, 2024 at 05:16:34PM +0100, Thomas Zimmermann wrote:
> Framebuffer drivers for devices with dedicated backlight are supposed
> to set struct fb_info.bl_dev to the backlight's respective device. Use
> the value to match backlight and framebuffer in the backlight core code.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>


Daniel.
