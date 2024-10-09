Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0C5012EBEA;
	Wed,  9 Oct 2024 14:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728485014; cv=none; b=I+CfaI86dXFW2h06x8twq0oi+y/iwfWXfkgwfOA6b3gyPjXk2LAHNG4l4X6j8HgtjlE6RFUNAISYKseyaiGLMhyf8s/dSh+lIfvlbNP883B2ybPyZ8r5Fh3I6zj4zNWuU5H/N8YogMyPJJxZ2CnQrQVZtoI8FO6eMDLIuuHFNvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728485014; c=relaxed/simple;
	bh=XpufhfIwBFzW0DRqV9iSYAuW1EUgE4gZ9XDPghDF980=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=bDgKkVGoLKvht402AxKOZ9Irb/9PoTE8oCe3B/rSpXGYrkbPgSlroiAYI3B9Pfmzq0uxOeQWEPrrMWsnkpm1GhSxTHaqVpvHwqjSoslUCI4AOkUYF+Zib5pvpXOTh3IUvy5aJtHXm3h66nsOaKKW4JEZ4OdXQGEu8U9ZWP85om8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QvSSIvCO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QvSSIvCO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB5A9C4CEC3;
	Wed,  9 Oct 2024 14:43:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728485013;
	bh=XpufhfIwBFzW0DRqV9iSYAuW1EUgE4gZ9XDPghDF980=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=QvSSIvCO0QBVSIjf7t8Xr9t4a7X9q+hgEezm/Qt+NGcOrNios7XHAEGgeHB9Cn7zU
	 d2MBFPEnEFayBmHt8gQc+iZxKsyAZWs4Pp384RAij5d2dQRW1O0YruwZKLPUAWohVU
	 BD8+g8aG3NVAZLClu+tjZahTj3g7x6FC3IjHZ1e+q3a1YD86NS57JX2m0z0MIFyXiM
	 A4XtOYgfqlFFZJD8kmNCAxeKiYkqhc32BCyUbwG7v2meLWf6Q0W1WXuzMDiEB74VCa
	 v3GYa6sTXSdoiGU0K2o06HcdJeukCmsYw2NYxrX7Skvzrd0z+35zjRMbG/RAMJmXUA
	 aJUIuefm7ediA==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org, daniel.thompson@linaro.org, jingoohan1@gmail.com, 
 hdegoede@redhat.com, linux@treblig.org
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20240919232758.639925-1-linux@treblig.org>
References: <20240919232758.639925-1-linux@treblig.org>
Subject: Re: (subset) [PATCH] backlight: Remove notifier
Message-Id: <172848501143.600706.12618555351534391287.b4-ty@kernel.org>
Date: Wed, 09 Oct 2024 15:43:31 +0100
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.13.0

On Fri, 20 Sep 2024 00:27:58 +0100, linux@treblig.org wrote:
> backlight_register_notifier and backlight_unregister_notifier have
> been unused since
>   commit 6cb634d0dc85 ("ACPI: video: Remove code to unregister acpi_video
> backlight when a native backlight registers")
> 
> With those not being called, it means that the backlight_notifier
> list is always empty.
> 
> [...]

Applied, thanks!

[1/1] backlight: Remove notifier
      commit: 5461f3fd74a89757f95f351eb0bc26aafc2a2e91

--
Lee Jones [李琼斯]

