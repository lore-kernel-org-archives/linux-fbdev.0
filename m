Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792562379;
	b=YPAKCar1XsRo7ieMiqd5IOF4/LIR4h7w3hAVrY+Te92fzb8ZLbBtvWGzkxRbD16kOSd1
	 9y9A3sYSHonbxv5BXRUC9ggb56vulLNtUUNpNsUwH+G8iyuu9BOaziXNIFGUQfB0Fk338
	 XsTKq+rCBSuMcXn/CeE0hwoDJl8g7X9mW53gz1BGkvF7lEGOvrX5tlKuD4CcD9aejT5Dy
	 StAAkMO1sqyumnZuLARIo/5gG8wckNwb8hTxhf7nUdFCUvEeD6UN7jBlF+OAN40QvZeaZ
	 3uUsHXpZvJSPFruZmyuNJQFpL+w0eaAWWXCvCUR/8BiVWoVkVh5XFaX5vyZgLbAGVTQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792562379;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=7wvxYM7tnszHbpN8YPIatF2rX8H2hfZfH08DLyoi0hs=;
	b=r06H0I9Fpa+5B+LILmJUO2uVdctiWr8N2ax+Qb62HYRsg2CXcxmfbzh+hPBpZpkEtLfK
	 0jh3UZ5ggMJdnO5XhrnDUJZifKl+h34LJnxhMx7sRj07EQLxNycIL3dXLjo+p/SkdofHl
	 9IBk2Cc3x217vyZlXz3I348Fevcfsjgr3yL8LPOxUkG28V2agco7nDK45LYRdtKDeq23S
	 kq7mkhfKnlX3mbhJE1TSdAKp7daxPcxe3CEZUWJXaImz0s96e24/WOubVlmYUNN6MWmM4
	 QSj7WBWwYQXSqCG+8na70rMfRsu1rHjzw/i76qlYn4anILHWHaxdYue0+GMkXsmWsKw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.128.52
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2219F606A319
	for <linux-fbdev@vger.kernel.org>; Wed, 21 Oct 2026 05:59:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2219F606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4a1f403aca0so1698135e9.3
        for <linux-fbdev@vger.kernel.org>; Tue, 20 Oct 2026 22:59:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792562372; x=1793167172; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7wvxYM7tnszHbpN8YPIatF2rX8H2hfZfH08DLyoi0hs=;
        b=mrLOs0Rpv9fxgu2Jd7PX8MJDia5wKQtpIQdDOF2qFbADuLm36VGWwWE0HDxIh9JRig
         w32Epcbwxa+m56SqCIKKjSl3/kB+LEXsLOLUONXC9szsW8tBGOeXNEZcoKcYpoeSzDhG
         1tAkPF0DhGm2Vip3PdkectSRzedcDY90XKAZOVqjhcRGvmo2BdGcLyUfoCL6OA97eE+I
         55kwVh0usiWzUec3VsTCCBFlvI0bwsiDMSLtPjbuyo3rOn9dBUIxC7n1HWh2r0SStKVH
         lYvuJbIGwYPY9pkor9fYMzY80u9PDl/ZdEVnfpK3xbHVpHn6YJXzBPjsy+8i6Tac9MXF
         kYIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792562372; x=1793167172;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7wvxYM7tnszHbpN8YPIatF2rX8H2hfZfH08DLyoi0hs=;
        b=GjSUxoCs1FO6ujXtye2RolEKowApIA/VZvOTy4EXDRMe+7deznRO7sOE+JQQN5/YVX
         e6OrvrSYt5Gkfbry0PJbyI+EydaYyzIhIgLS/gaH8Z3fEs8BIEEImHeKpPuQWd/GXzI0
         nOKe7dI+fYRhcHP2WokAeLLb31U9NCI/juXc3ZL7jHs089r3DrrP++CW5hlU2xmaaPv+
         JUm6do9N3lfikOGsxMqKUdQqOz9sw3rR+eRcA/vKZG+qP93zYaop3xA1lAWtTcFvYRB3
         VjgHqKtnUgisRtjUjwR9kKTqV278B7Ip8jkKCQBlsSD7GWQjK9fGePItQHthxTvqwbDo
         vDPQ==
X-Forwarded-Encrypted: i=1; AKwUvByDW+8sRUzrVfgg0F+R2pe/bZM8rdQvCLA5FhXNBzsDMazVLrJw7uHIR0XdXvsP4X79Du4IKSYdhuEsXQ==@vger.kernel.org
X-Gm-Message-State: AFq9FYIgh0Oa2qYvK4atfqklQDwWMXnExGGC4EZsoKPR6eaYKgZ2QQc4
	HQgsawyszEhH41Lb4LccnG0j0OlYjiwYC5+ez1NilQFkjk0/+gC9GeNr
X-Gm-Gg: AYBFou0aPBpRxPCaqAhkJczF31ZCn8lrBZwQhZKSSYvpQOsoIeZg4dgiP//cCm2a+FK
	ISpHYkNdoA93PPwHhfTfXWFmIhFfXkkIALqrQR2O4ahDVG8DLzBORCclqGhBEdd4jyUv7lpJ5eo
	IZ4iTT3zFebGba1Mjx2YHDRs5etRqbQfngX6hYbf8yXo2UqLc9fdNJTAku5Z1M7GxTdqidcpzGQ
	dnhoZ1vEXbuy4dkddCm0GQKoMQtEJsdvB4WNDhjkI1F89OTdHlEzQ7RLwFWSC9nQHDpoXGqg9lx
	DsHlw0fCCBdX9jOo6ixSjI7b1p6et+tN7FSLMSY/AEbG04htMtlKx0DJpnkqnmYTOECZ9Gbnc+Z
	Kx6gXBbWCDXbFcYV6TqWULlSRiVKCdxQ1B7IKJoWGY385nsffni4ASw/sjQEdISlKYPxrx7zrdy
	2oq+b2C7bSFbYzUDTLy1MytuvHvcS/j5B2na+wZzCLQyE0Pk/fJgv59ovJUnDQJpz4A3a2uTFyq
	ZQs/CV9dB0dBlHyxuOjFif6GtQ+r7fgz6qPHFHB8RGfflTKklButkZki9GXuJTzhlQOzqXoeg==
X-Received: by 2002:a05:600c:c8c:b0:4a1:e489:f8a1 with SMTP id 5b1f17b1804b1-4a1fd89d90cmr15704905e9.2.1792562372261;
        Tue, 20 Oct 2026 22:59:32 -0700 (PDT)
Received: from localhost ([2c0f:3d00:6be:8900:ce5e:9212:ea4b:f30])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1f2d6e2dbsm134642305e9.13.2026.10.20.22.59.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 22:59:31 -0700 (PDT)
Date: Wed, 21 Oct 2026 08:59:28 +0300
From: Dan Carpenter <error27@gmail.com>
To: LiuJunyuan <2058432396@qq.com>
Cc: andy@kernel.org, gregkh@linuxfoundation.org,
	dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: fbtft: use scnprintf for fixed-size text buffers
Message-ID: <athUwPFnbEJ0p-0s@stanley.mountain>
References: <tencent_FFC8FA1142CEF600BDEBE1EDF4EC27C39005@qq.com>
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Post: <mailto:linux-fbdev@vger.kernel.org>
List-Help: <mailto:linux-fbdev+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fbdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_FFC8FA1142CEF600BDEBE1EDF4EC27C39005@qq.com>

On Wed, Oct 21, 2026 at 11:22:08AM +0800, LiuJunyuan wrote:
> Replace sprintf() with scnprintf() when formatting the framebuffer
> description strings into fixed-size buffers.

In commits like this, I want some analysis of if this change matters
or not.  I would still support a change like this even if it didn't
fix a bug but the commit message needs to say if it's a cleanup or
a fix.

regards,
dan carpenter

