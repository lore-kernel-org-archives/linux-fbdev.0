Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 043A4348C53;
	Thu,  2 Jul 2026 16:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783009907; cv=none; b=qbv63i2PZZTX/MAD56B7/Q61USqQZkZlb6Ci+zruQJHzMicrJbFSgMOcmSqEoA0d1hVXqXhVrxq1kgpBz/Z00PpylkZFYdkb3LNIpSA3caWgDOY8UoIBMpIFZIkF149ZqeKKuFiJEU1kuDue2Nh4R8lDZ/AJ8q7E9J/9dO+PDik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783009907; c=relaxed/simple;
	bh=6p9oJw5MFDn+kSUamq/zaTSh6Mx38EjNSlPb/ngjyHw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=fNmEWJF+vTdwzBUox2dpXb++YQfsKLQVGN7ZTQ7mVP7OPcwvqMJdQL8PC8j2Qx2stwBB9gRLdWYmd+3QONyeI6ncCeIMuLfjEE7vQXlc9Dfx68wf+fHSyMe+LyjdgkYiZ4LoZRnkHt/zMgLXT7zy/zAn2OnWlKLEDOlKx7d8E4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FpMAF901; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FpMAF901"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B82AB1F000E9;
	Thu,  2 Jul 2026 16:31:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783009906;
	bh=RzzfmIogOoChfCuB1Ba9o2vBi864tKCQNnuaaTtA2d0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=FpMAF901KOCXsLd9Peup0g2nFxlws6YELsM6AeOcDUdHrNZTxBbYwbFPemRHFOrPm
	 WeoMU7b24n0MLm0SN62gtXKt6cOaVz1trQF1m6P6xawmpvqbHMtuekkcUE2BKRN8oy
	 iNtPaMFUFktzbSTbZSgrhOaVguNpvX0/clrZNEZoRJ0UeEkYhXB6HmPh5Q6K/0Tn2w
	 dlbUR0TG0l/hGuupWcYnV6+Ze6hQtoQIOx0dbDSduHKInlWJ5HkcVqY8dh6h1xsZp8
	 1SO7zYM2TcWCJjyBxxdwyQ66uyj2W11jhZ3BZHot3XYroQmTM1PHfj2EoYrca9LoZL
	 U6evvTzS2aACA==
From: Lee Jones <lee@kernel.org>
To: Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>, 
 Jingoo Han <jingoohan1@gmail.com>, Pavel Machek <pavel@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Helge Deller <deller@gmx.de>, 
 Neil Armstrong <neil.armstrong@linaro.org>
Cc: dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-fbdev@vger.kernel.org, KancyJoe <kancy2333@outlook.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
In-Reply-To: <20260529-topic-sm8650-ayaneo-pocket-s2-sy7758-v5-0-03aacd49747c@linaro.org>
References: <20260529-topic-sm8650-ayaneo-pocket-s2-sy7758-v5-0-03aacd49747c@linaro.org>
Subject: Re: [PATCH v5 0/2] backlight: Add SY7758 6-channel High Efficiency
 LED Driver support
Message-Id: <178300990349.2239788.13080024963462152507.b4-ty@b4>
Date: Thu, 02 Jul 2026 17:31:43 +0100
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.16-dev-ad80c

On Fri, 29 May 2026 21:23:07 +0200, Neil Armstrong wrote:
> Implement support for the Silergy SY7758 6-channel High Efficiency LED Driver
> used for backlight brightness control in the Ayaneo Pocket S2 dual-DSI panel.

Applied, thanks!

[1/2] dt-bindings: leds: backlight: document the SY7758 6-channel High Efficiency LED Driver
      commit: 2019a2a7268f6f7387f052110558b9f90b500324
[2/2] backlight: Add SY7758 6-channel High Efficiency LED Driver support
      commit: 110d67699a430daf0316f941254c46221e3f0914

--
Lee Jones [李琼斯]

