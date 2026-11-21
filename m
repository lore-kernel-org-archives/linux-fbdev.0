Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795263944;
	b=DWClXwEwcbIfI3Y+ZHqHb2lmAFd3oA9QlEWJXcYCr6CeNkTjqMI67hRGgiGqTVUYTZ8T
	 toSC/Rn/BkWasTGK+4UD7QErkVjXkVTOnU3s4IMSUjGgUodzqyD+uOlIR8LLqZarVQbL+
	 y9VAHokejiwRPy615TNy1VnUdNcfHmA+8mNKmb7Q+U3ryCq+VNEKFFiMQXUjhegfIX0Xw
	 0lT5AH3Y/Uzp3A256X0RYEbsKJFEYumBabm/faQSAzJ91TBlsE2m1+8grL8vkuyh5VH2V
	 0u/zQgSbw08Il2nHXr0l4docgs78zPBqrepLa2jWMl8cuNiJxiogYIU50C4ZIEMGnqw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795263944;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=2xTIHmgzq00zeTm+KYjdeLWR3+4wv51SMkHMEHilZEk=;
	b=miUz5uDjc4Ju26t1LEFC2vTQ57SGRGlR8Zuq44d1kyDlwKPWtN3SKxllMMkuCtCDFvDz
	 t1cC3sGAc4zPU1BwNgnk3FeCGSR/wrsPeU9Xpf/rXGuo47sMi+bOjWXNA5D96aPopQEWV
	 iF2CCLxTzS6ZlTrRF2HFjYob41fs/5DhUAOOlapE+M1WJ/O0LOFHPAII7kD4p3Sr664+m
	 /i08HxrSsPbL0TA/c9MACZamJtbM+7PY/CVgNesBZnfZkQWdKliu6io5mwtwQDzr4AhWh
	 keD9Mj8liVG3nfN8o3YbK5oNCd15bN4d/iy8jvgIUot6M5GY8KHHiuS+js2754smgNg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Sa0jDgdg;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F72B606A330;
	Sat, 21 Nov 2026 12:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Sa0jDgdg
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 090011F000CA;
	Sat, 21 Nov 2026 12:25:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795263943;
	bh=2xTIHmgzq00zeTm+KYjdeLWR3+4wv51SMkHMEHilZEk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Sa0jDgdglw59933Wovra2XPKfLyVfGYnAwW23yHMLQtVhCMgeTtBux+xufDx0loOG
	 9kPO3efUkV8E8cERpa022RyyarkmqPSHgCjI4W2VNVbIcNfK/+m2PkHD828N09d7Bl
	 k6/1crogHBRzZElaAE2DYsL5AFaAWakw6oNdwWc0CZDtmSh3sP56+5zrhVam8NoDvL
	 DMeLvowx11mlyrp/+KxvAGnCBZA58HA4g4p6jjxU8mdia/V7k5+iH+NPDa+tGQrnA4
	 Wleh//mNJsy4UO9q6nJtR95zH05EudZYFeO8FWhJ0EvSLqjdUouxtcIwqZT/Lcu3iz
	 JAnD8YSychHOQ==
Date: Sat, 21 Nov 2026 13:25:40 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Roman Vivchar <rva333@protonmail.com>
Cc: Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>, 
	Jingoo Han <jingoohan1@gmail.com>, Pavel Machek <pavel@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Helge Deller <deller@gmx.de>, 
	dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org
Subject: Re: [PATCH v3 1/2] dt-bindings: leds: backlight: add Kinetic KTD3137
Message-ID: <20261121-sticky-firefly-of-innovation-c4aaaa@quoll>
References: <20261117-6768-ktd3137-v3-0-b4fd957e3b00@protonmail.com>
 <20261117-6768-ktd3137-v3-1-b4fd957e3b00@protonmail.com>
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
In-Reply-To: <20261117-6768-ktd3137-v3-1-b4fd957e3b00@protonmail.com>

On Tue, Nov 17, 2026 at 07:40:58PM +0200, Roman Vivchar wrote:
> Kinetic KTD3137 is an LED IC, used in various mobile devices for the
> display backlight. Add devicetree bindings documentation for this chip.
> 
> Datasheet: https://www.kinet-ic.com/uploads/KTD3137-04a.pdf
> 
> Signed-off-by: Roman Vivchar <rva333@protonmail.com>
> ---
>  .../bindings/leds/backlight/kinetic,ktd3137.yaml   | 64 ++++++++++++++++++++++
>  MAINTAINERS                                        |  5 ++
>  2 files changed, 69 insertions(+)

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

