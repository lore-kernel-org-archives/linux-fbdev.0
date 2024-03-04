Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D084B654
	for <linux-fbdev@vger.kernel.org>; Mon,  4 Mar 2024 10:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709549092; cv=none; b=JvENIozbHSdO+MkCREgca6CcthMGLmJE511jg1+YEH7Fw9CzqA+RXfrz1raq4SWDUqwHvVhiYMmquJw4jWXgceIdmHhj5Zkujm8aLoYikJc8Gn2RYWo6xwR+yWW5+Xfw7QzB8nI+Zz3ZR1X6JQUkzpg9vQnTVhxRcvLonHYpn7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709549092; c=relaxed/simple;
	bh=DShOdkyxQQydWFkGrr4h1cWbRj4V/cqaen17JYA3fLo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sf4JmjxQtcEya2qDN3sbKsHaxFTahKsXhsY7n802OnnlLboeHp+g56kcCdJABhwBsuo84LIYmSAnTo7Cnko3Ecer/+nXXHvmfHsKyXnK8VlcEt130ae7Vdy6FY4+a1jGmiqAPDqttc0MYwBrygxVkk6j7mzJcSNnTC/63sotIgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YHc/qnd+; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YHc/qnd+"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-33d0a7f2424so2350608f8f.0
        for <linux-fbdev@vger.kernel.org>; Mon, 04 Mar 2024 02:44:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709549089; x=1710153889; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DShOdkyxQQydWFkGrr4h1cWbRj4V/cqaen17JYA3fLo=;
        b=YHc/qnd+JSnx05cPqvb/C3njAEicMucAFRNqoMDBp6nkWV38jk3DjPB4yAjfO/MJ6R
         U10Z7UvOL6O00yhWdCl55YMM3rr5jM6ji96MfOUa6ZJnyLGl1aidQTmNd2a43fXtG5jG
         KnCu+lkbr8b7Eu3wthl3X2dPRTD9K33K1LLZdKqBr2BMtFzMWj28RyADTn2gjrLjEO9f
         Mf6OETZ1MY5s+/G+dc9AF8MFFBqOa5pPdVEwErkY0qJ9DsepIj6+ZxjAcn7lJp4EMH95
         d62mh8HEtWdIncCE9bZUX4fkGt1MuGqhikVLFaaUwcQxcHreEqYRcGG7+/2AM5uUsbHF
         p2iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709549089; x=1710153889;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DShOdkyxQQydWFkGrr4h1cWbRj4V/cqaen17JYA3fLo=;
        b=Ib6vgt6hU+spMXqfPc/6vRAU03NwPjdfpFBpMd5HiZiDhh8/SDd5hIpGrITuQ1BCaJ
         WL06tzZuvyrGRFM8TWDmpkCiRIqQdq4oiD0X6dKaHw9wvNhBjQEhO3ta/29ETUn1Mjoy
         AoHL94fqgKZLBm7yTvdCQPHDUTlVKxMpwcqdKS7+YyFd6A/dQy63aD7c6Wmo7PIoFYU/
         JemF1JmIoX7LODvx+w9hXy0aJNVWToeGAt65lFQqtRJz2L0pxz1Zobw5gMlBF5WSqDFP
         mSjfDrUj2wNYHQPUazlaHBvKnOP0pVcXHV6Y6JIHcVnDKjiOd81bwvqG6/pGAExDBA4/
         2AWg==
X-Forwarded-Encrypted: i=1; AJvYcCWTZ0JlslroDaajkWgjX3lkJaOGLPI7ro+CeQRmAGKrJykHgjqsu7oz+3ASur4KTUm1uccM9Z0qA9DNHU9wybgjHaMPEAbTk2lIGws=
X-Gm-Message-State: AOJu0YwXtKM7m1kV0MwLPBxPfiY7UcjbTQr0apz7sfwMsA584/0HtoBI
	4P0rlh6DJvamrKCNbELBqhOE3xHDmoHNEmbSuHWmj/2SN4rSQZk5d3DHzkOjL5M=
X-Google-Smtp-Source: AGHT+IGHNvJcAynoDjTNPW/ad/wQJ0F772XQ2t3xcrYzgUbC2j348i+2RyW2OuqOddYLNpQK9qlF5g==
X-Received: by 2002:a05:6000:181b:b0:33e:162b:5353 with SMTP id m27-20020a056000181b00b0033e162b5353mr6523335wrh.16.1709549089558;
        Mon, 04 Mar 2024 02:44:49 -0800 (PST)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id t2-20020a5d42c2000000b0033d7dd27d97sm11832699wrr.45.2024.03.04.02.44.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 02:44:49 -0800 (PST)
Date: Mon, 4 Mar 2024 10:44:47 +0000
From: Daniel Thompson <daniel.thompson@linaro.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Lee Jones <lee@kernel.org>, Jingoo Han <jingoohan1@gmail.com>,
	Helge Deller <deller@gmx.de>, dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/7] backlight: lm3630a_bl: Handle deferred probe
Message-ID: <20240304104447.GE102563@aspen.lan>
References: <20240304-backlight-probe-v1-0-e5f57d0df6e6@linaro.org>
 <20240304-backlight-probe-v1-5-e5f57d0df6e6@linaro.org>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240304-backlight-probe-v1-5-e5f57d0df6e6@linaro.org>

On Mon, Mar 04, 2024 at 11:11:42AM +0100, Krzysztof Kozlowski wrote:
> Don't pollute dmesg on deferred probe and simplify the code with
> dev_err_probe().
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>


Daniel.
