Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C37FA7F7F6
	for <linux-fbdev@vger.kernel.org>; Mon, 15 Apr 2024 12:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713185377; cv=none; b=L2PilakD6p/Wgha7rn1Ex6uQd08079jkxZw2POXNZb9XsaddXlVgFJHHg9PlwovDX03OmOJ9Id1xsYHsCy7pNuYsrrlmDKooQfLo3VB+hmyuL/TyduVoL24X+gH+83iC7y2Y8+L8A664yj1oBnj7ntHZV1GHOK/Fz0siCINAEaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713185377; c=relaxed/simple;
	bh=7YIJFnYRyaWXrPlltVrIgYB7IVIKl7WksqYGlHILtZ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QXg7EJDu/t/VXtMFWOV7Bb+8xZJK3/8RwXIIxs4CDyYa/6G89Asf2zFbOt6S4Ro8u7Ky37qNLbTKXp35EYIqjsCRjQMjUBfNC+KdymMeVec8iThbaLLPEcquhNrsYZEG5+GoLTlbVNbZxe5OYsPpG8Tfvw5aMxu6fXtvJ/ELdZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=h42Oc/7Z; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="h42Oc/7Z"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-346b146199eso2280529f8f.0
        for <linux-fbdev@vger.kernel.org>; Mon, 15 Apr 2024 05:49:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713185374; x=1713790174; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7YIJFnYRyaWXrPlltVrIgYB7IVIKl7WksqYGlHILtZ0=;
        b=h42Oc/7ZaIDppUj9LBgMtk36CPgay2mkB6FjNXTWYcpcJS1EKTHZhd4R9+wbPhLeeE
         eD2LJR+pwSN2Pq+WKr+qvs7vl+wrkz8LglHmA/GzqpuHJYGw04yNLBSh01tyGL2NmhUU
         CneZggItfMkbLqoAPtkpSmuxSNT+abgnRrzc1vDdwpH2mxUjjwu2FhyYEsr5MzJXmOQr
         wAuAO3y6x2FKz+WUjzWFTejCqfHFlrneCAtGfAaVAODeKfE6dE7kQqrtxuC7YgHOEMvg
         +/E1TYCT6bMulQep/bk33kTXywBOT3vueCWsfMJoq9KXZYF3tLacGVATaCWQvn6B/BVs
         p1Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713185374; x=1713790174;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7YIJFnYRyaWXrPlltVrIgYB7IVIKl7WksqYGlHILtZ0=;
        b=CDX5zQYJio2usW//mFWbiAKwLZmB7iMJ4H9qRMgbbbtOk4nhEh3yOYwXy9BN8K7osp
         Egmsj3NMzYhyer+OyW/2ggwl/PhzjHHI2oTo5Fo35vgoZRr6wBdR+eo1XjJCk4fimSIB
         mCQfBACDcvwb9fN02ewE2n0g6PjfJYC0SPAXt20n8XLTFXw9w8E/ylPnpO9NHDvwq5Y3
         i4YNVaUuQCdNR3qrLKxQAXRFg4VKavHGG3VzRYmscCMC58+BVGzFVNYEV7ftA6/bq/h0
         9lGH5pP/W7sZzFmZUmZNDLG2W5EqVmLspCs3k2Yz5qZTPnFKujuVT/XaeDJHfl6kYHFR
         hecA==
X-Forwarded-Encrypted: i=1; AJvYcCUFG69Z1w/hrRBpNrL0QAkD3/cPWDlyZbE8k7QIAECV8r9/b6gIZ8OLfn1EmcQ8kHoHZrhkrsdVV3DD5CwZG2rsa1en7f66vmMOTQY=
X-Gm-Message-State: AOJu0Yz/Wl2FKwQmt1HLO8m1aZWq2/AXrXMbHjV9s24eQ/BkHB8Ke+zz
	qcmYaHewrbRYCvp8G2/i56CMEZUI+P5+DNoKZtrhpELwr+A0+h00EsTicgGvRgc=
X-Google-Smtp-Source: AGHT+IERNVIb7kkkXkEPWlxI4SlxeSXGIdHfAlszM7dr954BuhwHUlim2WOUoHyibBjW2LFxYJ6i9g==
X-Received: by 2002:a5d:4e0a:0:b0:33d:fb3:9021 with SMTP id p10-20020a5d4e0a000000b0033d0fb39021mr6183299wrt.54.1713185374316;
        Mon, 15 Apr 2024 05:49:34 -0700 (PDT)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id p5-20020a5d4e05000000b0033b48190e5esm12005471wrt.67.2024.04.15.05.49.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 05:49:33 -0700 (PDT)
Date: Mon, 15 Apr 2024 13:49:31 +0100
From: Daniel Thompson <daniel.thompson@linaro.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Lee Jones <lee@kernel.org>, Jingoo Han <jingoohan1@gmail.com>,
	Helge Deller <deller@gmx.de>,
	Bruno =?iso-8859-1?Q?Pr=E9mont?= <bonbons@linux-vserver.org>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Alexander Shiyan <shc_work@mail.ru>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>, Fabio Estevam <festevam@gmail.com>,
	dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev,
	linux-omap@vger.kernel.org
Subject: Re: [PATCH 05/18] backlight: ili922x: Constify lcd_ops
Message-ID: <20240415124931.GE222427@aspen.lan>
References: <20240414-video-backlight-lcd-ops-v1-0-9b37fcbf546a@kernel.org>
 <20240414-video-backlight-lcd-ops-v1-5-9b37fcbf546a@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240414-video-backlight-lcd-ops-v1-5-9b37fcbf546a@kernel.org>

On Sun, Apr 14, 2024 at 06:36:03PM +0200, Krzysztof Kozlowski wrote:
> 'struct lcd_ops' is not modified by core backlight code, so it can be
> made const for increased code safety.
>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>


Daniel.
