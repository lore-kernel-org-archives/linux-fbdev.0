Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6641378D8C
	for <linux-fbdev@vger.kernel.org>; Thu, 29 Jan 2026 06:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769668175; cv=none; b=ows/OdPqzIqjRbQ+zag+icuVow3Rlezfkr2JFqKXRBqq3+zXZt9nDsX/HlUmH1Y5Cs0ktgw7uMnmkrI7lFi6GcHv31goW9DEIoRxrl5rh9Nc5d3RqA/xMpES0T3C/iJCNzMYlxxCOfITpr4Dtxp4UTbg8B2lCJafdVkLY1yWpMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769668175; c=relaxed/simple;
	bh=N9h6vwaKVIUjJ2pkG8X7lhazeTPFYuCM0T9JxT0q6d0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ApQgVKbG8oGCou4hA1NoLLAizm5AayiMJva5ttO7vfqWIShzwrIA9L25oe0kP83fcSsJpz0gaEWgoj0tFUiiyayd9MeDfK340KLyqqUMCtdTLfXYjD3TPB6l/ocCp8s5G6o7/f8iYYO6xKNdkl8RIHYHunEWeXqGeLOBzHLV+fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=AD2aRfWt; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AD2aRfWt"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-48039fdc8aeso3171175e9.3
        for <linux-fbdev@vger.kernel.org>; Wed, 28 Jan 2026 22:29:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1769668170; x=1770272970; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=puA+CnwxAlMqbOnhYN3pZRQlGRvX1b7vDRdIRgp2KfA=;
        b=AD2aRfWtWEUSaoVLA/u+1Q+vBaFWQ6Py8djy2dCwi9jvLHZiT26aX5Xqoz5Hq8VhTL
         T99BQTs0ZgJPvHbDz5Coc65Jxl4M3T+sRJuFynjtR6czV7Ivrtwb6iiHzYAYpN3SIo56
         zaxaUZGLloA9fLFHU21VF0UWT2sQBxOVgxsJvkM8rbO2lHIzfGptPqXQhhzyjlP/fbhr
         34SDWucVJ37eDhAGq7h+0pg2dBwZF5yn5eyrRsB4P69ji7y27rAzsO+QQoNyDjW4bHRU
         SubGfR1K4nfjNyCDFB0DFpoRTuiEs8I7pyye41WfTR0odZ4kAw40gjtnTXXyERKc3rhI
         a5Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769668170; x=1770272970;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=puA+CnwxAlMqbOnhYN3pZRQlGRvX1b7vDRdIRgp2KfA=;
        b=YuvBt7MMOn7umuflGnsIDOKYMoOOwqZnHemdosODJtCwa/cZXZ360LE7mjwPWbUd8d
         sw/P+uLOrSycSLL2A9MbzVnFLcdfU0FaemHHeFdjUAb1idmthKll2+ALa7AbR2YnuBi5
         Zrz/qHRFqKxgn3NUhFTjDMr76y+QE4LaIC8lf+Ng2B1PCf/U2gFSIS6HUvfG4NItPwWC
         KBCKoouNHEVUsiWxhrwJzVZWamu/9OFmBGOCR33ejEclq4UJsZ34VIXW8EDx/ha3f2h9
         Rt5/+Xc4CNWHw3f9Wh5B2hGrjLayxp0dDhmx5JV2XpRrIXpU4ZGsARm6FkhLh2J7X5Im
         ENFg==
X-Forwarded-Encrypted: i=1; AJvYcCVl53/sNUHvTC/t/1MQ4DCx+smUHPV8HDexd6D/GkrOfGPVrWCL6bGFwEAFCi8JtQHRXe4B3UtwC5+lBg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzLkaB6oayNRWwUSUuKZodeRWQKBIIfZ+6rTeJcPa/R6J9JvQ3f
	eTclgEqTdnkBxShYCnSYKcU0LBFi4ky1Y6PFHr1wjxIfkas9puUOmrrfqdH5m2ChKR4=
X-Gm-Gg: AZuq6aJQoFmN70jbt7gdDN3FF5eDBPI/ws13PqulgKlJjgeU//KDkpIB/y0oEMYYIXu
	V+DDfnT66SsE5qBdsKPTmuFXMOzxZnMkzsnM2mIOsXD2YGzteRM9isstVSdAAGn9QUwXRibObcB
	zk1MOcuKr4fv+2/17/XVUT5a58TgAGmk0X2Oll5fFvfYMEdnx22BrXQODSJ9nP2zH1j1+EdwfU/
	2WrMwOcLdAGJykyX7WrIup4iPGKq2ENF3T5RA0taUaILcyW7EeXdge2ebemypAalnCiY1Q6ouMp
	Zewr3w5SCFYmx6APjJzftHdACtP+E+pZ1mmWu+0BcOQC+B5b68nCeC/XM5HXocgwr++J2TjJfSL
	DIz0RlGN8//UzDO7EH1LGnLbzZkYGVP/rjeUNyDZpBzBIojOcOmD6vUjTUZ0OKgIrGOKRkTghxb
	HgFW7H0EF4XWf7bdiQ
X-Received: by 2002:a05:600c:468f:b0:477:a9e:859a with SMTP id 5b1f17b1804b1-48069c6948fmr105945805e9.22.1769668170238;
        Wed, 28 Jan 2026 22:29:30 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4806cddffc0sm130968845e9.5.2026.01.28.22.29.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jan 2026 22:29:29 -0800 (PST)
Date: Thu, 29 Jan 2026 09:29:26 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: ChanSoo Shin <csshin9928@gmail.com>, andy@kernel.org
Cc: gregkh@linuxfoundation.org, dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev
Subject: Re: [PATCH v5] fbtft: limit dirty rows based on damage range
Message-ID: <aXr-RhUXwIvMHYZI@stanley.mountain>
References: <20260128203938.962414-1-csshin9928@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260128203938.962414-1-csshin9928@gmail.com>

On Thu, Jan 29, 2026 at 05:39:38AM +0900, ChanSoo Shin wrote:
> Instead of marking the entire display as dirty, calculate the start
> and end rows based on the damage offset and length and only mark the
> affected rows dirty. This reduces unnecessary full framebuffer updates
> for partial writes.
> 
> Signed-off-by: ChanSoo Shin <csshin9928@gmail.com>
> ---

TL/DR:  I suck as a reviewer so I would be nervous to apply this
without testing.  Andy is an expert here and we trust him so if he's
okay with it then great.  Or if some other expert could sign off, but
I don't know enough to sign off myself.


The problem for me is how do I review something like this?  Staging
is a grab bag of different modules and I'm not an expert in any of
the subsystems.  Normally, it's easy to review staging patches
because they are clean up work which does change how the code works
so I just look for unintentional side effects.

It's trickier to review a patch like this which changes runtime.  If
it were fixing a bug, then I could verify the bug is real and say
well, "Maybe the fix is wrong, but we were going to corrupt memory
anyway, so the worst case is that it is as bad as before.  It can't
make the problem worse."

This is your first kernel patch.  You don't work for a company that
makes the hardware.  You said earlier in a private email that this
hasn't been tested.

The patch looks reasonable to me, but it also looks simple.  If it
were that easy why didn't the original author do it?

regards,
dan carpenter

