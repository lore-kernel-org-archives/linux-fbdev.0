Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82FA94B8DDA
	for <linux-fbdev@vger.kernel.org>; Wed, 19 Aug 2026 18:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787163400; cv=none; b=A0efGX6ONufwaDiAsV1sEpxzyCt1immUXKQpx0AXNhAbF6rmoncTHZ4FQt4dy8W2sYUZ2mo5hz0DHsfG8a+3m8jCj7dQMXHzjqMB88TOYTtObt3fhEaLv+db4muzGTAHam2BhMRVlbcjW/ixVB8WtBBuUXfx43vSzF6rbPcQM/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787163400; c=relaxed/simple;
	bh=HKbHUPzIF0sxOi/gVORJXE9q94etDqfM25thtSz+r3M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ac4wEba4SvkCizizyK3JDQEk5dHueZGY1NYBMSkI/HHBL90+U06umRJIJ/v+GbL9LEi7mYY3Rzikod+8RLLKa45/M2TgOEwMHB7HI35nbELjzi63xVpxOMB8W7YSchlXWcDAmIP6zFVycuLJtDwERNDITvUkBzHntlVIYp2Ijv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C6W1nhmX; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C6W1nhmX"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4998e0916faso11055235e9.2
        for <linux-fbdev@vger.kernel.org>; Wed, 19 Aug 2026 11:16:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787163397; x=1787768197; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=etwYCc0YG/dlWmj1ZdGEpwanMrLp6se5hTk1lCrdgCA=;
        b=C6W1nhmXK1z7evNKaoNA8GhjqIanTQAajfVpoN4npra32Ycdv358Elt0Q4VwuQDrvH
         cangDOizZVA89i7wYoLqgQS1rLL7sYGDe95FO9Lzm4XQ5rEaQsXAiV+kLrSeF2e4w+Ua
         KDPiTgM2XbPtnlJw1ZizAXvQU4O2eyadAS5+rs7HZsRhWgqXkQKhqmI0a2LIGCYMtUAA
         O08KE3IgtdhTY3JpwSFd66j2EeTOOUx4HwSjjFCV9dlxxKLY+nzme4YIuQj4qQOUgDXP
         VgP0I7/WdCQiFfcFh/9MQyR7qR8NwDg/cmnfl7Ce9vdi25fzVoeuEEdNT2ZHGye9T2fJ
         +eBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787163397; x=1787768197;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=etwYCc0YG/dlWmj1ZdGEpwanMrLp6se5hTk1lCrdgCA=;
        b=orofymDRBGikSSMX0Ylax/QVU9ZEXY4hp+zYh0zMv10SF1IRzJapCa4WDSuNEOk0il
         u7vHmODAemL5gyRb0ua3yA3nkhwpmk4sZ6+AyjFY0b43yYeZYNnXLOHj0tBDc0NzKvvT
         qOLUQtBrHAGl2VEm5cj/7EDLLj4lqQpOlLDNTtcVTi1+qvJRmWmZaNdBpRYk1GfKDy9R
         vbslpQpvrdg+N/PzK8+V89PsNWaX9T4ItM4ftm5ji1fRxlwfsQ698fZC39k9h41fPLMF
         mLhgg1Yp8Ic6id95iMHIjHd8hypak+fxO3b/W6TWtLFmte/aFbgPcNz0tJYFy9JifWUF
         u9JA==
X-Forwarded-Encrypted: i=1; AHgh+RqCw8EvThK/Vo7u2kD77cuG4GjnZz648/2kLhuKSXCJXbpNsY6tMHkBn78FAdxuSJ3+G6XCIjYQ8Bj9xA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyLQ/edrTRTsPXJgGciRRAdxj2lJ5H7TUccJazahrb0tPm3SyC0
	YUDRx19OA9omuK0dRejkHlhDPv327SJfJmb4wgXeI1HyhTZT4prZOOCZ
X-Gm-Gg: AR+sD12Ouqyt2hJ5KlxDjq8k4GW67Cq25+73OyS8yCPpYcnr0BtiIws7GIXDMlVg2Gf
	Svb3ND/gczUCOzJBwgqagqhxzmUeCFBQU0H7X92Tf8lQNZvWaZmx22+Ti1At/oz0sfQxF1tnFgy
	jOhh1K2liOu7YRklmUe24BBKT5WRqqOhLEx1kIPrXyse3DYs5Ou8gqKem5/gQ4aRXMmWebouxnH
	4sz87YenVoX+6kcMVBgPye3yaU/kIKP+eA0+CX53B9qeJMmat1GqqkhsNuyQ1n3pHla0Yy2DMCU
	YoegS2S9+5trYG+06qjpQPxUuX3Wk+GWlUkfhLp+2fu9VFVJYMhtosEEDqOWC/FSoFDG4c+Apy9
	mcMcifozNsBrGl/C17Zjq7t1LWaiFDnRHT9TkxKFQaJL8udShxNPU+Fr26elVa64uZAX0Ya9o2W
	gjrNbIBWO4GB0Tx57aH+mCYvdowYtE2gVawMMFcKhGtraBIOPxtX0mGKjI
X-Received: by 2002:a05:600c:3590:b0:493:a966:d5b5 with SMTP id 5b1f17b1804b1-499aa14a75bmr129238445e9.2.1787163396476;
        Wed, 19 Aug 2026 11:16:36 -0700 (PDT)
Received: from localhost ([2c0f:3d00:6be:8900:ce5e:9212:ea4b:f30])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499a9e784b3sm67635045e9.3.2026.08.19.11.16.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2026 11:16:35 -0700 (PDT)
Date: Wed, 19 Aug 2026 21:16:32 +0300
From: Dan Carpenter <error27@gmail.com>
To: Tomasz Unger <tomasz.unger@yahoo.pl>
Cc: Andy Shevchenko <andy@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: fbtft: prefer scnprintf over sprintf in
 fbtft-core.c
Message-ID: <aoXzALsRLqyqro8X@stanley.mountain>
References: <20260819-fbtft-core-scnprintf-v1-1-842c0603634c.ref@yahoo.pl>
 <20260819-fbtft-core-scnprintf-v1-1-842c0603634c@yahoo.pl>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260819-fbtft-core-scnprintf-v1-1-842c0603634c@yahoo.pl>

On Wed, Aug 19, 2026 at 06:44:44PM +0200, Tomasz Unger wrote:
> Using sprintf has potential for buffer overflows if the formatted
> string exceeds the destination buffer size. Replace it with
> scnprintf, passing sizeof() of the fixed-size stack buffers
> (text1[50] and text2[50]) so the write is always bounded.
> 
> In practice an overflow is very unlikely here: text1 only needs

I don't have a problem with the patch, because I think making the
code easy to audit is helpful.  However, change "unlikely" to
"impossible".

18446744073709551616  KiB buffer memory
123456789 123456789 123456789 1234567890

spi-4294967296.-4294967296 at -4294967296 MHz
123456789 123456789 123456789 123456789 1234567890

The other thing is that scnprintf() is only for if we care about
the return.  Otherwise default to snprintf().  It's just a more
traditional choice.

regards,
dan carpenter

