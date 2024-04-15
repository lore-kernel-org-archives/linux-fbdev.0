Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8EC584D3F
	for <linux-fbdev@vger.kernel.org>; Mon, 15 Apr 2024 12:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713185397; cv=none; b=m7HbwTipVJ17X0JKvD87BFmuurghnj68qbqlwhUKKBo/xTZZxLePiO0mS0d3ZLKSeb35YCdNfdcOW1YAojZXdvbUWXpTrsTu5VLo5T3w01zOR7iCFE2gJCGjh5wj2z06KUF6+gu2yeoDy58vkTidORtxpVBL58m6SXbg89fELhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713185397; c=relaxed/simple;
	bh=YQTOMiU6gYM5FdXLFvC0kzpvxWDYETwVK1r4K+Qq21U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OlMl1R+uihBD2T9C7n34qg8Dp5bxtbFsqRrksd0CPDfuQCNpeGN/MmO+S45RZX4lE5iago4QQjvOmP6hYsGeoR1PRSyVlcgE0LS+aYgacyOXMKvWLHZgGOOHcZZPWwixQfXmT+LO6B322zfK3XhW6KWDl4hnb2zFSgY46P5E4g0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=EGs1PQ9h; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EGs1PQ9h"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4186971b53dso3933135e9.1
        for <linux-fbdev@vger.kernel.org>; Mon, 15 Apr 2024 05:49:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713185394; x=1713790194; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YQTOMiU6gYM5FdXLFvC0kzpvxWDYETwVK1r4K+Qq21U=;
        b=EGs1PQ9h0Kx1LlOLzDvkY+m+xg9w2PKNa1RIWrGVlWEWlfaE0LZeSuWAGliuR4JeJl
         OrBCoMEFEIfu9bTHqoZ+VHbd/5ZlYywwce/h8shEpn2sYo98h9xp+VTOMwo/g1dRohk3
         dJaW9xsA3e7fJl3UifiGyuwzE/4kEqjHlMDi17bPfxabqEqNJwkQVeG+KRPzRmuOCUBY
         SrqnLXZBUYSfoze4kA+3OPasjSkOvtKhQiZkY3g95oFlzoQYtxHv8pGX4Wkqe16hb+RK
         ElbBK/kceKwMnY4TG/mmelyj1DBfu/vFH8F1QG6eacEih/TEXkiCoFvgxgnAHuW6GIhm
         bhCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713185394; x=1713790194;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YQTOMiU6gYM5FdXLFvC0kzpvxWDYETwVK1r4K+Qq21U=;
        b=VsSgCjd5+VOI3zQJ7wHPxY/4+uciMhNj5quf9v13WhO/2UeHSqvkDwRhl0K8i73jbS
         /8WcGvw/UHuSXgfNldZ7yu+Y1m8QmyB59ua/STbB2CgYqHqDyA0jsJxBChW2Q4/IplkR
         RnsOiOMzDdHBlcGhJNPhe1W2mrxhpGw6aU1XykBuOUWsDo4iVPuhrvAvuH5bTCYOaWAg
         81jwVW893BEZgF9bLFVDirlHDTokFDJxwppDNoJ4VQ7D+7oahiI1jro15YSvTkbOg1oM
         BIpQ4t0Dm5BK0pM5pjIr3z2Un6u4Ir84PAojGe1NfYuoVUmwsKNfImFtc9+RKrPh+XiV
         LxRQ==
X-Forwarded-Encrypted: i=1; AJvYcCWjE4m0evC4RD1lMx/nggg2nI87LN4y1Sd+44/GFJDZoVS+hj+jTbB5JVnplnBSCPcKnEjgmzcFfpZgqfcq58uN8fCnEODbY4knYHM=
X-Gm-Message-State: AOJu0YzfbteiqEdcaySLNDMVBb78vbgUR73iTGo+yMbu8A4CDhT/FADl
	CNkcb6TepDJkAlVVDa5DEJ6bvQy+cMPnvRaK7R20sd10YL7IkhXh18tcOpWQQCM=
X-Google-Smtp-Source: AGHT+IE0jfEg8j9eNQ32UlJgwwRwcJBMnq8mxk2glq1rj3pDzq37W/GBcRUB+mKPUDxRmuZRlave7w==
X-Received: by 2002:a05:600c:458d:b0:416:b74d:eb94 with SMTP id r13-20020a05600c458d00b00416b74deb94mr7708786wmo.1.1713185394484;
        Mon, 15 Apr 2024 05:49:54 -0700 (PDT)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id m16-20020a05600c3b1000b004182b87aaacsm8741388wms.14.2024.04.15.05.49.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 05:49:54 -0700 (PDT)
Date: Mon, 15 Apr 2024 13:49:52 +0100
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
Subject: Re: [PATCH 06/18] backlight: ili9320: Constify lcd_ops
Message-ID: <20240415124952.GF222427@aspen.lan>
References: <20240414-video-backlight-lcd-ops-v1-0-9b37fcbf546a@kernel.org>
 <20240414-video-backlight-lcd-ops-v1-6-9b37fcbf546a@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240414-video-backlight-lcd-ops-v1-6-9b37fcbf546a@kernel.org>

On Sun, Apr 14, 2024 at 06:36:04PM +0200, Krzysztof Kozlowski wrote:
> 'struct lcd_ops' is not modified by core backlight code, so it can be
> made const for increased code safety.
>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>


Daniel.
