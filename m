Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0A3669D0D
	for <linux-fbdev@vger.kernel.org>; Tue, 20 Feb 2024 14:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708437655; cv=none; b=Kj4Mg5j6tCx8I93Oi6EpZpNFon6CIuA/IP7A/eisdhxb+SXUFmFQqNczbTXrfmR4Mkjbt5hG7Rbm8FrZEDLwogr1Hw8N+f2iJAJmZBcbgUNrbyu1mnx6rCGQrz/m3rY0/5TH1kd4Ddp7x8wlMMBlRUoOfVKEH5LNRDKLM1gOKmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708437655; c=relaxed/simple;
	bh=yIavGtyBVHQhwYxocbKlHQfDHDHgZOv5J9ExqtIQ0og=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d2g1NxhkUCftjac5wutcBGw6PbREbXdXvT4s9aZUa7ushPuQKLmX0Z9BraMSLI8aZtwJOlPQeU0IFA8sDYcyfcsB68fmjj15M43sQNC8MCI4YfAYOmkmyKUu9guPRP7CCMRMZAZ4hc2Jbz7cq78gdlmmipsVLJdYtsIjlhjJXcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mRZoJifw; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mRZoJifw"
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2d208be133bso56350451fa.2
        for <linux-fbdev@vger.kernel.org>; Tue, 20 Feb 2024 06:00:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708437651; x=1709042451; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yIavGtyBVHQhwYxocbKlHQfDHDHgZOv5J9ExqtIQ0og=;
        b=mRZoJifwVwTGd+0ntdKE33Zb9jzmcWjeV/lxBsfPyFWZYqtytI7rZ16bFKVibTJQe2
         hNE5QqSj8R30rVki/7gV6YWl1fh+RDRrsMIv8D77cTRzDGtXw+DF6EahyiqHVPLcYpwX
         Wg0H4Am93nmtABmrW2Kkp+PuQ12BbjleE9oKAdua39x9RLD931SWs+Umr7N4Jws06332
         e7Sd1tgCJbkxr/32up3Y4/BviJk5FkWxre1b7AUEDeB8lngX4RCNB33w/ChXZmVcxbG3
         irNS2JFykSbkwC33y+hF3TyXeOzCxabIFhyuJ96KFYU2ogInpvpQALB9CN6Wrk1WffPU
         9UFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708437651; x=1709042451;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yIavGtyBVHQhwYxocbKlHQfDHDHgZOv5J9ExqtIQ0og=;
        b=rMet3+UR5OPKlrByw/DUQYsvtA9xbOZR5XnQP7Wdt2lEo5LHUreygJjVktwaRL0jOr
         YJ0PR0uMivyMEXzOHIEJan4LiIoZRQBTIFAp1BtDWItHyBcGFoTIj3+AnM/S6oieNSF5
         iUlOTs7AXo/mI7I7GNqZAtbuqp756WEV/bmjSZBTWsYS6mWJSpL6JOXXVPRn6g71AaR7
         OSP/eqxDuitRUAw66ElFVksQlTRiDzHNqY+4Y2h6zfMmIcAt8ZBhnMNWGSVOUcORAzw0
         p3HS17RiMY3BZ6V8nNGjAwhPRQL2rUMV6aSriTzVKOGLN5bKUD9BrKkNBgr/36Fov8Xk
         0Kmw==
X-Forwarded-Encrypted: i=1; AJvYcCVSdwIl4tb0xo0gIOJyxww9dOJI+NbmvDG9Ua0i1px3qYF1FNaicZFdJB6GcZ6n2luXYCjXoVsJJf8CgO/JiZQQbDpHnP+LOgAeutM=
X-Gm-Message-State: AOJu0YxpVBf7w6gFuWu57Tg6uqrlZNzczYQ1/qfZYMy5RjsyUnm+OUd7
	A/4YEBgEUnds8DYPeYBN/sbiW88oAXIStkPFA00m2F82ohQ/ZFG+BkuWxer/ggw=
X-Google-Smtp-Source: AGHT+IFnMr7pgPZVpX97ZGZLJplTKGBJmAizHUWbgJVoD43o8CV/7GPFehR+pR53bgpnnhwAyZG3rQ==
X-Received: by 2002:a2e:b0fa:0:b0:2d2:3028:2bcc with SMTP id h26-20020a2eb0fa000000b002d230282bccmr5159754ljl.47.1708437650764;
        Tue, 20 Feb 2024 06:00:50 -0800 (PST)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id o8-20020a05600c510800b004105528c61fsm15006473wms.35.2024.02.20.06.00.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 06:00:50 -0800 (PST)
Date: Tue, 20 Feb 2024 14:00:47 +0000
From: Daniel Thompson <daniel.thompson@linaro.org>
To: Luca Weiss <luca@z3ntu.xyz>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
	Lee Jones <lee@kernel.org>, Jingoo Han <jingoohan1@gmail.com>,
	Helge Deller <deller@gmx.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	"G.Shark Jeong" <gshark.jeong@gmail.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Maximilian Weigand <mweigand@mweigand.net>,
	dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH 1/4] backlight: lm3630a: Initialize backlight_properties
 on init
Message-ID: <20240220140047.GD6716@aspen.lan>
References: <20240220-lm3630a-fixups-v1-0-9ca62f7e4a33@z3ntu.xyz>
 <20240220-lm3630a-fixups-v1-1-9ca62f7e4a33@z3ntu.xyz>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240220-lm3630a-fixups-v1-1-9ca62f7e4a33@z3ntu.xyz>

On Tue, Feb 20, 2024 at 12:11:19AM +0100, Luca Weiss wrote:
> The backlight_properties struct should be initialized to zero before
> using, otherwise there will be some random values in the struct.
>
> Fixes: 0c2a665a648e ("backlight: add Backlight driver for lm3630 chip")
> Signed-off-by: Luca Weiss <luca@z3ntu.xyz>

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>


Daniel.
