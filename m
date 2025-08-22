Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64CB86FBF
	for <linux-fbdev@vger.kernel.org>; Fri, 22 Aug 2025 15:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755878124; cv=none; b=Hi18do1z0YwlPVI3yUusW0JpvxIzIWZhW60iTPoM0wZ/EhePZ9uRwORWe1fT/J/ZmRfOu7zmPNK6L2RYowHvjNDPtM/uqiQDjYxIyRdN3rqwhQCcoFOnn31WXgPfzZwlut/QeYanKKaveqAS2BtPUE9G0XGzLN1tPqA2Z/TkyGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755878124; c=relaxed/simple;
	bh=76mE+AoyDKLpWocYWok9AwAG8ucQcvHSiy/Dh64jd9s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C/dwyQEF68/CfoHeB/OW9VPKeHHN8mYADkwc6GO1yxkxKs7AP2+S4w/luKXaNyvLUVGkfU2UL1HRDVF7seCDRzQrgE+XKyNBP4qeAbXAhHvwAd47RtVSxyWaYSxfD8fHzQ6YuRa2wCqusd5iNMG/t27zPJk6PqJq7D3+5Bp47Cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=ZkI+ncUg; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="ZkI+ncUg"
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4c7lBm4S56z9v6w;
	Fri, 22 Aug 2025 17:55:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1755878112;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gqwYpbaGMKmxH1oBKbcuZ4By8WCsIw4GnZB+EkEfPZ0=;
	b=ZkI+ncUghL8atBFhWUngS9x/wGZD+GaPB9MLLrmfukJEsg1sbY4x9XrW+Ph/8kNMW2xh5b
	aSwvD2mJMprRrq6EJO0BvmEBG6ZflqP8FzgnlnKFwchnkk+8z5ne7uoUF1zphDQsVtm5R6
	+6a2dMvoyXCe+CTtIL+cLEB6uC+gNfOPiYTChziDtQoW9EPgaB07zAMOgNkviF1CSz4hqy
	amn5Nlqbp28HzbVmk0PeGWSj48dTE5oMqHsiGTJF9hXyscTorgXZkyhRGQjthra3a7/Im6
	Uifs+9Vlh4++CKzH19fC3WBftGueVUF8hmvwSOHRcZO3OtNcnXt7SwK9LP7eMg==
Message-ID: <913533b5-2384-4131-8a98-a91b73daf490@mailbox.org>
Date: Fri, 22 Aug 2025 17:55:10 +0200
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: UBSAN: shift-out-of-bounds in
 drivers/video/fbdev/core/fb_fillrect.h:100:21 (v6.17-rc2)
To: =?UTF-8?Q?Kajt=C3=A1r_Zsolt?= <soci@c64.rulez.org>,
 linux-fbdev@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org
References: <1fda26b1-f988-449d-834d-b185d3ebf5c6@mailbox.org>
 <9473ef5b-c298-56b1-0051-e10bb3b4dd67@c64.rulez.org>
Content-Language: en-US, de-DE
From: Erhard Furtner <erhard_f@mailbox.org>
In-Reply-To: <9473ef5b-c298-56b1-0051-e10bb3b4dd67@c64.rulez.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: e6034a2dafda1e90aea
X-MBO-RS-META: wpt8ordrt66ihaqu1rxux74ddadr5ns6

> It's only on 32 bit big endian. I don't have UBSAN for MIPS on my setup
> so haven't noticed it.
> 
> #ifndef __LITTLE_ENDIAN
>          pattern <<= (BITS_PER_LONG % bpp);
>          pattern |= pattern >> bpp;          <-
> #endif
> 
> In the 32 BPP case the result is identical in both the no shift and zero
> result implementations.
> 
> I've patched it by skipping this realignment as it's only needed if the
> BPP is smaller than the word length.

Thanks for looking into this!

Applied your patch from 
https://lore.kernel.org/linux-fbdev/20250821024248.7458-1-soci@c64.rulez.org/T/#u 
which fixes the USBAN hit for me.

Greetings,
Erhard
