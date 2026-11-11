Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794402238;
	b=LeO7StZam6DcYxyBvXi6u6yVycoNqebv1EQXO7ymTkHYpoT50QBeB9D9C5OLgRuGJP2f
	 N9bhrlddqsF5kSuOq1b1rXH+Zd+6qEu8BdRd8HVJZ4DHV9pc1Sa0MYaVufx0fBzOiuKe8
	 /AsR7MR329gmR0TYmBDSTlX+UGX4Fzpl0qvXT4x8n/glJKab44dQWwaGlWEcsEAFgvS7A
	 EDUxEEG/NsbNnje/rq9V26oRhiD3V74Ke3Dhz8YLJgSK6992w/ZgRT1agpRF1g/XRg21e
	 ehn+8371WHU0BwCYzOpyzvsYf60eX9lHSC0ZYc8AfEocLmHZjstNZmgoNi/U//BTDPA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794402238;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=AWaIRPGVBwDKyVXL8rFvxOr7TIsCYjaMi2R2yUDvOKI=;
	b=PMaSjUVQLNh+CSQXe3g8zJ3RSuRbrdtiSl+GLLxgOmB3BdwlbDfAo9MFZv2dnldo0umy
	 OQNDyFFw/Huq/c2hkKflm1bnTHz6C+ld7zp5SXIY8uroKLyr5yw1vOwQ9BtSKZQ+FK4Nf
	 iX7CHF0v7eRYHzzcCy9ZGy3gsrMoPMlyJyps3qjJuNAen0oxHKpkIwvsu7kAlqRwFHbbF
	 kboCmzvfIWpd0WnzpJGzswiL3tdhJLSnHBL92+MAPMUxmrgY8417PeePBKIWV4taCF/Ww
	 qH8LxvG9i9+r2AJTiq7ovDWsUfJ7OZaII2qB1rlgm2rHrv6R9Wo4xu4Lutj2+X7WPuw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bY88ne8f;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E7E6606A327;
	Wed, 11 Nov 2026 13:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bY88ne8f
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B07C1F00A05;
	Wed, 11 Nov 2026 13:03:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794402238;
	bh=AWaIRPGVBwDKyVXL8rFvxOr7TIsCYjaMi2R2yUDvOKI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=bY88ne8fKH+AMIpDjGgLPKo2tQ3gBNt/paxmaTdDQeVQ9jEMzkXYg0fc6aof9e3cj
	 +EL8B7FEAS7BYmklA4wBXRvGufXIl+4383D4TJznpHT8v/vh7XnIIHfw52NMLud/Hf
	 BY9iJWiDXU1ZIXK8iFaRtcG30l7q0cJpAUA/sFeisFkFs5XsIcB41DFYXWNjHedPui
	 DCH57s3lM2cHITACQwufd/q6xziE6/X5QBouCIQkjCkxWYMssR7RMiKKK11PgXzwVW
	 11bIbTeGD+XulA/fHEmYWO17PgqnlOTLjZyJgmUDH0YjVD2kWQrrVru4kDW+uIYHhY
	 xqbonlRzll3bw==
Date: Wed, 11 Nov 2026 14:03:54 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Michiel van Beers <michielvanbeers@gmail.com>
Cc: Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>, 
	Jingoo Han <jingoohan1@gmail.com>, Pavel Machek <pavel@kernel.org>, 
	Griffin Kroah-Hartman <griffin@kroah.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Helge Deller <deller@gmx.de>, 
	dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: backlight: lm3630a: Add led-max-microamp
Message-ID: <20261111-cute-impetuous-otter-0d70c2@quoll>
References: <20261107-lm3630a-led-max-microamp-v1-0-ec9e441d9b2c@gmail.com>
 <20261107-lm3630a-led-max-microamp-v1-1-ec9e441d9b2c@gmail.com>
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
Content-Disposition: inline
In-Reply-To: <20261107-lm3630a-led-max-microamp-v1-1-ec9e441d9b2c@gmail.com>

On Sat, Nov 07, 2026 at 01:13:54PM +0100, Michiel van Beers wrote:
> The LM3630A has a full-scale current setting per control bank, from
> 5 mA to 28.25 mA in steps of 750 uA. Boards whose LED strings are rated
> for less than the chip default of 28.25 mA have no way to describe that
> limit.
> 
> Add the common led-max-microamp property to the led@0 and led@1 nodes.
> The property is optional, so existing devicetrees remain valid.
> 
> Signed-off-by: Michiel van Beers <michielvanbeers@gmail.com>
> ---
>  .../devicetree/bindings/leds/backlight/lm3630a-backlight.yaml    | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/leds/backlight/lm3630a-backlight.yaml b/Documentation/devicetree/bindings/leds/backlight/lm3630a-backlight.yaml
> index 6393cbf3afdf..a031679d5468 100644
> --- a/Documentation/devicetree/bindings/leds/backlight/lm3630a-backlight.yaml
> +++ b/Documentation/devicetree/bindings/leds/backlight/lm3630a-backlight.yaml
> @@ -77,6 +77,14 @@ patternProperties:
>          minimum: 0
>          maximum: 255
>  

I do not see in this node reference to LEDs common.yaml. You need it for
any common properties.

Best regards,
Krzysztof

