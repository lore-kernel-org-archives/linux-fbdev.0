Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E433B3AB476;
	Sat, 17 Oct 2026 16:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792255102; cv=none; b=D3tKsSyD+kuTjDBslnCChfbQ8/7r04kmh3r/tflIpBIaiSsU6ngKpI3o7asIZRO74XtcH1Geh4xHUOe0GwR2XNAu8nMtnxW6BBOkppmCL/Q1lP1gTMkHjB/tQLNVB27fFPpdI2RnsISF5RxeQG80syIAK+RV5tTallczVctiNGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792255102; c=relaxed/simple;
	bh=7EiPx0NfRryy1nAIN66IRR7ixmX6dy/1tOd8GWKR/28=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hmyqUtGNc5WFa0qljSDoMC/vhTgS9lPgOTCHIZjymd5yk+9PJNOz61v2Ynccg66SZxINW08hUF3js1QEoMJzH40W6TOdbFc+THE6rTp76SRn3mTIvMU7rEWLmufhKZ6MMIedMUzaW1UmrUrrrv4FGPJke57b8ueCsqsLrWYRf/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jCuGupfy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jCuGupfy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A34E71F000C6;
	Sat, 17 Oct 2026 16:38:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792255101;
	bh=IkiZRXdHDuxcbh3YWL1x4MnwjgrmBjjwtgqZJbbbgbQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=jCuGupfy4jWF+0lGgY6Gs3HyP6UkDNsk4OSXNaHKJDlvwrnIcPPqKAiwHPoCfbvKE
	 7KSRFdG6nlG7/3t8LLipzYqID1wnEVOlt/sokgkx5pwUxa0fFS5wtj9Y3JZY1oUK6o
	 QA1zCvjZFagOfOFxcjvkO2pQLGd6V6bpR+1CTVh/g07aesuXL1ycxDXHe69rD5oE8m
	 xStY3gtKO5pp/Lb4jRJU4k7pjhEwPHfWV54qvsIdctTtodesH5xF2YB3Egow3O6JVP
	 gxDbJGZ32dDunUPkFuz+vd9qYaEVFIN6dGpDXD6ge4FjpuyQtYS4Q0Jb+u0Oxju7mc
	 HhxryQVdJPiYg==
Date: Sat, 17 Oct 2026 18:38:18 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>, 
	Jingoo Han <jingoohan1@gmail.com>, Helge Deller <deller@gmx.de>, 
	Kiran Gunda <quic_kgunda@quicinc.com>, Subbaraman Narayanamurthy <quic_subbaram@quicinc.com>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Stephen Boyd <sboyd@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Abel Vesa <abelvesa@kernel.org>, 
	Dmitry Baryshkov <lumag@kernel.org>, linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	mfd@lists.linux.dev
Subject: Re: [PATCH 4/9] dt-bindings: mfd: qcom,spmi-pmic: add LCDB
Message-ID: <20261017-notorious-degu-of-refinement-2d3f42@quoll>
References: <20261015-sm8150-display-card-v1-0-5c14928cef29@oss.qualcomm.com>
 <20261015-sm8150-display-card-v1-4-5c14928cef29@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261015-sm8150-display-card-v1-4-5c14928cef29@oss.qualcomm.com>

On Thu, Oct 15, 2026 at 11:58:41AM +0300, Dmitry Baryshkov wrote:
> Allow the LCDB regulator block as a child of the SPMI PMIC node.
> 
> Assisted-by: LLM
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---
>  Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml b/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml
> index f6534e9e9912..1894fd82cbda 100644
> --- a/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml
> +++ b/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml
> @@ -171,6 +171,10 @@ patternProperties:
>      type: object
>      $ref: /schemas/input/qcom,spmi-haptics.yaml#
>  
> +  "^lcdb@[0-9a-f]+$":

This should be "regulator", if I understood correctly the device
purpose.

> +    type: object
> +    $ref: /schemas/regulator/qcom,pm8150l-lcdb.yaml#
> +
>    "^led-controller@[0-9a-f]+$":
>      type: object
>      $ref: /schemas/leds/qcom,spmi-flash-led.yaml#
> 
> -- 
> 2.47.3
> 
