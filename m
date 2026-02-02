Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65B3B1A9F88
	for <linux-fbdev@vger.kernel.org>; Mon,  2 Feb 2026 10:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770028126; cv=none; b=rBRluRkOZy1okbmtQ+UgI71QwlJVo0RNk+40rOKjZBhKAT9ZfAY7LMDxm4g6utaKagVmP6lIZL42UxIGEzjaFpSE1YPgZEpcdXLI/H1fe14jEcQefHMdgY8Xxbmh2pK+gKX+kXUmx91oyDFdahYWvcM3u6o2aR0BztxiLW1L8RU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770028126; c=relaxed/simple;
	bh=CGixetDr5XeqnxjJDvhNpPyZj8eg9DUKX5ATtM82gGg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kQ5irhpLZ9kCYQjwf+KsjzFJs5zEgl/U64mRl2msNrKjsWMeX/koYIpyVY0qbN0n+Whvpcb3zqkIjSzK3ahoObHG0/X365eFZUjt8w21sf8OS8Og5oM5/bqdmfqzPS2Tre9n+nEY7iQj7AWHCwmMYfBcu6/Ikjz5/90yJq59bIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=Q5H3M+Rd; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="Q5H3M+Rd"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-47ee2715254so22435215e9.3
        for <linux-fbdev@vger.kernel.org>; Mon, 02 Feb 2026 02:28:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1770028123; x=1770632923; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=CGixetDr5XeqnxjJDvhNpPyZj8eg9DUKX5ATtM82gGg=;
        b=Q5H3M+Rd1Rl0brN8K/nBJ30PSRxA6VsPhcF5MCwCck++PNaluTZGT/KBinDazDWC75
         lANgybPLnn79TsnOBvywJIJeQkCD8aws8CYjBFos2MpgGOR2+VRwG55v+doItsWLx51s
         lJsZZFhTQcqbfqDZ+eCINoQ6NbDMDDGZoeqxSLOb6H//ocSvMNfXW9+G+rVaqhPnlv3/
         SXeFVRv2k6JM6wwYTKiQqrUl/x7bcFffKr5ei6HfGZkbagFT7LUx7/vfjblc20VSpvA6
         zhoGGgfg8X9jvquzzSiIfOQS1ZCnniWhJNesOnJamYQwfJvcT5nSiUv1XzXJcIPz2nTI
         sg/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770028123; x=1770632923;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CGixetDr5XeqnxjJDvhNpPyZj8eg9DUKX5ATtM82gGg=;
        b=s819hSk0kB91H6UHfDZxwczfSNR4OSO2DY+Mf7Tlt7aQpp2TOt0D8B+ACW+frT7KXp
         aGhIXNBGAJGgyZZwm8kLJwqedfM4Fc3CyxpHtzruwMbjiz4b9bO5m+OtRK6YvrhhZYuu
         ARnI1gbOQ7L2nZ4ivg4Ec0bWuvuFhVJ9KSdGOBsdhxqx8az3V2pRjk1NwfD+9HvdExmc
         VrDDfvkQuHkAxBsyxQ/MvBs3Z0muHpuq2wyiZchZcUFCVN8gJfgZ1aEf/9WACXDI4uo5
         2lbY9RT7K8PBzsEVWvOkimnxlYXxFwiwTobTYyG0ttYP3VCnHug1RRUWBoyuA8XofaK6
         4tZg==
X-Forwarded-Encrypted: i=1; AJvYcCViscr3D/UQ/ZcHOgt6roUlBO+Y+17VlIqFv4XcQQ4fCj7FM/7qjAjmn6cMfaUz0gCKOxkJn8tUlBaRWQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxEB2tm8xOSQo5xXEtzzRrCDJnX7QRw665B7GSN27pOEf8l+XqQ
	FycF1XuL86yHyu44cfyY6EpQ6jP+7o4K2VuSzUmwhsDnCxwa9rE3BYAOI7rBnHYgwW0=
X-Gm-Gg: AZuq6aI8IayGAAhzAiOk6SCCjE+zrJLnFId+7mdiVpYZxNEAslsFIB5OEbUFb7sLVTK
	92f0h7P2zUTGCzPa0HGE2jO4G/L0kVRJby1MJGlLhde4qUkP3v4LWNqudPOhqtCXX5UPcyniC4M
	iMLSnw2h3nA2kt82uFYOjKJfbGp6gTQ1pqH4GPLLbqtznzcZ41glenrvyZn0Sa/9JkxDF0SvYvN
	6VHAZcJCJevmkE3GTit/WBJ4sXaVBfOlNCLfYLyprW97+bXWmSXr4nsX70AK3FLjclkWDtmHNWY
	S2NeKI+cj21vtwv/NsmlEWND94oN14fzIRaznA4YqYwDIYC/Z16M1yYxRFHwv3PngN238F6tOZy
	pOHe5T2enYnBa/NveOZOXNIzSnAU7BMKDjvQbtuKmi9n8+nNpfC2o7zlilfh7O8KzTEdRo1+V/Q
	CVCnaEaSqWJGAnRorRZc+c+Nw7wwwG6zuX7KP6ADUkI1fKUH60lhiQwBo9zzWO4kh6pnsZp33PV
	R3Sb6CeTY8R7mt9erHVBtYeUaGePqYuUELdcc/RmSXU6z53VFFloNt345Px2h44SwjOAt45NdwL
	iWplsUs=
X-Received: by 2002:a05:600c:34ca:b0:480:3b4e:41ba with SMTP id 5b1f17b1804b1-482db48d595mr129371045e9.18.1770028122637;
        Mon, 02 Feb 2026 02:28:42 -0800 (PST)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-480705956f1sm350132565e9.11.2026.02.02.02.28.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Feb 2026 02:28:42 -0800 (PST)
Date: Mon, 2 Feb 2026 10:28:40 +0000
From: Daniel Thompson <daniel@riscstar.com>
To: tessolveupstream@gmail.com
Cc: Krzysztof Kozlowski <krzk@kernel.org>, lee@kernel.org,
	danielt@kernel.org, jingoohan1@gmail.com, deller@gmx.de,
	pavel@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org, linux-leds@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: backlight: gpio-backlight: allow
 multiple GPIOs
Message-ID: <aYB8WPTUXHqfZpyH@aspen.lan>
References: <20260120125036.2203995-1-tessolveupstream@gmail.com>
 <20260120125036.2203995-2-tessolveupstream@gmail.com>
 <3f3c47ea-1660-4bd4-ab89-3bdf58217995@kernel.org>
 <54d156ba-e177-4059-a808-2505983b4e2e@gmail.com>
 <500b603d-5abc-4c45-8d56-bbc88fc85b83@kernel.org>
 <aXnxGPNtk5BwoJOu@aspen.lan>
 <304ef935-e82b-4556-be3c-6ec4f57cf68c@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <304ef935-e82b-4556-be3c-6ec4f57cf68c@gmail.com>

On Thu, Jan 29, 2026 at 11:11:34AM +0530, tessolveupstream@gmail.com wrote:
> On 28-01-2026 16:50, Daniel Thompson wrote:
> > On Wed, Jan 28, 2026 at 11:11:33AM +0100, Krzysztof Kozlowski wrote:
> >> On 23/01/2026 12:11, tessolveupstream@gmail.com wrote:
> >>>
> >>>
> >>> On 20-01-2026 20:01, Krzysztof Kozlowski wrote:
> >>>> On 20/01/2026 13:50, Sudarshan Shetty wrote:
> >>>>> Update the gpio-backlight binding to support configurations that require
> >>>>> more than one GPIO for enabling/disabling the backlight.
> >>>>
> >>>>
> >>>> Why? Which devices need it? How a backlight would have three enable
> >>>> GPIOs? I really do not believe, so you need to write proper hardware
> >>>> justification.
> >>>>
> >>>
> >>> To clarify our hardware setup:
> >>> the panel requires one GPIO for the backlight enable signal, and it
> >>> also has a PWM input. Since the QCS615 does not provide a PWM controller
> >>> for this use case, the PWM input is connected to a GPIO that is driven
> >>> high to provide a constant 100% duty cycle, as explained in the link
> >>> below.
> >>> https://lore.kernel.org/all/20251028061636.724667-1-tessolveupstream@gmail.com/T/#m93ca4e5c7bf055715ed13316d91f0cd544244cf5
> >>
> >> That's not an enable gpio, but PWM.
> >>
> >> You write bindings for this device, not for something else - like your
> >> board.
> >
> > Sudarshan: I believe at one point the intent was to model this hardware
> > as a pwm-backlight (using enables GPIOs to drive the enable pin)
> > attached to a pwm-gpio (to drive the PWM pin). Did this approach work?
> >
>
> Yes, the original plan was to model this using pwm‑gpio, and that
> setup worked. But on the SOC there’s no actual PWM controller available
> for this path— the LED_PWM line is just tied to a GPIO that’s driven
> high (effectively a fixed 100% duty cycle). Because of that, describing
> it as a PWM in DT was flagged as incorrect.
>
> As pointed out during the SoC DTS review, the correct path forward is
> to extend gpio‑backlight to handle multiple GPIOs, rather than
> representing them as multiple separate backlight devices.

That not quite what I got from the link above. There is a suggestion to
use gpio-backlight, but the reason it was flagged is because pwm-gpio
was unused... it was not referenced by a pwm-backlight.

Having said that I suspect it is better to model this backlight controller
on this board as a gpio-backlight because from a backlight controller
point of this that is physically what the controller is composed of
(assuming there is not sufficient capacitance on the signal for a
software PWM to work at anything other than 0% and 100%). Even if those
GPIO signals are connected to the panel's PWM input I'm not sure that's
relevant because none of the backlight controller bindings model the
panel anyway.

Whatever route you select, you do need to make it clear in the patch
description *why* it is correct to model the system as a gpio-backlight.
Deferring to (potentially ambiguous) review comments is not sufficient
to explain why changing the gpio-backlight bindings are an improvement.


Daniel.
