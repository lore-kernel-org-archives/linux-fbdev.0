Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95A5237C105;
	Tue, 16 Sep 2025 16:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758038737; cv=none; b=k9BuiXPvPCxqjtIg42BO9cELPK8y17KraRVpg+i4buHN39LnXz97d2ldcdD67uSGXtvRt2VmsIOGmcU0V8YmU+Av5XvvtK65ymOJK/dqrjy66Hllq7mySEOf30UO9ZAdGEP+sGflR7DKTwS0E3/scwum23ttA7d6G7IGbJCxtLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758038737; c=relaxed/simple;
	bh=E9SMcxHSoCpJNgbDzSmLk+ndjilBuArwSxCCWSsKG1g=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=osNII2Sait0mF/v9HxHzAo2Bsyb8kcDXxcTwSIu7mHtD2+D+PvCZxa8f3MzCq792UxaF0uZqqXmj2n+Up/o3D1w5822gfpBkMf13uolEsL+UNGLqub4ZDginj/JW7RmfQjBzqAfi+PlSocIl9GfTWod52bYteI+7Ojj+GbUJsqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tbqHYGCw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tbqHYGCw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A03B0C4CEEB;
	Tue, 16 Sep 2025 16:05:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758038737;
	bh=E9SMcxHSoCpJNgbDzSmLk+ndjilBuArwSxCCWSsKG1g=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=tbqHYGCwBfUBNylqSnwL3+TbYxHsobIxgtc1efGS4zt1OiQFdygz9bcuA2PJyOwYh
	 FdRvLPAaXYggXf8zxLa9qhKgTWwmALNXGaW0za35f5zRs4oM26SKB42QkLh4WCahGz
	 1yR3hWJYtOOzziuLVb1LbFFvGz29vhXaYjxI7zOnabXtIUYvQlsDR4XQzITzQifYwb
	 8838F0lFCIaQR4Xhij8PTIQ9AfyE82JFvmOV+Cy0PsjRVsiQB9xJuluHaOuXALapEe
	 u06NFSkpXTSd1LLMrZdA+67GL0duvy8avwXW9b1adTTDvz+RbV708DzG9LDVncD8Xf
	 zlkIM2McP3b5g==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org, danielt@kernel.org, jingoohan1@gmail.com, 
 neil.armstrong@linaro.org, jessica.zhang@oss.qualcomm.com, deller@gmx.de, 
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, airlied@gmail.com, 
 simona@ffwll.ch, fnkl.kernel@gmail.com, j@jannau.net, 
 ilpo.jarvinen@linux.intel.com, sven@kernel.org, alyssa@rosenzweig.io, 
 neal@gompa.dev, support.opensource@diasemi.com, 
 Hans de Goede <hansg@kernel.org>, duje@dujemihanovic.xyz, 
 Thomas Zimmermann <tzimmermann@suse.de>
Cc: dri-devel@lists.freedesktop.org, asahi@lists.linux.dev, 
 platform-driver-x86@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-fbdev@vger.kernel.org
In-Reply-To: <20250715122643.137027-1-tzimmermann@suse.de>
References: <20250715122643.137027-1-tzimmermann@suse.de>
Subject: Re: (subset) [PATCH v2 00/15] backlight: Do not include
 <linux/fb.h> in header file
Message-Id: <175803873238.3892705.12154571803108246655.b4-ty@kernel.org>
Date: Tue, 16 Sep 2025 17:05:32 +0100
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15-dev-c81fc

On Tue, 15 Jul 2025 14:24:37 +0200, Thomas Zimmermann wrote:
> Remove the final dependencies on fbdev from the backlight subsystem.
> This is really just the include of <linux/fb.h> in backlight, but it
> has some fallout in other code.
> 
> Patches 1 to 14 fix all the implicit includes that come from fb.h
> throughout the kernel. It's all trivial, but touches various drivers.
> Maintainers are in CC. Patch 15 fixes the backlight header.
> 
> [...]

Applied, thanks!

[06/15] backlight: Include <linux/of.h>
        commit: b12224c28d84d054dfb680c05cda61d1e2584bf5
[07/15] backlight: apple_dwi_bl: Include <linux/mod_devicetable.h>
        commit: 945e411acde3800234d506f4304203a9b11890f8
[08/15] backlight: as3711_bl: Include <linux/of.h>
        commit: 6789cd935a57464deaacdd14c84bc026aa228e72
[09/15] backlight: da9052_bl: Include <linux/mod_devicetable.h>
        commit: e2e76f67bdbbc7b8df608e3dd1028059d838871e
[10/15] backlight: jornada720: Include <linux/io.h>
        commit: ce4bb1a2f1cbcd5f6471f74ee5c7e1443a4cfd84
[11/15] backlight: ktd2801: Include <linux/mod_devicetable.h>
        commit: 5f60004f152b432c6ae5dbacc172adc1fa215825
[12/15] backlight: led_bl: Include <linux/of.h>
        commit: b38ed7c05a35f3a029c2fc5e43a94aa81e2ac843
[13/15] backlight: rave-sp: Include <linux/of.h> and <linux/mod_devicetable.h>
        commit: 246da2b48e2ce973db255fc4b6faf42f73c03114
[14/15] backlight: rt4831: Include <linux/mod_devicetable.h>
        commit: ba3b29a639fe5173033914db6ee58d8d9bb86aba
[15/15] backlight: Do not include <linux/fb.h> in header file
        commit: 9f218f9bb9d274b9d5d48a4c95e1b199141fc1f2

--
Lee Jones [李琼斯]

