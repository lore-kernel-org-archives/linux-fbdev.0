Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 554981A256A
	for <linux-fbdev@vger.kernel.org>; Wed, 20 Nov 2024 11:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732101656; cv=none; b=eAr805jfp61CHcWgpQWkOuj2efTUYtQALENWggU6yjkTVeHu6Zioa4PaUFfsEqwHBVpftTWSl34rPo6Gtc+3YPz9XauoRvEB+iw0rKfxe+J+sL70Ay4MHrkmhZAMsfv6pATaIK48sb9nB57R3gV2v28Vc2EHSLqG0x94dfCKJAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732101656; c=relaxed/simple;
	bh=l7G39Ni/WM+NIaPXJqS6inv2T6BnJhhqnj0CHz9jRB0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nbIKivxtSButnaFO1eBuEF+YK9cavodFF8CFT7IjRsmJ/gRwC3YS1Y6zLcw3dyhapu9fjQ8POgWdI2UxzbfvrgVu4AT5uNC4Zy37drcUXDXWLFHMAxC7IKwoLfabeLYz+2jHfv9cqNIhjg5oL3jU8uGzW/eLYzickQQc/Z6pS0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cR9MY3Gc; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cR9MY3Gc"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4315abed18aso37562215e9.2
        for <linux-fbdev@vger.kernel.org>; Wed, 20 Nov 2024 03:20:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732101653; x=1732706453; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DH68XPkDBDr2SFdw3UbWf74PCLjCq+oTGZBI03sAE6E=;
        b=cR9MY3GcrzYw/Tbw/EPSb9VlX4nT9b8k7QKpMGBbxIkhd/doCWNuPlqjk9aYcesJsN
         lOENSJc0W6DQeWIdm+i4gibZ8/TibDCwL+NK0gIZssMr8If9CTbfg3guF5klKhTNzhle
         b6Fk4X+rAJOO+om41E+m8Jde+x9K+2QcS4QFvc2XqRGyqzc5vS5BfyGS0wJyAgkhiBxa
         vmmJPdLJq9TX6CXw9sCq13NZpAuvMXETKF2502EOrXN0WUB5NekQJR6DU2n9VYA8cSKj
         b4U3kGiaTJ3Jl4g9Qn1mjENbj6MMXsHLbwweodOF7my7SaIqHTdZmL9YAY4fQV8MIlda
         Ne4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732101653; x=1732706453;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DH68XPkDBDr2SFdw3UbWf74PCLjCq+oTGZBI03sAE6E=;
        b=qxQjb7ajC/Mit7HRNyR1HCG9sB1hGPgQN0N44OO7ZRT91jgPj07sc5jxKg88sgsbLx
         6kgkcag0z2bWpKBM1EvbjpCYDGZcRIJanjYhAOGpWdY5eb2qwB+Wix066DJxQWYGAQ2N
         1RcZETgm6UXm31TVi/H9GYbmGZiOJPZa8ZY+rv3ANBercdA2Fg7druQAvNbwqHw+RUe8
         KBD6VAHw1ofhqVi5OqY4AcVM+oI639eEZzXWJPrMbqH4It0e6lWFR87zZnpvWSTIFuux
         Uy4WBdaaCFiXJOZ3tFIjhz8/ea3XvGAhrtWEwc8brGkcw+piIQsDl1sLyAx3Ci+T5Bd+
         x0eg==
X-Forwarded-Encrypted: i=1; AJvYcCUa+tOZuBNOFZwV4K4sJIiHc3SGar0Mb+gDSwz5DkQmCZh+Vy4TFlb2WfSojyIX0ZF4gnOM1Oj9e6kcMA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzsRimf3ysitHcaWoLn3sv6sc7yUAFGGQonTFf+ZzHqETr1XgQU
	EKVFimDipEWq4Xxy+wfThOMx5uiWA6riS4cMjkiCHLkJdcwHeoKM6m15XQ+BSGs=
X-Google-Smtp-Source: AGHT+IFoW0aGrY44f798dMADxQS0s2HP8FnMFtMgd/GYwO11/AYw3oJvuDLaWXWp9ideXtqi2/lvsQ==
X-Received: by 2002:a05:600c:5250:b0:431:4f29:9542 with SMTP id 5b1f17b1804b1-433489970efmr19437515e9.6.1732101652707;
        Wed, 20 Nov 2024 03:20:52 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3825493ea20sm1778948f8f.93.2024.11.20.03.20.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2024 03:20:52 -0800 (PST)
Date: Wed, 20 Nov 2024 14:20:48 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Paolo Perego <pperego@suse.de>
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Thomas Zimmermann <tzimmermann@suse.de>, Lee Jones <lee@kernel.org>,
	Jani Nikula <jani.nikula@intel.com>,
	Riyan Dhiman <riyandhiman14@gmail.com>
Subject: Re: [PATCH 1/1] Remove hard-coded strings by using the helper
 functions str_true_false()
Message-ID: <4c8f5e95-6d33-49bc-8af3-e6dec2dc7c62@stanley.mountain>
References: <20241120093020.6409-1-pperego@suse.de>
 <20241120093020.6409-2-pperego@suse.de>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241120093020.6409-2-pperego@suse.de>

On Wed, Nov 20, 2024 at 10:30:20AM +0100, Paolo Perego wrote:
> Signed-off-by: Paolo Perego <pperego@suse.de>

You need to have a subsystem prefix in the subject.  The subject is probably too
long as well.  You need to have a commit message.

Otherwise, fine.

https://staticthinking.wordpress.com/2022/07/27/how-to-send-a-v2-patch/

regards,
dan carpenter

