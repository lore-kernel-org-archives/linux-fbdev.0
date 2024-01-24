Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D73AC1272B6
	for <linux-fbdev@vger.kernel.org>; Wed, 24 Jan 2024 17:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706117050; cv=none; b=bCx2B81QzHVmIvPxKl9IVD7erVqoJp3t3OlE91qr0XDwXcML5OdoJ1OCDnAXf7Y8K55WdzJb3Evl6jBTNK53Zr43P61bH+uoeOcsxMOhv/gbEtQEv5u5CfqUyesR4T7kxsMd3pQRwxOQdNGlWzHIGOzeYcUH9j2N2AiPDwUxlbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706117050; c=relaxed/simple;
	bh=84hQubybZvoHS0mUrUXrKWieYpnepVChvkMJ3NXWaC8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XzbBljfm6+Vl5WpeRtbx68dfkFxUJVWofvCL17yEeVhma/4XBzCh7n7pkXjE8zzB+CdCBQWrLIiTl3vtMSMBh47WGe0j9Z5p6ePrS0AVZs7XTNTQNKRs+ZXGjIxiQ9XU4/8JizS+vMm+EYJb0M4Fjtcu1iVCjWO1q8GC5hKwdhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UsqQX4ks; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UsqQX4ks"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3394bec856fso680248f8f.0
        for <linux-fbdev@vger.kernel.org>; Wed, 24 Jan 2024 09:24:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706117047; x=1706721847; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=84hQubybZvoHS0mUrUXrKWieYpnepVChvkMJ3NXWaC8=;
        b=UsqQX4ksPZxr49qaJQov2WigdgSmZqUjvUVjaTXTjHSt/GOx9OHW48gRmpVJAXztWb
         IPYK5LqpyPJZtdd3TO0sM0h6C0D4sIpKr9MsRBxNW8Gle+r5HLfM2hVj/xErg2sMWxzw
         PZD1i7p7wESWuW8EEKzOzUeDX/ppuDOLk6L6dBreirKTbC5OALKKjn9SN8hekHnCOHpA
         luEOA/EYVRnNJ2S3zRRJRUj6kUq6FowhzkEeHZr0b5DutUmjVddYHwvopP4Wx8MojXyO
         deK0D0E5zzRCvfUy5q582mqwuWPdUww6lijmKMNJOCDyEauuBtuhmFbJhutJBTo0/V+h
         BiOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706117047; x=1706721847;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=84hQubybZvoHS0mUrUXrKWieYpnepVChvkMJ3NXWaC8=;
        b=u4DniOqyRRszUIGmd6BPJhaOG5F9C2GKeJp4tNEIxLoZyYscfwQJR4wZ0SNxMa/IMy
         7K+Y0rTVOQzc8Ca79nM5AKj1KkncR4GZ4yPAmtSou2BpqlxK3GG7R50FTN74ar6d2FKS
         LGCF5VeBoK+JpRELpY2T5kMFC3KEofRd2G12tVf0CQDvJCO2O56O7Weky5GezRK5S1OP
         6VhLxmbNCLIDPKlZTw4nsd9leQnoG/eRmdXqNJq/bFxIyo+FzYmXArSc3OM20m3zdkHq
         Jxk5+P374w9FkL4mimtVyDm8Fbz7NMpjxUw01UYoxb110/c2cImKZX09x4MOCdlVUFhs
         7i+g==
X-Gm-Message-State: AOJu0YzlYn416ujWLSjWiOn6pmYppe0aEJeAe7K7poT0tGVbpsXkYerN
	FwBx8MboSAzBSbCYEZYzsr5rZPYUAdjRltznrFJfRV5l7GrrHoO1hzYfU3Nv2cbR7OYb7vhjA4D
	fn20=
X-Google-Smtp-Source: AGHT+IGy6q1uZqnQR6FI8b7VYbGDPfXt1pitVJGLsnDj4e3SXBqZHBNvvYPKioX8VWyL3ysKZeRqoQ==
X-Received: by 2002:adf:f4cf:0:b0:337:d6c8:1af5 with SMTP id h15-20020adff4cf000000b00337d6c81af5mr735025wrp.53.1706117047102;
        Wed, 24 Jan 2024 09:24:07 -0800 (PST)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id b13-20020a05600010cd00b003392c1f40acsm10493581wrx.28.2024.01.24.09.24.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 09:24:06 -0800 (PST)
Date: Wed, 24 Jan 2024 17:24:05 +0000
From: Daniel Thompson <daniel.thompson@linaro.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Lee Jones <lee@kernel.org>,
	Jingoo Han <jingoohan1@gmail.com>, Helge Deller <deller@gmx.de>
Subject: Re: [PATCH v1 3/4] backlight: hx8357: Make use of dev_err_probe()
Message-ID: <20240124172405.GA15881@aspen.lan>
References: <20240114152759.1040563-1-andriy.shevchenko@linux.intel.com>
 <20240114152759.1040563-4-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240114152759.1040563-4-andriy.shevchenko@linux.intel.com>

On Sun, Jan 14, 2024 at 05:25:10PM +0200, Andy Shevchenko wrote:
> Simplify the error handling in probe function by switching from
> dev_err() to dev_err_probe().
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>


Daniel.
