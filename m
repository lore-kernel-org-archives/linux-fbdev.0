Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54FA714A4D2;
	Thu, 13 Jun 2024 17:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718299213; cv=none; b=gxmUJFIinl5Iq9J2HDhdmpmKvTufg9IGeelcGsYe5Y7jiZmlJbnw8rJeyO04Lm3vPkEsx/hi7aHEWvc2QQS50tzRZoFtKMgDxi02jjjENUXSUhinjzsOIoDnIJjcoXO4tpxImJ5PvImSnSgoPUDRzZTHY7JWMQvgctiRBoUxaMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718299213; c=relaxed/simple;
	bh=Apy/YJfzCXG5qBffjVb5Em/7Y/ajo8ZRh+LCsukDKns=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ifx9IjiCMm46I1p1wTvzGACANJBojIW3v8ckfBxhZvcRFSKHthJp9Co45mAuit4PeIM4jbW5/2+iQf1Sm85XkmRtjno3btbPmP4e23PD8xDFvmJGICWusS6pXPeB1ADvzlZQvpcDZSNANHNWwXBIZqst5a6k+PJdXFF6lFdMn6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kXFfAgqG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kXFfAgqG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66789C2BBFC;
	Thu, 13 Jun 2024 17:20:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718299212;
	bh=Apy/YJfzCXG5qBffjVb5Em/7Y/ajo8ZRh+LCsukDKns=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=kXFfAgqGGfRDajw1ZdSl8ujZ8VNXRrUmaB5qtDjpeh2Z+N7taNOmSuloB3JcuLlxY
	 cQn7auRp4fQYw9q4qszuzglsJCU4SucZjkUAaahDbFKjsIUGkRvXpP28EcpM0Agd9K
	 n8d6bfEiH0f0BmM9k7yQCnIqphMMFwSJc9DQSOvYG5VyhINGHmMerx0TozM2JWMXJX
	 jp0xnrq5xZme5OE7Lfk6dn0LQxUWD094vSQxaCEtvXPP0ZS3q3C5r0ygn1by4LYoFv
	 98QoRL7uyWnk0lrdx5nK4cw8ssU22dTHjOyn6y7qQGitRvmteIrGdvFrr/zCW+s5Bf
	 yMtoAR8UHUmOQ==
From: Lee Jones <lee@kernel.org>
To: Daniel Thompson <daniel.thompson@linaro.org>, 
 Jingoo Han <jingoohan1@gmail.com>, Helge Deller <deller@gmx.de>, 
 Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
In-Reply-To: <20240612-md-drivers-video-backlight-v1-1-f4ca1beb36cc@quicinc.com>
References: <20240612-md-drivers-video-backlight-v1-1-f4ca1beb36cc@quicinc.com>
Subject: Re: (subset) [PATCH] backlight: add missing MODULE_DESCRIPTION()
 macros
Message-Id: <171829921116.2731555.2620177411029795057.b4-ty@kernel.org>
Date: Thu, 13 Jun 2024 18:20:11 +0100
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.13.0

On Wed, 12 Jun 2024 07:12:31 -0700, Jeff Johnson wrote:
> With ARCH=x86, make allmodconfig && make W=1 C=1 reports:
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/video/backlight/platform_lcd.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/video/backlight/rt4831-backlight.o
> 
> Add the missing invocations of the MODULE_DESCRIPTION() macro.
> 
> 
> [...]

Applied, thanks!

[1/1] backlight: add missing MODULE_DESCRIPTION() macros
      commit: 7857f5c38d04a38e7a20060a6d370caf0424aa4e

--
Lee Jones [李琼斯]

