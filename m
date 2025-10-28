Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15CCE315785
	for <linux-fbdev@vger.kernel.org>; Tue, 28 Oct 2025 12:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761655880; cv=none; b=eVkF0WcueBqU4PTAhnIts4vJohO/aw8vTHMf9ck1VjgI+xOzPJfXcG0ggZ+EupgWq02HwJHSOZ+NgMZsCnoydH4Oqd8ZJ6MWtC3Zb0yTf1zrTq5lBJC9XsU5Zr2ARu7rG1ClE6bxtqfQf7gUcr7DorjGs71ygIWLbMneyvaiy2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761655880; c=relaxed/simple;
	bh=a2I4ejkEHJFUuiRyo4e3fbDozENBl6FYPGmLOAYLdDw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZqGd3HCaDt0w81ROgrBHwgXyTa4SfvYBJ7m3QPy41vImXLOX9H4UDSG6cJGuHzpN0FMG/G/oKOHwx3WcSyQsIDFzPbHs65/ehnQWqObhKIi/SnYfBfarUSeovLlq2hfnao2fTGIgAOAuJ69F+jrGm61SFUJQXspbyAHFie5tMRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=yVDKtrFY; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="yVDKtrFY"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-47109187c32so32551285e9.2
        for <linux-fbdev@vger.kernel.org>; Tue, 28 Oct 2025 05:51:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1761655877; x=1762260677; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=a2I4ejkEHJFUuiRyo4e3fbDozENBl6FYPGmLOAYLdDw=;
        b=yVDKtrFYAGqCnjcBkWDl1S/xl3a2ReUFD46DZSGwLpI6jbII60zMQ9afV85RHc/8zF
         aYP3gP2dfP8HIjSK3z07yPSIqj/SclmJSP3UfBE9y1k9YK2uqQKIIHcnbqTh1tqjV3xe
         PWFNh660by/rY8ltKnSVwz9SystN+0NUcqLvQv7O31rTqauYfdD1ma36jld5V22Ma/kU
         fjprkLwFbv+X7SILFdfd6aQqkvMCXxR38eELsgxA2q50gRuNDkqEqEMEqcWHVlnI5wh8
         rJo1mT0nhjfDh72Fsm/aWIZULDNFyAneEHmsx7geLC71q/1TlxNjeLQYBuDdOHqVmFr9
         mnvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761655877; x=1762260677;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a2I4ejkEHJFUuiRyo4e3fbDozENBl6FYPGmLOAYLdDw=;
        b=RDxx/tjknaQ8/cWVI3e5sTk/p6vW/uY59TmRvZAj6srrBt73MbJDUs5S6i/LIILx02
         OaAQA86JPetmKBUxx5KagOEvIw3A6D8GK+B6m+2Wwb2tggn62WV3TmMP5Wte4oLzyuMW
         NdMlUBvo/a3A+Nvo1S8XlJag6u0Rxeb3aa9xVDG/PPmwCQ/bh05P0mQteHAhXAsJGxMG
         AIJ0a76zp4A19OSkgIOFADfNqLcYq2Fd46yjm0ggnfg5s8/bZw3npKMF+5pBQvOt/45R
         W+mdQXkAINtAwHBjF4bGVwHQUllsx47Xne3q4lCEzcU8eN9y6G2UBwhzsbkH3HImAjAP
         Gwng==
X-Forwarded-Encrypted: i=1; AJvYcCXcGk8gyx6bho7tj7Nbf9FpVZj6Fk8FNsAmMG8SxJkcyB4OVicU9mGSusZFYFXd/DwU2Nnw6Q2RI9/SIA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwdoMrVIsfWbLb+Y4fSpR7MMhBFk5IkTAQEaEcYFjknLEq5O0jO
	0Mapyr8yWgv8SJPocwJl/ljiVOxSuTKmG8CBfizKSJ7dSBt8rFw6u8s+otaBijxqCUw=
X-Gm-Gg: ASbGncvyzdftjPwDP9g1nlNwf6dXTdX+BdsNycoYwTTUKRZGsIywAF7WiLJpAzugA/0
	jhQEvfJyfDWvxBj4Pqtgy6gARJuYFuAWrrS1QHnVtGyyD7rw+Tix+t3XaVB5JGNSj7Ny3uH3/qi
	UiFpX1g6zhCGETM5UOkwQCfsmCfltSKOsFzRAzNK1qBLiG5cR1x/kH8C3G/43Tgzm9heA/Pt0ej
	LC8iXPC3gePfqFB0o1BQ0lPWFP39Anb5Ze7ELima0nDPTPdgMxQM3vFLgU/Fop0bK+zGzVb59Y3
	Cw8Dmg8nSiVMtLfHlESnYKGxnV5NJWeno6FCgvCdDsD+/iDYlUuQhKCr1spPD/Ty+HrjMhQ5ks+
	xsvWdibJeaVtzpPaNoQvYTqrrtyhcIaB3vJIAthtpn4w0eINxuKbbH00g7OnIJXegC38UyRP+T9
	ZaPKUm3Ww4mn/+EgxlIROJiCboEzkEgrYnHyUj1z7aOdLCL41rhFv0KSGNxak=
X-Google-Smtp-Source: AGHT+IGj17wXVLJVImH23lwqcOG2/t4wVchddocpSe5VZMuncdh0FaPOQTztffjz3tOnEKdIdlVmpA==
X-Received: by 2002:a05:600c:6218:b0:45b:47e1:ef6d with SMTP id 5b1f17b1804b1-4771d043763mr5450425e9.36.1761655876812;
        Tue, 28 Oct 2025 05:51:16 -0700 (PDT)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47718ffa42bsm19014515e9.4.2025.10.28.05.51.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 05:51:16 -0700 (PDT)
Date: Tue, 28 Oct 2025 12:52:09 +0000
From: Daniel Thompson <daniel@riscstar.com>
To: Daniel Thompson <danielt@kernel.org>
Cc: duje.mihanovic@skole.hr, Lee Jones <lee@kernel.org>,
	Jingoo Han <jingoohan1@gmail.com>, Helge Deller <deller@gmx.de>,
	Randy Dunlap <rdunlap@infradead.org>,
	dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] backlight: ktd2801: depend on GPIOLIB
Message-ID: <aQC8eZhHIueu7Ub8@aspen.lan>
References: <20250411-ktd-fix-v1-1-e7425d273268@skole.hr>
 <aQC1iJlm2jS479_0@aspen.lan>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aQC1iJlm2jS479_0@aspen.lan>

On Tue, Oct 28, 2025 at 12:22:37PM +0000, Daniel Thompson wrote:
> On Fri, Apr 11, 2025 at 07:22:18PM +0200, Duje Mihanović via B4 Relay wrote:
> > From: Duje Mihanović <duje.mihanovic@skole.hr>
> >
> > The ExpressWire library used by the driver depends on GPIOLIB, and by
> > extension the driver does as well. This is not reflected in the driver's
> > Kconfig entry, potentially causing Kconfig warnings. Fix this by adding
> > the dependency.
> >
> > Link: https://lore.kernel.org/all/5cf231e1-0bba-4595-9441-46acc5255512@infradead.org
> > Signed-off-by: Duje Mihanović <duje.mihanovic@skole.hr>
>
> Reviewed-by: Daniel Thompson (RISCstar) <danielt@kernel.org>

Ignore this... I opened up my mailbox with the sort order reversed!


Daniel.
