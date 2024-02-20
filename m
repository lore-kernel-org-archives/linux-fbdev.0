Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA6A876033
	for <linux-fbdev@vger.kernel.org>; Tue, 20 Feb 2024 15:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708443711; cv=none; b=i+fEMp6Mgco63kZpY/ZSeCsRQ+uo0tfu/oDB+2p75vPNgrrX6uyw5ufoys70ZEEpipBrYsyHKfKUr95xL2R2/iAxbx+MeQH8OFoOxwi93CFGP0Ug5SG76lZwiOa7Bn5iSfA8toHwfKXns1wzkBSBzDQocQ7TbDiVj2niYicClfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708443711; c=relaxed/simple;
	bh=T78uSbL/6vBHmFMUx533JSz7i0LSC2jc2pTuwaqbKDg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ncL39iQJHIp8Y+/w3LJZwPs5vHuKYe6A7NajQAThhJztV403kDN9kRvj3h1Hd9m/8IFXrufKiLS+9a8xHxdde/6vuc6hnwGq869gMnaPahoyWS64dpx1mYL5nZB2dB/PdynEDkwHWXK7qR5Cdrvsr/pW0Bo30DaAOpy7x4sK1R0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=u8AruOfv; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="u8AruOfv"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-41272d31489so749055e9.1
        for <linux-fbdev@vger.kernel.org>; Tue, 20 Feb 2024 07:41:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708443708; x=1709048508; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+cFEpv5w2TPD8QTkYd4ABg1XTB4+ZdG1BlQCAicZJSg=;
        b=u8AruOfvTwBPWA7XghfXJbpi2X46ibm7crtvQrHa4h8DFP4DXhsFAxfWzjxEdukdhd
         56u8LAD24ALHAIdlo0lDhxLnLc2P6dF8uZbs5ZJfC6uoVBeTmjf226sAjJsCwrv2A+14
         5w8DG0SUA455m6WWlTElUuJMVprKkb5CbuV5Fo4byZZSorI/De+kNWXvuNSjKxhmjgeB
         7Sjr5HB1rVlavn/GxgFklk4qSnns8NJ0w2irmN4W6IqShxtAmgAnPDMaKkTHfYIAwCu/
         vGa70WLJFVo9beWRtBXvmdJ0knZlOtH84JB9LnnmhOxMgZexT+UhLI6VHFvcva0F/YC/
         rlzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708443708; x=1709048508;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+cFEpv5w2TPD8QTkYd4ABg1XTB4+ZdG1BlQCAicZJSg=;
        b=GSIrDg7uEg+RMppJcDW63h10CoJIgd0JY+5FOHKSvdNg/HwrHuoNi/PbmlpGTDGnv9
         fvQ/83MYozP1w4Rh3o1zi1SJqJkv3CSp7DeOrt4K6jjoBDL12xddxDQv8OswKv3zDJNn
         j7bEZ/Hv2YuOcbW//eSeh7QM1PypXVUBcWdJ5VYQl2oiB04+fqAEjPHEyFYCWnfmLyls
         W8T4xxVbhOG+o/tY66eiSRLBnTS/vLO/F3aTIWu16peBHPOXLWwjgbLMrdP948XfUKsU
         /G/Qh5xkMRK7pxWYSqNWb9haK7elq34KiAxJ4RU8SJSPGz5+WlxEYtiMlHJCnneZEC54
         20ig==
X-Forwarded-Encrypted: i=1; AJvYcCVbg/4nsTHytOKVMGjpSwJW9VqaV26uqk/epV0crSudJqjTVBqnAXcyHW1ToZfowPQScW/xPj0Kz+89CGwHGlOLpLuovJpxq0jVzjI=
X-Gm-Message-State: AOJu0YyESVqy7WkRUCdTGkngZVgw/v+Snjs9GOW2kzBFknE/W9p5RzPt
	ktqvGqokUATSplMcQxi4zgAOOwuVO/IyBvp4dYMUyT3LtxHD4Xwl02ktwbpjfK4=
X-Google-Smtp-Source: AGHT+IFI6EilanMRwVS5/UaPI4MAn95lhdZbLUWfuY0Pbto/1QNDPs2PRzsV8tlz9b+wn0au2Xix+A==
X-Received: by 2002:adf:f2c3:0:b0:33c:deed:6745 with SMTP id d3-20020adff2c3000000b0033cdeed6745mr11302397wrp.13.1708443708405;
        Tue, 20 Feb 2024 07:41:48 -0800 (PST)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id jl22-20020a05600c6a9600b0041069adbd87sm14775650wmb.21.2024.02.20.07.41.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 07:41:48 -0800 (PST)
Date: Tue, 20 Feb 2024 15:41:46 +0000
From: Daniel Thompson <daniel.thompson@linaro.org>
To: Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: Luca Weiss <luca@z3ntu.xyz>, ~postmarketos/upstreaming@lists.sr.ht,
	phone-devel@vger.kernel.org, Lee Jones <lee@kernel.org>,
	Jingoo Han <jingoohan1@gmail.com>, Helge Deller <deller@gmx.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	"G.Shark Jeong" <gshark.jeong@gmail.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Maximilian Weigand <mweigand@mweigand.net>,
	dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH 1/4] backlight: lm3630a: Initialize backlight_properties
 on init
Message-ID: <20240220154146.GH6716@aspen.lan>
References: <20240220-lm3630a-fixups-v1-0-9ca62f7e4a33@z3ntu.xyz>
 <20240220-lm3630a-fixups-v1-1-9ca62f7e4a33@z3ntu.xyz>
 <738dcf0e-57fe-4123-af83-be91d8166420@linaro.org>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <738dcf0e-57fe-4123-af83-be91d8166420@linaro.org>

On Tue, Feb 20, 2024 at 03:07:54PM +0100, Konrad Dybcio wrote:
> On 20.02.2024 00:11, Luca Weiss wrote:
> > The backlight_properties struct should be initialized to zero before
> > using, otherwise there will be some random values in the struct.
> >
> > Fixes: 0c2a665a648e ("backlight: add Backlight driver for lm3630 chip")
> > Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
> > ---
> >  drivers/video/backlight/lm3630a_bl.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/video/backlight/lm3630a_bl.c b/drivers/video/backlight/lm3630a_bl.c
> > index a3412c936ca2..8e275275b808 100644
> > --- a/drivers/video/backlight/lm3630a_bl.c
> > +++ b/drivers/video/backlight/lm3630a_bl.c
> > @@ -343,6 +343,7 @@ static int lm3630a_backlight_register(struct lm3630a_chip *pchip)
> >  	struct backlight_properties props;
> >  	const char *label;
> >
> > +	memset(&props, 0, sizeof(struct backlight_properties));
>
> You can zero-initialize it instead

I don't object to either approach but memset() dominates backlight
implementations currently.


Daniel.
