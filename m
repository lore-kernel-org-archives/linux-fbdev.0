Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 873C1340DA6;
	Mon, 15 Sep 2025 14:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757947752; cv=none; b=Yz4e7zAw20KdG5WoheIzygyjjd5wUAX4XhUzBABAHyFy4DGqILfit4+87m7hyWryuIx1i65WhqkkZrd/iG7a+//yjhYeuTXt/XtMoVNxGhhwnUifqcUqm8UK3uNaU1AQYibLKQJX26iVwZAImzDAzhvQ01dDEsuJmvTJDUoRA68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757947752; c=relaxed/simple;
	bh=1ZNBEQC/8mpEzL4wmbNqb3FPh6BDDrGddIBOowgnbp0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XlqrqJNgC7Kk4Z6dDKG1Lx7M8Pf/YAKMWH8nWKcnc6LuGy3n/oVylYifzVpQ2iOzkOK2HXejzdca3ftFNL0Gn+VXw6K0f/YTtpWA6aC29ZlcAseK7ac2dlmQD8cEaEof4+dVYzJBwwEECIU5qmuFTL+7RK2GhDtGGABopJnuy7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uw/e9d7/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uw/e9d7/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EDF4C4CEF1;
	Mon, 15 Sep 2025 14:49:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757947752;
	bh=1ZNBEQC/8mpEzL4wmbNqb3FPh6BDDrGddIBOowgnbp0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Uw/e9d7/kGCAran4GK0T6S0xU0+gS6A944ToJDHNMIGJHn9PAIUYlRLUTSxIVOfds
	 7Zg/ChGsYEhAkzyT5nSAUbVpCVYjQBFUKOfgeLKSV4N4bztiHb1bilnrmZTPRI/3TK
	 RkmBLTwNY3a0Hw2KLJXnijdTvniaBGMZCcmi+dkzPorZH1WeKe/DrYVfSPAqNMl8or
	 fBxrz5KZ6PHUSBWsBb5ugQkgS0SLEE8uz6pxcTfza21YdBAjbODqepbdm/x7ec5djr
	 QZrPWDpqCBt/X9jxoPp8PXB3ToP50q98GQ535zG0XIPPNyEtu27jdNz0HjJScGHOKs
	 5yZyB3qr0jtHw==
Date: Mon, 15 Sep 2025 15:49:04 +0100
From: Daniel Thompson <danielt@kernel.org>
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: lee@kernel.org, jingoohan1@gmail.com, neil.armstrong@linaro.org,
	jessica.zhang@oss.qualcomm.com, deller@gmx.de,
	maarten.lankhorst@linux.intel.com, mripard@kernel.org,
	airlied@gmail.com, simona@ffwll.ch, fnkl.kernel@gmail.com,
	j@jannau.net, hdegoede@redhat.com, ilpo.jarvinen@linux.intel.com,
	sven@kernel.org, alyssa@rosenzweig.io, neal@gompa.dev,
	support.opensource@diasemi.com, duje.mihanovic@skole.hr,
	dri-devel@lists.freedesktop.org, asahi@lists.linux.dev,
	platform-driver-x86@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-fbdev@vger.kernel.org,
	Nick Chan <towinchenmi@gmail.com>
Subject: Re: [PATCH v2 07/15] backlight: apple_dwi_bl: Include
 <linux/mod_devicetable.h>
Message-ID: <aMgnYFWzXLUKUG-w@aspen.lan>
References: <20250715122643.137027-1-tzimmermann@suse.de>
 <20250715122643.137027-8-tzimmermann@suse.de>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250715122643.137027-8-tzimmermann@suse.de>

On Tue, Jul 15, 2025 at 02:24:44PM +0200, Thomas Zimmermann wrote:
> Include <linux/mod_devicetable.h> to declare struct of_device_id.
> Avoids dependency on backlight header to include it.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Reviewed-by: Nick Chan <towinchenmi@gmail.com>

Reviewed-by: Daniel Thompson (RISCstar) <danielt@kernel.org>
