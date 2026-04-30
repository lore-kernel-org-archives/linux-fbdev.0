Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FF7C28751B;
	Thu, 30 Apr 2026 09:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777542035; cv=none; b=pe77fnV4LUaC+xqGDE6SS4Aop0Og1Vyavwlp7PGlaECeE4DCdvVPTZaqtNJuBcwWxiHwg5hAFvKdHL5HorX5xknGS9fh/V8W9Vd64NpVU0lOAUJiyVGtobGNfWw+YtzdDZOGT2OR+2NP2ovOVFV4sypFGpUIkt7R/MLIWJpfk6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777542035; c=relaxed/simple;
	bh=Tj7K1qp7clDNye0BbLNXPFP5MofQdFJ7SeapubT7TdM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s2XRgmTJLgy6KIMErNjE9SgwHSn7aLd4DWYXvV4cNCh90KmuS3SAv1fFaTjPO59GH+h6dz0YyWHxxlA15aIzLQ/oVvzbtdN/sOalWJjPKyLPn+T7qNvD7yg7ZSZxFp9FbbAZK4xXP3RYFbWtjrEjdzj6WgYt3X3IgTiVd4pYjmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bi7W1P5N; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bi7W1P5N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AF26C2BCC4;
	Thu, 30 Apr 2026 09:40:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777542035;
	bh=Tj7K1qp7clDNye0BbLNXPFP5MofQdFJ7SeapubT7TdM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Bi7W1P5NJgq5JgaZXIam/iHdqEEAlfiLj7Mcclo9abxMfE34smq9+J23v+F0BA5o0
	 2IL+vhwg4/+gBP6RaTxNJnUsP0zOrKn6G3RCVDpsG2dYr02CNH540qDfSeXxOcQdBp
	 5u4y/gjsUb3TUUP1LdLm4wq7vm3nQdPLBGZVy19Bap5vYgbttxRlgWogIX+y2jGdQc
	 3kZpOL/nh+GeUL1Qbs/Z/A0tjaUqcpi0tHot2hfV3vQc0BoJNg1j2hPXBeaAT8B4nM
	 B9wJhzgPhxoTRLEB/lMaaz0Itu25mOemAeMXV0AKC30/EujE8GJdqq0IWERpWwALp4
	 bGCuSSYKNrH4w==
Date: Thu, 30 Apr 2026 11:40:32 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>, 
	Jingoo Han <jingoohan1@gmail.com>, Pavel Machek <pavel@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Helge Deller <deller@gmx.de>, 
	dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, KancyJoe <kancy2333@outlook.com>
Subject: Re: [PATCH 1/2] dt-bindings: regulator: document the SY7758
 6-channel High Efficiency LED Driver
Message-ID: <20260430-interesting-pink-salmon-082def@quoll>
References: <20260428-topic-sm8650-ayaneo-pocket-s2-sy7758-v1-0-0caade5fdb32@linaro.org>
 <20260428-topic-sm8650-ayaneo-pocket-s2-sy7758-v1-1-0caade5fdb32@linaro.org>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260428-topic-sm8650-ayaneo-pocket-s2-sy7758-v1-1-0caade5fdb32@linaro.org>

On Tue, Apr 28, 2026 at 03:59:11PM +0200, Neil Armstrong wrote:
> Document the Silergy SY7758 6-channel High Efficiency LED Driver
> used for backlight brightness control.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>  .../bindings/leds/backlight/silergy,sy7758.yaml    | 53 ++++++++++++++++++++++
>  1 file changed, 53 insertions(+)
> 

subject - not a regulator prefix

> diff --git a/Documentation/devicetree/bindings/leds/backlight/silergy,sy7758.yaml b/Documentation/devicetree/bindings/leds/backlight/silergy,sy7758.yaml
> new file mode 100644
> index 000000000000..dc44b3b502e2
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/leds/backlight/silergy,sy7758.yaml
> @@ -0,0 +1,53 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/leds/backlight/silergy,sy7758.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Silergy SY7758 6-channel High Efficiency LED Driver
> +
> +maintainers:
> +  - Neil Armstrong <neil.armstrong@linaro.org>
> +
> +description: |

Drop |

With these two fixed:

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

