Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A549286405
	for <linux-fbdev@vger.kernel.org>; Sun,  7 Jun 2026 17:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780852765; cv=none; b=Zo5c+dqDut/McGumQtkPlaEfvbPTxm9OA6fG161PDAwKKlRiqYWeshF3avCd0chpbuqCsB4AgRfqz37aFN+TCMcI3vlYRS23Fp8lj92QWLfaqpHnoGcaCfUuOpkaHtjIeg8GVkG12AZ3j45B0kKXCISklcQV1xCEplK2z4QCnV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780852765; c=relaxed/simple;
	bh=ykpEPE1mEDQLHsSg8yjADb1LOr1H6XrIljux40fRo4A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YClZ/afTOyrlz4xVCOC/L6e3NyIETDr0t4O0eItc1uQp2DzVvxoRVcH7XIxkq5qFOH343p5wfIU322S0k2cXbhzL+V9YGnLwk+g+ip6nWXF14x8fbIMivo0SDu2JmufsSOdtGnkJJeTECgTFYuD70Y9KrsDuaIx6D+wd2y4NWXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S1NZFFJ5; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S1NZFFJ5"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4908b92904fso40647015e9.0
        for <linux-fbdev@vger.kernel.org>; Sun, 07 Jun 2026 10:19:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780852762; x=1781457562; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tmgHB6tze2Xss/dF/g3O35dG4S4EFs7DvnlvIwWXTEc=;
        b=S1NZFFJ5hOGDqRnpeLuZUMiTntyz3USV8ri9FOJypJeSQvU7sZZu84FyLCE2WD6gzI
         fhBVv8BDMlIeyr6+/E5eDKcjpOoIiMsIAoEiUrbUPPV10Z/kN78gnp6G6So72FVSsZZ9
         qkUagMetQQGCMElDNGcxfznJ34MzcrC5775wVG+SjLX8o/2e1SQ862dqLNpA5KwnwR+F
         xqVtgQ62gsbLRjhS4te5lnbr4j6ZUK3L91hnWwcyywntVZSyTOotZ5Pe+rM3Py358Ytp
         4tfmbxBb8+TB2TQy2Rq9wq0b9CdCLCLpuUgaeg5mmzjjuV9deLmlBuwO79BzbxA6+D1e
         /uYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780852762; x=1781457562;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tmgHB6tze2Xss/dF/g3O35dG4S4EFs7DvnlvIwWXTEc=;
        b=S1su/0U+iHU6v0Epc3owTffwVLhsJ6ihaobm9BDBInByxAymltuKTLAQ8mQbdsEOxV
         N9fyBRlXL1p/VshSbLAdNwN7zNQbXhbqE0X9YSZj/ONl9KqAVaJt/VDPtQFrLrfZx+fU
         MxxTvOJ0zZPRTTvJf1OTQIJErX7JaAg2qDsW9ZnVHwmjRLMTnGzWyXcyP+7AsK6QAzdK
         5pordeaurWceKosb6/pQJBSC9uHtYqrTsERzmT/g8dvJMNrbWjRdl1ewaO0Cvk4lAAu/
         ontdO/NqXGYbDPMWJ+iPy60qSBIj9/jUEIxpEEgQtagYCHwr8k8Jt71TiPQpihMRlo83
         4Vjw==
X-Forwarded-Encrypted: i=1; AFNElJ/JfPVEFMXYN+/5W5HaOAB1xNDaF4MM5suHq3yu5wUK+GUoypZtxiC/5ACEQjMLua2qo51EP+We9doviw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1P5+Hbch/MggqpWVDb74hv1CDL78QehJ0CbXxIwrrOhbMqeTJ
	D1jDUtdeXaAvclJz0583U+IGvCvjH4R6PZN5mlN16/5/HUh18JnfZezi
X-Gm-Gg: Acq92OEUjU+TSWBHS8W87dE+A4dip1JGznR0thKkc89jsnaawXhZ7YckpxrPL2C2jUa
	4x++CgflCi2Atr7uGtbqX6Efi5mUa9/IINi6QakNLZBzizcaYvjlEYQrXHH3uMzAuxmEmjPLPve
	qUIfygLWsWhgFj+qkt2i5DjF9/ZnLcPa6iqbrqPdfev964+abGRCrD2UpPfszext09uCNknLPri
	cs6JvsYrfDjn7DNrmK7TiyeUQ3MOKo7Y6BwPW/9mKoX3AjuI854smj3hWXZkDiYmQ9Ucdh4MG50
	fuJ7nAz/PrjvS/RDIXsLRR+Q+vBOnIihfa1UNn2/JdBgMPUzTluAfgLP810Xa83OJXZmdhZ9Hkb
	g89Gy05YtKkKpyixJ5pq67TiN0KROWnTAKO3xVUuUBxg4tGRZlniLJorVVvqBJqrjEwMlv/dcsP
	TtkHCiUrWjnI1BgkrO2R+mUTHnXs3N+AcXsbaNenPwCNLQOZd7s/QUC/4VPweDB7Xxf6eOusM=
X-Received: by 2002:a05:600c:1c1e:b0:490:bccf:2bd6 with SMTP id 5b1f17b1804b1-490c25f1143mr218800505e9.15.1780852761462;
        Sun, 07 Jun 2026 10:19:21 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490c2cbb4cbsm162470085e9.0.2026.06.07.10.19.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jun 2026 10:19:21 -0700 (PDT)
Date: Sun, 7 Jun 2026 18:19:19 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Helge Deller <deller@gmx.de>
Cc: Kees Cook <kees@kernel.org>, linux-hardening@vger.kernel.org, Arnd
 Bergmann <arnd@kernel.org>, dri-devel@lists.freedesktop.org,
 linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH next] drivers/video/fbdev/sis: Replace strlen() strcpy()
 pair with strscpy()
Message-ID: <20260607181919.2b916ddf@pumpkin>
In-Reply-To: <a2ed1741-f49c-4a16-8d4c-e6698bd3dd8b@gmx.de>
References: <20260606202744.5113-2-david.laight.linux@gmail.com>
	<a2ed1741-f49c-4a16-8d4c-e6698bd3dd8b@gmx.de>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 7 Jun 2026 17:50:00 +0200
Helge Deller <deller@gmx.de> wrote:

> On 6/6/26 22:27, david.laight.linux@gmail.com wrote:
> > From: David Laight <david.laight.linux@gmail.com>
> > 
> > Use the result of strscpy() for the overflow check.
> > 
> > Signed-off-by: David Laight <david.laight.linux@gmail.com>  
> 
> Hi David,
> 
> I've applied your 5 patches to the fbdev git tree.
> 
> Thanks!
> Helge

Thanks, that'll be 5 that don't come around when I try the same test
in a couple of months time :-)

David
