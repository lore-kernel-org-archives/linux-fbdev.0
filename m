Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 292BF70CBA
	for <linux-fbdev@vger.kernel.org>; Mon, 15 Apr 2024 12:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713185259; cv=none; b=azo55Su7zYY3IL58JsmSgAYvr1gto2g1UGaOWCkOeJi1ZKKZLj/riDy8U1EJvpLfvRI07m1tCRC1ztSs0yw2QGj3zbMHpO1CIqOzwUaEezTsifLpvCp92Gd3+y00H+94eJy10OvCYKbA7Vv/fabK5tx6pt7Q/s5FWuCnG7VKapY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713185259; c=relaxed/simple;
	bh=3t4xYvc7hHt8pbqXgosG7LpZfvaanvwAGHZrjcMgUgM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fFg56NuZUImIkvtwjC8oUiaZSk8k6EoBNehYGs6c5B2O3Cfcaz5JCvoYvjaQf2RkXQK2MrpewL6bM/viWy/qmvYUPWBO2UDBvk5tZb5hg/funerQ1zQINGLKQFc/4/myHEmw9o8GPHGubXTck6/DqxPco+rlpJypWItBopz24aM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zMhMOAIR; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zMhMOAIR"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-41879819915so2691945e9.1
        for <linux-fbdev@vger.kernel.org>; Mon, 15 Apr 2024 05:47:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713185255; x=1713790055; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3t4xYvc7hHt8pbqXgosG7LpZfvaanvwAGHZrjcMgUgM=;
        b=zMhMOAIR2xHVidy3q7bh2Eg1kxU1D5a/eh4LmM+imz0betaRFq0zd7DvVp3BC46NKp
         dusdIc69deorbnMnYI74A3rSI69fxUkyQwD90y+M13gq8mDeCC+4w970wQuaUZHBrPZd
         ChuyElUAjMf9qOm2cj98/TSvbazx/qcsJMJsFCrXvXnFCHOHqD8jx9UEXDGdFug7f/zY
         7259diEnulw9wGo0cRY39nrjhoreVc4yxe1g6WL9YoSjcE5ykGjNVRtbHYtE0sJBeZB9
         gm3IibcmR2mzEFtFmeBju9ki1ZHIMdxl7BCt/9OGshcmeEOYxozmJCOdypjDrFRR50p8
         8uCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713185255; x=1713790055;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3t4xYvc7hHt8pbqXgosG7LpZfvaanvwAGHZrjcMgUgM=;
        b=oEEjzXgAG7fIvVZcJVLzgMXOZtF8S4rUVedaK9fq7hnA8uPuK2RuMivuWIBlnzNW8z
         q90iDY4ATzIdnLo03h1NOZSnRu91uddWo1cRpKZBehztoa5vTtB/l1W36nGEsmglfRRw
         DjdrEVtRmMEKSfIrkgoaWd5l6Sg3JSbAiB5XyTLN7kPHjfwsTbQ+GoYRJV6DQOH5n4Zz
         HZXxyhSSpjgqVkvxqa4oUezAqZK4gslGUCgOqyVN+zyed3oL9GF3at8BlVsgDHHiwe6v
         fcYWmIVG/fEBP+D/zKgAdjOO68Vs75rw95vmY0FC1ej9kL0m1qJqZKhafHx2Zt9U0PQp
         oHVw==
X-Forwarded-Encrypted: i=1; AJvYcCVgaU/wTxpPe0Uqxa7AEhD79obSPo7bLACNSEhFPiHZlLKr6rLPOf69n/pgFvm+bLVX/MTLTEfdUMNWSLRpMmCMVFIHzPQQwxhqm20=
X-Gm-Message-State: AOJu0YwS2QjwwfVK29svDHujjoqywXOi44u2H8tab90yR1ioN0IWIUo9
	3Aj2FN4Ki1sVDKekY8oDnU154ZjLyy8P7CnlSvru+I5oSu5L1lksfFzocL/KNYs=
X-Google-Smtp-Source: AGHT+IFkh12z6YoZcRxE26DaCtpPtJRpH8bNSc6xGkmU2C8eUzmYQG+zsWzJQF76MdI0E3ybiY+H/A==
X-Received: by 2002:a05:600c:4e8b:b0:416:3f85:d49 with SMTP id f11-20020a05600c4e8b00b004163f850d49mr7937971wmq.18.1713185255476;
        Mon, 15 Apr 2024 05:47:35 -0700 (PDT)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id n12-20020a05600c3b8c00b004165315d885sm19315874wms.11.2024.04.15.05.47.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 05:47:35 -0700 (PDT)
Date: Mon, 15 Apr 2024 13:47:33 +0100
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
Subject: Re: [PATCH 02/18] backlight: ams369fg06: Constify lcd_ops
Message-ID: <20240415124733.GB222427@aspen.lan>
References: <20240414-video-backlight-lcd-ops-v1-0-9b37fcbf546a@kernel.org>
 <20240414-video-backlight-lcd-ops-v1-2-9b37fcbf546a@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240414-video-backlight-lcd-ops-v1-2-9b37fcbf546a@kernel.org>

On Sun, Apr 14, 2024 at 06:36:00PM +0200, Krzysztof Kozlowski wrote:
> 'struct lcd_ops' is not modified by core backlight code, so it can be
> made const for increased code safety.
>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>


Daniel.
