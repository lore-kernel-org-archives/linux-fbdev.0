Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD1D065BC7;
	Wed, 13 Mar 2024 16:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710347636; cv=none; b=BCnKlFf1nsYQYiFYjjuKk0kyW8PU6hDwJddtABpNL2DuvJSuj6YndTwbEwLlgdkmRGV2YbKW9+OWYUCPp4DrVCvAZmmLnO7wvVLtMDhw8t19dolgsSmw1ciz/6jxWIcNLPTPaBVBUpNxKnyWoAqysL+3yxF+E8QjWfmC0j+/JzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710347636; c=relaxed/simple;
	bh=Z8+NUNpRE+2VDl0oGhDDoGU2zsP/cVwd07jGMJxdApE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=drdNpWmAVNk2EcY5P0/L0fjccK9gdgNoANdRs5eZ3mbR91QPyEYfLkpu9xDclhEmUBtzcpqs3GwSz0qSThBs8+8XAaSmDrrl39RhRJIqUNzRfXl2rdnL9FaG7rnh+sqMosdUCaZLbh2Y+mc7sOsu3UKMoR9NfTW5FTj378uElCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B1mcMxZY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B1mcMxZY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4303DC43390;
	Wed, 13 Mar 2024 16:33:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710347635;
	bh=Z8+NUNpRE+2VDl0oGhDDoGU2zsP/cVwd07jGMJxdApE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=B1mcMxZY2FUzH8ySkDlroxMN/syRJftbD0gVPi2ZOlRKaZf+rc5UBbvcr1apBJHtK
	 tv3LB+b+KJm5anJtYokkac4MlQJ1q94JpldrlZLhHN/QUfqg6ipUdnAHGkNbtUs/jc
	 mpaVb68go5pPQwRsM02tzbpQcU89FO7zIOBB15oaNgn11w+lAgEUuPXFkAFleH5bJn
	 obcLd1E9pAciaXEaSBA999ISHlXaHotl+/x6wWULWhpxZOa9z0LbVCDruZ1LGmMQFn
	 CYLGRVeV5NKZS6UNp32PlJIWYYFHYaWcSUf96MJXxn+NIo0BTLC9lt3c29st1hf5v0
	 5fFzDzpRnRkdw==
Date: Wed, 13 Mar 2024 16:33:51 +0000
From: Lee Jones <lee@kernel.org>
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: daniel.thompson@linaro.org, jingoohan1@gmail.com, deller@gmx.de,
	dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev
Subject: Re: [PATCH 2/6] backlight/omap1-bl: Remove unused struct
 omap_backlight_config.set_power
Message-ID: <20240313163351.GH1522089@google.com>
References: <20240313154857.12949-1-tzimmermann@suse.de>
 <20240313154857.12949-3-tzimmermann@suse.de>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240313154857.12949-3-tzimmermann@suse.de>

On Wed, 13 Mar 2024, Thomas Zimmermann wrote:

> The callback set_power in struct omap_backlight_config is not
> implemented anywhere. Remove it from the structure and driver.
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---
>  drivers/video/backlight/omap1_bl.c     | 3 ---
>  include/linux/platform_data/omap1_bl.h | 1 -
>  2 files changed, 4 deletions(-)

Just a quick one - I'm sure Daniel will be here soon to conduct a proper
review.

Could you attempt to use the subject line format expected by a given
subsystem please?

`git log --oneline -- <subsystem>` is your friend.

Thanks.

-- 
Lee Jones [李琼斯]
