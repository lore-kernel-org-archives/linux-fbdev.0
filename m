Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F20E605CE
	for <linux-fbdev@vger.kernel.org>; Tue,  2 Apr 2024 10:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712055169; cv=none; b=p+PN0nxlwpb2fWKNVulVjbFBh98IUg1Yp7c3r4gtU0FfGmqrqgC6CDyKiasNBW8r9t0L2xobgzQpqiA6JjixiALMOTdpP48m3eygqcIqN1BBcWNly6BUnQ8sVzplx8wD+W8ffoNGhphTM1G+hsUo9mjF+eET28JL9D35L9+k9dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712055169; c=relaxed/simple;
	bh=1YTxvmjRmcfQlUlxr5z5vqfrDT+DzwsPEc5WOijGjCk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=udyarVWvIbzJy151MTvMwLegOrLJrijh/5CkSWagSRAn9fMl+VbvBR5DbZz11KRM9k0VYaHx4qBkKKpB+KtJQesizscH64kN5ohbRiWFRTVifZ9XfoAKc200Es4G66YQrN4nQ7UTIm6QsU7u+cE9Lu1H0w1HE0KhoqDX+8Hi29U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FMzRviN9; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FMzRviN9"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-41569f1896dso10076605e9.2
        for <linux-fbdev@vger.kernel.org>; Tue, 02 Apr 2024 03:52:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712055166; x=1712659966; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1YTxvmjRmcfQlUlxr5z5vqfrDT+DzwsPEc5WOijGjCk=;
        b=FMzRviN9kJYq46OxwaxbRd/nN2UPA9XWrpWlawBOC8GeXU9+UlJV5BuzAlsb+bY8bn
         IzH/UPbOlXSLmtFVckYS9+z8mjhYf4tivwDRdQMN7VLK4e9DHq6kMejHxUZYTQALjWr4
         dXh4y5sj+kayoN/n7cj5V9rxajPGLURnjoa9pAzFH0wyekg1tFMqp+3S7c1Lal7enfdE
         0TiezpZ3rhDhS8Z1zOqt9trTk35pWYIPIy2KobpoyY+SVEpZKMP/5wgNPNfzPTXlthOC
         QalGY/8/a1FrL1UkvPduHYrnsJajPwn8ETHhTmzEOzpNMiUSQfgDutzomW1NThYY7QTW
         xTjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712055166; x=1712659966;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1YTxvmjRmcfQlUlxr5z5vqfrDT+DzwsPEc5WOijGjCk=;
        b=EpUI9fPy6AfkzUC3u6d25wz0jetniDzxiwJKQrDBxsH/xpY1OuqQ0NO2W6iP5qkoNS
         kbvFeDc3Kxzn49vcy2wIAEyLTVqtvvmFZg/0qfJn58Q4Zx3n4a+Sj5tV8XzjImeMWF29
         exhYxgNQSaA/4F+Ny9xeMnvYyRG1FJur+NRNJ34WRHtOI9yOBExrVeeK3YrRkzLNcVq7
         l662xsyn/teiNhq9GBZs/C2qxqDu+E3nLe69QhvnsK65uEd2+tBelv2F9OJ36okBj87K
         cSJclRLuh9+Tp9xq/mpNnbj9hY2RHy1Z5gaUBhEqr8ReJXmXb1yOQuGzONWSDPSJT5hl
         EvOQ==
X-Forwarded-Encrypted: i=1; AJvYcCWJvr3xyZoEZUYUspgfRy4FnzGFcVvsKtt2PqclaeE4YKG3scUxAklOsok1HO/y2ElLeTUrCqA8q5KvqS3/+Exl6nY3Z/0APTPDLKQ=
X-Gm-Message-State: AOJu0Ywlrr4eOECIUM1WrE2kuZiDDWjR6fuE34HbJDS93WhGtUyrtJTQ
	o7BFxgN44xxl2aDXTYhzORc6d9sIOd/w7BhAAVsAXnBMSLx9NRjUu03RBXeOwKg=
X-Google-Smtp-Source: AGHT+IECFFC2QpBeFxWbttS37ljtNH1Md/XKAYuE3SMOGvLg9paIl3bsTuA0JUInIDn5SAMDlrEOBQ==
X-Received: by 2002:a05:600c:2983:b0:414:56ec:22e7 with SMTP id r3-20020a05600c298300b0041456ec22e7mr9343996wmd.21.1712055165953;
        Tue, 02 Apr 2024 03:52:45 -0700 (PDT)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id fs11-20020a05600c3f8b00b004146dd6bfe2sm17450520wmb.47.2024.04.02.03.52.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Apr 2024 03:52:45 -0700 (PDT)
Date: Tue, 2 Apr 2024 11:52:43 +0100
From: Daniel Thompson <daniel.thompson@linaro.org>
To: Patrick Gansterer <paroga@paroga.com>
Cc: dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-fbdev@vger.kernel.org, Lee Jones <lee@kernel.org>,
	Jingoo Han <jingoohan1@gmail.com>, Pavel Machek <pavel@ucw.cz>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Helge Deller <deller@gmx.de>,
	Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH v5 2/2] backlight: Add new lm3509 backlight driver
Message-ID: <20240402105243.GA25200@aspen.lan>
References: <20240330145931.729116-1-paroga@paroga.com>
 <20240330145931.729116-3-paroga@paroga.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240330145931.729116-3-paroga@paroga.com>

On Sat, Mar 30, 2024 at 03:59:25PM +0100, Patrick Gansterer wrote:
> This is a general driver for LM3509 backlight chip of TI.
> LM3509 is High Efficiency Boost for White LEDs and/or OLED Displays with
> Dual Current Sinks. This driver supports OLED/White LED select, brightness
> control and sub/main control.
> The datasheet can be found at http://www.ti.com/product/lm3509.
>
> Signed-off-by: Patrick Gansterer <paroga@paroga.com>

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>


Daniel.
