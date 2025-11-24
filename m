Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5284A95E
	for <linux-fbdev@vger.kernel.org>; Mon, 24 Nov 2025 10:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763980252; cv=none; b=E+ddRd7rX45xgf5/BTSClPYdT0g4nvuBw36gks+bToFsvLbipYbGJisjiNFwpRtFxnft6C6BPsLUX8NeTUZy+MNED02ngUWHh/b3cAfnVb0X6nQMKEYNRBJCOAGCH2VjV0vqdvJ96EtxxKGJtN4+u/c/+LTFW9pKyFPmWoWdkAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763980252; c=relaxed/simple;
	bh=h+6tU4BC4F1P+zHlJEhy4xvq/Rtffs5b/r87AmI+WpA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ElC5nNoFx1ngIHfCiuLSrty3Yn2Rb/Q/lqc4c2UF9QaZaNqzEuyvbfvmHfDoMP8SVvNna4X92puIxaQfLZhpfxMXWjwmqdbRnl6ypF3IUX+ueroW/JhqMvbi62mHHc9O2+hhqI2U+ar8mwiQmaY9RRO3VNRRYVu5QYwcV+O1Zqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=GAyEoZV1; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="GAyEoZV1"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-47118259fd8so35235795e9.3
        for <linux-fbdev@vger.kernel.org>; Mon, 24 Nov 2025 02:30:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1763980249; x=1764585049; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4c093UhJVULliuhoXS0buCOSXcGwmlWet+kmHrIixLs=;
        b=GAyEoZV15EpVrYIK9tP93DtOohqYN/z9wxgq1cwSgYSNkX9Gm3cEnDT4J/CmQHOIBZ
         dHFK7dOqzBn/iw+4D1MLh5ffZUcugKi5c7NFCCF55FcbB2h4OXN+DvJg12YNjNIPWl+O
         7gI5QrWXRtEK5m7p/AMrjSCnsAz0E4W+JAp86sxgVFkS3U/FFYUB7xVI1qh0OtL3AwKf
         JNrlhLeXqyWozDCFE/XflqDdXrwtxZMeaN5GYLkwyxMidgqFyGrzMF6sTxUddfgoSy09
         d4d3nuVGF1l3J6ablbl5jQyUUnyfRRYF+IgKnQFu6uQbucxW8ST/79iXLEndOCJdZj88
         dnfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763980249; x=1764585049;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4c093UhJVULliuhoXS0buCOSXcGwmlWet+kmHrIixLs=;
        b=uo/me7svfMgUk2zLIH/ETK8oHOdaSrDgxDVRZGAuOI/Q3rzzOi+n3GyRimEI6S/0fq
         gtc8yyYSIYxOQTK/dQZ5mwsjxo1Wh67PW/5uYD+v11m/tEjEJe8CWOjf2ZNSIwjp4Xzx
         mlSsHRVlZsxeYSFfUEsfrHbLT3kuHTH2JDWYjgjhMGwA6+rwKHe36P7Oa8/V+eINudkb
         7OJPnmx0lAlRGdWAbKdNC4aJAr2iqVPD81PYQCqlmOaVbMAMVcF9lW1SEh1HtryIap2R
         iRuQ1s74GIO/PyXP2Z9AYrCE51ln1DNLxekhHNUvkqgFP3JnO7pPjA5stt+FTU1XacVn
         n8RA==
X-Forwarded-Encrypted: i=1; AJvYcCVbUfrBdR+p2AHaiwrCz73yaMSTmpNhJ53AvA99Rq5NDgKV5oXY3j44F5aOHrIrizx3QR3aduFfVZPsdw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyXijHy0/0jpWzmPgJaFSHBrmqcmKKhK2p+rY8p6N7OwE/wjlWz
	FBs7tXz696kDT6WYbOzwEqEYXz5kzNEHo1DziDtLZ7dAHVABnurtKfRwAAmPeHjGOmNitWP2I/j
	RvXhX
X-Gm-Gg: ASbGncvHQ4newOZI3YXHIwta6nh3bM59CSHt40bmeA/cUhrwAlLkTqFO5TuploU+HQL
	PO93xqAJPQIdSgSjgy9K9eriiazyKEz4p5vNsXFJUDjdHoZ+orzh257er0GUNwi527j/oaZLsFa
	v9edT2w8Ny3HMIsLV+oIACFBAsaztce7PMIhRT9sQxCncTVWDbFlNa/+9HIUy9LV5Ma54TmzpOD
	b9y+LhI6nKC1iofTGgn3phEw18O9rD9QW2aZYBER2xcCeqgP2tDB2IU0VuCuMuaMkh3ylveDY/T
	GZsXSMmSaBDQfP2Blk9pgqARoCrchVxbXClT4mnmyRuu+N1X+l7B7UzAV8VKY1djKCGKdUNqXmY
	iGClajvwhqJ4RCTuD8Xc8qW/ab2Em4VK1y9t5jA1Z2ep0pi0iQm/cV8izR6408QPggE8buqBPfN
	Q0H9kYeNwnkofCM13jXHm26utX4Hr5mcmcJz1qBJ3vfL4W9RZNk6c4KUyatZWslOpMfHVMfw==
X-Google-Smtp-Source: AGHT+IHPvlWQDf6K1Dga8MvZAdfzerPWHGBEBq8a4QKy7lgUieNkzL+6lwU5ijEhA9SrymIWtcSJSQ==
X-Received: by 2002:a05:600c:35cf:b0:477:9a28:b0a4 with SMTP id 5b1f17b1804b1-477c00ee003mr144798845e9.0.1763980248870;
        Mon, 24 Nov 2025 02:30:48 -0800 (PST)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477bf227ae2sm188134925e9.9.2025.11.24.02.30.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Nov 2025 02:30:48 -0800 (PST)
Date: Mon, 24 Nov 2025 10:34:32 +0000
From: Daniel Thompson <daniel@riscstar.com>
To: Nathan Chancellor <nathan@kernel.org>
Cc: Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>,
	Jingoo Han <jingoohan1@gmail.com>, Helge Deller <deller@gmx.de>,
	Pengyu Luo <mitltlatltl@gmail.com>,
	Junjie Cao <caojunjie650@gmail.com>,
	dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
	patches@lists.linux.dev
Subject: Re: [PATCH] backlight: aw99706: Fix unused function warnings from
 suspend/resume ops
Message-ID: <aSQ0uLLsvnWy_yvj@aspen.lan>
References: <20251120-backlight-aw99706-fix-unused-pm-functions-v1-1-8b9c17c4e783@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251120-backlight-aw99706-fix-unused-pm-functions-v1-1-8b9c17c4e783@kernel.org>

On Thu, Nov 20, 2025 at 01:22:46PM -0700, Nathan Chancellor wrote:
> When building for a platform without CONFIG_PM_SLEEP, such as s390,
> there are two unused function warnings:
>
>   drivers/video/backlight/aw99706.c:436:12: error: 'aw99706_resume' defined but not used [-Werror=unused-function]
>     436 | static int aw99706_resume(struct device *dev)
>         |            ^~~~~~~~~~~~~~
>   drivers/video/backlight/aw99706.c:429:12: error: 'aw99706_suspend' defined but not used [-Werror=unused-function]
>     429 | static int aw99706_suspend(struct device *dev)
>         |            ^~~~~~~~~~~~~~~
>
> SET_SYSTEM_SLEEP_PM_OPS, used within SIMPLE_DEV_PM_OPS, expands to
> nothing when CONFIG_PM_SLEEP is not set, so these functions are
> completely unused in this configuration.
>
> SIMPLE_DEV_PM_OPS is deprecated in favor of DEFINE_SIMPLE_DEV_PM_OPS,
> which avoids this issue by using pm_sleep_ptr to make these callbacks
> NULL when CONFIG_PM_SLEEP is unset while making the callback functions
> always appear used to the compiler regardless of configuration. Switch
> to DEFINE_SIMPLE_DEV_PM_OPS for aw99706_pm_ops to clear up the warning.
>
> Additionally, wrap the pointer to aw99706_pm_ops in pm_ptr() in
> aw99706_i2c_driver to ensure that the structure is completely eliminated
> in configurations without CONFIG_PM.
>
> Fixes: 88a8e9b49ee8 ("backlight: aw99706: Add support for Awinic AW99706 backlight")
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>

Reviewed-by: Daniel Thompson (RISCstar) <danielt@kernel.org>


Daniel.
