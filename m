Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA8021CFEDE
	for <linux-fbdev@vger.kernel.org>; Tue, 27 Aug 2024 16:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724776967; cv=none; b=LESiH/ACc9A7Pvub1/WcP7jZ7lFcmPgPHx7UoEOY51ByO/AVc5y/Tba0omrSikMVAwMwO9Y4W4rPwF+mzhnHrELdxdMhMJHOX3GLBq5hIo/m06HwDEsCP1F/jZbh6KkVe2o9M31QjkcwxgoiYRj0s8Pt9Sdid1/wS5Wh3VoJgXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724776967; c=relaxed/simple;
	bh=RMUnWmh7KaWXAIiVgIe3wZOOVqlaIt5VdHV35OZZHyU=;
	h=Message-ID:Date:From:To:Subject:In-Reply-To:References:Cc; b=f9dhcNKIw0m9l+MuZgCHcb5dKt6CYUKwoVmcsnn5sEuyd4LQyN4s/vtSyeEbyJkKIRNoLhKIhy8l//wBh0XGx5astjJ2dCzNs17J5Xy+0C5dHtAzMKpYZV8/Uu7DYR9MFiEcPLmo/7cyhZ3MYJc0+d02UNb3mezRWkldXVihHpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T6Vx6biO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T6Vx6biO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D68A5C4AF1B;
	Tue, 27 Aug 2024 16:42:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724776967;
	bh=RMUnWmh7KaWXAIiVgIe3wZOOVqlaIt5VdHV35OZZHyU=;
	h=Date:From:To:Subject:In-Reply-To:References:Cc:From;
	b=T6Vx6biOilPPMDlLnXju6vmhqTEP9p9ZH78C5DEGVT54eNtmzeQ3nFpFfYMLM7VDp
	 GhRU/6G6VQgP1xi67zg/mQDRy81odFk2RDHt/DOPFTT9081tTBMOxmDzGbuR9LRaJx
	 g2H9Pk1BmQxoKsKSx8/ybuenzlYAp94sO9o4NgwliRw4mUZzly541MeNwkmCzjMHqo
	 jO5MffgD2xBVq/3xxhgZUepbrKeVb7WW8uXO3WodDT2/ZVokCQ5Tm1AndoUJIC+sVB
	 hE9HCLNy98ShKTBMy+ga0gCzUJk6flovW/Q/iOqQ6IPdyjXgvxaFGanu0dN0Gj1ozD
	 dqrbgxTL7v+TA==
Message-ID: <ece4d6c8888cecb4cd7c646cb0ec8d55@kernel.org>
Date: Tue, 27 Aug 2024 16:42:44 +0000
From: "Maxime Ripard" <mripard@kernel.org>
To: "Derek Foreman" <derek.foreman@collabora.com>
Subject: Re: [PATCH v4] drm/connector: hdmi: Fix writing Dynamic Range
 Mastering infoframes
In-Reply-To: <20240827163918.48160-1-derek.foreman@collabora.com>
References: <20240827163918.48160-1-derek.foreman@collabora.com>
Cc: dri-devel@lists.freedesktop.org, kernel@collabora.com, linux-fbdev@vger.kernel.org, "Helge
 Deller" <deller@gmx.de>, "Jani Nikula" <jani.nikula@linux.intel.com>, "Maxime
 Ripard" <mripard@kernel.org>
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>

On Tue, 27 Aug 2024 11:39:04 -0500, Derek Foreman wrote:
> The largest infoframe we create is the DRM (Dynamic Range Mastering)
> infoframe which is 26 bytes + a 4 byte header, for a total of 30
> bytes.
> 
> With HDMI_MAX_INFOFRAME_SIZE set to 29 bytes, as it is now, we
> 
> [ ... ]

Acked-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime
