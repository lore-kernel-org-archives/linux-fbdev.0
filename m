Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0ECD352FB8
	for <linux-fbdev@vger.kernel.org>; Wed, 28 Jan 2026 13:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769606904; cv=none; b=Rm13PkZW+6Dr99HwBnc2FBjpDJDVzIaHzi4jM9jM1Fpr+3GeKMID947ur5WPco6ektOHDwhM6NSaiO9GIegR43VJVbTWnxYVuWHy3Vvi+nS6CL0d5JdQx/NBCOteR0z+51JwM/tlj7BVwipamc/GvMhfoSTvb4G6NiF/zxTrG7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769606904; c=relaxed/simple;
	bh=kPcbbevVhJlCEBzXzO406NdwUd7Cj27M4P7lSigLkdY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S4bFMRPPZKIvpVrRmPzABiFas9IuU3q0dytVnutB/YpXPNP013N6LdgI2f+6NmTywtoOrO5+ClfZx4x+xxtQbQovXtj1rStQQnauerHkQwTO5QupMlGYoPRSNZVlNDmOHG8GTHOsWcB2dZk5SYFU01fZRCnrkAagdcP97Bwle3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=suaKZwiF; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="suaKZwiF"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b885e8c6700so945081266b.0
        for <linux-fbdev@vger.kernel.org>; Wed, 28 Jan 2026 05:28:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1769606901; x=1770211701; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZagjdEHQ21hUp48jB8mdfWlYbNhCwoXWZ/IjA+v/NaQ=;
        b=suaKZwiFHf0cw0sgMRESQy8np3g1fKQvY8zwpnbdI/EEae9fYLP/KRT7cFJLaXrxUZ
         ud4nd3Xfka05QMe0hLjCYzbyLYB2MjsZAVgrmAibkI1D6nBIi2mWk0S+xy4PqdHxBoIT
         iOqQTK8QRBu3Uk96pwP0+89+1wjWlaLfI5IKPig5NGhsgSaAjBczWgC4YQZiWq71/FIq
         Tokf2otuWkLgf97SRU4pB1likx9+XcavqZOscylSVpb/rfLPabW55JGBR9Ur5jWixXu+
         ll76su1uv0oU4/1vF72IPih0DGehytSbN8ceqUUg1PEn3xUUPAKBaILiM7+n5kLgNy1O
         NcSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769606901; x=1770211701;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZagjdEHQ21hUp48jB8mdfWlYbNhCwoXWZ/IjA+v/NaQ=;
        b=pdHBSkrrSgSN2EfrFcpVtOzEIKap4T6hAJma7VkwEj78ufYkdl0nMYzZNpJVGFS9KZ
         bBRxmWCMlNHALCqSUi5P8CrwqEWFAgDu2Zv6eYGBi38NUPnqRwjcwJDegITnFhk23ylL
         RmdLeztayJxyhqpM6zJiMd/9FkLpvgSVMlxARAEUvoXkNhZxUTornK5aQzg8/zihxnQx
         7hvCOK8a1HndtYIrmviR7tGtULzt0cU+/1Pk1iIk2st3s9kj1kUFW8Sawg5nW7EUbUn0
         1lfT3mauaLbWEb1j2u8oMbFFapOZkZQcqM6GQCmwyW9qovHpOQvxJS6MZ1Hx210eSfYs
         jGZQ==
X-Forwarded-Encrypted: i=1; AJvYcCUyt+WifHzxNmLEs1gX400/NQ6AfGZdG3D3kwo9D8fVYUhPu5tt6vTgj80z1fec9NmoQv3wF2NEra5VWQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwhnVWmQwfdnhafHvQ31nzOOUL1Ya+Z9ewGt580uBgX67ZRNKud
	ErD+4FF6XPd2MjdzkS98j6QnUSmUg2McQVqYWn2B1h+xkP2NxvC/qToi2kbmOmGwBHY=
X-Gm-Gg: AZuq6aJleiy5OdTKuzDOXtQu2jaDJsmslcYq9jjcVNHD6KOclvv5hSwGnPdo9ANz1VD
	mYqrBgnScR0czj6QWrvROrV0T01vAlF5RulZBSldNXAumv3C27+ByOiR3cVe8nWNjwrpglHjrgl
	TMpKZmPGMJyZkXP9Zx1Kb3yMa/85eiowwE3ICkWcyDEBhVL4o1f2MkWToPO9omkMlY5VZwMkIC+
	+gtknA9nXXRx0YloKbFcVGlmr7d4Idt8mafOOTeS8rI9biQd6uRauzR+YV6DbFU4Y5NB73jzbkc
	SklH25Bbt3KxDNTLyLET/bWCyTtWXOuHvVky8utBeBp8+0/UacwZtWmStEUyg/CbA0fuq63Vnkf
	zv2NzzJfia9V/REx4pxoN4LlO0LkTGHxTvRg2nGvCWj7RG73Pkw2SRXMG1qH3I6AT/LusV8hL29
	8Tw9kUPbyXk0ODPQkV
X-Received: by 2002:a17:907:3e0c:b0:b88:38e9:8f89 with SMTP id a640c23a62f3a-b8daae2b120mr380653366b.0.1769606901119;
        Wed, 28 Jan 2026 05:28:21 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8dbecea68dsm131504166b.0.2026.01.28.05.28.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jan 2026 05:28:20 -0800 (PST)
Date: Wed, 28 Jan 2026 16:28:17 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: ChanSoo Shin <csshin9928@gmail.com>
Cc: andy@kernel.org, gregkh@linuxfoundation.org,
	dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev
Subject: Re: [PATCH] fbtft: Improve damage_range to mark only changed rows
Message-ID: <aXoO8Yn9JibNVs-b@stanley.mountain>
References: <20260128130503.868466-1-csshin9928@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260128130503.868466-1-csshin9928@gmail.com>

On Wed, Jan 28, 2026 at 10:05:03PM +0900, ChanSoo Shin wrote:
> Instead of marking the entire display as dirty, calculate
> start_row and end_row based on off/len and mark only those rows.
> This improves performance for partial framebuffer updates.
> 
> Signed-off-by: ChanSoo Shin <csshin9928@gmail.com>
> ---

This is v3 but it's not marked or described.

Have you tested this patch?  What was the speed up?

regards,
dan carpenter

