Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A20B7FBD9
	for <linux-fbdev@vger.kernel.org>; Tue, 23 Jan 2024 17:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706030438; cv=none; b=SW4nvEEmp0iYQwqtJiVHFzfR+mFOE0uCuwi3ILCVDPaCoTEc00T+q1AJAD29Ao0ixgrMXILHW6M5MFuN9PCfKOJRM828M0WpB1zuAkJP3Smx90a4ojFnxoO0mJqRPU5mjByXkyEVi1vT7CIsctFS3QCkWChsyM7PY33YwxAtmqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706030438; c=relaxed/simple;
	bh=tqYXrsvbaMlrmoMHzhpki5Mt71I7zZeWsiDaURT2h3o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rh2IgeQhVwoHBVlfDRRZasVWmOgohlELAj+9izczRSJVhTD9OI9RVW9KzM4AobXuT5M87whi/E3ZPK+tcM8kZRb/0Y0kEhRvocQHqgajw6FFPRRDmgg31Pt7ff/BVgcGi4Kv1AdfCTUBXCCgAwWRZ5OCLacIsa5WbfPU4WsGMPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rA0LXFpr; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rA0LXFpr"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-40eb033c192so12835275e9.0
        for <linux-fbdev@vger.kernel.org>; Tue, 23 Jan 2024 09:20:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706030433; x=1706635233; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=tqYXrsvbaMlrmoMHzhpki5Mt71I7zZeWsiDaURT2h3o=;
        b=rA0LXFprZhz8Z4Y6F0/C884hx/HCE+elxLKLv72xU+KwRRBViEU5csF3539WCvbxVy
         MaINguGrb7AnLQWg4CjkJQmYajl0O2qCtq4Rnhiz2b9uIzpwBEnQo6f9UiM1En4p0vUt
         cL9gFVRMZ4YwbK5mb+ugSoAdwpEpUDp5WMwHGMUoxjXsZCTWAeg4svvfBQxNYZK1pJOL
         fF5Yt3//8NPCeCfyAFgOPFrrvlH3O+DiVJ5XqH7bFRRaB39EnVjdrAucCUo1JL5iC8CI
         FBQOnqNgiJKauTwZe7z4lN58IiqOa14LcOWHnAoI66muRZ27W1YkgLMoWlvmODVUIJQA
         D8xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706030433; x=1706635233;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tqYXrsvbaMlrmoMHzhpki5Mt71I7zZeWsiDaURT2h3o=;
        b=Lmf5ssHnbWzoeNrosJ8c+558eQqLoftzWg3WcT1yNSCHMxlQ+LcoibitkxTenWq/Yk
         ZOi4dRCNSp+S0oi/FqNGl0E6+1vq+2JzQax8bK8D0toOtcV9vN1y4j8QSCEYM33jGOy+
         jJZ69O1opZtf/ZAuQv9ErFQ8LwzCFlMIefu6vapwoZ/0dP1At4VfRSyUnP+JIuWETpF8
         0kXeLv7osXJOiqXxDKfR1jpwT1bn1Ws/vVGtaNgyFCZEcj8DA5w0pR+L4Hmg/Ep/m7gr
         F7jQM5NDUbASodr6d9lPOBZQiWHphpi2+tuROydjiBWMO2yFPUzaXsmvIrXSV1qT1XX2
         I5xg==
X-Gm-Message-State: AOJu0YzIxlZ6Nxmhk9LAZKTWworiiuPqptks3hdLWN4BAdsMdUPK1gu/
	UZdaN3OPKFgrwaGXY/F94nImGXQppwjMUee27lZpVihKgwwBdeWECoQLqB4Vl8s=
X-Google-Smtp-Source: AGHT+IE0+DZQGCS4EN1BBZgSwkTn7W+MJDfyHXzr6PStwtw6b5GaozKJv9t4TXOiNKfsBfmbOiSaIg==
X-Received: by 2002:a05:600c:2310:b0:40e:4c31:affa with SMTP id 16-20020a05600c231000b0040e4c31affamr329334wmo.138.1706030433353;
        Tue, 23 Jan 2024 09:20:33 -0800 (PST)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id r20-20020a05600c35d400b0040d8eca092esm47199795wmq.47.2024.01.23.09.20.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 09:20:33 -0800 (PST)
Date: Tue, 23 Jan 2024 17:20:31 +0000
From: Daniel Thompson <daniel.thompson@linaro.org>
To: Duje =?utf-8?Q?Mihanovi=C4=87?= <duje.mihanovic@skole.hr>
Cc: Lee Jones <lee@kernel.org>, Jingoo Han <jingoohan1@gmail.com>,
	Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Helge Deller <deller@gmx.de>,
	Linus Walleij <linus.walleij@linaro.org>,
	Karel Balej <balejk@matfyz.cz>,
	~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
	dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-fbdev@vger.kernel.org
Subject: Re: [PATCH v4 1/3] leds: ktd2692: move ExpressWire code to library
Message-ID: <20240123172031.GA263554@aspen.lan>
References: <20240122-ktd2801-v4-0-33c986a3eb68@skole.hr>
 <20240122-ktd2801-v4-1-33c986a3eb68@skole.hr>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240122-ktd2801-v4-1-33c986a3eb68@skole.hr>

On Mon, Jan 22, 2024 at 08:50:57PM +0100, Duje Mihanović wrote:
> The ExpressWire protocol is shared between at least KTD2692 and KTD2801
> with slight differences such as timings and the former not having a
> defined set of pulses for enabling the protocol (possibly because it
> does not support PWM unlike KTD2801). Despite these differences the
> ExpressWire handling code can be shared between the two, so move it into
> a library in preparation for adding KTD2801 support.
>
> Suggested-by: Daniel Thompson <daniel.thompson@linaro.org>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Duje Mihanović <duje.mihanovic@skole.hr>

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>


Daniel.
