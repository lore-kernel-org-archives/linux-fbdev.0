Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1F2E70CDE
	for <linux-fbdev@vger.kernel.org>; Mon, 15 Apr 2024 12:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713185331; cv=none; b=OU8Spau/FquHKa5HAwWU2ca8qf5QvHNU90lLwReBKprtlZciQ8FQjEUTWnUl4vg+/ZNdGtQD0yXh3NybhhsakE/zyyWrHAiziuobC8McdEnGIoTe2trw2Hg1gxJywoZdKXvDant/H9G1URobZNj7iGUk2lY/k6vkCTzry/A7gUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713185331; c=relaxed/simple;
	bh=fYBgV11sH3JLVboFSXkJgCoU/xJb2f3Jo4YenY/vo9Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oIc9acCjPSjvhY0Lw2JESyWQUelTT7uo1zjtybtaZpPzIPus2vtiDcFM2e2neQaFxDzdrSrU+h2/9Yi0Iq6QYhNYxrIvRigQF0jgndupY6dvHT1oHUPdOMXiGP40FBTIl1kbhRkOrSWNRZrRH1P95Ykq5QclGpqu8ZiGI3Zp2PQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SSJcsbZV; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SSJcsbZV"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4187731a6e1so2827815e9.2
        for <linux-fbdev@vger.kernel.org>; Mon, 15 Apr 2024 05:48:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713185327; x=1713790127; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fYBgV11sH3JLVboFSXkJgCoU/xJb2f3Jo4YenY/vo9Y=;
        b=SSJcsbZV802A6FbFgaQ/sICCSCHOxZTqj276nqflCcLgmSVhR69xhwgRgYV1/ts15V
         HQnsV3ZKaOljE8SfBHUnbp7f89J/0GVdW1c7/IyhuIV/VwCNTxcmkU4z3MVcvEvjJVeE
         QdlxHE3oC3GqPVRSbjq7LR9qH5Phjx/zCNH6SgSRErE1psCN6ePnBRXS333zMHn0U2CJ
         baqMc4zl5VIlU2TK2uxGDkMG2e78JT4T8SiJlBcYFPiLBJyrMeYzCZaxa+LfsneV+x1S
         LzPocwv/DMXuaLO2ymTAAgwOkwStmr8N3rnpO7BtaQRGXHwjIPYTKes2kbY9iheiWjBq
         EsIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713185327; x=1713790127;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fYBgV11sH3JLVboFSXkJgCoU/xJb2f3Jo4YenY/vo9Y=;
        b=iMqdi1cYt5j7tiSfNgQVJXlpm7RxgJal0b2fsun+sM0pYqPyfAaWFEVzgFOM7c3DON
         M0Jv6Hcf/mPnt7LHuvV/HmHDh9Cl2UbPKoaxXiacV64D/0ePZHuCUWsObo+ERpIX+bX2
         6sQyGy0pLDvCtWB0dnLCwbUBcUCSwI9o8Q5eA1NDNzcSfJTxEYl9mG9nPGBFaJVKzlqX
         RH8LdsTF27x3gk2NP5945v8OlMqz/BEeYD1+u62VOgVyO1SnoQbDHJW+y8BG16k3UalU
         Iu+p8hx4Qadj7gGIKqgdFql4p4R88j8S1eSCHb9XAE3FhOTGgAg2/X3QOkGtCXb0LNfe
         GedA==
X-Forwarded-Encrypted: i=1; AJvYcCVGBHQdO5Lxl+s3HUbbWfPrcmn+g/CUsHC5ZbXZhsXvRQUbXQbtswKKFOq4vl+myjL3d4hP1VF6lBBGK+ZuxqOz8QOegSxU3jzmHOQ=
X-Gm-Message-State: AOJu0Yy6Ycu5FU1HEOnSMVXrX2NoPh1KB5vEcJedHS3//2MlO0EgYcyJ
	XFtTUheHvozHuzEQwIdZH6AKBn5SEs7UsZHaJQEkE4rAHxU24uzh1YSxRY3cQ1M=
X-Google-Smtp-Source: AGHT+IHAa4VIIZPfYQm1PVHVmrI/agaXvepugvesuVkXOga7yarPxPBfCgzSQL+8bsNFdokUf2ibJw==
X-Received: by 2002:a05:600c:3511:b0:418:3f54:1132 with SMTP id h17-20020a05600c351100b004183f541132mr3484001wmq.12.1713185327355;
        Mon, 15 Apr 2024 05:48:47 -0700 (PDT)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id a13-20020a05600c348d00b004186eb69a55sm2411188wmq.25.2024.04.15.05.48.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 05:48:47 -0700 (PDT)
Date: Mon, 15 Apr 2024 13:48:45 +0100
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
Subject: Re: [PATCH 03/18] backlight: corgi_lcd: Constify lcd_ops
Message-ID: <20240415124845.GC222427@aspen.lan>
References: <20240414-video-backlight-lcd-ops-v1-0-9b37fcbf546a@kernel.org>
 <20240414-video-backlight-lcd-ops-v1-3-9b37fcbf546a@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240414-video-backlight-lcd-ops-v1-3-9b37fcbf546a@kernel.org>

On Sun, Apr 14, 2024 at 06:36:01PM +0200, Krzysztof Kozlowski wrote:
> 'struct lcd_ops' is not modified by core backlight code, so it can be
> made const for increased code safety.
>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>


Daniel.
