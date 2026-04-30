Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3C9026A1B9;
	Thu, 30 Apr 2026 13:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777557224; cv=none; b=PhEDTMjHXONfy7BTvMChcVBQ+d2VoN5ghe0gdtEGIw9DSSNLeLRO5I2hwd9/WgkyjmozHrr+JR2VYhlqcCE2Yb788HZyOqNWKMFPtwuHVVn1WkvZsuMU2P1n5XwHgEFIVtuzGVtH8Y1gqXhax4p9DZ8lh6e4SXYMkzsWSXXLhPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777557224; c=relaxed/simple;
	bh=fWyb1fnAhDmuoMg4sCok6IXhdPjS4ufIlM7IHmfO3cQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=aUs9jqraahup+0xOjZngsy2hxlXYr4B5381GoruYuaBd5Fjt6R44bt++N/QA5i7tSpWTqHpa+ueEXTHSw3r3LYI4lJyFXFMknjZzIEfjeb8FKp5siMRDIJo3m2vy/mcOYtAgK0SiG3HrqPkHneqTmAXYkfsOZzLybz8YAw2xcVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BcaGs0Wn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BcaGs0Wn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76D4FC2BCB3;
	Thu, 30 Apr 2026 13:53:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777557224;
	bh=fWyb1fnAhDmuoMg4sCok6IXhdPjS4ufIlM7IHmfO3cQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=BcaGs0WnxaKXHcEN5c7CFyBz3gN9zxY+w5isfrSHyrkHWZRtHBSQDZ0MTtTCx2DEl
	 pelTfHZHQdyr2wijxR5oF4cfb9x7kHzT5cuPWdRL85aJa9J+T/QTBo+JwSsCu06drh
	 jALonMAMuEE5mo9+n4E41Gydnk49mRedhQ6yfjzoO5UKu5bJ1H4HeSn5QmDW24iWlV
	 FXTMpNkt4qlEobCNgek4pdZEJIGYC8L57RLYZsdABxEYZqA43YCjRGYajBXKZ0+odx
	 6m4DxopmDNnGa5lXamWE9k/zG5yjSuHq1RLRo3Sh19qPo01blTQPgkH2kXKQHYI1Bz
	 nl9+H5FMuQd7Q==
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
In-Reply-To: <20260407-max25014-v8-1-14eac7ed673a@gocontroll.com>
References: <20260407-max25014-v8-1-14eac7ed673a@gocontroll.com>
Subject: Re: (subset) [PATCH v8 1/4] dt-bindings: backlight: Add max25014
 support
Message-Id: <177755722019.2606736.10749503716773482329.b4-ty@b4>
Date: Thu, 30 Apr 2026 14:53:40 +0100
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.16-dev-ad80c

On Tue, 07 Apr 2026 16:41:42 +0200, Maud Spierings wrote:
> The Maxim MAX25014 is a 4-channel automotive grade backlight driver IC
> with integrated boost controller.

Applied, thanks!

[1/4] dt-bindings: backlight: Add max25014 support
      commit: 5fcbbedec9dfce78044eee922bf2030e1bd03faa

--
Lee Jones [李琼斯]

