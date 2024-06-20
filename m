Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71FB11B3754
	for <linux-fbdev@vger.kernel.org>; Thu, 20 Jun 2024 17:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718905007; cv=none; b=tBMGSThKob3jhl6nWIh6XoAzuo3AmZQdAu/VRohzc1U+xrY7VK3xZLEVz8Zk41xBg4D67mu/8z6W//kFb+BNMwxHfXA98/Hsdt5XzXNx1wgYfMvplp+3QpiYVxpSD+XfXWPSHD845SjjNWcDPazA1ZeDTRjobXrB89UHtpTDe9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718905007; c=relaxed/simple;
	bh=dPCprZAMLvbfsHJ5R8XAFEw9v43XDOOJojCX40mGVnc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=QCSvkd7+p9ZiK+gr51Rrhbb8ZaaiOg3A5msDu4l1GR+vjtKDrlNLwx0kiMx1/TxpP2SFg5HQh0ZgYCXqGVK+7bLSpChAkTtza8aVWiTd83ODit0eJQBjAErU3ZBooSruXQEDwXan2m0iX7A4aUiDaThG2EVP8qy0ReI3nYhZFnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MFa63tUW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MFa63tUW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51A07C2BD10;
	Thu, 20 Jun 2024 17:36:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718905007;
	bh=dPCprZAMLvbfsHJ5R8XAFEw9v43XDOOJojCX40mGVnc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=MFa63tUWCVu0pDbyk2NXiXn5zn1JhYShXoY6YSQzWZlfl56HZfdpnG+AFrFgh9DGA
	 IY2BrodcPgx4ljsBp95RA1mafgtH705lcRNulA338eoojNV4HjhbYt7VYC1U8Ab4EM
	 di51NC0ohtW6h0YjF/N5RL8hclCGtlXVAjyr8QTJnOeelQOHWL8U2C963DDLJ1uu4Y
	 ggtGcsqngfG5T+RDRNeBb7jfRwaRPonheqSHxOut639N5IzXZy5E7gc2W3i25qCwQK
	 f6KkelyXnl/3qyEXbHpwLqbr17hNUhMDZOE0o7olSzq0f35cySq3BW8EMOvKJIbDXr
	 9LDnC0d5aWuWg==
From: Lee Jones <lee@kernel.org>
To: Lee Jones <lee@kernel.org>, 
 Daniel Thompson <daniel.thompson@linaro.org>, 
 Jingoo Han <jingoohan1@gmail.com>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: Helge Deller <deller@gmx.de>, Jianhua Lu <lujianhua000@gmail.com>, 
 Flavio Suligoi <f.suligoi@asem.it>, dri-devel@lists.freedesktop.org, 
 linux-fbdev@vger.kernel.org
In-Reply-To: <20240619193558.2543645-2-u.kleine-koenig@baylibre.com>
References: <20240619193558.2543645-2-u.kleine-koenig@baylibre.com>
Subject: Re: (subset) [PATCH] backlight: Drop explicit initialization of
 struct i2c_device_id::driver_data to 0
Message-Id: <171890500507.1324703.5444947342099416550.b4-ty@kernel.org>
Date: Thu, 20 Jun 2024 18:36:45 +0100
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.13.0

On Wed, 19 Jun 2024 21:35:57 +0200, Uwe Kleine-König wrote:
> These drivers don't use the driver_data member of struct i2c_device_id,
> so don't explicitly initialize this member.
> 
> This prepares putting driver_data in an anonymous union which requires
> either no initialization or named designators. But it's also a nice
> cleanup on its own.
> 
> [...]

Applied, thanks!

[1/1] backlight: Drop explicit initialization of struct i2c_device_id::driver_data to 0
      commit: bfd3587760498227510acc1b18c4299c7922ffe3

--
Lee Jones [李琼斯]

