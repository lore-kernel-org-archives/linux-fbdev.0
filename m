Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795773804;
	b=cnTv4P0/Ygtb1C3NZ+XoMlVS0PLa1bSueOZNsas0X1o6duazj2+NvgbZ+tbvbQ/6KNRH
	 sN7U6iOGoAlmie6uIDTEUhouiCFCLXv3L1h4IZ+TvYgGe/rxrrOHr5pzTm94Ns8276yEN
	 FGY66bjGW4f6t3svQRD/9P1EngUMZrHQDU7ozqci6qvTpuvesLXGQ5db+CgdBs9wyz37E
	 JeCbltijdr9z0IbXQpnGdXiwpEkUd8vSBWMp6q2R1clvmQEaoeCzMHNYTM77vQBcai6V+
	 gvmrQxmTTOEd4c30dqLwgrpFv/CIkkYcLS2kRR/lOeIHoGLIv5CO2Yal+uNvRh2VndQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795773804;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=lVOW8l75+YA+TNFgiPtCP7q5WQJyikZOcST3pLWFG+M=;
	b=R01BExZE7SjBNcQeH2aVPlnuX7TGnvJgx6HBosUgut4ugGNJxT4b5p2lD/SAHpc6d4XM
	 LRXb9glQwiFDqwKTTtUWCnagGjLnaB0EokVTtzKyvz1oZhpTBAK40wVoUOV4PjnkRVRp6
	 w/fth2atSbgwkii8nsQ7Fg47HeplUon/NWuh2wUOACrnI6sFwoyAQrXWG2iG/m7tQM22o
	 64Owrb7BBjaqp5Vo9XLDqhdIar5k3tR0kGaYQ3u6IWEN6X1KbuqbBqCzL5b8dFKXjcw6/
	 fi5Ai5KtD/thV3a/F56FUtS465PLDjzjqd7FtsR0HGbWnPFYyQhu2Sk8Wra6NwGWbCg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=cYH2v8JY;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FB5F606A327;
	Fri, 27 Nov 2026 10:03:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5FB5F606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=cYH2v8JY
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1A8C41758;
	Fri, 27 Nov 2026 02:03:20 -0800 (PST)
Received: from [10.33.50.35] (e142021.arm.com [10.33.50.35])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 671123F86C;
	Fri, 27 Nov 2026 02:03:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1795773802; bh=H8nZxnnDGCJuTHPvOjaWLW2hhq4iXdq3kr4GLdgMbYc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=cYH2v8JYfSlKSm6ZU73aDFvRc7WlCVMeF0g3+UbC9kRZKGdzHWwTu6gHISmDJwJ6K
	 VPEmR19SFFV0mQu2hCiL1pVSZ0H8xZZUlW21OAwqeV/XieQ/XSym4yfn7scqXB527u
	 nzRhpfMl8pWJ47e+AirLLdt5xtQdGK4IeMuewj1U=
Message-ID: <18637573-d20f-4a58-9e63-6bf71b015cef@arm.com>
Date: Fri, 27 Nov 2026 10:03:18 +0000
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Post: <mailto:linux-fbdev@vger.kernel.org>
List-Help: <mailto:linux-fbdev+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fbdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] arm64: dts: allwinner: sun60i-a733: Add simplefb HDMI
 support
To: Alastair D'Silva <alastair@d-silva.org>, Hans de Goede
 <hansg@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Chen-Yu Tsai <wens@kernel.org>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Samuel Holland <samuel@sholland.org>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev
References: <20261127080649.1982883-1-alastair@d-silva.org>
Content-Language: en-GB
From: Andre Przywara <andre.przywara@arm.com>
In-Reply-To: <20261127080649.1982883-1-alastair@d-silva.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 11/27/26 09:06, Alastair D'Silva wrote:
> This series adds boot-time simplefb HDMI support for Allwinner A733
> (sun60i-a733). U-Boot enables DE3.5, TCON_TV0, and DW-HDMI2.0 and

Where does it do that and which U-Boot version does?
I don't think we really want simplefb in the mainline DTs any more, 
unless there is a big blocker or delay for proper Linux DE support (like 
there was back in the A64 days).
In Jernej's HDMI series he hints about A733 support being pretty 
straight-forward with the reworked H616 DE code, so chances are we see 
proper DE3.5 support in DRM rather sooner than later.

Cheers,
Andre

> updates the disabled /chosen/framebuffer-hdmi node. Linux keeps the
> display clocks and PCK-600 power domains active across boot.
> 
> Tested on Xunlong OrangePi 4 Pro, based on:
>    [PATCH 0/3] arm64: dts: allwinner: Add Xunlong OrangePi 4 Pro support
>    https://lore.kernel.org/r/20261125124407.4098345-1-alastair@d-silva.org
>    [PATCH] pmdomain: sunxi: pck600: Initialize pd->pck in probe
>    https://lore.kernel.org/r/20261127080625.1982574-1-alastair@d-silva.org
> 
> Alastair D'Silva (3):
>    dt-bindings: display: simple-framebuffer: Add Allwinner DE3.5 HDMI
>      pipeline
>    arm64: dts: allwinner: sun60i-a733: Add PCK-600 power domain
>      controller
>    arm64: dts: allwinner: sun60i-a733: Add simplefb HDMI node
> 
>   .../bindings/display/simple-framebuffer.yaml  |  1 +
>   .../arm64/boot/dts/allwinner/sun60i-a733.dtsi | 36 +++++++++++++++++++
>   2 files changed, 37 insertions(+)
> 
> prerequisite-patch-id: 309a5a3ca5b216915907263dea7024263abf1d1c
> prerequisite-patch-id: 55e543b9854c7ae2fa86969233d05ccadd3792e9
> prerequisite-patch-id: cfcad85224e288ec2168e7f245b4a1c63e9a34a7

