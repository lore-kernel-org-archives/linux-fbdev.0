Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAE791B6D08;
	Wed,  5 Aug 2026 00:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785890176; cv=none; b=nfmmRc2aIrSzO4VrzuZrT4OVA+tffpao83SecgWvYvZkyJhK/y2ZzIPpsHILlm0+G47uoiqyj2/oppfH2A3Q9UzgQ/o6Ah1hC6t++oLig/Qd/jNCiS1WqtK9u/k2U4VzQzm4pPgIrUvledJl2FeKBhVAQmfEzXVyoreukflICMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785890176; c=relaxed/simple;
	bh=OLmxSdjIZG0pbtPOoixqQn2ZoRFzSw2+6m85mzgOU44=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=LvaPzx7DYuwb4jCQZiUdOHAT3hmoi7K8VzjEAHkxwjOHBzsDjG2+oO8T+n3jtWd4Dt32Ew5LG2TY9b0LXwA7QGH/NtGpVTnZwBQHch4KH1vrSJH32nEzaP9c3CytJVPuEw0d8hWpZRkFD9ORhAYMPiEn6XPNz6Z4K425eue4Tq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UzfErMoK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UzfErMoK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 324B51F000E9;
	Wed,  5 Aug 2026 00:36:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785890175;
	bh=7eQ5n/iGpSnvTqj4pTR3mrzSee7O5vh1QLpKl6Bg9h0=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject;
	b=UzfErMoKx40e2blQeHBXSCWHrkWf3gT/4gPA6Ln90TDRy5NKPRSQqcxXUzzw04hr1
	 /myqb631zNn+dnijLZJGJP7BXHOJRqfLk0BCpDe+D+MlAMgBLbMpWg60+7zU+IXZjD
	 m7dumXj0+13Nwgae6uSZnM9GBZyMv7oR4I7MgXoQZXs/9BcYQE2HFIMIRXztOMk14n
	 uBt7WqVLibUdRfcy+HYtqV+4qTdryt6kXeRL0NtcMz/Miq0eRRwAgNG4xB0DmBDpAQ
	 oIfxDBLy/5rBqs6/Khh1sV2dcLO4uG5P8iBrVoW7iMzXLP39yjo2aEuZNHroM/xuO6
	 kWF3YyRd/ibyA==
Date: Tue, 04 Aug 2026 19:36:14 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Maxime Ripard <mripard@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 linux-fbdev@vger.kernel.org, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 dri-devel@lists.freedesktop.org, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 devicetree@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>, 
 linux-kernel@vger.kernel.org, Thomas Zimmermann <tzimmermann@suse.de>, 
 Helge Deller <deller@gmx.de>
To: Max Pedraza <maximpedraza@gmail.com>
In-Reply-To: <20260804225617.264861-2-maximpedraza@gmail.com>
References: <20260804225617.264861-1-maximpedraza@gmail.com>
 <20260804225617.264861-2-maximpedraza@gmail.com>
Message-Id: <178589017450.2494424.9339926059212534643.robh@kernel.org>
Subject: Re: [PATCH v2 1/6] dt-bindings: display: add a device tree
 supplied boot logo


On Wed, 05 Aug 2026 00:56:12 +0200, Max Pedraza wrote:
> Embedded products frequently need a product specific boot logo. Today the
> only way to get one is to replace one of the logo_*_clut224.ppm files in
> the kernel source tree, which bakes the image into the kernel image: a
> change of branding, or a second product sharing the same board support,
> requires a separate kernel build.
> 
> Add a binding for a "linux,boot-logo-clut224" node, which carries the logo
> in the same paletted format the built-in CLUT224 logos already use, plus a
> few optional properties describing where on the screen it is drawn.
> 
> The palette size is derived from the length of the "clut" property rather
> than spelled out separately, and "data" holds plain palette indices; the
> 32 entry offset the frame buffer layer reserves for the console is an
> implementation detail and is applied by the kernel, not by the binding.
> 
> Signed-off-by: Max Pedraza <maximpedraza@gmail.com>
> ---
>  .../display/linux,boot-logo-clut224.yaml      | 131 ++++++++++++++++++
>  MAINTAINERS                                   |   1 +
>  2 files changed, 132 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/linux,boot-logo-clut224.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/display/linux,boot-logo-clut224.example.dtb: /: 'compatible' is a required property
	from schema $id: http://devicetree.org/schemas/root-node.yaml
Documentation/devicetree/bindings/display/linux,boot-logo-clut224.example.dtb: /: 'model' is a required property
	from schema $id: http://devicetree.org/schemas/root-node.yaml
Documentation/devicetree/bindings/display/linux,boot-logo-clut224.example.dtb: chosen: 'logo' does not match any of the regexes: '^framebuffer', '^pinctrl-[0-9]+$'
	from schema $id: http://devicetree.org/schemas/chosen.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.kernel.org/project/devicetree/patch/20260804225617.264861-2-maximpedraza@gmail.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

