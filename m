Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793725807;
	b=wxnB6ct+gL17gxCXerl976+abL7vWA+Zez7+UHz4JIKkgEbTzbS9VRXz0mutwGat29he
	 rfvbrOhYe1enX/IDv6JeqEtYZznGrHU1z3b2fO0a5GeUCbVP85kGZCr3Cv8wFirKjjeWL
	 BPsrFJ6QTv9hvlkkJRUOy1p/97vTaLiCBUTgLtGjpjRpZfJkz/P/QHPSpaAIGufjVlNZW
	 DY65Z84acB/QPoxxLZczQpNFpEDHbb2un2MvAUZH+7QzrFfkPHdLd0DXcr5WxvdWhYwOi
	 a+IVPBbxe3zd52Vaelpn+KD9TDjczA9g8eUQ1YdS5no1VBXUWuJ1XrnoHfLbRza4rcg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793725807;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=4yXF2qH2dZlH5NaZeOXrAhyY/aCMSbLE9DiPJAinWiM=;
	b=C5vvE1rh4OSw1SSrEuoRF0skIcXa7//b3V22wLpapTnBStzwqMMS2ygx/RLo5TtiIAev
	 OtkMsSF5W5ZfMU1egaQSmDJflw3hfPGaUrBmtICjtj9hh3p0dTIsv9q7RDmECUuSMWgI8
	 OkglLk6zdFmOAeJ5n6ecOLUy1QlWlCIswDnUbHw5tkTsOXttBqCjOfgpgbis2Rw6QFUwV
	 Qvlz80zwc1d3C6gRP/RH0ivjRjtqTwdRCVWOm5omEhzjnvrOAqB24sw8TpnfaLZJed4Oz
	 P9hAv79bYkm06o4h7gpcp3EJzCNbZoQXX9BhvNYCybudxDvtqX8fIiaCASYMW1ftViA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=H2GtedTK;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7270D606A328;
	Tue,  3 Nov 2026 17:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=H2GtedTK
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 841171F000C1;
	Tue,  3 Nov 2026 17:10:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793725807;
	bh=4yXF2qH2dZlH5NaZeOXrAhyY/aCMSbLE9DiPJAinWiM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=H2GtedTKni4UU2EY3qobMS0Dg3+Qmas82D0rV3NG1oUmo/Ml8rDNYcCcm0B0ET+Yp
	 9SCFdcnz4ahrGyyNSCy9b16+wLKDB+Gj4iVSBMsQFv5KW95uzWSOSxkwyDlbif19V+
	 ZO09Z7FBbVo/mZpUvU807tA1ga8DQw5UgYbs1RyYaMZDI0mc45lBdybYIoOx67hGdu
	 NIuyZczUueXbJoZQFi3Gw3+zxdgfZBwoMyjRIBqzddkNHAq1ZN6xjWy2ZHYwhHuWsd
	 lOvsHMTguvX2mYrABptuiCFjUf9QaiywEvoTmtZJJqivuMh2WT0E5HclqIBPMl2V95
	 w4QhY8zlKUGMg==
Date: Tue, 3 Nov 2026 17:10:01 +0000
From: Daniel Thompson <danielt@kernel.org>
To: Roman Vivchar <rva333@protonmail.com>
Cc: Lee Jones <lee@kernel.org>, Jingoo Han <jingoohan1@gmail.com>,
	Pavel Machek <pavel@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Helge Deller <deller@gmx.de>,
	dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-fbdev@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: leds: backlight: add Kinetic KTD3137
Message-ID: <auoVaaZjcnRTj1S9@aspen.lan>
References: <20261102-6768-ktd3137-v1-0-b5b4f903c56e@protonmail.com>
 <20261102-6768-ktd3137-v1-1-b5b4f903c56e@protonmail.com>
 <aunqGVkX7-Y61iDA@aspen.lan>
 <_kyk4j6fx0PX5QqVrjAIGH-5fzUhj-fKhD8YT4F734mCOnQCDXui6wQB77AOka69_gblWOJN2SxzC5OSrH1lXiQeciLfVnWuPHS0JfaMKD4=@protonmail.com>
 <aunyu4ToQ0T3b2Mj@aspen.lan>
 <CmvbeteAqxtpenZUmJ4dqRvXYjjDzTTDevRB4NUlN0WGLOUk0jwzt2C3ZtuZ3Eb2UwBDEPUWpu9biU1OOhKGWQITolX96cFXolBTMgSyh1c=@protonmail.com>
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
In-Reply-To: <CmvbeteAqxtpenZUmJ4dqRvXYjjDzTTDevRB4NUlN0WGLOUk0jwzt2C3ZtuZ3Eb2UwBDEPUWpu9biU1OOhKGWQITolX96cFXolBTMgSyh1c=@protonmail.com>

On Tue, Nov 03, 2026 at 03:21:45PM +0000, Roman Vivchar wrote:
> On Tuesday, November 3rd, 2026 at 4:42 PM, Daniel Thompson <danielt@kernel.org> wrote:
>
> > On Tue, Nov 03, 2026 at 02:34:02PM +0000, Roman Vivchar wrote:
> > > Hi Daniel,
> > >
> > > On Tuesday, November 3rd, 2026 at 4:05 PM, Daniel Thompson <danielt@kernel.org> wrote:
> > > > On Mon, Nov 02, 2026 at 09:58:48PM +0200, Roman Vivchar via B4 Relay wrote:
> > > > > +  led-max-microamp:
> > > > > +    minimum: 5000
> > > > > +    maximum: 29800
> > > > > +    default: 20200
> > > > > +
> > > > > +  vin-supply: true
> > > > > +
> > > > > +required:
> > > > > +  - compatible
> > > > > +  - reg
> > > > > +  - vin-supply
> > > >
> > > > Why is vin-supply required?
> > > >
> > >
> > > The chip cannot function without VIN power supply. Even if it's on the
> > > always-on power rail on certain board, there's always a chance it might be
> > > accidentally left disabled on the other. It's better to document supply in
> > > the bindings as far as I understand.
> >
> > You haven't just documented the binding, you have also made the property
> > mandatory by adding it to required.
> >
> > So what I am asking is why is this property listed as required. You
> > didn't implement the driver in a way that makes the supply mandatory.
>
> Not sure I follow.
>
> In the driver I've used devm_regulator_get_enable(), rather than _optional(),
> since my understanding is that the non-optional helper is a standard kernel
> API for required supplies (with regulator core warning and fallback to dummy
> regulator in case DT omits it).

That dummy fallback essentially makes it optional. On a board with an
always-on supply then there is no need to include vin-supply in the
DTB. The driver will work just fine without it.


> Do you suggest dropping vin-supply from required: ? On my board it's connected
> to an always-on supply, though I can't tell about others. I can proceed with
> this if the DT maintainers are okay with that.

Given your answers then, yes, vin-supply should not be in the required:
list (e.g. we don't want DT validation to fail for a DT that does not
include a vin-supply).


Daniel.
