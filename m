Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C8B2428839;
	Thu, 30 Apr 2026 13:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777557497; cv=none; b=Wzb5iuWWOBrjzoMLLZlaD9Feby6zMKuk6nRriEYcVW5laLks31QZwTldGAYNHz9wplB8MkTje8udWkjTMIwMCX80Ra/WS6v5m633xR0gPKT4C9DCpO4SB1WI5NEsm2F4c7eTqaWMi+GmIB2W77Lstih1FgYeTx+xAkcEflo1ds0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777557497; c=relaxed/simple;
	bh=o+8+KjdJ8yZ9gakFLBvMNa1VbfsIydfrHzxEKqLfIGc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=uwWYQaN1ZeZH4mvOM0+50bw+GpigR6wG01W3o7zzScFGFBtTJUPT9dIiYg/LaNjfU/t8Ec/hudDd585GaILfdKSfXjAd6aDVExGcg5JuxuOQXoVEOmXhHcrEJK4q0qwh57kBgZIzD2TN2fC6r4ePhpRrga+7sqKqgOSnR8QrkMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OuhE1BM6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OuhE1BM6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 295DEC2BCB3;
	Thu, 30 Apr 2026 13:58:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777557497;
	bh=o+8+KjdJ8yZ9gakFLBvMNa1VbfsIydfrHzxEKqLfIGc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=OuhE1BM62f7Wu/VvE9GJhsvrcGk6tTHvmjROQzTm6Tp1Ypek9rKLRu+hv9yqLnvU4
	 HBoM7skhBKxG0VWiRv/c3dYjcqZ3nmeWCqlSxiOIiiN8PT8lLEgszpW8xiSl9cJmu6
	 QVG0PbT1E0/FlDr1RUa1SdFA+p9fDFY20D7EJW/D/BfC4BTsmgG0Mj1mIpkGVPFqMo
	 MqwypdBusXGm5XJyX/AzodUXDIMaD3r/x6gBPxjXxSwh00tsBXG57qzUVvB65P91vL
	 ka0xloXLsGYPNd2XeiHHFno8ZzErWG8HaeHCzJ2kqJxW794cmjEXgauw4cgt64KOPP
	 MjeHpr/5k/jBA==
From: Lee Jones <lee@kernel.org>
To: Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>, 
 Jingoo Han <jingoohan1@gmail.com>, Pavel Machek <pavel@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Helge Deller <deller@gmx.de>, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, 
 Mark Brown <broonie@kernel.org>, Frank Li <Frank.Li@nxp.com>, 
 Maud Spierings <maudspierings@gocontroll.com>
Cc: dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-fbdev@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org
In-Reply-To: <20260407-max25014-v8-2-14eac7ed673a@gocontroll.com>
References: <20260407-max25014-v8-2-14eac7ed673a@gocontroll.com>
Subject: Re: (subset) [PATCH v8 2/4] backlight: add max25014atg backlight
Message-Id: <177755749291.2610033.12945503282955319463.b4-ty@b4>
Date: Thu, 30 Apr 2026 14:58:12 +0100
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.16-dev-ad80c

On Tue, 07 Apr 2026 16:41:43 +0200, Maud Spierings wrote:
> The Maxim MAX25014 is a 4-channel automotive grade backlight driver IC
> with integrated boost controller.

Applied, thanks!

[2/4] backlight: add max25014atg backlight
      commit: 3014ad47cfaf454cb0bbee353272beacd1e7c4bc

--
Lee Jones [李琼斯]

