Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB36535949
	for <linux-fbdev@vger.kernel.org>; Thu,  5 Mar 2026 05:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772688882; cv=none; b=i1Z5bw+GqxU3EaE095gC9fYW+fXv+qOSRqy5f/lCQt42mtTEirsrtx34AuejV7Q7BsCRQao4ageWc9KvOeqt7YkkNZwzcQYm1s2qC/KFuLDL2pXF67y3QnijYSm7c4yD5B0KvJAV6MsmNPREEODPwYZN2S3bytnWop2FFrVP3Ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772688882; c=relaxed/simple;
	bh=MdT53VNsJo1KTOqLFXLHrv9hSp5uEa2RzIedrlI5hlE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dj3hbENiFyN1h0Q1RTvh77AKQf9/eqg4gNqePL3p+Vmf64o5buLD/AE61eCM5tN/WPSR/PRmjKvZrWgrjA+c7JEBLJYwTzTGCoPqIfm3bJAPTtgLlEbJhv3YQQpjT5UKL7/n1JT8TfuVPDgSL+PlXnZnyo4R47UZSfffcvL9PFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uvMzd5VS; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uvMzd5VS"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-439b790af67so2383521f8f.0
        for <linux-fbdev@vger.kernel.org>; Wed, 04 Mar 2026 21:34:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1772688879; x=1773293679; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MdT53VNsJo1KTOqLFXLHrv9hSp5uEa2RzIedrlI5hlE=;
        b=uvMzd5VStfX61P3qkjRU8SsWz5rA/uppZWNuZx6KzoRJhAy6jPX+Yo5UnQRHMLVYzX
         ++G2dpmTs4MQXxYepuUU6A8FOC/0bEWgn5j7IWpbf1I9Xxhz3AH8dVORNDMhViMSmIJ9
         homRZgBjSHRRyO4OacV48b6nSoqd5iMyVXqpvTdnyZrvxG3suw2rT1a6EjPElgUNicMq
         x5itAnYtoLDCxmareJJ+jrzcs3r6+fDPmxLo7JkEvAGFhGlV1BOuIUyJwLm1nlvMKCJC
         ZKW5IX9aJHRuFVutx5UXJp9I1tFK2KDMIrlwTHrZPvdCPxyV17DdgyVU7UMdyV42L/P3
         hi9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772688879; x=1773293679;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MdT53VNsJo1KTOqLFXLHrv9hSp5uEa2RzIedrlI5hlE=;
        b=M8rp0mgof1FW0oTP4B3eC/D63fsJialMhqCePQykT+Qmu5PqPJEotO76cOffcTIEZV
         TVLx6cRESTN+g75N2RGlvQfZmDUR7QRhhSvS+fRjk/T+jaa1GwvxKn6cWUNdoGHWgcl/
         YS0ZwhpYlPH7digFM7YdcC2TTBNNNX5tgp9yEjx/NkvObJtG2wLgTtFaulQAgK4mHj34
         cjkZf4jDc5fM5PdtwlOU3/y+2kv4467hlqy/1mWc9pH6Z+YG9P68uAHiktTx+998OzX7
         B0P4ynuYxVpzmftlgmWLuI00Olk7Pfd7LCvy4QCwmcZ0pnbny+lzOXQlfeBxy30GZNrk
         dNig==
X-Forwarded-Encrypted: i=1; AJvYcCUtR3QYHhUG2bFgmNpMytkUmFN35HyEFrn3K2s5kmwf5A5FymkcKJB9kEJ+tLdmNPcu6EjBGV8m6KWwow==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8u5TXWjxGcLtVikqP5ublCjakfE/lY6RhcKXilDOmIrGsxk1P
	a5oRtfe9T/NXxkefh+dalb9nZBYYKR8aB7NBjE3RYXBC60ZeOqZ9343IF5X7BycAxtg=
X-Gm-Gg: ATEYQzxgNs+kJYcR1O6kxmYKAoqd0L/4A8Sd3Un28B+WbeMX03cvtP6bl85DH0rfRy/
	VlKVK3WhGFn6bKP7L0CP3EP2VK1ziGo5xynv2m8LNw39OG3LNw/gGirMpGEUIJB7I2ZTsZdEPDB
	7HbAXyngs+DLyWKxczvtLiIhXHHIcD8ZCzp/wJZxJZjMu3N8bLHJTEkb9Kj7tJoeV5hLYz8lBdd
	WJE9KMnb9FjoChD6eQA/bcohL9UQSQIA+aygxqJG4ykgdfi+ujWO78wDkHsr7kBeLOgYeuv3R4e
	aogMx2luJPGSgBNcG/WtjcZG5rEznPaJerYYrfmA4dXs9uJqYGqVz6IHbR8u3lxb5bmfN+JvmN0
	Xe3fm7Qav7bQxMU235AmAqtnyMJClB+9o9Hh1CZtLEzf3CPmx1/4YCJ5JkmrGVJ1jN52ef5PmH+
	/r4UQCdZV2f8MWlJ5fUEO+CIDu17uv
X-Received: by 2002:a5d:584c:0:b0:439:cc67:abe9 with SMTP id ffacd0b85a97d-439cfd461camr1819806f8f.27.1772688879158;
        Wed, 04 Mar 2026 21:34:39 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439b8807a4esm26871282f8f.4.2026.03.04.21.34.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 21:34:38 -0800 (PST)
Date: Thu, 5 Mar 2026 08:34:35 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Soham Kute <officialsohamkute@gmail.com>
Cc: sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com,
	gregkh@linuxfoundation.org, linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/6] staging: sm750fb: sm750_hw_fillrect: propagate
 de_wait() error
Message-ID: <aakV6zJbUAJR7j8M@stanley.mountain>
References: <aaVT1mSeKrSSlrha@stanley.mountain>
 <20260304173529.192067-1-officialsohamkute@gmail.com>
 <20260304173529.192067-2-officialsohamkute@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260304173529.192067-2-officialsohamkute@gmail.com>

On Wed, Mar 04, 2026 at 11:05:25PM +0530, Soham Kute wrote:
> Propagate the error from accel->de_wait() instead of returning -1.
> The caller treats all non-zero return values as failure.

No, the caller just ignores the errors.

regards,
dan carpenter

