Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B0A446AEDA;
	Fri, 27 Feb 2026 20:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772225972; cv=none; b=df8HbpB0VSZu1O4/Ta1lOmbfe2Yfq/2cd2oUoCJAOuNXila6o8nJYBM03TqkfuNV2fhMHawgfW4QetlIBiMHESEcZvQ/hMUzKPiqElbvEOVbiGYBxSI4P13wYHWdRMczLdHXKb9i9YTCVKEGvdv4sicYnbWoZfGNRdAAkuz99oI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772225972; c=relaxed/simple;
	bh=CgVe0XTTYoyB3y5Oww3RwtITptG6dm/3IIyqAgbIS3M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JN1h3rBk5Jt64J+Dj8AOOi00E/F5mDVlqhzuRb14RVqV7v1oRLF0lR7g02S7ZrhNWXXcbjRRUosOl4fSd5q6T28Hghcg0VPtfB3j6mIoHGC6gun5GZZa56ZO4R3xIQB7IcRW0EawmwW3DyVYEOvw8gzN8hRw46K3Sfjs17/y0wM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OFMMGcxw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OFMMGcxw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79A23C116C6;
	Fri, 27 Feb 2026 20:59:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772225971;
	bh=CgVe0XTTYoyB3y5Oww3RwtITptG6dm/3IIyqAgbIS3M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OFMMGcxw5F+MnIsdB2mQgIvIT+jkcY5GRr66lohSmHM0hxJZ8GuIZ+fO4vebdbWp1
	 FWoWTy9AY8c2IeDV5WYOmD3+Dp3pY4453vFUdD+QpqBh0sHqyhf2VLKDYpvX3sq7AW
	 PLqUHduuOeBlme7QchtAAfSd0xA1odF42cNY/SpCjoo6i5aOVAk8fq9dvsYBfaCgb9
	 jOLl/ui5mP4XfOyfz4nlbiyQBr1pMhKpNYw1RUX3Zblp3+bWIWcrIc9juVYkyGo3TI
	 NNNxoTqI3jN12diMrUq5KLRSD/wqCQvkRh+lUPcPNB7YY4IIgfY14W98jC4rD+06Re
	 FwJ3ExuVpM7HQ==
Date: Fri, 27 Feb 2026 21:59:27 +0100
From: Helge Deller <deller@kernel.org>
To: Pavel Nikulin <pavel@noa-labs.com>, linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Cc: Helge Deller <deller@gmx.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5] Fonts: Adding all Terminus fronts from 12 to 32 in
 bold, and normal versions
Message-ID: <aaIFr-GKG1qiJYwg@p100>
References: <20260226073404.13511-1-pavel@noa-labs.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260226073404.13511-1-pavel@noa-labs.com>

Hi Pavel,

please include the graphics mailing lists (fbdev, dri-devel).

* Pavel Nikulin <pavel@noa-labs.com>:
> This patch adds an option to compile-in all terminus fonts, and removed the old bold only terminus version
> 
> These fonts were converted from Terminus psf files with the help of psftools and a script.
> 
> This patch is non-intrusive, no options are enabled by default so most users won't notice a thing.

Sure, but you add a whole lot of fonts.
Why are both bold and non-bold fonts needed?
Why do we need all in-kernel?
They may be loaded after bootup via userspace too.

What does other people think?

Helge

 
> I am placing my changes under the GPL 2.0 just as source Terminus font.
> 
> Signed-off-by: Pavel Nikulin <pavel@noa-labs.com>
> ---
>  V4 -> V5: Added changed font.h to the patch
> 
>  include/linux/font.h       |   42 +-
>  lib/fonts/Kconfig          |  142 +-
>  lib/fonts/Makefile         |   15 +
>  lib/fonts/font_ter10x18.c  | 6412 ++++++++----------------------------
>  lib/fonts/font_ter10x18b.c | 1305 ++++++++
>  lib/fonts/font_ter10x20.c  | 1305 ++++++++
>  lib/fonts/font_ter10x20b.c | 1305 ++++++++
>  lib/fonts/font_ter11x22.c  | 1561 +++++++++
>  lib/fonts/font_ter11x22b.c | 1561 +++++++++
>  lib/fonts/font_ter12x24.c  | 1561 +++++++++
>  lib/fonts/font_ter12x24b.c | 1561 +++++++++
>  lib/fonts/font_ter14x28.c  | 1817 ++++++++++
>  lib/fonts/font_ter14x28b.c | 1817 ++++++++++
>  lib/fonts/font_ter16x32.c  | 4107 +++++++++++------------
>  lib/fonts/font_ter16x32b.c | 2073 ++++++++++++
>  lib/fonts/font_ter6x12.c   |  537 +++
>  lib/fonts/font_ter8x14.c   |  537 +++
>  lib/fonts/font_ter8x14b.c  |  537 +++
>  lib/fonts/font_ter8x16.c   |  537 +++
>  lib/fonts/font_ter8x16b.c  |  537 +++
>  lib/fonts/fonts.c          |   45 +
>  21 files changed, 22124 insertions(+), 7190 deletions(-)
>  create mode 100644 lib/fonts/font_ter10x18b.c
>  create mode 100644 lib/fonts/font_ter10x20.c
>  create mode 100644 lib/fonts/font_ter10x20b.c
>  create mode 100644 lib/fonts/font_ter11x22.c
>  create mode 100644 lib/fonts/font_ter11x22b.c
>  create mode 100644 lib/fonts/font_ter12x24.c
>  create mode 100644 lib/fonts/font_ter12x24b.c
>  create mode 100644 lib/fonts/font_ter14x28.c
>  create mode 100644 lib/fonts/font_ter14x28b.c
>  create mode 100644 lib/fonts/font_ter16x32b.c
>  create mode 100644 lib/fonts/font_ter6x12.c
>  create mode 100644 lib/fonts/font_ter8x14.c
>  create mode 100644 lib/fonts/font_ter8x14b.c
>  create mode 100644 lib/fonts/font_ter8x16.c
>  create mode 100644 lib/fonts/font_ter8x16b.c
