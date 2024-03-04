Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3711D36B02
	for <linux-fbdev@vger.kernel.org>; Mon,  4 Mar 2024 10:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709549222; cv=none; b=t3SY7NMmcMl+oHhw04+VqPHrq6T8lA3HJiLK2TOuPhOna2G5xONIiwHg64khroWMxZLtfphQ+av4BvMM8ABU1FUtDssEUFKdy1HVJVTLyohBPkFseLIres1wecPRrKJXLHCabPQGilvtS1HmWqcWpyzYZOEr169NghAiS3JKylk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709549222; c=relaxed/simple;
	bh=ztqxNc62ilEiiomZuQZyglakJvz8sfZEaKzsNmup5ao=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HwMjAdQz4xDtHFuPoGMJDebntrKZW+3zeN80GBQEJpwf0ZquclAxPoW5PYoeQfTYl8PVqStgvAfIs/9QUWGWzQoeqFvhddTadvPPYy0VeJGCTBRt+JxSSaTGTu+UfhGAy8L2f+pqeyBwSV6agZQwCE/PF4PLsJmxw/4CLa9zEVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ms94XLj3; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ms94XLj3"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-33e17fc5aceso1891708f8f.0
        for <linux-fbdev@vger.kernel.org>; Mon, 04 Mar 2024 02:46:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709549218; x=1710154018; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ztqxNc62ilEiiomZuQZyglakJvz8sfZEaKzsNmup5ao=;
        b=ms94XLj3+eNTnxnGxOFScwCjm5FoZ7WZ8qoFpr177uVUQRxIYpu9qZ9o+X8AcfpFo4
         9ERoa5PrO/PiDCWlbdT/dvUUeaw7MQau0TtVj20sULZXlrt36NIpiclxwxDQmKyJbzuc
         RVWCci+YlgkVmI8eU+nIJ5cuIVxu9l6hC/GVZMH1k0m4mbWyVtwgoCPYr44VtF8i6Xmq
         kKgNwI8+A2TOFwvHV7Q7KQ8VWK8VokS9aG7AdWVFRkxGDtSLpXSwGfqeaSQRdIHg3Ytr
         JH+xvnI86fmM/STrbrCMFn+Mnc6uSk4S8S32UdvUKQaj8JG3IcLLaW24nZveo6PJiUzZ
         wAdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709549218; x=1710154018;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ztqxNc62ilEiiomZuQZyglakJvz8sfZEaKzsNmup5ao=;
        b=WMlk6XaEJSXe4bcZxQwIUR3h4t1enhhijfLAJetbitTa3OIXQ3h4amv6kzkQHrTtI5
         FFxgrMZwr/7/L4qpxnsFK488rmh5j7RvR+49zX4q5kfdZVfRJMxwmx2BtVGWoLNIR6E5
         xOdhQWsvdD91ewFE4D7ZQa4sDBeBB9pLEmyUqtsSAICcTRlleJpXuwskzRHV6BOljAXP
         FnBHuSDBxJgNhSo3eCWKgJ5v1pA0V//tHleqlIxPFmX5zdKeruY3WV2w8nK7RqBzRPPI
         tXUvVJFmvuq81C80tguvNWiol7OhMJ0H/eyKn2/p4SYacEduz45YfduIeOGisVhROitA
         oh7Q==
X-Forwarded-Encrypted: i=1; AJvYcCUuPEEEXJlhGbHJNY8hWsOPlX3Gg+f/A0yhb5Czf5AIgSU3AKMLphH7EvGPv3yvBuXoB0SoaSMCtE4a4MYZLf/dqTdzaXZDfbn7G6I=
X-Gm-Message-State: AOJu0YxCFd3x/YZWnHqbGkeujvKqot+FI7SY+9rhpET5XIOQN1u7QTaE
	ckKDYiXuDZeNNs2r1weYf7K475rBWoVlJEn9l7bcHOAfPgOD2gLie5/4XwalrL4=
X-Google-Smtp-Source: AGHT+IFeyTWKk1LmAT0UNG56sujX19bae73Htg+PyrowHL0edmjBLVd20DjVb8TWcjVE0m0Xy+Q76w==
X-Received: by 2002:a05:6000:1cce:b0:33d:d7c7:4c33 with SMTP id bf14-20020a0560001cce00b0033dd7c74c33mr7776162wrb.29.1709549218568;
        Mon, 04 Mar 2024 02:46:58 -0800 (PST)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id ch14-20020a5d5d0e000000b0033e18421618sm10161297wrb.17.2024.03.04.02.46.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 02:46:58 -0800 (PST)
Date: Mon, 4 Mar 2024 10:46:56 +0000
From: Daniel Thompson <daniel.thompson@linaro.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Lee Jones <lee@kernel.org>, Jingoo Han <jingoohan1@gmail.com>,
	Helge Deller <deller@gmx.de>, dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/7] backlight: lm3630a_bl: Simplify probe return on gpio
 request error
Message-ID: <20240304104656.GF102563@aspen.lan>
References: <20240304-backlight-probe-v1-0-e5f57d0df6e6@linaro.org>
 <20240304-backlight-probe-v1-6-e5f57d0df6e6@linaro.org>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240304-backlight-probe-v1-6-e5f57d0df6e6@linaro.org>

On Mon, Mar 04, 2024 at 11:11:43AM +0100, Krzysztof Kozlowski wrote:
> Code can be simpler: return directly when devm_gpiod_get_optional()
> failed.
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>


Daniel.
