Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 145A43081C7;
	Mon, 15 Sep 2025 14:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757946812; cv=none; b=PffvWxdnAbGNggPrDnwtDMDeqeWiLmcGXRtxC3J1W9o3Bv3zEIYaj43EmBsnUIOuoMtGMaPMD46wsCeIsYrU7Kp8vqbeozPaCFnU8nZB6Cf7OA4m0gvVnx9ZlFwALlMbGbkHPfjmXkexWaIKhGJ/zPXHphqJ1wcnJHMuBhTIfpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757946812; c=relaxed/simple;
	bh=XnxETN3pQB03+YuQRoYCXb3VddRPV+i6oTI+z8dKemA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TYd+OgwsGbOYwecFJrbAhcVcIkHgoUcxtC64m5k4nT8+Y7fBMj5+1DiL8WhLPJ50sxWJ2GfzWl2yM6iAkOdQ+zY3SmF6Anbb0spNzZrQLIuLcGFa9q4YsLCluiDzrakzF6x+e10jWBGOZfXF9O5t7eckNm7sgq9gWjY/q510ho0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nkg0+dU5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nkg0+dU5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D9DFC4CEF1;
	Mon, 15 Sep 2025 14:33:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757946811;
	bh=XnxETN3pQB03+YuQRoYCXb3VddRPV+i6oTI+z8dKemA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Nkg0+dU5gBuQ3T4IqcH/TC8AknBhqV89aiPa2hjrC1DpRLGKSiypWZp9Bimdt8ZOX
	 E2hGQz5D1qQxg/sj5fpu/cT7OJ6oYvSt/JyOViArNc64ez3sb5cspyztEmuDHuFAQL
	 k7qMJEUXCydEHOlCFd33W1Me+hy4gSdGzJU9mW4yzOrTrIFEdVKCQ84hpN2dBpETQR
	 Ihh8OB/QV0j3p944u0dKTpUiFz+WpeHtVTd4EyzZYBKPAgqbEBZnaixRitLJnhc5aZ
	 7L8HSjmzIDdOKjkxmn4CO12B1iXhvkLa/5M0mWVigJgCmnIBpCDFTPohuFvS9OONHu
	 mWuVvDuq6GbEQ==
Date: Mon, 15 Sep 2025 15:33:27 +0100
From: Daniel Thompson <danielt@kernel.org>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Lee Jones <lee@kernel.org>, Jingoo Han <jingoohan1@gmail.com>,
	Helge Deller <deller@gmx.de>, dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] video: backlight: lp855x_bl: set correct eprom
 start for LP8556
Message-ID: <aMgjt1g9C782ELBQ@aspen.lan>
References: <20250909074304.92135-1-clamor95@gmail.com>
 <20250909074304.92135-2-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250909074304.92135-2-clamor95@gmail.com>

On Tue, Sep 09, 2025 at 10:43:04AM +0300, Svyatoslav Ryhel wrote:
> According to LP8556 datasheet eprom region starts at 0x98 so adjust value
> in the driver accordingly.
>
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>

Reviewed-by: Daniel Thompson (RISCstar) <danielt@kernel.org>


Daniel.
