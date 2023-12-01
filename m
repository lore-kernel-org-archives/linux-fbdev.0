Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCC0B208A9
	for <linux-fbdev@vger.kernel.org>; Fri,  1 Dec 2023 11:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YmIm5RK3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86B97C433C7;
	Fri,  1 Dec 2023 11:24:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701429890;
	bh=rYqBSjamQXtlSslFcg8gvLvU5PS9WpJZS4rNYHLG+H8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=YmIm5RK3ckUH4e9RsSXlclJRgNNR9mlCL9AKQLWj9hZf4oLIQenz7MCKvfqLFX3Sj
	 N2DBN1jm7uEugLNJ9FQ+AYwDG5kLS+s60SrO5hlE2r1C8ECpoaP6S4f05RysULzBS+
	 DU1YciJ+coOKpPHlVZbn5ym2UigN41+EWF31uGX/Yl1pVWpk3iyGUJBcbv/LY6960v
	 DbTff0rpJ4PIeaH5Gg7q6oHYgEVjnht9IF9J1KOkNtlg1uIml63qY6mVo4+l335UJt
	 TieIg18K1mCrrlwPYr1kIvME+Kg60VRlZYSRIUViVde97kwNHLybC/8iloKqfi0/tm
	 Z6dZ/19r9yApw==
From: Lee Jones <lee@kernel.org>
To: Lee Jones <lee@kernel.org>, 
 Daniel Thompson <daniel.thompson@linaro.org>, 
 Jingoo Han <jingoohan1@gmail.com>, Helge Deller <deller@gmx.de>, 
 Dan Carpenter <dan.carpenter@linaro.org>, 
 Flavio Suligoi <f.suligoi@asem.it>
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20231129164514.2772719-1-f.suligoi@asem.it>
References: <20231129164514.2772719-1-f.suligoi@asem.it>
Subject: Re: (subset) [PATCH v2] backlight: mp3309c: fix uninitialized
 local variable
Message-Id: <170142988824.3370898.14636793712947246293.b4-ty@kernel.org>
Date: Fri, 01 Dec 2023 11:24:48 +0000
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.3

On Wed, 29 Nov 2023 17:45:14 +0100, Flavio Suligoi wrote:
> In the function "pm3309c_parse_dt_node", when the dimming analog control
> mode (by I2C messages) is enabled, the local variable "prop_levels" is
> tested without any initialization, as indicated by the following smatch
> warning:
> 
> drivers/video/backlight/mp3309c.c:279 pm3309c_parse_dt_node() error: uninitialized symbol 'prop_levels'.
> 
> [...]

Applied, thanks!

[1/1] backlight: mp3309c: fix uninitialized local variable
      commit: ab47505ce45b869ab649024dc932e981fcdd6e5f

--
Lee Jones [李琼斯]

