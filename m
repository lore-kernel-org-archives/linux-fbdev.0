Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED22E6FE2A
	for <linux-fbdev@vger.kernel.org>; Mon, 15 Apr 2024 12:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713185215; cv=none; b=aBQU/CbuInKw7TzURbZ2+JUz1fyS8dwotJGAqoOF3ThO5h10nYSG2mBBS+YwLzCSup0WpfwNgnq1IPWePNcgGpfIok1G1H0khPYpO7ka6F4h9WB6HkdabaGtqNoB+uFslhYPHlZdd6UQT1xHMGfWPt0U65TMKC+lUFV1sFVSc3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713185215; c=relaxed/simple;
	bh=LZr9b2jjHgXnxRQrIHWuOp1TQFMyAy7pMficXH8VXFA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AGvGR+iO6pvHgvZamwWx6hf/fqpswfLLahxlOd93HurTZtP9/WZ4FDas+BUpOqjV1QoYBok7LQDtwZmlkiPzXkAvduK76xzNNssfrjQ//OHyEoaSDq1Rjbr3pLBZKQXROLsTd2S2qw/YSHTMlb0EnJQc4X2EpXyuxNs9tmpu2iM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=shJEToUm; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="shJEToUm"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-41868bb713cso5378915e9.0
        for <linux-fbdev@vger.kernel.org>; Mon, 15 Apr 2024 05:46:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713185212; x=1713790012; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jbZUbhG0ov/FwjYBTgroRKws49tP3YZqZ1e9nA++yqQ=;
        b=shJEToUm56T4SyXUqRI9Lfj9MAE3WjgiLsMAstobhhQyUD9ZndUBy6azMFjMFjANfo
         CQMrODslF+6E8HEDOAqsRAOMGGgQFBDkmxQr1kg9h6HK4t/9AapwQ0T7DPiTPYbKo5y6
         oAGi2WaasaxvZRfaKkMb4hPDLG+3fOYlgXTpYFucaZpppH5PBY7PhG4qDIiffvZA47Hj
         geUIBRl+L3em8L0EEf1esoxsXNYuBTrifcEqKJAdkT/JP6UgZABmGr3u8rIC6tVEPEnt
         OGv4JdbrDhJlqUCEUB/K20slZqb++3BCzoUmsqfRoj5Iat0G58Qc5r1GjbEp/YFveXEZ
         LeEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713185212; x=1713790012;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jbZUbhG0ov/FwjYBTgroRKws49tP3YZqZ1e9nA++yqQ=;
        b=fgSry7n8eljehOTt8QyFPfFgZtU+cNmtiTQVUivjLiDfPNPXhbyjRdoB7I4t7UWxZK
         DHbRVxKZSmyhmQEOKb9l7j7UWtj4ya3gokdTSbRgRzClmLi1waJIrLwCRCI0YVAQbdY6
         4Py4Gs4HZqrFtgaddqXndduXbMi1F9N6USR1yXeatu6x749ODDgbOjJdh8qN7rSIBv/T
         yAfatRNT8pRlXIClqXJkpSC2TvUnZm93cpwT6kVI5HaJzj1AWEl7CVYxoDCv4lhNpaBt
         qXrRfK9SUBZS1FaeAT9p6z5ak69/IsWhGjDFtbbyVh4CDxYZhPN+Nxsc8bYb3ur7J8h0
         CicA==
X-Forwarded-Encrypted: i=1; AJvYcCVjbpqj4s19qYTihfLqfpyQvXpzr35GbVWNPm57XaS+6SlwDDjpVv47Y/lS1L/1nVowCKU4/yYv4CEZ2Ovx3+Y7Md6gerx3tJEB4kA=
X-Gm-Message-State: AOJu0YzWJVb+kIf1AOeyIAfixvy7QL66mfS4vt5LpbwhtsXqhE9gT2DY
	ZieyJQZK+p6pKB8oSI5XGYiINayxwqFyaw6sISO7mMIRnnnmaPx15GuVm27Ge2A=
X-Google-Smtp-Source: AGHT+IGhmqnCG1TcWkxS+Zn15K31a+Oo01IPIQuW6ofPPWCyjZuMzPolU6GYhaxMv6ytY7keceZXhg==
X-Received: by 2002:a05:600c:1e21:b0:418:6cda:e95e with SMTP id ay33-20020a05600c1e2100b004186cdae95emr1418529wmb.8.1713185212321;
        Mon, 15 Apr 2024 05:46:52 -0700 (PDT)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id w16-20020a05600c475000b00417e36953a0sm14818200wmo.20.2024.04.15.05.46.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 05:46:51 -0700 (PDT)
Date: Mon, 15 Apr 2024 13:46:49 +0100
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
Subject: Re: [PATCH 01/18] backlight: Constify lcd_ops
Message-ID: <20240415124649.GA222427@aspen.lan>
References: <20240414-video-backlight-lcd-ops-v1-0-9b37fcbf546a@kernel.org>
 <20240414-video-backlight-lcd-ops-v1-1-9b37fcbf546a@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240414-video-backlight-lcd-ops-v1-1-9b37fcbf546a@kernel.org>

On Sun, Apr 14, 2024 at 06:35:59PM +0200, Krzysztof Kozlowski wrote:
> 'struct lcd_ops' passed in lcd_device_register() is not modified by core
> backlight code, so it can be made const for code safety.  This allows
> drivers to also define the structure as const.
>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>


Daniel.
