Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793714719;
	b=1DQkJ9ARiTMLuz0EEAmmo93X6D2W9HS+LCNjfEuO3A89wMkrtdKqj/y7jcqlwUGR0LYs
	 5B3YYoDKhtWf0iRgNdi7s2gd5s9WlHwrj8mm0rkK8dLZ0zE1KdReuvqCu9i54hhZZOVxw
	 tG/CmarZ1TtPTEB/v/viUJbz4X9KjLz4L06SrSMG/cqiQQWuBycxDp2D9vRaIsXRQYP10
	 y1GDYnTn1/tV/6LpRypdBvzWx0YJDcvoVK1CvbOtf+VqC9pqyNqYCKOuu0Tbr2h2LKPih
	 MggWFid63/oQCBWZwT5ANOpktC2V1NGPWJCjO0t++x/eq3KvYGCbNF21+X8cMKTVWDw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793714719;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=bF7qGpdtN0WIrQT8+FBNrErYPWOmZTo7dWkERTkp0DY=;
	b=xmq/Bqea+Fo0bvjJmq5A3YdeVU1ywLP42nD+vh+1VjxK7nfGd2V5veTiUexWTOCQkw6r
	 Z0wro9NLxAxQAJ2nQs20dw+HMzeT/ME9srLtDeEkRx7eL5HhaA+/FDTeStPqYle/H7zZ6
	 VXvsEXEczs3njX998kAG9PKbK09Dqjki4IPjBMkXLL4Fhew8zberNOHuNHnaIZaFcuxo+
	 tOgC/0fHbMyzcEKOzxXOqgPBMsJW9CUbUolz+tRwxYaLBEM9CU2mlJci1be3n3CV13eTY
	 G+P0l0eiJVRoZn3GCJXIwHpB01Sd40eyX2HHF5ZRuGFWDptVZpqhNdDaKCM/GUeYCEQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GhKpbDLi;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C3CE606D816;
	Tue,  3 Nov 2026 14:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GhKpbDLi
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9067A1F00A2C;
	Tue,  3 Nov 2026 14:05:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793714719;
	bh=bF7qGpdtN0WIrQT8+FBNrErYPWOmZTo7dWkERTkp0DY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=GhKpbDLia+ePgaenqQHOfJQOjb2rh86uzpnEuGIj8tTEmWCLbyq1lvnZ4EFDyuPxH
	 Vv0rd000DCFwH6xiDLBmoAkk7GTDD1IqDLk6hF64Jy3rbTzqzdJ4G1tSurY8v0/YzX
	 FvH2io3WUnl1/JErrbGdQBu8ynP4m/azATLPEta2b1s7I2UsTHIVjO+zSoheO5j5qG
	 W9j8814TttOmhTo8R448UZseXBdBiOYQtyAXesqB0Wf/VJcGTNdht2Sv+k5M8I0glO
	 V1+JrGK55NW7cdIZYxrgga8xmc0BKJAP/pQ4Y9OqI/R9JR7TBKuHOoxJUyvQgW7kII
	 hPIt7jsO9Pl3g==
Date: Tue, 3 Nov 2026 14:05:13 +0000
From: Daniel Thompson <danielt@kernel.org>
To: rva333@protonmail.com
Cc: Lee Jones <lee@kernel.org>, Jingoo Han <jingoohan1@gmail.com>,
	Pavel Machek <pavel@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Helge Deller <deller@gmx.de>,
	dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-fbdev@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: leds: backlight: add Kinetic KTD3137
Message-ID: <aunqGVkX7-Y61iDA@aspen.lan>
References: <20261102-6768-ktd3137-v1-0-b5b4f903c56e@protonmail.com>
 <20261102-6768-ktd3137-v1-1-b5b4f903c56e@protonmail.com>
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
In-Reply-To: <20261102-6768-ktd3137-v1-1-b5b4f903c56e@protonmail.com>

On Mon, Nov 02, 2026 at 09:58:48PM +0200, Roman Vivchar via B4 Relay wrote:
> From: Roman Vivchar <rva333@protonmail.com>
>
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
>
> diff --git a/Documentation/devicetree/bindings/leds/backlight/kinetic,ktd3137.yaml b/Documentation/devicetree/bindings/leds/backlight/kinetic,ktd3137.yaml
> new file mode 100644
> index 000000000000..140615640a9a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/leds/backlight/kinetic,ktd3137.yaml
> @@ -0,0 +1,64 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/leds/backlight/kinetic,ktd3137.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Kinetic Technologies KTD3137 LED Backlight
> +
> +maintainers:
> +  - Roman Vivchar <rva333@protonmail.com>
> +
> +description:
> +  The Kinetic Technologies KTD3137 is an I2C LED backlight driver for medium
> +  to large size LCD panels.
> <snip>
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
> +  - vin-supply

Why is vin-supply required?


Daniel.
