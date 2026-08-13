Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3025A35A3BF;
	Thu, 13 Aug 2026 09:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786614151; cv=none; b=KVW6yz9tUD1wq2MnLWToFGm8zOTqNvItJLwSNe9XgyPbdbCOEIbQT68Y96RiweuoCowM9UQnZUb7vRpUdfoTKMuL+7bZ7kySMeH1p22UI8XzqKnDcVxg1LP4on8zQQRPtS3ZcTVhB1KRMcGS8k8q1it84545cgBWNCNlmg74bvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786614151; c=relaxed/simple;
	bh=Q64nye9tKvCSxklrMxOUXgaHxhujm/rs91sHzrnk6Rg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=romy3uhoqc4EMNs0mv1dUEJrWnWKYXwy19/vUGwarqf4xA+ML9Y6XOH6kuQo/KV5YlomIrhzeaR3f548qIJn5jMMnVpStbAujWrY7FdzepHUiJQWznGD+IkSpW8HQSy+pLtfWKa5WMovzs70hIMyCdhbX4oeVVBDCv3snIiuD6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OX7ebVpz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OX7ebVpz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83A221F000E9;
	Thu, 13 Aug 2026 09:42:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786614150;
	bh=wGzl9P3ZZvwgNJ4nMBz7ik5uR0eH93+YbNY/M3r14bQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=OX7ebVpzSdJUcCOwP7NVFZCItKsSEvnwyDYQHdSksOhQdLQOxNDwEnvoSq0suMEXZ
	 CGAT/wMIlE8hlrv63mXCnk/iNEkE7eWHXIqOs20OLbd7zNiR2kZfGNcu+2AbI2cYET
	 Sc0r7TmaNmyqWrVwQONsQF622tIzw+/eA16UUlGUr8TA0tOviccT9WDsAF8AZNBGu2
	 MJ3uKbk3QinROWx50Aodof6NflKKtUcUj+piRU3s+GXH78dzcIlBDzUa37/NibykCq
	 oXb7yDeKHxyEuqAO5YTZbI7L8ZgFfMrpjSrj5WLUoaNg+nNvDVg2AyFM9l2iLq7r0+
	 pHIykhOpMYdng==
Date: Thu, 13 Aug 2026 10:42:24 +0100
From: Daniel Thompson <danielt@kernel.org>
To: Wim de With <wf@dewith.io>
Cc: Lee Jones <lee@kernel.org>, Jingoo Han <jingoohan1@gmail.com>,
	Pavel Machek <pavel@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Helge Deller <deller@gmx.de>,
	dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-fbdev@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: backlight: Add Orient Chip OCP8178
Message-ID: <an2RgGwu2YaglM7H@aspen.lan>
References: <20260812-ocp8178-backlight-v2-0-4ad18b48bef8@dewith.io>
 <20260812-ocp8178-backlight-v2-1-4ad18b48bef8@dewith.io>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260812-ocp8178-backlight-v2-1-4ad18b48bef8@dewith.io>

On Wed, Aug 12, 2026 at 09:21:46PM +0200, Wim de With wrote:
> Add device tree bindings for the Orient Chip OCP8178 LED backlight
> driver.
>
> Signed-off-by: Wim de With <wf@dewith.io>
> ---
>  .../bindings/leds/backlight/ocs,ocp8178.yaml       | 47 ++++++++++++++++++++++
>  MAINTAINERS                                        |  5 +++
>  2 files changed, 52 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/leds/backlight/ocs,ocp8178.yaml b/Documentation/devicetree/bindings/leds/backlight/ocs,ocp8178.yaml
> new file mode 100644
> index 0000000000000..57c44d3383b88
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/leds/backlight/ocs,ocp8178.yaml
> @@ -0,0 +1,47 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/leds/backlight/ocs,ocp8178.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Orient Chip OCP8178 backlight
> +
> +maintainers:
> +  - Wim de With <wf@dewith.io>
> +
> +description:
> +  The Orient Chip OCP8178 is a white LED backlight driver controlled by a single
> +  GPIO line with a vendor-specific onewire protocol.
> +
> +allOf:
> +  - $ref: common.yaml#
> +
> +properties:
> +  compatible:
> +    const: ocs,ocp8178
> +
> +  enable-gpios:
> +    description: GPIO to use to enable/disable and dim the backlight.
> +    maxItems: 1

Is this really an "enable" GPIO? The enable-gpio(s) for most backlights
is the HWEN pin rather than something used for protocol. Maybe
onewire-gpios or control-gpios?


Daniel.
