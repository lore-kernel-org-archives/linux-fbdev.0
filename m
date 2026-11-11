Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794399095;
	b=joDihWgOBp8f8SczsIC4WAY24QPbshhxS5ai74x9mHWZ7EY9TRkq89uP5MtLyNPb2giK
	 GkcQgNuYH0UwsJ4wkzeaW43sSGrnDhI2vxq9z6QuAQJo/TotOsg8yYSPJKHMYTrfAAEdf
	 VisZr2Pw6RyKgLj3/cW7xupLLyI/t7DS75KMGSIDz7c/eILgt2N+6gRqWtE0Nx8ZEKtJZ
	 NKjtnVqQ8MpWDPSSVj9+ziw0X/AilDb0MZPex15vEYwB6J1ESrKPeffPVeyYS1UtRgLHm
	 KhAu6bbFduvgwZUnPT3kOiDxwzEuR2kDTALY+uFR6X1EMxgI/RGf6DUKMKz/onqlTDA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794399095;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=uxHaYs6gzjD/EYRdqCnmVXOY/SAjTuU2zRL4ZifLNo8=;
	b=dolqK4PopGAKFFQBXYy1l3Dt+Lob0cfHnwavyFiBG8PpVejIL2xgZ5wtBxC7TBARYPX3
	 xeVE5TwWhc83JUd1p78OqNTWnFbWab1U4JF+rcWJtMbyPSFaEehuQ21usC1JpGj+0Sumn
	 NNWeuHJrlNru7xs96bjif/43TRI1093dTMCXijCFPHwpWHvlQ9AgEWaqQriClLvj1Gmdl
	 jwTKubIsaP21LtY1y/lkLvvgYG1DdC1U4DWNhJ4bmBAxx73+IynJSPKj9DDSD2VcJIQoi
	 hOh/dTWNJ6D1iYTUZTdt8D2dDOjpu6ZTPobWMK7w8qGXLVEjYJwEtzYFLED+oWKxirg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=O5LU3j6A;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CF8E606A334;
	Wed, 11 Nov 2026 12:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=O5LU3j6A
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3B041F00A0B;
	Wed, 11 Nov 2026 12:11:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794399095;
	bh=uxHaYs6gzjD/EYRdqCnmVXOY/SAjTuU2zRL4ZifLNo8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=O5LU3j6AUykozDtd1abkEmq/4Udfi6wDxcXuWeNNRmpDbsirA/Esp1xjUqAeL7h99
	 47q9locMmGH9fRS+y5sA0kX3GQqQ1TkdRUSTUESoTtXdJfK6RKh4A97H6wAtp8xZI3
	 rbnUimqhzfM9n7Jvgv9fIa+ffABSktTumjYDx4Q05bt+I8LqVUlK3Yr5l4LmXwPdtx
	 8rFJwdjMxb36eAwnqcAaM8tiMXYnqi/uTWvUhroiBJxvVLFEYm7RGSPrl/KAw0RA1z
	 Fwf1kzlAD3I7FsHfpG7NR/2AqeWFqHcySsJxHrErHTmO9GxRs6hXqj6Q3Ce7NfQshi
	 40AIHSdu07Pzw==
Date: Wed, 11 Nov 2026 13:11:31 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Roman Vivchar <rva333@protonmail.com>
Cc: Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>, 
	Jingoo Han <jingoohan1@gmail.com>, Pavel Machek <pavel@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Helge Deller <deller@gmx.de>, 
	dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: leds: backlight: add Kinetic KTD3137
Message-ID: <20261111-liberal-wakeful-flamingo-3c1f3a@quoll>
References: <20261110-6768-ktd3137-v2-0-9496c51efea4@protonmail.com>
 <20261110-6768-ktd3137-v2-1-9496c51efea4@protonmail.com>
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
In-Reply-To: <20261110-6768-ktd3137-v2-1-9496c51efea4@protonmail.com>

On Tue, Nov 10, 2026 at 09:38:51PM +0200, Roman Vivchar wrote:
> +  led-max-microamp:
> +    minimum: 5000
> +    maximum: 29800
> +    default: 20200
> +
> +  vin-supply: true
> +
> +required:
> +  - compatible
> +  - reg

Supply is required, device cannot operate without power.

> +
> +unevaluatedProperties: false

Best regards,
Krzysztof

