Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794822106;
	b=eQpxHSEXcbWjoLa6B+M2ozZ6mv0r1zFZix3tPGYQJ369wbiavIHS0k32DVM0hwKnjD8H
	 QD6+eAK+jwb++ECuHzP/FaEtp99pC0tUbw82K+yU6/EA3z86Omy+r0HtaP06+xcsK32IE
	 H498bLomdSP1Bkq4jN1y0K2TW56Z4LwOpRmuRCSMaHXmX4PBylf5YK4UpJt76EXk5dmQ4
	 q2zn+xcTsUw2FASC39Ka7s6tT5mlHf7UGZ4yLt+ClwfgX9ToIWU79859cci6DDO6/p/3I
	 5pB3YsFRR0drgZyt8JFO84xq2cBsia0PsquVHeU7TjRxY1Irpiwpkx1t/FuwJbbctvw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794822106;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=doTb3+6760LyHkJLv51ETQTO2ku1Db5vB98zHM1U87o=;
	b=uz7en0+xoQBFTlaioiYDqSlk5RwN5KjTPOHFDlUI6I3+nakQEcE0T+W9o1k90xURv99j
	 XZ73G/pf6N3o/1OKFXyDnU7VUCC22wUoZxk+9Q2GNl1f3moIbGtzAr5w/13ncCHxz82Sc
	 V7u7LFcAe4F5CqYkK/jQc4T3JUCM+A5peo7ArDGWPOdqiU0++0MJE0+vLrZ+gydEc82f0
	 3I0MsBOt+pXoc59bXMxJBUHMiJ7lG+RVGTVoNCdC8kF6mKxNuQ8kDMezN1K2lvzOh5pgJ
	 fY7hX/sVqg2C8WH0SHnLXG4gmC0W13lvlT6EBngoKf3hJVNHdmT8PjbWG4u88eRK7Bw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=tP8BTgr5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64DDB606A31C;
	Mon, 16 Nov 2026 09:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=tP8BTgr5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 728A31F000C4;
	Mon, 16 Nov 2026 09:41:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1794822106;
	bh=doTb3+6760LyHkJLv51ETQTO2ku1Db5vB98zHM1U87o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=tP8BTgr5EYmm3Lh6mkM/XBOFuIV0Rr3l0tsk8XTLa2pUYmACVmP5647Ds5QURB/MN
	 D4ZRvlJ/P2Kaid+s/uACDxkHlrcTgV3ky5M20Vd6c8oOszMYeuKfi1+I0ZHx9HkqAL
	 +F2TWJjCJjsy+at2Zlp+PkOoljvwjKJZnAKZ0v/w=
Date: Mon, 16 Nov 2026 10:41:43 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Leon Pelzmann <brunonick1801@gmail.com>
Cc: sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com,
	linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: sm750fb: remove ineffective sw_i2c_wait() busy
 loop
Message-ID: <2026111622-vision-dollhouse-f72f@gregkh>
References: <20261115215427.112315-1-brunonick1801@gmail.com>
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
In-Reply-To: <20261115215427.112315-1-brunonick1801@gmail.com>

On Sun, Nov 15, 2026 at 10:54:27PM +0100, Leon Pelzmann wrote:
> sw_i2c_wait() is meant to insert a delay between the bit-banged I2C
> operations, but it only consists of a loop that computes a value into
> a local variable which is never read. The loop has no side effects, so
> the compiler removes it entirely and the function compiles to nothing.
> With W=1 this also triggers:
> 
>   ddk750_swi2c.c:95:16: error: variable 'tmp' set but not used
>   [-Werror=unused-but-set-variable=]
> 
> Remove the function and all of its call sites. The I2C timing is not
> changed by this: the object code of ddk750_swi2c.o (x86_64, gcc,
> allmodconfig) is identical before and after this change.
> 
> The W=1 warning was found by building the driver, and the change was
> prepared with the help of an AI coding assistant (Claude); it was
> verified by comparing the objdump output before and after the change.

Please read https://lore.kernel.org/r/2026080354-skater-urgent-31b2@gregkh
