Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC75837B02A;
	Tue, 18 Aug 2026 07:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787038526; cv=none; b=YoB7N+t6vNnUG0jHgeoE7+WWRXcqh9NCPRmdFdcyxk5I0KYpZIf02qF8MoE9Utz3U+xEciuL6cVkJ42TEyCWamPqrhHgLR9v5Qyc+cxlzzLlK8BnPU92aBgnHCgY4VOYuZisW0T1vRZosXp8GXcruFBWqnYpOx1OCXAHelcFKQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787038526; c=relaxed/simple;
	bh=4aTCD9NC3nAGU8XOohAvMxQsXEXQELTX5KZJuVHIs8A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KjydGKXbhr6AZzdB5m0fJafdxfqqGh9Op6KmBqbWdWp2HbI63nzWngii2b3Y26gq1MQGZiP61eUCMbDBhIfIrDTV/W8CvVLjqD5PxMXTkDQcw1kiPpGXAcK1ukw841a/HRDdTga87arlIJWnyig/oNMSl02Vj0FahAuVnSUTRAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z45/d0fb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z45/d0fb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA3491F000E9;
	Tue, 18 Aug 2026 07:35:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787038519;
	bh=3FjFA8QdIZbyMJMywsq7y6vxV2t4SvR33hKPXAYgD2A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Z45/d0fb+Cw5JyKjPlUV0lbfBycSDceEw9XFHDi0YhhDTCUWOaSJHZ07g1FAZ6YYe
	 26o4GrUUwxEJ33d5P3SNRY9JOXOX7hultaXPAFOjMouRQouCCQ/+MZqtwa3pjNmZ2z
	 sdIoTeqQyO4+ls0g7jf2Uo3DGr+Tyte5kr7vh2z8Pl5P6BKnE33msGUasGnd9wms4B
	 yH5aipF0tB4rm5/Bf3uujsy+ELBoKoQhMkvJ1pjlB+3780z64Top3vYzFO9iYg2TQk
	 iAbNDSN1zuCe1fNECaoDy9pEi/Ia8gcqPURlupN6EQ67LrulOTBK7MRKikypAilGxd
	 fFCVDoDOgYUpw==
Date: Tue, 18 Aug 2026 09:35:14 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Wim de With <wf@dewith.io>
Cc: Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>, 
	Jingoo Han <jingoohan1@gmail.com>, Pavel Machek <pavel@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Helge Deller <deller@gmx.de>, 
	dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org
Subject: Re: [PATCH v3 1/2] dt-bindings: backlight: Add Orient Chip OCP8178
Message-ID: <20260818-complex-noisy-dog-ceb320@quoll>
References: <20260816-ocp8178-backlight-v3-0-caf95c453c50@dewith.io>
 <20260816-ocp8178-backlight-v3-1-caf95c453c50@dewith.io>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260816-ocp8178-backlight-v3-1-caf95c453c50@dewith.io>

On Sun, Aug 16, 2026 at 12:57:03PM +0200, Wim de With wrote:
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
> index 0000000000000..1cd95aac0d168
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

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

