Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BD1E3F6C51;
	Fri, 15 May 2026 16:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778861804; cv=none; b=fwXzxXW643fmB714WDHNjM9y8uTa1or9P/uF1CmAOBLKDjdebiqkMAebmDDAsLIBFPnoNyOCllU3X7+OUVPUYxI8h9GgAiFpHfSq4CYFr1NEGvU1vYhCfV6nTnxxaSIIVHzhjWUyyDTHaR4v2ih2m1PVLe2rIGOJ5dlH8ZaXdLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778861804; c=relaxed/simple;
	bh=mqYa/GHvUQdJjr9Q95SDUrpGgPrZMqy7TvdIMziLca4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F8ejHZRvOat+F/pOzH+zpdyGckD17uSwL053f/H7I5gYQJW0WgW5hsqHltL5Rp/hwgCompI8IgR3AXDgzGVy0flnNfnX2vWDGDHk3HgAnPQbNGfHMBQEUiqLGaCAClV6L1udmHibbbZAWMZYCIIRCxngQkM2kfkNduTnVsEDdgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rm0aXw47; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rm0aXw47"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1BCCC2BCB0;
	Fri, 15 May 2026 16:16:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778861804;
	bh=mqYa/GHvUQdJjr9Q95SDUrpGgPrZMqy7TvdIMziLca4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rm0aXw475XclSOQxzbBcwZmoJvlAcMjc/q9W7OMqBVQu7sP6shKwJ9Z+kMjOl2eMX
	 JuusKkOGT+DqKZhtyGCVb7YQffUPqnz4cq0gR/oD0MQAXDw7lqa4yJKDE1i9eQzISm
	 Zsrih3IKg28VGKiLPrK7+jfFe9s3JJ3h6YgMP2R3pXiq5aPn2ZPf6Cg6MyLTTPTKYt
	 Ulao28EsiYLXO8TmWkHGGJbV0clMoMbHTKjDcL1Nws8E58CFEn8Q4sf8n7I7J/+azl
	 yA4PDtVTEZ3Cvs2TjzwFUH5WTnAtDlu9mK65GKDBLsJKSnneoOYxMb0q/5OCbkKIjg
	 MDcuaigPoKUCg==
Date: Fri, 15 May 2026 17:16:38 +0100
From: Daniel Thompson <danielt@kernel.org>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Lee Jones <lee@kernel.org>, Jingoo Han <jingoohan1@gmail.com>,
	Pavel Machek <pavel@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Helge Deller <deller@gmx.de>,
	dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-fbdev@vger.kernel.org, KancyJoe <kancy2333@outlook.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: leds: backlight: document the SY7758
 6-channel High Efficiency LED Driver
Message-ID: <agdG5hdbLkZt2pAZ@aspen.lan>
References: <20260430-topic-sm8650-ayaneo-pocket-s2-sy7758-v2-0-308140640de9@linaro.org>
 <20260430-topic-sm8650-ayaneo-pocket-s2-sy7758-v2-1-308140640de9@linaro.org>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260430-topic-sm8650-ayaneo-pocket-s2-sy7758-v2-1-308140640de9@linaro.org>

On Thu, Apr 30, 2026 at 11:47:15AM +0200, Neil Armstrong wrote:
> Document the Silergy SY7758 6-channel High Efficiency LED Driver
> used for backlight brightness control.
>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>

Reviewed-by: Daniel Thompson (RISCstar) <danielt@kernel.org>


Daniel.
