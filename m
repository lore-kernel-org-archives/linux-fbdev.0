Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C634364022
	for <linux-fbdev@vger.kernel.org>; Mon, 22 Jun 2026 09:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782119170; cv=none; b=u+JZYtYQ2oaryh5k99+sTtkip6RKwVKwWOP2EKj0DgscynbXw/7r3lT+VDTyOlrCW+U4uIGf652IYq+DXK8kifnsI4i6Clbwne1zdeVmWKgimEMbpouDDwDfgt57sL5MCva30oyCMZuYxjpwsnh0KeC80OuGLPjRaeqfM/S5ITs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782119170; c=relaxed/simple;
	bh=nt5nHNDTmRUYsbCNxPLNby+fTZzQ7KQWG3C9lgxxs38=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UBq2F3D3vHMFwvPbK2ZvyrTQCE9thJzu4cQtZa0aR40ib7Qe5KtExS13lAOb/KNiLJbR0Tx5XATcWKNWvG+CiWv/0rNkblgftVrJEGwMyrjARrldsr2YIsfh7F82FNMwU1bWPBoXut/mDeEYju3rK2VItIXwP+TrM/wEN636trI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rlCrawh/; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rlCrawh/"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-6977c0814d1so2755862a12.2
        for <linux-fbdev@vger.kernel.org>; Mon, 22 Jun 2026 02:06:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782119165; x=1782723965; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rKi0tpNxnV7aF2Y2gDvU0xwj8sSkYkSXh8nfiFV0TdY=;
        b=rlCrawh/gxRlE+KPP+Z/p05BpeRRoR3b5dSSqEJ5KB4A8BJ7HehwNgiLd6/AvGpJo9
         3HVfYiiU5FrAsfDB1vM80WxfbNYfCQmb6XecPdjKqa29yNACQ1Bz5Uxt/fIejff7iQSS
         4Rs8rusE/U6ectqTjOYLEEcbWICzmY8yTvbzRDy8LmDHrOX2x9TMCuyiTJwszkmrfBJy
         slOFIdFmsIYG+Fy7UKzA2wXs4jR9+L/AXzRLVBbf3+cmrpd80PWY2x3gi9Worvvhs5fk
         cofw9AXAoRCkcaJ2dZbvT4W8kxEiQCH+pS7VKZpnKysyaUJi8R4togk2TnAY8lyjA0wl
         fAVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782119165; x=1782723965;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rKi0tpNxnV7aF2Y2gDvU0xwj8sSkYkSXh8nfiFV0TdY=;
        b=m1nBgDQd5E7CDsYWxpsHxspcjmxO8xoxHy4zivzAc7sk2KAKStbJ+aj7+yZ0WAcAAz
         34CPoujOj5WaKsDbaR7qdgUTq3khAV+5PTXS8yNSRAez8Z/5D2te0D9HbQ/zwkkGXRx3
         I/xDfls8WLEOKIab7PF8QJCmtuyTzMPpYsoqqwYxMZ/HFuvnqJrYXkAXLryV3C0hzFSH
         qItPYlXML6uaoKsPWxtMGUiHtGu8OTXKTwuvaeL0HJmzAmSNKumE6bRqlj4zOSKnkiEp
         O3CuXvnQevYf7Y4NY/i/UD9sgDYxKQ2jJbBz7Vm0vKODmEFlVFTdVgZisw5Y+ElAq/oI
         vxHg==
X-Forwarded-Encrypted: i=1; AFNElJ9WEDo+BNyg1z0nSMCd2ocOIDppC8b4av3k5//7P234hfJBc+jjqEuJHVX5J28SH+5JLTHeJKwGSjYK4A==@vger.kernel.org
X-Gm-Message-State: AOJu0YyWi869gf9PpbIwECQc2vadDZyNzGZiiwXJ9ZUdkxTgR9PYFVI1
	MLC9xrpZ41u1Tf9f8TXAt/r05KOJ+pYnkXjKvtjU3Ylqq9Kv9Ryb87SN
X-Gm-Gg: AfdE7ckLqt2cFV87sVojKo+kkzFjCGLbJWRet4oG4MdAEyqNcwfRlIl2yxU0SJKpvFf
	e5DE9UhdDsYnLnxpY3/OiywH7rfnBd2kDIuAnKx1gtmjRahyGYVqsGBwbbS0qCk4H4voB6EhbSn
	luU2r6Rp8E2D/pHD9JOePcRLyNBwEsEBtQ4o9+oYKFhK3m/JTicP65bQUSCtUGMQN98Cft6Kr4a
	13x5ysm4VXAhMm/WKH7UnyT9E6Gr8jvPrNROGJxkRVrRMmn496kw4MJRnTP2n0w7j+MWGoMCEBx
	+/moxmxLpPkM+7zXxhSboIB6IDYlzgV9nJLQfN5L1tDMG619pRmmaD9Sk5yJgxFaQtqzl1/Ke9t
	sxu0siTuPyQYCQtHIo762r8kLdpPrSv1guQeP9Prm1BAEIiOZ16MttC59s+lE/3p9Z1j3iCl/mj
	MduGV14WAJ
X-Received: by 2002:a05:6402:1941:b0:68b:d82b:fc2 with SMTP id 4fb4d7f45d1cf-696e5237c1fmr5954025a12.26.1782119164183;
        Mon, 22 Jun 2026 02:06:04 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-697c1ec13c3sm300017a12.7.2026.06.22.02.06.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 02:06:02 -0700 (PDT)
Date: Mon, 22 Jun 2026 12:05:57 +0300
From: Dan Carpenter <error27@gmail.com>
To: Aditya Chari <adi25charis@gmail.com>
Cc: andy@kernel.org, gregkh@linuxfoundation.org,
	dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: fbtft: fix parenthesis alignment in fb_tinylcd.c
Message-ID: <ajj69VJU6A2AjHDY@stanley.mountain>
References: <20260621062945.42519-1-adi25charis@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260621062945.42519-1-adi25charis@gmail.com>

On Sun, Jun 21, 2026 at 11:59:45AM +0530, Aditya Chari wrote:
> Fix a checkpatch.pl
> CHECK:PARENTHESIS_ALIGNMENT warning by aligning the wrapped
> argument list of write_reg() with the line above it.
> 
> Signed-off-by: Aditya Chari <adi25charis@gmail.com>
> ---
>  drivers/staging/fbtft/fb_tinylcd.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/fbtft/fb_tinylcd.c b/drivers/staging/fbtft/fb_tinylcd.c
> index afa8f1c74..d58b12472 100644
> --- a/drivers/staging/fbtft/fb_tinylcd.c
> +++ b/drivers/staging/fbtft/fb_tinylcd.c
> @@ -38,7 +38,7 @@ static int init_display(struct fbtft_par *par)
>  	write_reg(par, 0xE5, 0x00);
>  	write_reg(par, 0xF0, 0x36, 0xA5, 0x53);
>  	write_reg(par, 0xE0, 0x00, 0x35, 0x33, 0x00, 0x00, 0x00,
> -		       0x00, 0x35, 0x33, 0x00, 0x00, 0x00);
> +		  0x00, 0x35, 0x33, 0x00, 0x00, 0x00);

The original is deliberate.  Just leave it as-is, please.

regards,
dan carpenter

