Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29D167E77D
	for <linux-fbdev@vger.kernel.org>; Wed, 24 Jan 2024 17:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706116874; cv=none; b=lSVNvTZVZNz1ep8IDDcSNSKPeWXng7/5QJuEfrPSkKxqTAPS/ysFfytIaaM8u/ht1gYeqEjWeZqRy1Bc2DwJRi+xSB1Q6mta24g9srgvs4cu5gG7dZWqBhwgNckDfKCgdE+8TfY6LxdyuGP6cuZL3yVhKJ7yehQ/F5QocV5yYU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706116874; c=relaxed/simple;
	bh=4xiz0GcQG54/BySvte8DcHDS1R9W9I7lbxkZQ/Iv5WA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mvn8lSj1E82xNBLws16fmCY59IBuAs3o14WUnPxSdC7eOlB+aNLJi2i/fU05LdxfPiH2Pfti8CEyx/KaGDDzAWGpA3rBkhxc6/ibcTnO2mDLdKQvggMLcRazGsxwnEUr9J4MTiaZUCS1H0BQzqRog1o/Ot/cfbjOhz/NsE1+dIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fXK9nLAM; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fXK9nLAM"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-40e60e137aaso62964065e9.0
        for <linux-fbdev@vger.kernel.org>; Wed, 24 Jan 2024 09:21:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706116871; x=1706721671; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4xiz0GcQG54/BySvte8DcHDS1R9W9I7lbxkZQ/Iv5WA=;
        b=fXK9nLAMsX16J9E/9Qf8l/kbYDzwLwQKvReg3QVxLVWpCGvOK9GO42gMDxq4CJRoWi
         aBf5jMkWE1otqL8yOhAO76nYg+OJ9oDDBHRkt1NVfL3A6kmjRFoplrYN9HjrdblSvARe
         Lf1HxiQSBUW5MSbNX9Gg2XcrYoUI/I0Hho6laYX93Hz8W1vmzLTSrqvBAiWd7ejUt6In
         KM58vJ+ZCYwyGfQD8j1ONeW/9O3blMiByEGgfi1hmK3kidHv1rAAidfwderSTIVhJZhc
         HAZgPsIYqcXvZio2jEV64J82xyg8wvyco/yXTQvJeBLL4ce2DAThhui6MNSaOZefon1f
         1IpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706116871; x=1706721671;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4xiz0GcQG54/BySvte8DcHDS1R9W9I7lbxkZQ/Iv5WA=;
        b=EMxr8IfEQxOLws8Z58S4owR3A9AeYRI0AIEVIvbPFF1VwlDoxz/ZTemH22eYLU8Zx2
         J77DO8Z6GpMF4USu1b+5rm+q+9uSGgxU+j8bFBm3npcoCxanimF0SqseSApUDpCeGh6I
         VQ0s3xKs1ObFvTDc18rTzwSv1sK91C6H1hysEIMxY04NK2Rayq7vQ/wgJZdOq26Edgz9
         hBFJ/Mjv/94Z7H6zHRRwv+8A9mnqvN1sETyrR6/NzC7LiHKFfNS2meEDEP9VN5PQFsSz
         KhwKkF38GrVgCFf7wE87TKR/vxgRBlroTLcHbvSAL9FNc4BpRD+27reumqHYp3HIhVzr
         14jg==
X-Gm-Message-State: AOJu0YyN0O73qlqx/Y5zxy8tlKHx6H33Ds5Q7XlFRkQ1Xnsn96x2JSvl
	A8wq1vYvzeRq80sCom1tifqKvR8gwzW6gIZI1ql5FWbciuqlHeY4+XJ1kXOrMaU=
X-Google-Smtp-Source: AGHT+IGAFW4D80dnsAHiW82tmDEk0cyiMsQBq0972I3W5BOphHDe6lKpbk/KrXx73htiztW7fMICCg==
X-Received: by 2002:a05:600c:3d13:b0:40e:c428:4a6b with SMTP id bh19-20020a05600c3d1300b0040ec4284a6bmr889987wmb.13.1706116871447;
        Wed, 24 Jan 2024 09:21:11 -0800 (PST)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id w3-20020a05600c474300b0040e549c77a1sm279382wmo.32.2024.01.24.09.21.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 09:21:10 -0800 (PST)
Date: Wed, 24 Jan 2024 17:21:09 +0000
From: Daniel Thompson <daniel.thompson@linaro.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Lee Jones <lee@kernel.org>,
	Jingoo Han <jingoohan1@gmail.com>, Helge Deller <deller@gmx.de>
Subject: Re: [PATCH v1 2/4] backlight: hx8357: Move OF table closer to its
 consumer
Message-ID: <20240124172109.GA15685@aspen.lan>
References: <20240114152759.1040563-1-andriy.shevchenko@linux.intel.com>
 <20240114152759.1040563-3-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240114152759.1040563-3-andriy.shevchenko@linux.intel.com>

On Sun, Jan 14, 2024 at 05:25:09PM +0200, Andy Shevchenko wrote:
> Move OF table near to the user.
>
> While at it, drop comma at terminator entry.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>


Daniel.
