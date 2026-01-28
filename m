Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C583E2857CD
	for <linux-fbdev@vger.kernel.org>; Wed, 28 Jan 2026 11:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769601312; cv=none; b=amoh/777xXQZ90EPGUWs8fFWEwOpIVTkTULMicQD5g0xwF0Q7zOe3a7oHjIxrUH0tamGaMwPUPQoap6pxdW/9i8E6Y8lKDfw9Cxr6nkgfWkczmAPXDKN6hyTl91sbM1QJ83JZnO8ywtj3a2wm28DavdbHWOH/B66gkkTpLRqa5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769601312; c=relaxed/simple;
	bh=PXNg2izECdZqLH5eteW2kxT1B8Pnh6OxK9bdrd2/Ewg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pV8gdvWVjtCA2CB0fLtRVGb+07dek7tE6uC2zff+9JLzI/GHuXPd73NzSSmr9U6FF+9n33mod5PtgBuFujQy1aN+jhXwc1BRevDGKY+yWum3QuEqbuFfeEEbdkKoE+ULFTmU3XprLBMMX+pb7zmv3kzTgxGkUAxGi0lk85f0eB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=EnQs7Ak8; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EnQs7Ak8"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-435a517be33so4187923f8f.0
        for <linux-fbdev@vger.kernel.org>; Wed, 28 Jan 2026 03:55:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1769601309; x=1770206109; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NIZARC7cWLedCY7/Et8vUQyK6E+5feyX/hh/mMWrN5g=;
        b=EnQs7Ak8O4dvsreKmCW0moqzAWEttjnwEBnWPFyD0O/u+DmkQ7wyOd/wRfesFNANme
         Eiy91Emwk/hoV966NZ1dZuq3HK3ZiqkH3khL+yH/AM1fogj18VgsiKcvpoZWsUugrsds
         BcY65t19h2z/OmVcQKzEBcQZN6+jZUzB1aMIgI8x8IUVK2i+qmIUF0clTmrmL28urrPR
         d9bzB2jD3RD069nO+28vs0cNomTXLBicEh4s9Gtp6/hU/vVndxWUchL0qBAkklG4/xIs
         BTZfnmOARYwKHuL8TMeeGhggGRR1RU8J90D8wczYYF4nfdKSYI3uZ7EBam+AlAS7QkOY
         RNHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769601309; x=1770206109;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NIZARC7cWLedCY7/Et8vUQyK6E+5feyX/hh/mMWrN5g=;
        b=AuGCxVXdxGPG6VRoPwqS7IAxi6yY6eKvz1Gt0AwbYFQp+7vnwbXmWoMXmp7WduqOV9
         VvdhusoPmcH/l7kunVvksJ2yTyRWYKqJkPX2gCsmSlYLrWf1pcGpWKBztINW0xPY4zkC
         ce2qjS7jTprqdYmIFwwM7sCSJSBKLfhGVlHb6cQI+yg1+DXRV4egfZAPPxrAxpOajw2N
         s0wnFGy0NlR6Ey6fKAK18Dy5uwSrOFBOa4nIHfhQvxUorjwD5KBZbQJLz8ml4JG2f7FG
         2MVN5kkkKiJlzBHFU+6/0//LXzRjcSbvv1+5Mui0U0+MK7K2QepBqRF7P8Hz5TVLK3HZ
         OxJw==
X-Forwarded-Encrypted: i=1; AJvYcCVkLu5C9gU3XCwi6QHQJ+x9s4khbq4sdA/5RemnestIumERM0IREpmOaRQ2+J91RuYvi3S7775uLh8l+Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YxYk87qu6j7+/4YCtdK3/kPuHtspQQWUsKYc3S5hr7rDZUYaQLO
	E/BeH/vquw4AFx/lmXiQOep7H4LmllMad9kAsKScnCFeO5HSwEok2hXh0Vn4pL38kcs=
X-Gm-Gg: AZuq6aKtf14PwAd0TI2aBqYlXHH1vjiPoafEv0cz8ZxfcuV2ibALZxBkQ15SSMyTdxy
	wk7vrUmiHgxNLmZz1wLTTellk9WmJYmkGgycDRwJWaSI1rQo5+iCBVJGqXrlkPz3bOViyOWSA6K
	bYGKkhtgj9eukbzNtjPfoShR0W71R9YW4eNRgxi4sexESn0XZrAMitxmug+51ZJffTSh2M/qjgx
	dyJHtv+8A2deluj15ARSKBr7Bcn5m7lwSDyUQ+xQolZDpwlpgSTFja+ZsfsQopT9Kdax2+PidrN
	qhojBUtkmC2t7iALl6XT5Apw+i73eBz1UaHhh87zTc+ppslfQdHZED4uHwluFl/Jcybw/nC3DAk
	d0bslaogN8xuyUgyavTCxFDY7JeedDv5tjK10FCRwJ08lRdS6++x9CtP8Nmh+EC1CPhgRFdze2v
	qG13cloVoqTXnhfh47FBGVP7fTFiE=
X-Received: by 2002:a5d:5c84:0:b0:42f:bc44:1908 with SMTP id ffacd0b85a97d-435dd0514f8mr6071296f8f.6.1769601308968;
        Wed, 28 Jan 2026 03:55:08 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435e10e474csm6545107f8f.2.2026.01.28.03.55.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jan 2026 03:55:08 -0800 (PST)
Date: Wed, 28 Jan 2026 14:55:05 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Madhumitha Sundar <madhuananda18@gmail.com>
Cc: sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com,
	gregkh@linuxfoundation.org, linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: sm750fb: replace magic number with jiffies
 timeout
Message-ID: <aXn5GXXHSZtq66d7@stanley.mountain>
References: <20260127154056.74855-1-madhuananda18@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260127154056.74855-1-madhuananda18@gmail.com>

On Tue, Jan 27, 2026 at 03:40:56PM +0000, Madhumitha Sundar wrote:
> The hardware wait loop in hw_sm750_de_wait used a hardcoded loop
> counter (0x10000000), which depends on CPU speed and is unreliable.
> 
> Replace the loop counter with a jiffies-based timeout (1 second)
> using time_before(). This ensures consistent delays across architectures.
> 
> Signed-off-by: Madhumitha Sundar <madhuananda18@gmail.com>
> ---

This feels like an AI patch?  AI patches need to be disclosed.

Anyway, we couldn't merge something like this without testing.

regards,
dan carpenter


