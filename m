Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793716929;
	b=NR0GGo3b9wjsn9k7IcGkhzHJ4psPhuYXOlsh+8xS10rUXwW6/DmwOe55s309+Y72Ga+r
	 CyAyaVXHuS1GahdU53XmZ6Dv+HIh+/VKDtxwHupuxb+y27hhFJAWsoQ8Tq6znYKqbAGYS
	 RAjwAU4pa/UDZSbQNfr26yXC/F/BOUb5JZNMFVd6op8sK+kXNXcnxYKT8hmHLnXAMdahi
	 DyrmadxeIOQrht1R/gjwm45BOwtyFj0pqfY0EHgZneAtX1stpxc80SSlOT3DM/iT/PukE
	 zaKDc3iPj0gHZCvdUm/SJaGF5EiaQzimEw8vhzfRZg4xGf2kYbRJjcnhbxaD2BpmYog==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793716929;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=XMbRjeXjK8HpPncDUdoXbZIVfAoatGdmgR/tQAmDQc4=;
	b=Opy8xd/Veb7Tg3l6XQYWatK8isJH7rk8ll8BAGGLFd3dS30mZ57zeewVlwE8gKSXGvpd
	 psrBK4A03izHRcqeuWYcDlqetymGzlUmfomHEOUFkRGfrlqAUDEii032VjVTucvzKgqwN
	 J7B2vQpZCKkixdZZP7EEgINMTjVe9lqPsgsj1j6jnVGW6ThW4sXniOBeMJkoJSZfrc6Te
	 PDImuZd8oc9xVhTFr7CHX/5TQHxp2W+m2w8kKowBaBMkKLXIAYiCgo5P+4yP4rezjjX4V
	 TggisUEM0dsoYKymhfxKyUPsdmzQuWbfZKlUOUOo6USlfBiojX/BFpZT3KZn+Ra9fWQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=R+C9b1g9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74423606A332;
	Tue,  3 Nov 2026 14:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=R+C9b1g9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB4AD1F000C1;
	Tue,  3 Nov 2026 14:42:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793716929;
	bh=XMbRjeXjK8HpPncDUdoXbZIVfAoatGdmgR/tQAmDQc4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=R+C9b1g9x1xIC4nQ7+4q4VaAGG0Q/QOC+5KBaa2cPTIuBhOZqwkBQJU/tuLr4fFyc
	 TkjMcDB3+pkAStkno+5k62DzD+IEPrI3MCiVhGvUSauhctT+jnCNnniKCic+GcdpTK
	 VC+qDYygRD+ltAT8ojIuV7m3kGChkSQJCTLu9aYk9x7qaDKB98t1bFdxrVxltkRURw
	 /CkWEYrqfIMrp4KXhoWcBkqgoCNs/AhrfdoixdmoMUYXYfZ2c4d2/+KmY2vnft+bIK
	 i1jBobQJhZdqvwEJnukp6b9PFFFVwyxmoAXhPwi3MN+T1y0pxYqov3vmWyg4Z2+r75
	 4PQfhwSsGGX3g==
Date: Tue, 3 Nov 2026 14:42:03 +0000
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
Message-ID: <aunyu4ToQ0T3b2Mj@aspen.lan>
References: <20261102-6768-ktd3137-v1-0-b5b4f903c56e@protonmail.com>
 <20261102-6768-ktd3137-v1-1-b5b4f903c56e@protonmail.com>
 <aunqGVkX7-Y61iDA@aspen.lan>
 <_kyk4j6fx0PX5QqVrjAIGH-5fzUhj-fKhD8YT4F734mCOnQCDXui6wQB77AOka69_gblWOJN2SxzC5OSrH1lXiQeciLfVnWuPHS0JfaMKD4=@protonmail.com>
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
In-Reply-To: <_kyk4j6fx0PX5QqVrjAIGH-5fzUhj-fKhD8YT4F734mCOnQCDXui6wQB77AOka69_gblWOJN2SxzC5OSrH1lXiQeciLfVnWuPHS0JfaMKD4=@protonmail.com>

On Tue, Nov 03, 2026 at 02:34:02PM +0000, Roman Vivchar wrote:
> Hi Daniel,
>
> On Tuesday, November 3rd, 2026 at 4:05 PM, Daniel Thompson <danielt@kernel.org> wrote:
> > On Mon, Nov 02, 2026 at 09:58:48PM +0200, Roman Vivchar via B4 Relay wrote:
> > > +  led-max-microamp:
> > > +    minimum: 5000
> > > +    maximum: 29800
> > > +    default: 20200
> > > +
> > > +  vin-supply: true
> > > +
> > > +required:
> > > +  - compatible
> > > +  - reg
> > > +  - vin-supply
> >
> > Why is vin-supply required?
> >
>
> The chip cannot function without VIN power supply. Even if it's on the
> always-on power rail on certain board, there's always a chance it might be
> accidentally left disabled on the other. It's better to document supply in
> the bindings as far as I understand.

You haven't just documented the binding, you have also made the property
mandatory by adding it to required.

So what I am asking is why is this property listed as required. You
didn't implement the driver in a way that makes the supply mandatory.


Daniel.
