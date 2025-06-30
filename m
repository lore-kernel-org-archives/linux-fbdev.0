Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0A292459C4;
	Mon, 30 Jun 2025 17:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751303801; cv=none; b=o5uwlaIqVwzURyiI+TaI/dejZ3tN5gshAXkkulJRXkiCMk/2yTFMdnCl23qXryiAl6AoH/uMkiVQfN22sGoqdRkCjka5bNhK/MxvYp6C3JGlyT5Al7vUgy0GeQNUrzrr7mVn8zQ2XKMr4XNVgt8CgzUdN55nXHLCF50iBvtvLq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751303801; c=relaxed/simple;
	bh=o46b+qzEeO5R+D3GfcJjy0xzYMzH4gfbKZTrdNsCCQY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SxQxKwXbNmGKXt7ob+S3lEZhkS4s5aDFP48Vm4BmyYQ1HyI9TFSH2UTQUSUpds1wDuBdH0k0DestCHXHqGYALUOCgmg38FeskoXzl85fuhqgErDb5K2d8AKdpaDT+f4X4G/BhyQCvc0admj3GnpGgV5V8m+dHuhwIixJEdq0opU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DOsbfGRd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DOsbfGRd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F4A0C4CEE3;
	Mon, 30 Jun 2025 17:16:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1751303801;
	bh=o46b+qzEeO5R+D3GfcJjy0xzYMzH4gfbKZTrdNsCCQY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DOsbfGRdjmqBhSjcurza6/J672t3KpGEeR9L9vM56lWHXo6AndByMKkYi2RXmzMuH
	 1leVCf3j5rj9rWhkqKfISe8yIXBjosIT1yPIwxCywADlK33B1GrdabVqESroC2qwp3
	 O1peHe2k3f9xco2dbJZPvfqFJqkE/uOKUQFOXvcY=
Date: Mon, 30 Jun 2025 19:16:38 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Abdun Nihaal <abdun.nihaal@gmail.com>
Cc: andy@kernel.org, dan.carpenter@linaro.org, lorenzo.stoakes@oracle.com,
	tzimmermann@suse.de, riyandhiman14@gmail.com, willy@infradead.org,
	notro@tronnes.org, thomas.petazzoni@free-electrons.com,
	dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@intel.com>
Subject: Re: [PATCH v3 2/2] staging: fbtft: cleanup error handling in
 fbtft_framebuffer_alloc()
Message-ID: <2025063022-chump-pointless-6580@gregkh>
References: <cover.1751207100.git.abdun.nihaal@gmail.com>
 <4e062d040806dc29d6124ac0309e741c63f13ac0.1751207100.git.abdun.nihaal@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4e062d040806dc29d6124ac0309e741c63f13ac0.1751207100.git.abdun.nihaal@gmail.com>

On Sun, Jun 29, 2025 at 08:10:11PM +0530, Abdun Nihaal wrote:
> The error handling in fbtft_framebuffer_alloc() mixes managed allocation
> and plain allocation, and performs error handling in an order different
> from the order in fbtft_framebuffer_release().
> 
> Fix them by moving vmem allocation closer to where it is used, and using
> plain kzalloc() for txbuf allocation.
> 
> Suggested-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> Suggested-by: Dan Carpenter <dan.carpenter@linaro.org>
> Signed-off-by: Abdun Nihaal <abdun.nihaal@gmail.com>
> ---
> v2->v3: 
> - Remove the if check before kfree of txbuf.buf, because it is zero
>   initialized on allocation, and kfree is NULL aware.

This patch does not apply to my tree, can you rebase and resend?

thanks,

greg k-h
