Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85D1C36B
	for <linux-fbdev@vger.kernel.org>; Mon,  8 Sep 2025 05:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757310358; cv=none; b=NUJQDsSxx2ygwNYzM8zKCVuZd2ExNQbscKcSkLH0OsS7AHezPzbAvO1WaYTHcDdrzn9WFFSzXBhHFafuurwwx1b3oOFdUv0Xhc2kZsLcpOfJIHtL/dp61MGDH9Lf9D8V/hNm08RgbzKpuq/L+akgACFqWErZo4xSxO/WH3bEtdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757310358; c=relaxed/simple;
	bh=Z93EEMLZ8bdepan4BINitcyJFnBNPlN2fw5mo9Yqvos=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jubfNbi4dK0Q5qgCB4+l+ZdUW9mDDVvs63uo7pOmSDk06cCKJ5WYoU986Yzr5ltTxMYWfwJbqou+SBRKZypAsk42cM3f1QqAO5wlNcrxY+Seww92kmgSRAYTYHKBr0HpeU39TeUn4h1fV92UP5pLYTB73dbA6Hw6uwdf5GU8rn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OKOJTUdZ; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OKOJTUdZ"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-45de60d39b7so3415575e9.0
        for <linux-fbdev@vger.kernel.org>; Sun, 07 Sep 2025 22:45:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757310355; x=1757915155; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=G+fMI7jrlec1AYc5iE/AykLzEwl5evDQP4qBoNzK6d4=;
        b=OKOJTUdZK48uCdEZXPshpcq6dnuABq4T0+zoIRi4Mcasj2dQatRjPSppit/FT4rRmc
         5ERA5fJMqX6om6iVFo6KN5an613f7HVq7vkoR1c2kcc/E4FXDWUZVQqEVevFwqZKn+ty
         vzhTlmtfiYkbEisxeyNhGWwLXxBA5BxlmG/n1jOsPLFCk6MTnL+rzBgiGAm2GqJGMakv
         z0kJr5h9+/+HMHg2dQbrUd8rrK8crIRosYXDOXcxyUdUUtRAj+wF0XsR6eeeKk6lo9He
         +dNtMsHswgd1DML1dC9PGMQc1I+A8mJxbe2uLJgcGwe1A89ljhTdU0J5k0qcRPkseo4i
         O/oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757310355; x=1757915155;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G+fMI7jrlec1AYc5iE/AykLzEwl5evDQP4qBoNzK6d4=;
        b=V/bGEiMspenscGbdgAGlDf/JSQ6g/NAGVeUwvSW9bM2DRj8fc5tA+cU4xBKt6q/+2i
         BMuON/n5bfHMyaHMlBm5jMhndnt/msYtEQ9F+vqWKj8V57/daQG6rOqOd5MNmgZ81Nvm
         zKY4AglH754yR+LwtfhWbC/AYCWrI/XVy3BQOJaFQz/zBCLWUba6XQZTYPwMXZ5T2Ihu
         relzsfv02jW4AX8d6CM4uujem6grbS7o5ujmh+ulx4yxQ5xXMCWxIfjDM+Pmpao3vNeN
         l1CFQrFhYtynHFWIM2h7EJ7dsERYBglYt1NCnpzWtNV9DEscMqChtWJ9kN2EhuON01PL
         CaxA==
X-Forwarded-Encrypted: i=1; AJvYcCXDR0gzg7ajYLGfB2LgIOvXYivQwdNaOoV+9MgDpxn4NJo3vOvUlCOr99GTY5UAbWIoNBEch4el1NLymA==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywqu8trFipDJSXI8MMMt+GzQ0yP5KJtkHhcVVIzrLNZX4iP0oFh
	kBVjIJz/RoazzuZ+R5GQxq33JZgu0v3QmwiCqxn6yAsbRafcwH1TWv3UPC3f7AxzOag=
X-Gm-Gg: ASbGncsEHkaTN+5pWVvrz2ZGU7EcDNT5ZnnzqLh5BmH40MlqwuaHA5Ksr6JGaRZ9Xl0
	9+OsOQmTdoTi/XfAQ6oUb2rLi6Yv9un8ESiDdlJlEquiNSyBvtF2DpQFIuUBBLQOXyF8cUdB50t
	47tMFJctLY5d3ms4WjOJ3JNz3bkw2UrwbLHVoujJ2j1+l0+plAc1OYfNOY9FHZE/g67JN0tB4tx
	537dMylsEtsBnk2v1/bb1jEfbTzqKKB1PHfYyU1oBSVTaquXQgqABf2m/rQOuyDOGJK4cgG+gjN
	4Evzrx17cGFC9wPGh+XerbgYhFzMH8Kx1hslh9+Vzt79p/kW2Y8jJ7yTQv13+bS/eY9dAqQ8cqL
	iuHiPHNvt37j6dVFtFiDFWdz86Uo=
X-Google-Smtp-Source: AGHT+IFrY+W8Zw7FZwKYzK8IHAxbMi7aFqUaLDdeIhsBhJpxTXZZW2/teY75/VCxA00xqU8hHX5z9g==
X-Received: by 2002:a05:600c:1f90:b0:45b:8f11:8e00 with SMTP id 5b1f17b1804b1-45dddee8f49mr43141705e9.37.1757310354706;
        Sun, 07 Sep 2025 22:45:54 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3e74b2e0511sm1114669f8f.62.2025.09.07.22.45.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Sep 2025 22:45:54 -0700 (PDT)
Date: Mon, 8 Sep 2025 08:45:50 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Yiming Qian <qianym1996@gmail.com>
Cc: sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com,
	gregkh@linuxfoundation.org, linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: sm750fb: fix coding style issues in sm750.h
Message-ID: <aL5tjv_2YkvHPs5C@stanley.mountain>
References: <20250908052133.8888-1-qianym1996@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250908052133.8888-1-qianym1996@gmail.com>

On Mon, Sep 08, 2025 at 01:21:33PM +0800, Yiming Qian wrote:
> This patch addresses several coding style warnings
> reported by checkpatch.pl:
> 
> 1. Replaces CamelCase variable names with snake_case:
>    - dprBase -> dpr_base
>    - dpPortBase -> dp_port_base
> 
> 2. Removes unnecessary use of 'volatile' qualifier
>    from the lynx_share_struct members.
> 
> These changes improve code readability and maintain
> consistency with the kernel coding style guidelines.
> No functional changes are introduced.
> 
> Signed-off-by: Yiming Qian <qianym1996@gmail.com>

You need to split this into "one thing per patch".
[patch 1] remove volatile
[patch 2] rename snake case variables

regards,
dan carpenter


