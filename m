Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6937C28466E;
	Tue,  2 Sep 2025 10:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756809657; cv=none; b=lkMxgpSh0pyOZQXmD5/7cs4eBta7IG5a/y+fQWsh5ARfWlDKeLuy9BmkbOPWnAcIIqjujijZFZjjhEYBolHIhGQhQdzehQzuwB0Ul7iu6+X4/FQ+AMdgXCwJ2hySQEPpPakylHCfe+Qft4hJGBrGrX5Asu2oJFLICx/BCO16wls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756809657; c=relaxed/simple;
	bh=4EdmcQuNQy+OKjG07zuxiwGokehf0Nr2XE4I/Phgibo=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=RgBRiHzV0gbwCUtah12J6hse77vYTKJJkcGceALnO2TvKb9OBsJ9JU54XIvdgIN81tYhi8JRtRoko65YuHIzH9VW1WM5R3eFYTSQM7ykeHo0slaYss3r7FvYLhvTpx0UzT/nixCeDvN+j+6O54T9KjJRCdmIrTlR2szIMKmo9tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GRMDL0ZZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GRMDL0ZZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82070C4CEED;
	Tue,  2 Sep 2025 10:40:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756809657;
	bh=4EdmcQuNQy+OKjG07zuxiwGokehf0Nr2XE4I/Phgibo=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=GRMDL0ZZiI+KzzUOxeXuEZUqHa94l0iXlibBJJACpGpT6//kJCB6Kob9Hh3vQsCYB
	 3iPZu33GUKo9JtzYnwwQYRptut2WKDV3EtHSnOyAH6UWK5CU50CzASV4AkyCYKu1sK
	 SdpoJUV0tIrXbcmGnOhwFhlLQimL/WYAg7wQ4n3c/9J5xcNz1ldoV9TJKMPN0NC0c4
	 oRMF5IteKRyARjq9B3N9/hRFGBXldgduNNysOYiiTbjH9b5dT19+rGi3V9jBpY4naI
	 d0c6InG1/MZFnkS/Dj6cYgSu9Cd65JJTRpHGrv31bTTnhvsl2yymzatInBoLDGNZFH
	 Fhl1jy+dcRd+A==
From: Lee Jones <lee@kernel.org>
To: Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>, 
 Jingoo Han <jingoohan1@gmail.com>, Helge Deller <deller@gmx.de>, 
 dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Qianfeng Rong <rongqianfeng@vivo.com>
In-Reply-To: <20250819035804.433615-1-rongqianfeng@vivo.com>
References: <20250819035804.433615-1-rongqianfeng@vivo.com>
Subject: Re: (subset) [PATCH] backlight: led_bl: Use devm_kcalloc() for
 array space allocation
Message-Id: <175680965526.2264832.11658794524011845016.b4-ty@kernel.org>
Date: Tue, 02 Sep 2025 11:40:55 +0100
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15-dev-c81fc

On Tue, 19 Aug 2025 11:58:03 +0800, Qianfeng Rong wrote:
> Replace calls of devm_kzalloc() with devm_kcalloc() in led_bl_get_leds()
> and led_bl_parse_levels() for safer memory allocation with built-in
> overflow protection.
> 
> 

Applied, thanks!

[1/1] backlight: led_bl: Use devm_kcalloc() for array space allocation
      commit: 7a5e9040f418c2dd5d30fbdc2cad4446a004c6c5

--
Lee Jones [李琼斯]

