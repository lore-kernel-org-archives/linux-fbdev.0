Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792994547;
	b=OF8BgB2wvkAmJwUHBikIb3+oJh3wfk3rQ3Gkiv9+jjFHxkSyQnVa3RiONGuuECsy+X1/
	 rGd1thfxCn0SKZFxCENlggIFxJrIdLk2OA6WlUO+GeqAucn3s0jRiDdsACP5RoGD/D5+Y
	 LrfNRlMLOIeQdHKPZj2vXKKf1wgiqQUzBO+aQMsqL5ceuel3MptrI/TBFzxTvSn+69PXC
	 oF9p9W3RksJTk4Ttn/m5HRM2nt7l9qPzskmHAgOEiNgbquYnFMcn84NgR1y1nfAKIvpK/
	 guoovKQdX/DlpsZbtCli7qoqdHU9Vr+m02Kk0PaBhCzkeAEJcdz8wPI4b+4urwvearQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792994547;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=3yaOxFuIZbizNooBA1VEmbpRjVSQUGZB/XbbboKN0bg=;
	b=QalJZa+glZl/doOxOI5A7ABTu895GY4B2SkIVfw3LYO0HnzEwskyC56f6RzhYAWdHBhB
	 tP3g0KHz2KRdI1hpVFKt+EEWcl7tDtExxgrroYNdCNL0RhZwFZvrgV8UNPXdmjInWUrpm
	 AAHegmRll8P85FFo/fTcfDBxAhYqRFR03tRJcHDRpN2HtgiEEnd4JdVpJi3E20enRk7Xz
	 WJ02I2SHBYHSTVl6ryc0GJyNNU6jq5KrJtZviwTz/Z7GNEB0V82pb/9VfLv9q0juwjxh2
	 MPLvftQsDUq9loDpfJHi3nC17iXfJf+4L+iCX1sygNf+cpRguPAurAZXiNeeIAwupHA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="ei/iLWIL";
	arc=none smtp.remote-ip=209.85.128.50
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90114606A31A
	for <linux-fbdev@vger.kernel.org>; Mon, 26 Oct 2026 06:02:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 90114606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ei/iLWIL
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4a5720b0a57so3428345e9.0
        for <linux-fbdev@vger.kernel.org>; Sun, 25 Oct 2026 23:02:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792994546; x=1793599346; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3yaOxFuIZbizNooBA1VEmbpRjVSQUGZB/XbbboKN0bg=;
        b=ei/iLWIL/PrmmLeI4AIopw+UGzJlXl2GkCswSr7yE1+sdiV54f7cirKsZ0wqwONmMd
         uIWd6QxYO8q4/rZC1RSQIFx9fSQtabC2IaLbx5fnZTFR6tZCED3eiulwX0M0JytW9dm2
         Gr6IP8B90nNHmXqBM64QC1czF4sZ8NDBsJNMw7Jwm+8W3MVOwRHeV1mJ7HdxVN4l5oVJ
         6yIDwK9INWCTEfOFakAWyzJf6SWFXhjnet2AAdN0EuhUw7s/9NaD8/Zdv7B/yiWaU1TM
         HOFQCWPXI92Tu0a/43IEkPgwf3ZU1vHLq6diLy9+BdM3VEz+z2/ni8NK6/M20HgAjL47
         sRhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792994546; x=1793599346;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3yaOxFuIZbizNooBA1VEmbpRjVSQUGZB/XbbboKN0bg=;
        b=KLtiJaeOr8jGmUkL6Wud73gNvRwSq5cpaQmrtKkL5EV1kWjiO1SZ9TV33e1YdjUiG7
         ckIb3H15RxYJP8kSNCKBjwuW67k9rj44EYha52TxaH+0UZzfWiLjXTqGRBbqqwg53pEF
         2xHxz7o5WIgtfCJkxn7LIYLjCRv9P744i3mHo1xjie4p1Mv0tjT1vPmGkSqGVN/68Cvd
         dtOFYTGSvOw1ZLJMgJO/2dDn6IhxnCGu3MI0DVA3UUNl07x2c+rvhRSxzbGC3e/rmVBk
         46R8lkLV1aSw5j5oGb2ckD5MfaycRovZOyyGx03DQXTinR2rlzy8QwFtdk6ewTghwjkE
         J5Dg==
X-Forwarded-Encrypted: i=1; AKwUvBx2wKJggiyfA7WivknB1XOcktEzndk33xWQM08tra5J29ErJdRqi/bvBP2qTh4PfMw8ZI1IoG9kantTbg==@vger.kernel.org
X-Gm-Message-State: AFq9FYLMSRCykuXOC5YF6k5D7HBfO0eOPvmHWQmoLUQjJ3soLxbCoGwd
	VAdwkrfznqW2QsfIqYu6B//5pxpkeHyyso/0A9QJQbBwoc1p26payp7p
X-Gm-Gg: AYBFou3eJCP3bOJQuzspsLm1wR5uRnkwCTFfGMLuhMLurr6Yrhv2Dzaq6hKLQKdvvnO
	RbXtaCS0iypcHi4wlOVuLhGrZ2zvypoFk8XFrIyj699RAj1fXB7/uhsHPH7NeY2Wt+k50wDfco4
	fm+t4BIlimgrZr1D/GhANqSnbKTVHypc8UXKqnBT0o2cG7XJdcTsnnXwwBfjQQl75OKGiKb3LJi
	UPBUCVXsBHXbZWDu+ISw6a/aGC/XdKSG8gRjtRzm0shh4fBjBGq2m7Xhw5hEQ9x8Ql5PE8gdx09
	TEKevHerK7MKtfpFm0xGgCb3VrVVRncb7Q2XduLEG6dVmYLYHv/bNbMI1HOFRt53oFQungZjxeX
	4vVdOyenO5gduKL62te2kgHRPgSPTwSJ4E7ux83rH4HGYoEn9wvxQhdAa+MfRFuN75oGvP6c+1S
	ePM7HLkJQJxJFFFsB+zG8C4EefZzHNnAKI48BrhdAVX6GtG9ZL4h/NzrTrJkjDbg/yLWt/CXlt1
	UQOc0D2lNSNmknCa7DiRxNuHxXhyEqM+wX8cMX49LLNyvRbBBsS
X-Received: by 2002:a05:600c:4e8b:b0:4a2:180a:3417 with SMTP id 5b1f17b1804b1-4a35ad01256mr111335215e9.1.1792994545819;
        Sun, 25 Oct 2026 23:02:25 -0700 (PDT)
Received: from localhost ([2c0f:3d00:6be:8900:ce5e:9212:ea4b:f30])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a35a04ad39sm454920995e9.1.2026.10.25.23.02.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2026 23:02:25 -0700 (PDT)
Date: Mon, 26 Oct 2026 09:02:21 +0300
From: Dan Carpenter <error27@gmail.com>
To: Himanshu Bakshi <himanshu.bakshi478@gmail.com>
Cc: andy@kernel.org, gregkh@linuxfoundation.org,
	dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: fbtft: Fix line length warning
Message-ID: <at7s7We7bxdmmmSM@stanley.mountain>
References: <20261025164003.143864-1-himanshu.bakshi478@gmail.com>
 <at7pu4hldDTgZtXy@stanley.mountain>
 <CAGLmz9JaXM8s4BHQ2Cn5QQdBZpzDXmHyb-GQ_jXtj4Rz6SJOJQ@mail.gmail.com>
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
In-Reply-To: <CAGLmz9JaXM8s4BHQ2Cn5QQdBZpzDXmHyb-GQ_jXtj4Rz6SJOJQ@mail.gmail.com>

On Mon, Oct 26, 2026 at 11:23:21AM +0530, Himanshu Bakshi wrote:
> Hi Dan and Andy,
> 
> I have sent over the comment on the v1 message chain and
> also sent over the revised patch separately as v2, I will be glad
> if you will go through it.

The subject here says we are already discussing v2 so I'm confused.
You can go through my response and decide what still applies I guess...

regards,
dan carpenter

