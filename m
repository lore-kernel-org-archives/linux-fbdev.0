Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B0492F2914;
	Thu,  4 Dec 2025 16:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764865912; cv=none; b=DOVPvNVk2aY5tBElB5vWaRIBYQI5DMBvzHriYwrQpNtHQGyVFV6jS0Pnph3KkuH4FulzQFvlN3qoCcCtE/bc+rD64W3FxR0inrwin7/vCvEiAmfW1YvhCJLHiO9plUL/fyJB5OSrF48Ad83Nuxz1Os4iaGuuRvtadUPkNJkBz00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764865912; c=relaxed/simple;
	bh=7xyZc9+BmbOgEn7wwK+/kd3lA1bF7ElNnkCDaoIwq2E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SfBE4Ft3TzrTvZSF04L/d/2zVt/48Aeqemt8/0tRta+bSECbRHHfxw0xWURB/ksE4ZXvZj3Uh1W7XYLcUFmOcq6lzCWxm9+buMjH7a3Yye6NFez7BtMxXqDNB2pPuTnCSp9gzmAip/CgPKtyb0H2pJr1bA8S6rrxEv4y1KUj3wU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vJr2oJHf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vJr2oJHf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22421C4CEFB;
	Thu,  4 Dec 2025 16:31:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764865911;
	bh=7xyZc9+BmbOgEn7wwK+/kd3lA1bF7ElNnkCDaoIwq2E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vJr2oJHfoMpmnVlSPDNGZndUE9v7sXIPEMDSXYxLNqVakYY38u5jij3hZ2LZzz2Ya
	 OeemcpMAH1myIthILN5vTemU8Knf8x9kB0wZF+abeOI+vLSjUplh11/NdwWaD3MoDU
	 FoZan6cHgJXzf18PH8pDSvJ6cyLiDdhIaM7Tf1nFN28RyqsLGx5jG9O5hyxvdckKi5
	 5RkAXPrOuseQr8MCSCBQbOkXf0NGRe7lUbIy1fctKsBcnSgW377w2VXHHmKVZsC5mh
	 kSR643CFCy/6/ttRpq/2Ue33qJToQLgCcAa+vV2cLkwzYsZkEQRmlx2ECXUr45+Qq2
	 1A5sz3Haxc7/w==
Date: Thu, 4 Dec 2025 16:31:47 +0000
From: Daniel Thompson <danielt@kernel.org>
To: petri.karhula@novatron.fi
Cc: Thomas Richard <thomas.richard@bootlin.com>, Lee Jones <lee@kernel.org>,
	Jingoo Han <jingoohan1@gmail.com>, Helge Deller <deller@gmx.de>,
	linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org
Subject: Re: [PATCH v5 1/2] backlight: Add Congatec Board Controller (CGBC)
 backlight support
Message-ID: <aTG3c0Ey2DWwa-T1@aspen.lan>
References: <20251204-cgbc-backlight-v5-0-26f1be6a69c3@novatron.fi>
 <20251204-cgbc-backlight-v5-1-26f1be6a69c3@novatron.fi>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251204-cgbc-backlight-v5-1-26f1be6a69c3@novatron.fi>

On Thu, Dec 04, 2025 at 02:35:26PM +0000, Petri Karhula via B4 Relay wrote:
> From: Petri Karhula <petri.karhula@novatron.fi>
>
> This driver provides backlight brightness control through the Linux
> backlight subsystem. It communicates with the board controller to
> adjust LCD backlight using PWM signals. Communication is done
> through Congatec Board Controller core driver.
>
> Signed-off-by: Petri Karhula <petri.karhula@novatron.fi>

Didn't I already share a Reviewed-by: for this?

Unless you have made changes big enough to invalidate the review then
you should collect tags offered on previous versions (if you do ever
disregard a tag there should be a note about why). For details see:
https://docs.kernel.org/process/submitting-patches.html#using-reported-by-tested-by-reviewed-by-suggested-by-and-fixes

Please don't forget to collect the tags if there is a v6 but, for now:
Reviewed-by: Daniel Thompson (RISCstar) <danielt@kernel.org>


Daniel.
