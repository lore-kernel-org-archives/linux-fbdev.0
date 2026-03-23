Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 347DF379991
	for <linux-fbdev@vger.kernel.org>; Mon, 23 Mar 2026 08:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774254762; cv=none; b=TldabIDIiMK2tr/f0XOgfGo1vOzavBirGN0RDWJxpaSrbNXra4IMmUQEvDg5EB3aYxnYHf50BobTpIs5ARckrvMaRQzhd4xpb2tYKNSGCydUBGf819vzTEGchFGpCwBSNrxLJ1q+uc3d220evEOc5i35kYkxjoetRLFgW9uGG7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774254762; c=relaxed/simple;
	bh=OM4/8EjqVIC4YfRgUxJxtAfGfU91Jx+od/JJ0lKT8ys=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IAv8GM9VxXTtQ4aoBzf5ttJzMebCkgjGAbWn+PcaaZI5EPst449gaQ0HzGPRrZatEQUwPslsxf6bPdqGcZZWiAXRz67ENy/k3bd5ooC6oA785YxQtg4SEfVw2AtTkL03Yjtzw5AHxcVYNdSIAFvT8kIJusfRNmi+E6jI6gfJva0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cca36gek; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cca36gek"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-48702d51cd0so23935905e9.2
        for <linux-fbdev@vger.kernel.org>; Mon, 23 Mar 2026 01:32:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1774254759; x=1774859559; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Fr3pV3yyRiJVOwrQfx1saRdyigbk5kS5X76An04qniw=;
        b=cca36gekC8kcWOc1c3TpI2dT+mm3p6Asxh6IlGNrtAfkEs/Y7WZsQvBf0dV8X7RcNA
         fMdZ4233lusvKl3bW1aTBZMpO5KTO2sqrt62fcuVsyT2WhGTo9k5PcdT3JdsCyRy+9Aa
         vAuMTyofkeFrIQSkOjxQfTxNwxeFqSA7ZPPLCCZD+SeeWNRatevYXU61Hp2B3DLg0jkD
         82V6FbUR47paASV99V98TT0G4I3fIXOIGJRLhRt6TmN2FnKj23LJyDzrgGDStY4sS+3b
         YSI/TzNPTeqk6LB2dAGKxonhkTUdy/yiP5Eh+VHw9AVOYJ5o0M6CzMwHbwZbwwH7Vn/J
         lKng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774254759; x=1774859559;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fr3pV3yyRiJVOwrQfx1saRdyigbk5kS5X76An04qniw=;
        b=byHWZ/GSSzxYlOgvTw36SJNV3/ScHfgzbyavnDDrqBUGhaAyVKJb1w0xGEKiMQa1Q1
         pQV8xxNVt56gabZR+6ZW0MLo085YrfdS6bHqcdDb9fVJWYRJ7unHWjkTcGafzJOjj4cH
         KBwMQI8NibvsoHx+ScdsUovlsKY0m+OuT11kxmR4l+MXAyGpEdiw1k5K21F1hBl1v9A0
         Ztv9vK8rywOTBOURYQo6jRlFdD0GK3NU7K0Hl5JeVxg4HZPPFEzTpXGylJ4E+jLc/lll
         Z6d4vDldKo1rbrsXSdcOAZWjQTyD/5SZNcrOYZtexH8OgDlOdA+KqKTzpJwDy9YePELv
         C2gw==
X-Forwarded-Encrypted: i=1; AJvYcCW0Dx+cuPLB9/gUqRRMKbwpzERWbjVD6TGf1GvBjko92E+Yq5LZnqC0l/wBSf+BIpwFGCevpKSVSJetcw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzqhKLoBdZXZ0MUqJ0G9YjW1QHOhqBU1f1vbgj4iPW10M0hJEgo
	rj313oEpW2cwwI7NewQqjb06acEZofJ31hW5RYOz5DctIaM+I15eYlFpeNYrDLI7jic=
X-Gm-Gg: ATEYQzyZqmrBw2c1AdHMVqBm5gy3P0t6tQNmUnZ24uRcbgZzkQlBKy6YfSMRT8KYtNz
	59NNcQ3nraQJ6kmOwcK4Cvm38+GgKWYuO0NG+rYI9TTuwXrUjTz2EH1fAL3R9Wg2JelZxsX4JPg
	RJ+d85fSSIMfbCta9n7AjE1YVI4V3msoX9Zmuj+86K6V5IUm+lA1XTZini32kWk9eIk+Tz+5/6r
	fWFQC0X2BcNV17igrDzIHJdUiHxMUf1+PnFxQU+6Wy53eiBmdS+ixBZaiJzQsWGClAFc+N5Whwi
	dXS65VINITV3oW+dda8/0YTjgXv7wqvNx0ffGq8HbjE+3Wi6JBoXQ16cirCYAMAAnlQpoeQOivT
	FItIieYl1rPU5WN0+yt7j9vbhXm/Bl8sb4peR5rvD38zxPubdHMucyYRQn8SVEbpqmFZNotalK6
	4/0OBPF/HyIzvon68rnWv2GdA6RG+7
X-Received: by 2002:a05:600c:1e09:b0:485:4526:ee06 with SMTP id 5b1f17b1804b1-486fedfb677mr162420025e9.11.1774254759594;
        Mon, 23 Mar 2026 01:32:39 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-486fe032a55sm515752485e9.7.2026.03.23.01.32.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 01:32:39 -0700 (PDT)
Date: Mon, 23 Mar 2026 11:32:36 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Junrui Luo <moonafterrain@outlook.com>
Cc: Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
	Teddy Wang <teddy.wang@siliconmotion.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org, Yuhao Jiang <danisjiang@gmail.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH] staging: sm750fb: fix division by zero in ps_to_hz()
Message-ID: <acD6pMfM9XjTXdhf@stanley.mountain>
References: <SYBPR01MB7881AFBFCE28CCF528B35D0CAF4BA@SYBPR01MB7881.ausprd01.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SYBPR01MB7881AFBFCE28CCF528B35D0CAF4BA@SYBPR01MB7881.ausprd01.prod.outlook.com>

On Mon, Mar 23, 2026 at 03:31:56PM +0800, Junrui Luo wrote:
> ps_to_hz() is called from hw_sm750_crtc_set_mode() without validating
> that pixclock is non-zero. A zero pixclock passed via FBIOPUT_VSCREENINFO
> causes a division by zero.
> 
> Fix by rejecting zero pixclock in lynxfb_ops_check_var(), consistent
> with other framebuffer drivers.
> 
> Fixes: 81dee67e215b ("staging: sm750fb: add sm750 to staging")
> Reported-by: Yuhao Jiang <danisjiang@gmail.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: Junrui Luo <moonafterrain@outlook.com>
> ---

Seems reasonable.

There is no Closes tag.  Could we get some more information about how
this was found and tested?

regards,
dan carpenter

