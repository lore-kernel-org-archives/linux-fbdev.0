Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794400874;
	b=dKmGKFTd4GvNFGgfWxKCL2pcTsz7Cvr01L7BuE2sPIk3Dj/8tAODbimf7wdX6QTcN3tt
	 ho98kbK+A+CyiHrQ48H77eIh84c9dr4x+q9GEAVnm5Ua5fAyq9gsqKEZRDEH94isvfqDG
	 o6zTv0mFXtxNJnpju5hJb02a2H3SiCbkgpMy0SxN187um+5tlC8vDpPI70MgGgOIjONkV
	 tdqaI8RGKjqEheY8Ya4KITisVX4drzXYZQPKGbZ0i0ehSJUa3Cogn3imqy6sTPVN2xtZT
	 teWcvsTHsOtn2ho/oQNXy1f0Ak+px7Qe7FFFO4op02Fut4S4wJ9nCCzMVOREy2YemXA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794400874;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=Hqw355eWcLP2IhrR1rvrrSe1NgJExHjFpju/gucphkg=;
	b=YBx6GKnpWPXndXM4e2kx9pfx24WDsNViL4KINMusrRvIAmjwKsUIO4RRv8SiHSpGt/w7
	 +CffS407ZManM8mUg46ZnRshVe9dg7qkK1apRQxRqZqXLH3cMJOXyg5yuHrsdroDvsQ/z
	 8eiqkzXzG1E9wV4t/zycolFZDypADN/5d/T+LQhhYi2d6ogmOKcwrez5Qm2AtHs6EyBMR
	 TqeujpARcy44R3EeoF3T4v5Jhk2DNR8LAoO5SVznVq6YxbhG0C07gQvvJx6hgCJfe02Ab
	 mBZhcPR86b07XkIKzb4pEcWGwO2ZzbI9HxKaEhSixxECcowWqoQjX7OKJ6w7UeZrmBQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Sy+hubuP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F315E606A321;
	Wed, 11 Nov 2026 12:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Sy+hubuP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D46CA1F00A06;
	Wed, 11 Nov 2026 12:41:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794400873;
	bh=Hqw355eWcLP2IhrR1rvrrSe1NgJExHjFpju/gucphkg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Sy+hubuPvpqnweZrL1Lr/AyHyj/APQUd3Zs/ZrbyAcQSyBXHXqDU6zjU4tOgcsBm1
	 FmhPevTIUrE9w4/YaRhi3MGMCslGVYVtuHwk9J/HVozCOoaRVOX4c6OaxPnZH/eFAa
	 MYmtxX+TNenBy8yr+xsQ1ZsvbhZlEODydJ9UNXR4XMBp3L54R67m8mlrcCzTzy6KNf
	 sn2zkzaupVd0HhXjoJF51dDE5wc+F562TtwfXfVBiVxwmhr+ZijITjkE0cygWF/sVU
	 ndSF5uNTBPa4RGsBiUGtVSvW9b5XrK6wrO+7U/o8HWJQwKEmN4fAoatsAo/39wojJb
	 2rAX/63GPBR+Q==
Date: Wed, 11 Nov 2026 12:41:07 +0000
From: Daniel Thompson <danielt@kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Roman Vivchar <rva333@protonmail.com>, Lee Jones <lee@kernel.org>,
	Jingoo Han <jingoohan1@gmail.com>, Pavel Machek <pavel@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Helge Deller <deller@gmx.de>,
	dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-fbdev@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: leds: backlight: add Kinetic KTD3137
Message-ID: <avRiY-8Fw5ZdrkBH@aspen.lan>
References: <20261102-6768-ktd3137-v1-0-b5b4f903c56e@protonmail.com>
 <20261102-6768-ktd3137-v1-1-b5b4f903c56e@protonmail.com>
 <aunqGVkX7-Y61iDA@aspen.lan>
 <_kyk4j6fx0PX5QqVrjAIGH-5fzUhj-fKhD8YT4F734mCOnQCDXui6wQB77AOka69_gblWOJN2SxzC5OSrH1lXiQeciLfVnWuPHS0JfaMKD4=@protonmail.com>
 <aunyu4ToQ0T3b2Mj@aspen.lan>
 <CmvbeteAqxtpenZUmJ4dqRvXYjjDzTTDevRB4NUlN0WGLOUk0jwzt2C3ZtuZ3Eb2UwBDEPUWpu9biU1OOhKGWQITolX96cFXolBTMgSyh1c=@protonmail.com>
 <auoVaaZjcnRTj1S9@aspen.lan>
 <3bbc1c1a-0435-4cde-a1a2-a408bd7a794a@kernel.org>
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
In-Reply-To: <3bbc1c1a-0435-4cde-a1a2-a408bd7a794a@kernel.org>

On Wed, Nov 11, 2026 at 01:11:13PM +0100, Krzysztof Kozlowski wrote:
> On 03/11/2026 18:10, Daniel Thompson wrote:
> > On Tue, Nov 03, 2026 at 03:21:45PM +0000, Roman Vivchar wrote:
> >>
> >> In the driver I've used devm_regulator_get_enable(), rather than _optional(),
> >> since my understanding is that the non-optional helper is a standard kernel
> >> API for required supplies (with regulator core warning and fallback to dummy
> >> regulator in case DT omits it).
> >
> > That dummy fallback essentially makes it optional. On a board with an
> > always-on supply then there is no need to include vin-supply in the
> > DTB. The driver will work just fine without it.
>
> There is a need, because this device needs a supply. How you describe
> that supply in DTS is a different story - can be always-on, can be
> missing etc.

If it is missing (but listed as required) then won't a DT that omits this
property fail schema validation? If is legitimate for the property to
be missing then I'd view this to be a spurious fail

We certainly didn't list basic supplies as required in other recent
backlight reviews:
https://lore.kernel.org/all/20260529-topic-sm8650-ayaneo-pocket-s2-sy7758-v5-1-03aacd49747c@linaro.org/

Is this something DT maintainers want to see tightened up when new
bindings are introduced?


Daniel.
