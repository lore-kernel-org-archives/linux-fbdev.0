Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 506DD1F1908;
	Tue, 11 Feb 2025 14:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739283174; cv=none; b=dbfA4Q538RplDZW5VTkt80X4CYO9NDusF/J2v6EPVqAzGhmVAeUR8HANOitYonDWzWNgDfCKNvSNmVMrXIWyuIFPwz7uUVyEiCv80Sdgoh9k0cHchk5CRk3Nzih6JvHdyR/e3+arzr2iN4nl9vGNYUGLgpVCWvt5o/CEaJixV/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739283174; c=relaxed/simple;
	bh=mKSUCR+IxE2qXFtP516xYX1WLmqPO++UTOjw4oSFExU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=HLzN/MRwFUMSNP6IyFwxLmzW5bJq6/BI17eUCOX95Wfh/q5FJ49sAH2YGDrFUdHFEGL6pfkbi2BcG/3iQiL3JDX3ic0WXKQHxWMty5H9+JSZ68GpWJBT7e9E/lMutPQJaiplTXNlCJ/aR1jsJbMl7ueHNy9IW4vyJTWIzJ5yxZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zqm4MJiI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zqm4MJiI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8C21C4CEDD;
	Tue, 11 Feb 2025 14:12:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739283173;
	bh=mKSUCR+IxE2qXFtP516xYX1WLmqPO++UTOjw4oSFExU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=Zqm4MJiIkFFoWcKdN3F0zazpM02h7BwB8rgHvGPCSG4u52Eb1rUEc70R1Wa1b9dlu
	 1D1lqWnIUeYrB3TsjWc9qKX9r8rmQ3oG9+XeB5FSaWaFxGvIu+lG4V+DV+2yhWBl8d
	 HI5mdo5/OY7qx3UBTtn1w1OCaDrkGRXdF7YbBtNPDTbiwJCRPzAUXqYYzKE2XnUYic
	 +MxdOdwWNQP6UwEkZVKU8o9GlFV/JYwJl3ZP5lJ7s3NjaRNGgyenpo2/hmnbDi73oL
	 vOyrrkx2Be2TGovr6cUYn0OZMrjjms2FJSCWZ9R0kA6Cb2r7d5Q42WDvppnkZUzLu3
	 J+YqE/RwSDm2Q==
From: Lee Jones <lee@kernel.org>
To: Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>, 
 Jingoo Han <jingoohan1@gmail.com>, Helge Deller <deller@gmx.de>, 
 Tony Lindgren <tony@atomide.com>, Pavel Machek <pavel@ucw.cz>, 
 Tomi Valkeinen <tomi.valkeinen@ti.com>, 
 Jean-Jacques Hiblot <jjhiblot@ti.com>, 
 Herve Codina <herve.codina@bootlin.com>
Cc: Daniel Thompson <daniel.thompson@linaro.org>, 
 dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, stable@vger.kernel.org
In-Reply-To: <20250122091914.309533-1-herve.codina@bootlin.com>
References: <20250122091914.309533-1-herve.codina@bootlin.com>
Subject: Re: (subset) [PATCH] backlight: led_bl: Hold led_access lock when
 calling led_sysfs_disable()
Message-Id: <173928317062.2187723.11690130605159710532.b4-ty@kernel.org>
Date: Tue, 11 Feb 2025 14:12:50 +0000
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.13.0

On Wed, 22 Jan 2025 10:19:14 +0100, Herve Codina wrote:
> Lockdep detects the following issue on led-backlight removal:
>   [  142.315935] ------------[ cut here ]------------
>   [  142.315954] WARNING: CPU: 2 PID: 292 at drivers/leds/led-core.c:455 led_sysfs_enable+0x54/0x80
>   ...
>   [  142.500725] Call trace:
>   [  142.503176]  led_sysfs_enable+0x54/0x80 (P)
>   [  142.507370]  led_bl_remove+0x80/0xa8 [led_bl]
>   [  142.511742]  platform_remove+0x30/0x58
>   [  142.515501]  device_remove+0x54/0x90
>   ...
> 
> [...]

Applied, thanks!

[1/1] backlight: led_bl: Hold led_access lock when calling led_sysfs_disable()
      commit: 276822a00db3c1061382b41e72cafc09d6a0ec30

--
Lee Jones [李琼斯]

