Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5CED13CFA9
	for <linux-fbdev@vger.kernel.org>; Mon, 15 Apr 2024 12:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713185723; cv=none; b=H/0bixRWpCCVIW/Mr2BznnG7WFEIl7KkwHD9w9m8c/5OUSKNVEQYrcu1zPRKTzozpLfSPZe1z5/K7O3ozFMafV4khYg5bYnJ5xsMJZj5GouVateDU14BWbtkFlVpgDJzq274tUwNKc1DxBD/nnuGnzFevhZwMVZdzcROXODSz0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713185723; c=relaxed/simple;
	bh=w28Vgzy/l8vd8BHW49TVBr3mcKt4Lu6grGdOVajJg6Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lqCZfXmdlTFTOd5D7K7zmIKpYS2rqHSuQHe7Rm5p3fYEmE0Jcm4byWUviSc/2HvrYRpfL7vk/gfrLjvbDLFsa09mrmhHWYufqX8FWL9q2ShDvpSbzdfz1dTZuIccpL8hvBgr2MJcp38Ego7uABYmC1dBDf+/IXK7lChfXpt/Njg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lRp5mflH; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lRp5mflH"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-418671bac0aso3531485e9.1
        for <linux-fbdev@vger.kernel.org>; Mon, 15 Apr 2024 05:55:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713185719; x=1713790519; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=w28Vgzy/l8vd8BHW49TVBr3mcKt4Lu6grGdOVajJg6Q=;
        b=lRp5mflHObnS+9j81fxt5C0JNjn674hgOaIPVtkWZq8AqNw7yMJ+viv9BzJahXKISB
         C38YlUxu2TFABzsp3FvLg7xzucit1SFGvokikGVqZtnbkHmQnHsp9V3c8L5SGYPJ2Ca5
         yPNLHCJjEgrBkAWnE3T+c+rVJvCUssEPz5XA3QS0Mu1oS1ivlbf7/7KBW8tp8VrwLgWW
         IlIoT7YNp4Rm932+rzXaFSm3oC7ib5xFS7VzP7kkS9Tm0iXotZ3RklmJ5ywUGYrgPFzF
         28QBBHOf6+ES4BF1dQRdnSjeHN/Zlx/Hak2pa42H3HvMLt98HZEQel4T7HNazTFzsIj8
         v+9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713185719; x=1713790519;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w28Vgzy/l8vd8BHW49TVBr3mcKt4Lu6grGdOVajJg6Q=;
        b=kRRJSPmxA0ZLWhsbU0Bbqw7JxkaTQUahSa3dUIMliaRwtDe1Cb577ioncQilfIQVC8
         LERXF60T4dnaYQvnyyqmxrT3KNlmjbrgZsFa9kzSNDrzUi1jYLUIgkRIsLmkt7VAISse
         GKCcwx+7ecAsvc3oRiwnktujzvgEzVAEswryqBFYQnsKGfLMbAAP1ArmXguX/C0QRXOZ
         FsL7r27lnL7QAiDQwb0MqgjmAgZHSFa6aPvpWRhw8fd8b1vfbXUm+ruS1B39NNx1Sscc
         /TVNmgdTS+2J09UX4kkZHqt6YenNXHGAyyhGX1hNTqZY6cmYiEf8+g++a+E+kK95NEb5
         Hk2A==
X-Forwarded-Encrypted: i=1; AJvYcCV8qABfylfEa70HlxxKUlDuD8gABOFvHi2daIo+N0WADacdlPY5H/pBUQ0AS4y33hKM4/hTQTavuvCmjap+VHb38nxelFDyUksZ+h0=
X-Gm-Message-State: AOJu0Ywl4kCVcNvMaPBDJE1Cv/9tq+yigYyWDmICDRkVJkfUGu51BDS0
	7gQI96FleOW7ACkuxKukJDst/+OFLYPQZm/2AoISt7/rqqo5dp4hDCW1B4b2EFg=
X-Google-Smtp-Source: AGHT+IHtbwzdHFlfRbkSxCve8iZ6ujqhwgWjkWmq8yTpU351E4Av/06V3X/v4naeroGsr+pFHM+HYQ==
X-Received: by 2002:a05:600c:3582:b0:416:9cf8:cf05 with SMTP id p2-20020a05600c358200b004169cf8cf05mr7326072wmq.18.1713185719212;
        Mon, 15 Apr 2024 05:55:19 -0700 (PDT)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id s11-20020a05600c45cb00b00417f65f148esm13117334wmo.31.2024.04.15.05.55.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 05:55:18 -0700 (PDT)
Date: Mon, 15 Apr 2024 13:55:17 +0100
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
Subject: Re: [PATCH 14/18] backlight: tdo24m: Constify lcd_ops
Message-ID: <20240415125517.GN222427@aspen.lan>
References: <20240414-video-backlight-lcd-ops-v1-0-9b37fcbf546a@kernel.org>
 <20240414-video-backlight-lcd-ops-v1-14-9b37fcbf546a@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240414-video-backlight-lcd-ops-v1-14-9b37fcbf546a@kernel.org>

On Sun, Apr 14, 2024 at 06:36:12PM +0200, Krzysztof Kozlowski wrote:
> 'struct lcd_ops' is not modified by core backlight code, so it can be
> made const for increased code safety.
>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>


Daniel.
