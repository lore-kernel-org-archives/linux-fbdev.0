Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEC1034A32A;
	Mon, 15 Sep 2025 14:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757947878; cv=none; b=ktlxTxrxsdGEqQ3Z0Lvb3f/LSU8ya777ZhLNU+QoWiA4N70E7wB/qxEa5XFYtI3ONMyigyP3a/s51PNQdkVNOrhm327vK1Zym9FeW5eTwzHtV8lD04RH5VbhfUzNxtpKwELpJuIL0MnjI8o2oAHYPWJFtM8MSTtTSbFvw06YhQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757947878; c=relaxed/simple;
	bh=bma8GiY4yUzV27qSAWPGDFtL0k+HG+lI2FGJDZ+a/PQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b/ajNYzNxYgfa8C8XR+I/bTeb57OoWXNJxppF1qZHcqJg7SjNELhSjD51keYd28W6kdntVvvvWBX3NAl+3Of2BSJjyyyyqfp4Pp3Xs064dO7I3YGQCUAu5tTcEZpupf/Lvl2/4JLhKN/Grs8irIxzQFSsSf/yWnJcNSymOFflVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lt8uy5TI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lt8uy5TI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5688BC4CEF7;
	Mon, 15 Sep 2025 14:51:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757947878;
	bh=bma8GiY4yUzV27qSAWPGDFtL0k+HG+lI2FGJDZ+a/PQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Lt8uy5TIMZvdWWoEVcsK6aGDdWEzGe8s7vVNvgTd8ZNu1QQjqO6SWmHCJ1Q6WbO5S
	 Gz9lbP7gQbJJwWUMmpaY0xDTSM4Ck5MC8Ubwx7/bLfG7TviNkhu7mdLPAY4/mBqYfH
	 3zvh1C4ulnfpd2PrkkGGiPXI7IBbH5HxfdD4DpPkHbPXXxjUIRiRaK1weTrIn7ujFN
	 mH4Sgv5RVTwD1jV8B/IKNs6JMrnLOEpj+9V62T06Vkwn6Diz1nHaBEjHmQT/JmtKiX
	 huJplgGSJNy+ewquR96QHCN2HVoGry4w+hsTnaqqpUDbXWHxUsu6H8sXECoENs8CUM
	 8sXhYcx0pEoEQ==
Date: Mon, 15 Sep 2025 15:51:11 +0100
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
	linux-arm-kernel@lists.infradead.org, linux-fbdev@vger.kernel.org
Subject: Re: [PATCH v2 09/15] backlight: da9052_bl: Include
 <linux/mod_devicetable.h>
Message-ID: <aMgn3zB9yigdlVrw@aspen.lan>
References: <20250715122643.137027-1-tzimmermann@suse.de>
 <20250715122643.137027-10-tzimmermann@suse.de>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250715122643.137027-10-tzimmermann@suse.de>

On Tue, Jul 15, 2025 at 02:24:46PM +0200, Thomas Zimmermann wrote:
> Include <linux/mod_devicetable.h> to declare struct platform_device_id.
> Avoids dependency on backlight header to include it.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>

Reviewed-by: Daniel Thompson (RISCstar) <danielt@kernel.org>


Daniel.
