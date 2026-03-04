Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13844397695;
	Wed,  4 Mar 2026 10:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772620711; cv=none; b=ITOl7ximtNGVe8ubXyORuYB2PrT1jvc3UX2xRFpRcMTKQtcS3m04w3o6BdODNukS77Ta87UWTbqDyC62oWGQQi8eEdXKZLBn/syPSTi8BFMRlhi8Vqa/CSVGVDl2IMmQoI37A+C1SHFR30NK0ptwup54BFymTaBvBH+h6QISNt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772620711; c=relaxed/simple;
	bh=qJq5OiNAaCAjRVT0mIH/WZXQf7nV9YcAogd2Uml1ylQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gy+pLHhHprMqWedAMQPLpeS1Cq2TtiE0rCTRRqGcx+c+iAoCpaklOrbCj8OHBp1urua6ovBoZ3qKDfSYx6ztMXJUXI0p7dwcj/UzNFgXAt4qzlHuAyJu82vQE6elE7IMtq11hGctOPEOhDaVL/ZfIa3FFohh3CkRCXLYOHibxCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YMqciHFo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YMqciHFo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 736C1C19423;
	Wed,  4 Mar 2026 10:38:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772620710;
	bh=qJq5OiNAaCAjRVT0mIH/WZXQf7nV9YcAogd2Uml1ylQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YMqciHFoHWkm0gdqztZeLKiemNl3siyzBI9JJfaPcMdT8MnwG8uZJAZnWeXfvhmgc
	 RBbiLcNSE37QC6l3M5S695MBfoaBuUeH92sFKI6pShPK6h11T2yBi355R+v2aGU4VA
	 tEop2mpy9xTaC1Mi9Y5x0lPqIVTcNFXBehIyKaisVMxdR7K93Ay88v2l7LbmNeb9xI
	 UJCHicElosPEGA+VkGrYBQg2G4D757XwE6Tbr0Ww9mxh2XN8/xSlCEWChB5ttVKOss
	 ztuzmODhMiMQtHOl8s3Q7S5gagk09kWwS5G4meOD4z2JBSUCem+W3qOrhBvehVxvdM
	 eue7k7dU8I58Q==
Date: Wed, 4 Mar 2026 10:38:23 +0000
From: Daniel Thompson <danielt@kernel.org>
To: maudspierings@gocontroll.com
Cc: Lee Jones <lee@kernel.org>, Jingoo Han <jingoohan1@gmail.com>,
	Pavel Machek <pavel@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Helge Deller <deller@gmx.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, dri-devel@lists.freedesktop.org,
	linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v7 2/4] backlight: add max25014atg backlight
Message-ID: <aagLn0PyqLqcwS4R@aspen.lan>
References: <20260123-max25014-v7-0-15e504b9acc7@gocontroll.com>
 <20260123-max25014-v7-2-15e504b9acc7@gocontroll.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260123-max25014-v7-2-15e504b9acc7@gocontroll.com>

On Fri, Jan 23, 2026 at 12:31:31PM +0100, Maud Spierings via B4 Relay wrote:
> From: Maud Spierings <maudspierings@gocontroll.com>
>
> The Maxim MAX25014 is a 4-channel automotive grade backlight driver IC
> with integrated boost controller.
>
> Signed-off-by: Maud Spierings <maudspierings@gocontroll.com>

Reviewed-by: Daniel Thompson (RISCstar) <danielt@kernel.org>


Daniel.
