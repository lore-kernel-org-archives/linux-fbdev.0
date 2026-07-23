Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB92E432E83
	for <linux-fbdev@vger.kernel.org>; Thu, 23 Jul 2026 10:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784801428; cv=none; b=V0EgRULKrj/fR3aPWhgp387E0hzcxpPP4tPwc0vOl0G6BoZVGCuguKTFsy9mTmf42uCYSKzgwskJ2+4BQHs9ekoW3k2SNngQQ7glfYhFW6+LXGPNP2Di8JgE+BV4KKneEEuyPrPdjxMtkbtmZQW6/RQr96b1RNbkxsse14lgfNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784801428; c=relaxed/simple;
	bh=ZB447XxCBqH89cLA+iAMyBEOgv3a3ukggHt0biRRmDI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GR9e85l5okV34kMn/7cXb9pab9xf9ZE4C4upO5tmF23zC+rMeJ/q2PDE9CB8b+HJyUZuDvQF83D3A30gP3La5a1Ie4XL77yUNEEtZ1UlgEEcmAzjVXv7GvNe3bpMadzR/D5BOPMxmZPkPR6JlaeE6LdJzIUSdtViqvhrAxrkBTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BcwoaSVP; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BcwoaSVP"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-49556f97a9dso3026845e9.1
        for <linux-fbdev@vger.kernel.org>; Thu, 23 Jul 2026 03:10:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784801425; x=1785406225; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=VlMWE9xZkorwpxL9EbIVt9uDSDnZ20C3ZODwFQe3gZ4=;
        b=BcwoaSVPa8oIQDNaHuRM5qHgObZX933GWrEWeYI3Vb6ekB6kpEu/Y4omFq8RWirgcj
         cB43pDW9+Psl5tZsR21pP40BbuWbRYjP4C7mx4LDHQcagIRbpXCJLxda2PORlr/BfmD7
         4R8WsJxPs2IEPJ/mX/ZHKz4ymlu2oGvejUmT9X22VR3/FVJlwo4UtcfyRiaEbP+1M7K3
         hPMe9kpGKb1gDID6Y7JoOHTQuUe2PCJVsUTfWMySC0Is99oViwsY7Py6A9/kMr1TxL4U
         /2crRAtWOEssOMunbNFLDgOK1c5zA7IGN4wonISlagUH1VS2tx0+XK8b1TiS1yEeipFz
         2YyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784801425; x=1785406225;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VlMWE9xZkorwpxL9EbIVt9uDSDnZ20C3ZODwFQe3gZ4=;
        b=QlY9LRKGZAcxCHtcUS7aqWKb3n5QkJ01PsND+/8ps7ZNZRHySOgBx35A/22IY40+Z2
         yIE41KPqeV9KenI4uTHRmoHELjX2rLm8mij0/kLRJpukaa9qhoibkgmE2P+MEoJtdSGY
         1IIHqZuIfcyGYtAMknNY8qylRbDDyQsdZcUTTvaYzkaOAuHpifvDvE76slOY57oIvlEH
         2dIAoe3k/AKTAmnJLlaENhp27G6HIRN/BNmyu5w/AXYIJGxpz+NTlbI3jTW62sitdEX5
         7R120En63fSJ1YfTyIQgZyP4KcOf8k3u7rWczt1k8gefxFOVHJHifHq4B1AoKXsZvX1A
         /pkw==
X-Forwarded-Encrypted: i=1; AHgh+Ron3rNy6Pi2EawCUcjqWfmm8GMptlrsMkxlcMW5XQov/qEfRT7u0ii1rDgcHmo34gPi9nejtzojK+uZGw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwF18piukTQSRqw7YwEHmJbxjkshAs/HTV4skUr6OgDjHh15HX4
	gljZTfj5YFSJQbBOqmHLxIYy98TdoofFXjPFhSYg3/kA1hVG93u2Fx06
X-Gm-Gg: AR+sD10Mrf/g4nPMEc44WYRz9KmtmqL7X+4jeJqcaVA+VV5USLZ7ZoERZr7AmiqxxBa
	kbTAciOEw4GC26uc6QbKIFhHOofkrbMdXRYbpyhChv01odcb8HiAF7FAKUvhFyRcEifCBPWGcvU
	bTSzlNmvn//JcEIapvAeKEayFJeR9YbN7Lwom7cZR5v8Og7Ohq0wJgX1RhhiWcr0DE/ScJuwAIT
	nA+BMwAUgVznckGPa2Nd4V3/EBbOxh0fgOCO27JIGOenQNrf7ih6YS7sC41PCvR3SJu/1qeew3K
	ZM07UCYlUBOtC8o5Wo4F7LxrB0zUPgJmx5SI4VAzB/ztSJHG83YAzpLBIolDfOlSNHRFmvkzUlq
	kdfi7iz/JAjzWZEMXWKAoU8U5hOCW6t/ympycoqV0IsZc0cAU6CG40fMpi16XS5rjRSwRTWOcBw
	==
X-Received: by 2002:a05:600c:190a:b0:495:6e68:5df2 with SMTP id 5b1f17b1804b1-49573c9995bmr27760195e9.12.1784801424740;
        Thu, 23 Jul 2026 03:10:24 -0700 (PDT)
Received: from localhost ([2c0f:3d00:6be:8900:ce5e:9212:ea4b:f30])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-495653bfed7sm229252705e9.11.2026.07.23.03.10.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 03:10:24 -0700 (PDT)
Date: Thu, 23 Jul 2026 11:25:55 +0300
From: Dan Carpenter <error27@gmail.com>
To: Mohit Mishra <mishraloopmohit@gmail.com>
Cc: Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
	Teddy Wang <teddy.wang@siliconmotion.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] staging: sm750fb: Remove legacy kernel-doc comments
 from header
Message-ID: <amHQE1sKtB9rxoiA@stanley.mountain>
References: <20260722175817.213235-1-mishraloopmohit@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260722175817.213235-1-mishraloopmohit@gmail.com>

On Wed, Jul 22, 2026 at 11:28:16PM +0530, Mohit Mishra wrote:
> The header file sm750_accel.h contains duplicate kernel-doc comments for
> sm750_hw_copyarea and sm750_hw_imageblit. These comments are outdated,
> still reference legacy CamelCase parameters, and generate kernel-doc
> warnings because they do not document the 'accel' parameter.
> 
> Since the correct and updated kernel-doc comments are already present
> in the actual implementation file (sm750_accel.c), remove the duplicate
> and outdated comments from the header.
> 
> Signed-off-by: Mohit Mishra <mishraloopmohit@gmail.com>
> ---

Acked-by: Dan Carpenter <error27@gmail.com>

Because nothing pisses me off more than comments...  :P  LOL.

regards,
dan carpenter

