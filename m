Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.70.43.167
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793719313;
	b=N/mHUkJ2cnFSL4Gv1zMhbAUCCiosaUuXKSdpgCepRa426tlJHnwAEDoFqzNUzwW2mAhE
	 hYGYPhLj3MMa8wI2A6FLsbaG7ltIl512klBhdsf7WnzwC7Az40lJKktUgyoj8hmVYzBCI
	 C2bYHnMxDecyjNcM5rgoPE3y6WAif2uRl7trGzPDoQbVgxzfslRWuz3Q/F4z5wWfI2L6X
	 RYFerynsbZ4PnS/CulrEumFSO6kr3wOehHkYa45+Ik+lGXcUZSM/WBImiR75lbu5Zf4CD
	 AHyt411ghmBtSa7vrs3UZZ/0fPdaT5e/RUfi/7eZELxkGY3WfZy1aMiAuSXSAgD8cZA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793719313;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 In-Reply-To:References:Feedback-ID:X-Pm-Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=JoLc0tLRW6eAwNOg58s4xMBjrC0q7X6tzQl25fCbdZg=;
	b=J6SpwgzMGKqeAfzICTfCf+F5YfevyLuUmhBv43uMtjGBJcB2Aqe7MIXWg88OKPW6yy4x
	 A0385awau/V2vRCBDOmDw0wN1p84WWAvdUdFswdsWDrWRo7jG3vrs7x74yZsQHa6UJi9/
	 Ef0Hp4YUIy+X3++NO4xgGPNi39977Q09xCHOBbFa2S6ATNqoTdebDj+OQWRQDnsOlFL2W
	 XOnWLDi4yLVYxn5AZlFUo/TnOyNd19GqsPX90YmSxbOY9E0ATdEZmwMByjXt8KlYNK/sz
	 ZBK15IpU0xzv32aze9kurtmZ7KzguWQGGdVfMFlcRmX/mh14hKUpU5kzHseC/GY0epg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=protonmail.com;
	spf=pass smtp.mailfrom=protonmail.com;
	dkim=pass header.d=protonmail.com header.i=@protonmail.com header.a=rsa-sha256 header.s=protonmail3 header.b="e/28QZrj";
	arc=none smtp.remote-ip=185.70.43.167
Received: from mail-43167.protonmail.ch (mail-43167.protonmail.ch [185.70.43.167])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3139606A338;
	Tue,  3 Nov 2026 15:21:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D3139606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=protonmail.com header.i=@protonmail.com header.a=rsa-sha256 header.s=protonmail3 header.b=e/28QZrj
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1793719309; x=1793978509;
	bh=JoLc0tLRW6eAwNOg58s4xMBjrC0q7X6tzQl25fCbdZg=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=e/28QZrjOVQRoLqSTslqXIOvOiffP9NFF9pzkflb8rM6KNng9cu7YsTrP7Hmjmckx
	 A8rniU86IInlwkzctFBhYYxblnhG1PeBhahyBspgcGZvcuc5rKFrMXo48ppMXt1QiI
	 v6vHmZFOw8c5mvkVOrJlUOMXO1rhasrR3acwgsxzJawwuzYK8O00ALWaD2bTFgy2xA
	 q1BPXK0/z2CU3w6oV/b8IPu9ofsaVA75HnTttUUQ6vqIcuI+MeeBFJMupFvtDdGImx
	 TdaelalJ0ki7FaYssw2y8qnxvM0hHQe4AALXVKMzGDmcl2cFBe+tW4el2xHEErQkQm
	 oSjZiklzPL24w==
Date: Tue, 03 Nov 2026 15:21:45 +0000
To: Daniel Thompson <danielt@kernel.org>
From: Roman Vivchar <rva333@protonmail.com>
Cc: Lee Jones <lee@kernel.org>, Jingoo Han <jingoohan1@gmail.com>, Pavel Machek <pavel@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Helge Deller <deller@gmx.de>, dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: leds: backlight: add Kinetic KTD3137
Message-ID: <CmvbeteAqxtpenZUmJ4dqRvXYjjDzTTDevRB4NUlN0WGLOUk0jwzt2C3ZtuZ3Eb2UwBDEPUWpu9biU1OOhKGWQITolX96cFXolBTMgSyh1c=@protonmail.com>
In-Reply-To: <aunyu4ToQ0T3b2Mj@aspen.lan>
References: <20261102-6768-ktd3137-v1-0-b5b4f903c56e@protonmail.com> <20261102-6768-ktd3137-v1-1-b5b4f903c56e@protonmail.com> <aunqGVkX7-Y61iDA@aspen.lan> <_kyk4j6fx0PX5QqVrjAIGH-5fzUhj-fKhD8YT4F734mCOnQCDXui6wQB77AOka69_gblWOJN2SxzC5OSrH1lXiQeciLfVnWuPHS0JfaMKD4=@protonmail.com> <aunyu4ToQ0T3b2Mj@aspen.lan>
Feedback-ID: 173184497:user:proton
X-Pm-Message-ID: 2545d42f3fa76bf9b85c028d11f510898844a499
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Post: <mailto:linux-fbdev@vger.kernel.org>
List-Help: <mailto:linux-fbdev+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fbdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tuesday, November 3rd, 2026 at 4:42 PM, Daniel Thompson <danielt@kernel.=
org> wrote:

> On Tue, Nov 03, 2026 at 02:34:02PM +0000, Roman Vivchar wrote:
> > Hi Daniel,
> >
> > On Tuesday, November 3rd, 2026 at 4:05 PM, Daniel Thompson <danielt@ker=
nel.org> wrote:
> > > On Mon, Nov 02, 2026 at 09:58:48PM +0200, Roman Vivchar via B4 Relay =
wrote:
> > > > +  led-max-microamp:
> > > > +    minimum: 5000
> > > > +    maximum: 29800
> > > > +    default: 20200
> > > > +
> > > > +  vin-supply: true
> > > > +
> > > > +required:
> > > > +  - compatible
> > > > +  - reg
> > > > +  - vin-supply
> > >
> > > Why is vin-supply required?
> > >
> >
> > The chip cannot function without VIN power supply. Even if it's on the
> > always-on power rail on certain board, there's always a chance it might=
 be
> > accidentally left disabled on the other. It's better to document supply=
 in
> > the bindings as far as I understand.
>
> You haven't just documented the binding, you have also made the property
> mandatory by adding it to required.
>
> So what I am asking is why is this property listed as required. You
> didn't implement the driver in a way that makes the supply mandatory.

Not sure I follow.

In the driver I've used devm_regulator_get_enable(), rather than _optional(=
),
since my understanding is that the non-optional helper is a standard kernel
API for required supplies (with regulator core warning and fallback to dumm=
y
regulator in case DT omits it).

Do you suggest dropping vin-supply from required: ? On my board it's connec=
ted
to an always-on supply, though I can't tell about others. I can proceed wit=
h
this if the DT maintainers are okay with that.

>
> Daniel.
>
