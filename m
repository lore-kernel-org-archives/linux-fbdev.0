Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEBCA387362;
	Wed, 12 Aug 2026 03:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786504251; cv=none; b=gcFuwsejkhV35WYh19fmx+RazGJkWn/6hAZtyN6J5PKl36xVJTGS+mDqYM1UiXGd/d4blWZw1FWFXcsFGAoJr3uugOdWdIWQwJH8N5wcEdmBwCvWk7p7TfQFp7G62OhwjP7YjOyRR/C4iH2SNKSKh+dBWMmpLUO5ZZfvXnxFJ4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786504251; c=relaxed/simple;
	bh=OkUTIdFwxkAvH77JL1OgM+1gYacRAK75ccwbtZ/rD1I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pz8oNduqcmPKoG1INJZzCKlwNtjXHgayTNG6m6M3ynT+cL86HX0RmTlX+KJzxxgMwlk0VByIw9cWmI/MGf2Fa4LexNdoGqZSVzpziyvmbsoV86SKw3B039s7r5+XPsJ3Adsh+DCezlDwYmOTAJWpiSRl361RqOU89hxncO02n98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fuU7ipvf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fuU7ipvf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6661D1F000E9;
	Wed, 12 Aug 2026 03:10:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786504246;
	bh=LE3W24wS75BSIMOFlefIC8ZjafXejnzU7cRNPUtlVmo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=fuU7ipvftV6NBq8GsZ6wtII+FkKlGgo80Jqmt2JbzmsXhE4gnwgJKawgPDN9wG/1B
	 Xw8XCIZgy1JFVwCMFUpQcRmaKnDK30nB7/wCogNa0Iy2al1VM5ME5Zr8jL9MCLhsYa
	 bwFkvui5xsFY9VpdMACj8p05FGQef82RvfQcqPaDDg3t6xAyFwjFQaE89a8fUIxsJ/
	 v42n+fkQI2XcEOHJR8m89ySzGT4WOxXjLJ0IggOB4syQ7a2cvGi//hQP1U7bpcDpIw
	 5n8pvvX1+SnYh/nKzqe+7gmFFQ1iYZg/mYlD8/Re1SzLvq6KkIrZ6yMsWLYJJgXR5W
	 L+Z8EimPAYWkg==
Date: Tue, 11 Aug 2026 22:10:45 -0500
From: Rob Herring <robh@kernel.org>
To: Wim de With <wf@dewith.io>
Cc: Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>,
	Jingoo Han <jingoohan1@gmail.com>, Pavel Machek <pavel@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Helge Deller <deller@gmx.de>,
	dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-fbdev@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: backlight: Add Orient Chip OCP8178
Message-ID: <20260812031045.GA657686-robh@kernel.org>
References: <20260806201541.101304-1-wf@dewith.io>
 <20260806201541.101304-2-wf@dewith.io>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260806201541.101304-2-wf@dewith.io>

On Thu, Aug 06, 2026 at 10:15:40PM +0200, Wim de With wrote:
> Add device tree bindings for the Orient Chip OCP8178 LED backlight
> driver.
> 
> Signed-off-by: Wim de With <wf@dewith.io>
> ---
>  .../bindings/leds/backlight/ocs,ocp8178.yaml  | 46 +++++++++++++++++++
>  MAINTAINERS                                   |  5 ++
>  2 files changed, 51 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/leds/backlight/ocs,ocp8178.yaml
> 
> diff --git a/Documentation/devicetree/bindings/leds/backlight/ocs,ocp8178.yaml b/Documentation/devicetree/bindings/leds/backlight/ocs,ocp8178.yaml
> new file mode 100644
> index 0000000000000..9a4df1ef91edd
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/leds/backlight/ocs,ocp8178.yaml
> @@ -0,0 +1,46 @@
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
> +description: |

Don't need '|'.

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
> +
> +  default-brightness:
> +    maximum: 31

blank line

> +  max-brightness:
> +    maximum: 31
