Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792483054;
	b=Nwk3MWnsu/bimvOH1/a2KCp21MZBY58PpAluNbNqTZnh5hY4Lphy2pzyoUJCfarGB7Re
	 VBE43tp7kAdqhWIySz2M6CDggIM2hGeVn5ZXLIuXWhIMr2Dn3GZRgl7e5iHkB1M2d56mc
	 HnnFjPjCSoSvXy971g4/9+BCD3/VM4Xl5wtSg738lZG1gNAdrQlRFnY4IRjejAOzkrhxi
	 JG3CcDyMqvWwiz1wIf5FJotOICgoQkSLynlVAKi1JRstmwZgGiVCw0jRNuN78SvGFkYa7
	 jBwY6GhWL6C1HYOi4wXdzn/FgY2JpC60TRY0/xoBxDPCQzrCW6aNeqa3PPt1kbJhMyA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792483054;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=mlPkgtEB9wKXaP4Uhs/P2TX0qVUv9caR1167FeDUJuI=;
	b=HBMlU8OnfvWfF7O7uRZKikYPruCCho5W850tzpSGBLu09+yo0AdRW9x4ktIVHTWqxSsG
	 i+/DeGZxSKyQPgVZnz/7/7VgKNepkUZ5J6in2KH19bzGc+t6jRAggah54eSd8Pp7Q0gpM
	 cD5a0LK+5WF55kqP09QSfPehqdcVXTNliYFvjiEsXcDPKxbYzwKBSFkD8JZrItp7UOZ7G
	 dEtieGZjJZGHT5S3XBtyTecfQoafxvsDxmRfb64ovP/Pzok2idlUdzsad66tcGTRApe2A
	 Q83JyFzYjbdgcDGM/GOLUZPQQWQJVBiwd4Nkz+8sj8CoTOfMafDceQLQeDthS1y0Hkw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ojpGzEti;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C24FD606A319;
	Tue, 20 Oct 2026 07:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ojpGzEti
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3D991F000C4;
	Tue, 20 Oct 2026 07:57:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792483053;
	bh=mlPkgtEB9wKXaP4Uhs/P2TX0qVUv9caR1167FeDUJuI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ojpGzEtibXYnqSq9ttf61L+ZIWw0Wx9Twmh0EIk8ouSDAztcpTeEnFjBS9N8qjlf3
	 MLCqVqz6MIqwM/grpczvF0LdWSmHeBHwxZ2qHf8YM2rZgaYZXna7qDpqea1orbW3Ln
	 998+tYMvswZWi7MWx4seCVbFucQqGMSG1d5KZo46hagSfCL1xI0f8gees37yPm41bJ
	 ES8Idwn2w/Z1Iy39pbrKKRDBwrT2c8pMfRTy3t9RlQAkSgmhHbCVEZrP2zrLnsETgV
	 Z1ngMMa2LXlPAG6P9WIdaNoCu/l8RyWm0gMRZXK2i8vk42WzSRk+CrZqRrHVXoMQzO
	 IYHc6AGHJ0zPg==
Date: Tue, 20 Oct 2026 09:57:30 +0200
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
Subject: Re: [PATCH v2 3/8] dt-bindings: mfd: qcom,spmi-pmic: add LCDB
Message-ID: <20261020-illustrious-amorphous-ladybug-8a8526@quoll>
References: <20261019-sm8150-display-card-v2-0-86c05068efc5@oss.qualcomm.com>
 <20261019-sm8150-display-card-v2-3-86c05068efc5@oss.qualcomm.com>
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
In-Reply-To: <20261019-sm8150-display-card-v2-3-86c05068efc5@oss.qualcomm.com>

On Mon, Oct 19, 2026 at 02:25:39PM +0300, Dmitry Baryshkov wrote:
> Allow the LCDB regulator block as a child of the SPMI PMIC node.
> 
> Assisted-by: LLM
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---
>  Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml | 4 ++++
>  1 file changed, 4 insertions(+)

You need to document/explain the merging dependencies. This looks like
cannot be taken alone.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

