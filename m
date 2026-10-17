Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6175037DEBE;
	Sat, 17 Oct 2026 16:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792255055; cv=none; b=cSUE01NliVNcBk2g9H6nykQYKpAvKhGooHp6MlaXpQZ5xeSAkX1cj8lYrU3rWsnRd2xBzI3rljZerppkkdJ0HS1voggS+AT1SUk1JTHBvTySAtYBegAXG8byMoo7Y5su8YtdXbw85QWwH9wabBNIfajoSFqBzpzNpEN1Ot2Ak/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792255055; c=relaxed/simple;
	bh=Kxy3m8TYu9b7PA1MA5QaC7rocyw0sBLIPEymVIRi1DI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PG76O4dKmRCPUGpzWPd1Q6N6edT0cjtEf4Vta2fNF5MKDRzxPwzDew+uEFv5UDhsWzFtg5iV1nWzb7b9VZdJHC1KZZY3gigyRPJirJomq/mQ/C/mt2FCAHia6l9YHsa73MqKpwk+dmuqp/2IpBqh5csFVhnJdGvOTIH5aJxtZuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ajgpPwRD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ajgpPwRD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BA291F000C5;
	Sat, 17 Oct 2026 16:37:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792255054;
	bh=5YQWSI4ybuP3+qZ2WIH2lJW4okdIiZktG/jNbRw5lxc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ajgpPwRDVpSR9qx+gRAnR4zdOE14k/fr+tSCNxvDM9/65ngZPp1Ifrc7Ip9953irt
	 Dr7Evyr7Ze7W+5VoACIzLie7isRpU6TtSFfFpVcvc+m2G8p1sau9lo9HZzh1h5i0Ip
	 5difS6URCxy1Y9xpyryb4Rc2msfm9AYTzYzx7GfMAPMHI01c2ttXn9XJKxdtZhceoF
	 1wmwj/SY01hBxkRr8Rl5iTuHIIit6IwmzaWT7SoOoTo3h29TsEgZ4Iu+JyS8AfCU9S
	 W/ogJWye0OPYbC+FiuDh8ELsqPoeH8gT8IXip6qiat3mN8x0M3ZZ3PJAEx+gY8mKCC
	 YBFouicgvrr4Q==
Date: Sat, 17 Oct 2026 18:37:28 +0200
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
Subject: Re: [PATCH 3/9] dt-bindings: regulator: add Qualcomm LCDB regulator
Message-ID: <20261017-daffodil-buzzard-of-amplitude-9e817f@quoll>
References: <20261015-sm8150-display-card-v1-0-5c14928cef29@oss.qualcomm.com>
 <20261015-sm8150-display-card-v1-3-5c14928cef29@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261015-sm8150-display-card-v1-3-5c14928cef29@oss.qualcomm.com>

On Thu, Oct 15, 2026 at 11:58:40AM +0300, Dmitry Baryshkov wrote:
> Several Qualcomm PMICs have an LCDB block providing the positive and
> negative bias rails for LCD panels. It is not supported by Linux, so
> boards using it either model the rails as dummy fixed regulators and
> depend on the state left by the bootloader.
> 
> Describe the LCDB regulator present on the PM8150L. Use it as a fallback
> compatible for LCDB blocks on PMI632 and PM6150L. PM660L has a different
> version of LCDB block, so it's not being covered.
> 
> Assisted-by: LLM
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---
>  .../bindings/regulator/qcom,pm8150l-lcdb.yaml      | 81 ++++++++++++++++++++++
>  1 file changed, 81 insertions(+)

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

