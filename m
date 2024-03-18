Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D1AE2E827
	for <linux-fbdev@vger.kernel.org>; Mon, 18 Mar 2024 10:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710759439; cv=none; b=Tlh5kI3ITUMSttof/h3lkp+0klgy1dIJQ0kND/u/aVtlX5w1Xitnk1EswLOKlyx0HfFzgr13uyQXZz7/xWHdMBRQ7TS0ch+/934YyWb1DlwYeaRV3nbO+m2+kH8+zJa6hHizyK00BL5eU/uqIc2hcwYvx7sjs8uL+DXx06kxs0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710759439; c=relaxed/simple;
	bh=3h+E+hcgQ4vcDM0k4nAVO71XgCj8+OwE4lTWOvy8hsU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZPGA6NwQAsCxq979zZJcRbA2BTtmv2cJcBjFyuYs2E6IsKNdnJuMv7SocaafZi9OGSjSC5JASXk7T/QOFQvJrDjW2KSKA08D6KPoLmdyT5fxaQpLo6l5hVelnRUaY0CyQnYXNQ6V4m3I1N9Y9BuBGtXhx8mKhXcl5dLm7WwKyRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xGNBF0zR; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xGNBF0zR"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4140fcf4d02so6635305e9.2
        for <linux-fbdev@vger.kernel.org>; Mon, 18 Mar 2024 03:57:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710759435; x=1711364235; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DMEQFRnKe/GtgVhTR33NYEWIYjxVZMpk768Ijuz317k=;
        b=xGNBF0zR5Fwu0oS6poTVpQUyv4pei3sC9K0g5Ihq+4QNvcWHwD9Ytrxl1es17beuFo
         agwAWOf3WO9SzSHn7xMY4HLUpTT1gNabQs1CB8LIPZ3ZupkUcB5qFVXHyacQmhEYjhW0
         LmZHX77hcDKi8pfUU1ppQr5WkkmgWFB6OLewQrSpNmhHC8ztBsL6uG6CVpdcxu0W0PQG
         azpDuhcuPt1G2o/nrr4nyrZKjOAEU8xaC1bBXLpFAELR4P/u/KWdgxtZHXTKF4TrEp62
         svwJ8GB0aEA2itwO7nIAfvlGm4gSYCmHMBJw4zzjf+4F42JxyCB5AFvyuBUK4bjeO6wp
         ysUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710759435; x=1711364235;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DMEQFRnKe/GtgVhTR33NYEWIYjxVZMpk768Ijuz317k=;
        b=lN6FhhSmMcCNqnmP/xQ+n5AC7394RjRla4VkqGXeeG96wrx0yKwgF0QThYokcXRfR4
         4R7Y+UGWyCkgJvXfVNNShHBKeaE3UOCAVQJPPYsqBj46NjuFC2vfx04Dyslm6zQa3ESw
         9wponIRuwKHAueHRxuiJpGasvKXMdtYVAIZ2X0jPiSKElLVuwRfrU22y9ZbuplTDvjGu
         ok3yHXfgPJjI9aKwFuMD18t4U9UilrF8hy9/eGgUMWfl1sqD1BnIylxm9eh9ARMkAkck
         HsS2/AwDcQJn5fT8eUFy4ii1/teM1TZWRYVDxqF/v0YD+ITIT0RnXMsipGsV8XyBTzlb
         Ujbw==
X-Forwarded-Encrypted: i=1; AJvYcCXb2qa7rfEoaCMA10zsx2GXXqwumOZ5xedrnS0C29i9bDH/eVtXwV+2NS2SQMOevCVZd5EoeXmG+iY7vOdMLMk4jdEZr0xLGu1J020=
X-Gm-Message-State: AOJu0Yy97Kn3KTA5iVt2OAdUSFiJdX0hT3TA/on/yZFUGQqFnu+MW7+I
	VIDGSZ7lL/rNdozXTq9nvy5T73NglUudMWSmzmRLHOogaJa27IaDNh1XBRtpXl8=
X-Google-Smtp-Source: AGHT+IE29K2FxY2E1zd26b5u2He0AYwIVzgw2XE3wy4Qxd0kaljZ223UA0Jwz59ql9qOjp9el6rE8Q==
X-Received: by 2002:a5d:4e11:0:b0:33e:7404:be91 with SMTP id p17-20020a5d4e11000000b0033e7404be91mr7884838wrt.43.1710759434720;
        Mon, 18 Mar 2024 03:57:14 -0700 (PDT)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id bn23-20020a056000061700b0033ec812ee0esm6824449wrb.71.2024.03.18.03.57.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Mar 2024 03:57:13 -0700 (PDT)
Date: Mon, 18 Mar 2024 10:57:11 +0000
From: Daniel Thompson <daniel.thompson@linaro.org>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Flavio Suligoi <f.suligoi@asem.it>, Lee Jones <lee@kernel.org>,
	Jingoo Han <jingoohan1@gmail.com>, Helge Deller <deller@gmx.de>,
	dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] backlight: mp3309c: fix signedness bug in
 mp3309c_parse_fwnode()
Message-ID: <20240318105711.GA16260@aspen.lan>
References: <74347f67-360d-4513-8939-595e3c4764fa@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <74347f67-360d-4513-8939-595e3c4764fa@moroto.mountain>

On Sat, Mar 16, 2024 at 12:45:27PM +0300, Dan Carpenter wrote:
> The "num_levels" variable is used to store error codes from
> device_property_count_u32() so it needs to be signed.  This doesn't
> cause an issue at runtime because devm_kcalloc() won't allocate negative
> sizes.  However, it's still worth fixing.
>
> Fixes: b54c828bdba9 ("backlight: mp3309c: Make use of device properties")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>


Daniel.
