Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF9DC84A3E
	for <linux-fbdev@vger.kernel.org>; Mon, 15 Apr 2024 12:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713185709; cv=none; b=O55EhqwsWQ/wVRN2TS/hFNeXdxeJ3AYZtQq3kTsOVeSAsmNVCUQuI49h+kwG+4IHrt9h+YxpQ99TWG+j2G56InCzGS6nK8lng3lJfDgpURDlOwCWHyW8ghL0Q999D564Wsfa42+IzmAjFzS1oDQs9oIiO9Nz4mUOXISFm4wbFHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713185709; c=relaxed/simple;
	bh=+bjzkMqcIFpcw2i9w83bp473RPBZ0vObyEaxzWVYmiQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OaCUSKZGdp04RNyRW0SoSZ/wRyqkSs9d4LqyxQcTP2cJJZKwxO6/2xwGGmKGAqj/64DLUOsWrFJ5am07+V8c6I/KgZAa0LN+rQFH+xZA58ch+jNX3mTdRel8g56PPNmQEBHS56qVlWtatlQduaTH8LrO0lzXdOmVkMG+J0t+EbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UkKI1Ju2; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UkKI1Ju2"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4187d5f08c2so1670725e9.3
        for <linux-fbdev@vger.kernel.org>; Mon, 15 Apr 2024 05:55:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713185705; x=1713790505; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+bjzkMqcIFpcw2i9w83bp473RPBZ0vObyEaxzWVYmiQ=;
        b=UkKI1Ju2OPqZvalCzzZ6yxajJxmFkF02Tp/3LzjJ/qJgXVwhWKQZMVOXjLWiruDa0s
         B+xQnvMPy6lVIVf6fNoedWVDj6JgqtmexOfR9LWKUfg709RmGq/+z40u/I7BzGr7FMqx
         MDhV70X0pr9YTWRpbR4clr9ZPhemWMcuaPcJCUagpfuCNOkNbNy8ch0dVI0/YwhW8+63
         ZqvUxuXhFUE+WysZRCSBK8C4P0XsOJqJm82VksJu9FuhisMgEfjH6Q8TdGHqfKnrYt5i
         RL24//6yR5srjtUKyYGbPGhZJ8XSUrHKvA35AfT8ZQrW0KpDEdp6Vd4wPeROjREEazjf
         J76g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713185705; x=1713790505;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+bjzkMqcIFpcw2i9w83bp473RPBZ0vObyEaxzWVYmiQ=;
        b=Yhkowgk7KeNxaInQ3X9w7zqxwwOlZHHEZDo4vCCvFkTYaRdP9/9JBFYP92CtHR0Ieh
         blK+yd+KrhJUSbYowNs2FG3StNNF/yCPjn0clQgzniMA8tY4EvfMKYBdwD03hEnW6u17
         fUZr5QdTVOKN9hsY5f7odudWLugss0lCA1PetwsA066nzBkB8gP5GDIl5VkqzDAevXZp
         cKYqCZf7mM38SwaDey/AK0YiUpik+m+qH4b6Dr2cSl4GJngavn10pTBIy3FnV3A9O34x
         pI7yOEq3VhOLnSQH8dInC98WxPWhrmjY7dXcAoVqTIUXRCFmP4z94FHvyPP45QZZiPIo
         xcNQ==
X-Forwarded-Encrypted: i=1; AJvYcCU5P0KfgEA/0/yM/QR5y90LqdVFi+QzLcgAmnJJeTpvLBSi+arJ1LQUzPWVTToeL3WKOdFucLzyGRu5gMpQA5wCsVWhepZGpgvPPIs=
X-Gm-Message-State: AOJu0Yzk3S3x3bSO2h60WckQuIaraUZH51V1OcUHzRhzeWl2Xat/3J3V
	ey6nqV9rw/ip5anj7MkOtsnylXFjDhGPPPB3tAObd6/zgxn0PoseFysmIh9c4U4=
X-Google-Smtp-Source: AGHT+IGHxu6Q4avREKIopyDMuH0F/FlZ8s8HVBOhkgD8sUoGIYcp5Z+UXW61HEvkoXH2alvv3fo09w==
X-Received: by 2002:a05:600c:19c8:b0:414:d95:cc47 with SMTP id u8-20020a05600c19c800b004140d95cc47mr9336810wmq.30.1713185705260;
        Mon, 15 Apr 2024 05:55:05 -0700 (PDT)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id l23-20020a05600c1d1700b004163ee3922csm19404762wms.38.2024.04.15.05.55.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 05:55:04 -0700 (PDT)
Date: Mon, 15 Apr 2024 13:55:03 +0100
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
Subject: Re: [PATCH 13/18] backlight: platform_lcd: Constify lcd_ops
Message-ID: <20240415125503.GM222427@aspen.lan>
References: <20240414-video-backlight-lcd-ops-v1-0-9b37fcbf546a@kernel.org>
 <20240414-video-backlight-lcd-ops-v1-13-9b37fcbf546a@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240414-video-backlight-lcd-ops-v1-13-9b37fcbf546a@kernel.org>

On Sun, Apr 14, 2024 at 06:36:11PM +0200, Krzysztof Kozlowski wrote:
> 'struct lcd_ops' is not modified by core backlight code, so it can be
> made const for increased code safety.
>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>


Daniel.
