Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96B5B1DE4E5;
	Mon, 15 Sep 2025 15:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757948552; cv=none; b=SFs5uLINmkgfQXAABi/RXoOaDEGWs3TtPT5SNCbIV/OijYFF6hilAg6d24ytM+beTQcmjJyfeShgufAPSSlemePT1QBa1QQRIjWbC2pTtaNS1nDZgqPmFgu5rrso3Q8/9qod1Q0UDWd23YSKcnw/8gl/8keKJWp774W40aGWKKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757948552; c=relaxed/simple;
	bh=ZafX87MMcfI5y2IRaqNAT6HmdaHGKFoLkfY+lm2hc14=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JrnHNE4nyKjJh5AbJeJTaNnzg8jD5oqN/0CJswlL3d9zZaL40+H+idqU0gIb6DTXi80942OFV/hth3a7l2+t62SxAgWKXbGxwisV2uVTwTbzZmLUrZpxvzm+UJpZUl7v998rhNyJ3SjUCFNdIo/cxgGo8zn51owieSTtXmP3kFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f5VmtA5g; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f5VmtA5g"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6991C4CEF5;
	Mon, 15 Sep 2025 15:02:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757948552;
	bh=ZafX87MMcfI5y2IRaqNAT6HmdaHGKFoLkfY+lm2hc14=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=f5VmtA5g70F71yXQYaxm3xCQGg6KvCFDB7chmTjFVILW8w/K2+eM3qI9j0DVE/mD9
	 MAIw0c8APm9rnxbauU+AbwBM1iTtXFuG3lWjdo3ho8OR2Axr4A857sy7pYLC+ashiZ
	 7A8z9djjmRDEBuvya/tt4gu7BUse4qW9tJhlyxIBf6AjcXxDfAbcYNscJaooa00DgD
	 DzjHb84yQGuqoSA1S9VJQapyTKLwGbbWjsTrPwZt+yKDmAKXzTZIUOpH3rrCkcaxsL
	 ojh1Qd8gZMMPIEn2HqaVu1Jb/tISXdkTGS2Zs+qk1NFMOvT4jS7ACtTQZWgFYSPxQ0
	 okYTlG8LjFpfw==
Date: Mon, 15 Sep 2025 16:02:25 +0100
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
Subject: Re: [PATCH v2 15/15] backlight: Do not include <linux/fb.h> in
 header file
Message-ID: <aMgqgSMaxFsM4eES@aspen.lan>
References: <20250715122643.137027-1-tzimmermann@suse.de>
 <20250715122643.137027-16-tzimmermann@suse.de>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250715122643.137027-16-tzimmermann@suse.de>

On Tue, Jul 15, 2025 at 02:24:52PM +0200, Thomas Zimmermann wrote:
> The backlight interfaces don't require anything from <linux/fb.h>, so
> don't include it.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>

Reviewed-by: Daniel Thompson (RISCstar) <danielt@kernel.org>


Daniel.
