Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EF4D3F54AA;
	Thu, 24 Sep 2026 11:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790250555; cv=none; b=ZiAe73QN3hjD7tCYuSudubYClz02Pkau1DPJDjP+zO57UtWtY/62wT8wEFEVW5m0GElI1SzncLxTUHNBXWL16qITp5I0GmW2Qpz8X9svef4zit3E2Fk+VapURE3y9TDK5gMUIskZZQExi3cjKxaNFzIaZ8BK0vb8jRjby/HAUmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790250555; c=relaxed/simple;
	bh=REXe1L/G5Swg4gI0yvsyd4VJtJnL+0m2IG48ctLZGqU=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=R3zY2SW+9itGKAacuntTz2QiP2Isl6c+SqoDY0b5f4kOqJMYBYFOUhbu+2JhwnkThAIfRMzk9PeKcFBcDD0bn1lJ+IMnyDBAgKPSIroPSYk4SJ6ZB2FSm9LrkuZjnzBNB5NwgLhlBAp7Fzm6/ia00mTsYNZ6Iw1gPpudiWDRD4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g0MhdNKx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g0MhdNKx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEC1A1F000FF;
	Thu, 24 Sep 2026 11:49:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790250554;
	bh=rku4KQA7zizHse97lsB6C+F4NuVJGArqTXbgqqfInPc=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject;
	b=g0MhdNKxQe8UYpGX4/RnEi6/0aLObAe5EkrCEiBvgjgHp6H+oAVv+Zaf7WgA+IDNv
	 yEz5kwGRWPnfapxq8h6fqm3rsffc92kdVfAeJVrYI+j7Y3KAB8vZyutd4vSB9fscl7
	 0ZDbc+g95lEJ8cId5H6t5LeMRYxMKmWAaztcM3htNcG9Y1Rz7h51kBirTc9gfRaiiq
	 yLlDb1njHf4MYIPMcbU5a/XzKRAIO/G7FpT7D1v4i7RIMAJlrgJumHKOlDHOasSASE
	 iI9S/t4hRFwQUElAO3DWbd8yjMZcgbBGOZX2PjY4fKJZWQip8VRTLpXKbVru0kOICI
	 NZs4HwRqPqi0A==
Date: Thu, 24 Sep 2026 06:49:12 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Maxime Ripard <mripard@kernel.org>, linux-fbdev@vger.kernel.org, 
 Conor Dooley <conor+dt@kernel.org>, Simona Vetter <simona@ffwll.ch>, 
 dri-devel@lists.freedesktop.org, Thomas Zimmermann <tzimmermann@suse.de>, 
 linux-kernel@vger.kernel.org, Helge Deller <deller@gmx.de>, 
 devicetree@vger.kernel.org
To: Max Pedraza <maximpedraza@gmail.com>
In-Reply-To: <20260923201035.51007-3-maximpedraza@gmail.com>
References: <20260923201035.51007-1-maximpedraza@gmail.com>
 <20260923201035.51007-3-maximpedraza@gmail.com>
Message-Id: <179025038211.3068273.9854294306608483193.robh@kernel.org>
Subject: Re: [PATCH v3 2/7] dt-bindings: display: add a device tree
 supplied boot logo


On Wed, 23 Sep 2026 22:10:30 +0200, Max Pedraza wrote:
> Embedded products frequently need a product specific boot logo. Today that
> means pointing CONFIG_LOGO_LINUX_CLUT224_FILE at a different image, which
> bakes it into the kernel image: a change of branding, or a second product
> sharing the same board support package, requires a separate kernel build,
> and requalifying that kernel for what is a cosmetic change.
> 
> Add a binding for a "boot-logo-clut224" node, which carries the logo
> in the same paletted format the built-in CLUT224 logos already use, plus a
> few optional properties describing where on the screen it is drawn.
> 
> The node lives under /chosen because a logo is configuration handed over by
> firmware rather than a description of the hardware. Open Firmware, which
> the device tree descends from, carried a boot logo in the same spirit as
> the oem-logo variable under /options, and simple-framebuffer nodes live
> under /chosen today for the same reason.
> 
> The palette size is derived from the length of the "clut" property rather
> than spelled out separately, and "data" holds plain palette indices; the
> 32 entry offset the frame buffer layer reserves for the console is an
> implementation detail and is applied by the kernel, not by the binding.
> 
> "logo-position" takes -1 on an axis to mean centre on that axis rather than
> carrying a separate boolean for it. A boolean can only centre both axes or
> neither, and next to explicit coordinates it would have to override them
> silently when a device tree gave both.
> 
> A rotation turns the logo, not the screen. "logo-position" and
> "logo-offset" are screen pixels whatever "logo-rotation" says, and a
> quarter turn only changes how much room the logo takes up. Placing the
> logo in a frame that turns with it would make the same pair of
> coordinates mean different places on the same panel, decided by a
> property that is meant to describe the image.
> 
> Every coordinate is bounded. The kernel clamps them anyway, since it cannot
> trust a device tree, but a value that cannot possibly be meant is worth
> catching in dtbs_check rather than on the panel.
> 
> Signed-off-by: Max Pedraza <maximpedraza@gmail.com>
> ---
>  .../bindings/display/boot-logo-clut224.yaml   | 135 ++++++++++++++++++
>  MAINTAINERS                                   |   1 +
>  2 files changed, 136 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/boot-logo-clut224.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/display/boot-logo-clut224.example.dtb: chosen: 'logo' does not match any of the regexes: '^framebuffer', '^pinctrl-[0-9]+$'
	from schema $id: http://devicetree.org/schemas/chosen.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.kernel.org/project/devicetree/patch/20260923201035.51007-3-maximpedraza@gmail.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

