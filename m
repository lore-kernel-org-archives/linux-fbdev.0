Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02FD4352FA4
	for <linux-fbdev@vger.kernel.org>; Wed, 28 Jan 2026 13:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769606808; cv=none; b=Llp66bPFIlprS3gpE2NO/B1NzkMaGMKuQzYdQzuZ3oKUTXOLx28pWIWjrpQWDAzNxqXaJXV/EEQOcL6aUJRGgF+t1rkdhjTC/XF5HeldSrRPL661TCc57DFGywpsg0IJOJVoZEcqtdcX2Mv6zpoRrCRtBaJUp69IphnssFB0DCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769606808; c=relaxed/simple;
	bh=OAgapCzSygvH2aPcfO6jzz2bFprxpCX1t+xt+2Pzxr8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FF5NfsdSHHX+WXkNy5/s0H0fnG9QWnkI07lsEo/h/3tw1pKfpwqWDK40WVdL7OzWMRUR8S5OGFX3FPdstUAwYa2yPvtS9cibImNgpMqAhFMCTc9tznvyn87BNbqqQFqH6t0cf8ksDYfQyBp6ZQwOc//2rBUNrywVROe0Ei8Mi9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HcYl24tK; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HcYl24tK"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-47ff94b46afso7977845e9.1
        for <linux-fbdev@vger.kernel.org>; Wed, 28 Jan 2026 05:26:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1769606805; x=1770211605; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=loXdXykH2/xF3NA+Uwx4RfRbCLma9XM176QXX5TmjYg=;
        b=HcYl24tKQzq5kTvBAFyb0A5lSKvAH015F7bNtoo9UJvRTgwUXEPmZaCkhE1OOW6dVB
         PTn5cDyI+aRzsDOHYLfrUUe7EjcQdOHLfIFOn8sU1oI3EgCfki7yfGIDPzEYvbydETYD
         uTUHaguUOCSb+mxPyJKb/chIRciviNR4A1qCW2Fbf2AN14g4fQkxA5aFDwAEbo2bxdo/
         jLwP7A/B7PsDDiH0KmjhVRbLNeQIc0wUK7xANyBRHGSE2JVfvB/JVcSfSN1Glc90P9Z8
         5O1isg2PqVHRgvBNdnjW0BiZwn8wVXdU2Jo0a+/eEbQywiuAdV06ZkE1IApihilNSa0O
         9k/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769606805; x=1770211605;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=loXdXykH2/xF3NA+Uwx4RfRbCLma9XM176QXX5TmjYg=;
        b=aejMN39pS+VZ2KA0mi3QT/MsX/xAwkVTSfBe5QAD6fxg2EtSstpQ0GWVYJQHIEJ+zP
         /MHD4UsTmLkGGHSqGvuEmYffu9fANho7FHWRxTIHaZJIhG+h+MqSlVokgvovUWpuPtZh
         mSPkO6aBgpr+2CrsOubktczXtWNpVX/pYoNJUYzZhkmuw/B9O2UYbvKWZ5OGpucBfSa9
         WDndT+Ux+vZybcHzzEGRO3KALPRptgytCJ8MnDfCg9vLB1beAcnUbKay+qAK5RclwHG8
         v4PdFPdqyO8TYp705UNqRgJzxas4bbK+qMPT8CIo/ojlLkBmo2aQYVHHJLlG9lgU3RHE
         RZww==
X-Forwarded-Encrypted: i=1; AJvYcCVWg8YvEhkOOzDncLaq9oitDtSr/SzmKjKQoWoBTKcmRhAODbmH8Skj8GmENBlD+UWIAAit/dYPJ6OHhQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/1DRfGoKqkZPTcco2MdVderOhe0Z59ChwDyh6X0ATrBjDfdaV
	426lAYcdMKSTrc1gGL5DmWU3zZxJHb+2i820ql5FQwi+VTTnuaEWyzpFoQ1VSYm/aSE=
X-Gm-Gg: AZuq6aIqXrpwI5uAu+SyjhAsc1zAqE/kbV3xcwwstL9HMJa0PRwR5qNIpXubmqPC5xo
	4S3cHKCxG2WjB0P9NPPpsmTJXeJcbbKMjTnSF3tZtNI9RchLIEXycAAtnxStKrf9IsbWfmQRwCQ
	VB624EbFL/k8TmpZqEsOXxbFpLiKnk0RMvGLvIOvzOp30fBvUwBfT0MiOvcVAu3nErG6rwJwwCM
	EO00IFFhaTmSfiCQDJ0fV+eKQyltoCLjZrYbYkY633x/wwlsKcqCxC4uWOj4NDRV9kn7/jwG9qp
	mNfu1PHyVPdRXQ+7BMI9m6Hec2yX4Mf3uFdrcTyhlsa8AL+xszHLXnkyU26pSyyHInLbp4jbTMi
	rHFVAP2kR1p4CkzVmnlwLa3Y2CFgvcpcw4kF3Ir1orw7w4sY7UfzqpmO53jmsqAx5l8VZG7V7/6
	AjohaYzN1soETHRiJE
X-Received: by 2002:a05:600c:4587:b0:47d:403a:277 with SMTP id 5b1f17b1804b1-48069e24034mr70902875e9.4.1769606805009;
        Wed, 28 Jan 2026 05:26:45 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4806cde00e8sm66387125e9.6.2026.01.28.05.26.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jan 2026 05:26:44 -0800 (PST)
Date: Wed, 28 Jan 2026 16:26:41 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Waffle0823 <csshin9928@gmail.com>
Cc: andy@kernel.org, gregkh@linuxfoundation.org,
	dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev
Subject: Re: [PATCH] fbtft: Improve damage_range to mark only changed rows
Message-ID: <aXoOkXRK2e44W_nm@stanley.mountain>
References: <20260128085720.862399-1-csshin9928@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260128085720.862399-1-csshin9928@gmail.com>

On Wed, Jan 28, 2026 at 05:57:20PM +0900, Waffle0823 wrote:
> Instead of marking the entire display as dirty, calculate
> start_row and end_row based on off/len and mark only those rows.
> This improves performance for partial framebuffer updates.
> 
> Signed-off-by: Waffle0283 csshin9928@gmail.com

Please use your real name that you use to sign legal documents.  The
email address is in the wrong format.

Have you tested this patch?  What was the speedup?

regards,
dan carpenter

