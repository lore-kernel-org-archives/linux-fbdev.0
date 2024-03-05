Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC4F6548E8
	for <linux-fbdev@vger.kernel.org>; Tue,  5 Mar 2024 09:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709629539; cv=none; b=o7trazrwqvMnVYcpRKf7Eyvuu0fMrR5FFxrwGyOfOY3MU6wZneVo/vJ8vkksUZr24rSXXMxIyZ2asa4/qEDRkPhCTxogYrgOguVjEavBDz7gxxnDpjf0fFwN+uIDGlzw7tcbtfzC8j84AQLIS6+iKRgXYzXZAdyG/hCHCBlhDRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709629539; c=relaxed/simple;
	bh=Hy//Hzvgbunb5xsN63aD2HSruKb+IayJoR8TyJL4Oto=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CJGuQyL13JHYyIhYGa15FRiOHPU7HO8msV6vWnXZf7dABkvJN3NDjs/eNviiCpiFhoFeFc4im0KIWNzvPdwTu/x54Sbzq4OXInHeDnZM2llCujoKK3H/pE46Bqr30U5Q6F/qw9dfKLaB9FYi7gPeXPKKOuRHMeb014F2LpU8d2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=D2bBAjaP; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="D2bBAjaP"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-412e96284b9so3437895e9.3
        for <linux-fbdev@vger.kernel.org>; Tue, 05 Mar 2024 01:05:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709629536; x=1710234336; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iVyff6pSUeH7eXbrIj/i6abg3oo4j85mjc8PEacBjjE=;
        b=D2bBAjaPpwq7O0TT18Q8eNV6IB2CMZIv1+EPS+loG+bcNp+AFP+/XOzN7n4RTAM37z
         lDH6LVyCvyw1V1zyfHwbz+1yHzyunjboQicGLK6hxAoXjUUJ6usER1IRNgqWUKe6K3Cj
         DiKN6IeKlayNEOpBlDlkKEEqAZcmXwkDFclVZZmgATBioSYDtqdcyOXrXgf4l9NUrruY
         hnu9iVH0/8YNrxntot0G//qlmzZTfM5WUDwEeR8kHMWJXY6lVPCzo0Nu2I3V4tbNxKs9
         P/QhqJHqKDmI5fhMoG3+J4rBUyhNb37NNNoTEZ/gwIE2hu8OcKFr9vAhTanVPCSes3T9
         vo6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709629536; x=1710234336;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iVyff6pSUeH7eXbrIj/i6abg3oo4j85mjc8PEacBjjE=;
        b=OF5JWK40GVMC+YPrUKEzqW9/iNt6JRrhzUi70WxvIeFJYJMioBYgXdeZAVoHsVlDER
         JWEBFANv7QpWxxWz6SOL0Z6+m82t2Xf7T737yLAcaNXTA0miZ4IFqqcgIo6ETC6aR3W8
         1raY1k3ng1dDpG2V4HZICTL6WxLkOZvGaKUJOLrt1NRJV+4UpkRXJcs3XwOu0dXkw8u1
         DpTC+Pt4RoEAcjjTKQxl+wtihECbS2Yuu5AFSiRnBB5mYdaGxROpH0y1DFXsBlUbAXBZ
         Aemey724xizGlt/xpmX+pFTgvGmUfYkyqK/yDv70KE66KAtIf2ptscntQbWN6/RmXb3c
         nmhA==
X-Forwarded-Encrypted: i=1; AJvYcCWb52y07aom+zY/pQ3IvZzUfg/8Fcd08b5akNqjUdzodK8LTuxyw5O+9fSiBaR5eZtaTtIwqF1UCjTLSSqe8l8zUUrgq8ARRfnJgBY=
X-Gm-Message-State: AOJu0YxSoIoWsjOQ5Bt9H2fGzjdUnF4JFLc+1a13iwe8X2vpWMM72ngj
	Ynbigoak6vfW032xHWlSJj6pW2wkuIXfIwHCE+rFJyW1TopF0ldDTutifnDH9N8=
X-Google-Smtp-Source: AGHT+IE3V7x03ggowAKVgcziDcq2QmZUnrNLZGdToxQ4bVq1RxNhNEasbMMg5KQP4v70Va8u3fFnoQ==
X-Received: by 2002:a05:600c:474c:b0:412:c9e5:b2d7 with SMTP id w12-20020a05600c474c00b00412c9e5b2d7mr7368975wmo.19.1709629536061;
        Tue, 05 Mar 2024 01:05:36 -0800 (PST)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id ay37-20020a05600c1e2500b00412e7dde7d9sm3637450wmb.15.2024.03.05.01.05.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Mar 2024 01:05:35 -0800 (PST)
Date: Tue, 5 Mar 2024 09:05:36 +0000
From: Daniel Thompson <daniel.thompson@linaro.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Lee Jones <lee@kernel.org>, Jingoo Han <jingoohan1@gmail.com>,
	Helge Deller <deller@gmx.de>, dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/7] backlight: gpio: Simplify with dev_err_probe()
Message-ID: <20240305090536.GJ102563@aspen.lan>
References: <20240305-backlight-probe-v2-0-609b0cf24bde@linaro.org>
 <20240305-backlight-probe-v2-1-609b0cf24bde@linaro.org>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240305-backlight-probe-v2-1-609b0cf24bde@linaro.org>

On Tue, Mar 05, 2024 at 09:11:56AM +0100, Krzysztof Kozlowski wrote:
> Common pattern of handling deferred probe can be simplified with
> dev_err_probe().  Less code and also it prints the error value.
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>


Daniel.
