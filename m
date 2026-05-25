Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9D0F34A786
	for <linux-fbdev@vger.kernel.org>; Mon, 25 May 2026 16:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779725634; cv=none; b=pEGE6gnKYhyzNQPcIco1ae8Q0BKFYlpKkmgscCL5Sy76Hkuzld0oQIQqz8Q9X71JFDYUG6Bm5bxjOJUkiy7yFgYGGqWl16yZeGMkbxiXuLHhtN+8HKVTYvYXuwXMy2eTEZYnxAi4dQi35mJRajtTGOITZUY1F/Rz48AYIcwJMT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779725634; c=relaxed/simple;
	bh=JzjiaMqvE6FAwKJVfStKuwbHiv1l5iHnK2iRBi/Jtic=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=brQeIaBP3z4OA5sMxtqgrDL4JBYhW/oW4/jca6NqcAajLQ2VUxWWasxMaQOdua5s8PhLQvbrIyZd+8px2JEJlfcEWfl6hVVNDHal0a1dfaU9C1Dx2mmcHVUNNs8dAgxx4ils/UVqWa92Dte7luEMRgBKkoJp3Q7nhOL4Ga1zZrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P9igVaic; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P9igVaic"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-48a563e4ef7so71983245e9.0
        for <linux-fbdev@vger.kernel.org>; Mon, 25 May 2026 09:13:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779725631; x=1780330431; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gmb4w9ug6rV3MhwyPHJsQp6I0uLZIGzYTMG8YoeZqok=;
        b=P9igVaicxryAXDr5qsu+pQ8i3X+blGg4WzaIAOHE8xDl04/ef+WJBBZiP2GJG8J/dq
         l5XD7qqbncGTQTSkyafzLGh1lkN7nzyXSBuKvjKhIRXWmsk+LVQv9T0gU4yG0iPC0/w/
         MC/SgXNS52CGocufGOEQt/UApnRICNqSqMxzX85towwirk181zIgpnKaEvc+AXHqMQiv
         v4Nw+xUKbF9orNAMqDJvbtZCv7QEOGQwk7x23hPM86KY4GJqxVVCziQ4Ie8dxO0JCa6l
         5HGJjl1RQ6jnXFFE/t99uSIVf24Ei5WIsgmPWhMrwc7bcX0SiKCOXsHrGQ1TpXa1tV1E
         3Wiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779725631; x=1780330431;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gmb4w9ug6rV3MhwyPHJsQp6I0uLZIGzYTMG8YoeZqok=;
        b=fBg7WQvZdP4xwtLg5pu42agZ4ElYPyTRu/hj7sl0sAeDyXXCH1VmDasxivk9iv0uRS
         u3QJQo3daae/g8ixXktcL7piuDEKl9pVbfoCCQWRXKhVgLv25nqiBCYyZ/0uoe1oYJ6s
         ht4hr4QsiQWS0Ibn6DlPva99ZBbUyx31JtwTuRCsohni4R32DIv4BAVpChsh/D4tCtRs
         qSQ80yygBZVkI0YTXV29UJhK+CfDNyKym6+/VZ007OvPJTNGqGFhdH5DFqM/FusQpuFE
         qNCmeYM358g45CdeqWr9JrINLt8S2JIWnauNpfxJDIgw8moL6GaPP5JCviQXu0EEpT/V
         Nd4Q==
X-Forwarded-Encrypted: i=1; AFNElJ/dR2iN0aACBVPSjRBHYeVszEeCfYynUW3rSQYfc5mXqAQ5PxbvZMG9NcdrfWTWOX71INaaEruJtRcJDg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzMVC9dt0PRPovbsF8QMaAUpocxfWpoYWjU66Q2XjjiGazqUJGK
	PNVlukfDtg1rrLt2fcyIpYuCjZYaruxPHfZKDCjx4IWFpeR9bYRKrIeW
X-Gm-Gg: Acq92OH+BSZr0yPUnLsfG6O6KCm6mH9R8LKs94iAcsmv/O/sKyWEe20xkpm8d90jKoe
	ugyTRzrFgkuzUpu8rI/z1aXc2J9mO0nXY1Kiwv695U6lhdd6yL0x0vwyWMd395Wpezn242ppujK
	FgV5+1S+l4awBzmzuxISRLXIT5duOwCebHqXdE5ppBJWKV0vtDAt1+8rz5UYWJ3DTCY/3I+RwIW
	AbDX2pcfhwzakCSbohyDfn0sJDYI95e84MrlcFmYg7hxTOI/kQRP0/tqA3S1yWK2hq7yH46aARR
	yRZUZMqN0MB42tg3e4cGnPnMMVRsbjjcX4w8rwE4c3jwFhAHZVciYN/p6tK2S8lpt5cXaoxa40v
	UMPlSfM2WacupwpxA4SBgktqkw0KhVDM0HUPKeB+kzHm14eAEJ0pakgRtkaGCrsMqsQipXAVVqL
	RQAauKE8gz0Cp8qMOQ5JV5fJQ=
X-Received: by 2002:a05:600c:8b84:b0:490:5466:8576 with SMTP id 5b1f17b1804b1-490546689a7mr190155205e9.1.1779725631134;
        Mon, 25 May 2026 09:13:51 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4904179c615sm90065985e9.4.2026.05.25.09.13.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2026 09:13:50 -0700 (PDT)
Date: Mon, 25 May 2026 19:13:47 +0300
From: Dan Carpenter <error27@gmail.com>
To: Ahmet Sezgin Duran <ahmet@sezginduran.net>
Cc: gregkh@linuxfoundation.org, linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/5] staging: sm750fb: deduplicate fbinfo loop in
 suspend/resume
Message-ID: <ahR1O_dF9XyVEmPo@stanley.mountain>
References: <20260523051509.166152-1-ahmet@sezginduran.net>
 <20260523051509.166152-6-ahmet@sezginduran.net>
 <ahQB8C1gTr7LF0FO@stanley.mountain>
 <86216e7d-7867-4041-892b-aafeb39781b8@sezginduran.net>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86216e7d-7867-4041-892b-aafeb39781b8@sezginduran.net>

On Mon, May 25, 2026 at 11:23:43AM +0300, Ahmet Sezgin Duran wrote:
> On 5/25/26 11:01 AM, Dan Carpenter wrote:
> > I was waiting to see if anyone had other comments bout this patchset
> > to decide if I should mention these minor nits.  But then I was
> > confused about v2 so I think there might end up being comments... :P
> 
> v2 was only about dropping another patch from series, no change for this
> patch. (would be better to talk this in v2 mails, but I guess it's no big
> deal.)

I thought you were going to to abandon the ARRAY_SIZE(cdb) in v2.

regards,
dan carpenter

