Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22C583B5310;
	Mon,  9 Mar 2026 16:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773073680; cv=none; b=mzHHBJY9Q6Xg11h8GzRdnZ9bjwfYKdIglbUc/eG0+d0KvfkOBu8MOezWaCXXVxbycYjMdoEvfRMaYAKuwUGR5IfFHeX0CPURB3r1XRVFM0WEejS0eJJggpWGseo8gHdzEREFd3M+PJPyqKNjNrjtaFdN+ARMF2XlRbmFX0rcY0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773073680; c=relaxed/simple;
	bh=zJjVKJZuxMBthtmXE9ZJwlP0DntECVVuQ4EddObCxCY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OM7tIY3NSb8afC79rZ8+qI0oJW0EwG6jf/73tmVXZPRhZFKc+G/5fPDLu9Nj/MOzG4J1f4hDjCQfYlKjQW7haW/ZHSBdGFdPMROvM/PA5IgjNazQIgCDhJtQOWzUeAlc/846fTHxpQ7MsAaBvNn5YlAxWf2DQmKwBl3s9MN6vPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UiM+GRh9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UiM+GRh9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E23AC4CEF7;
	Mon,  9 Mar 2026 16:27:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773073679;
	bh=zJjVKJZuxMBthtmXE9ZJwlP0DntECVVuQ4EddObCxCY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UiM+GRh9c3P+uX1gaxnBTe/QmYE4kpCY585Psak54gprQDe5LSZYgI5O0wFdalDnT
	 HN8HNbvnPC+k8ZcTcizAl6e5WdCUX4SeAZD8N06yFQ/ytYxOiQLQe/cnowF7B7Qjd6
	 WGEdMrdsPtbUF9QqALXldbYQdtmTYrl5Yz7iWeMw=
Date: Mon, 9 Mar 2026 17:27:57 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Soham Kute <officialsohamkute@gmail.com>
Cc: andy@kernel.org, dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: fbtft: replace -1 with proper error codes
Message-ID: <2026030916-spring-pawing-9370@gregkh>
References: <20260228202701.43337-1-officialsohamkute@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260228202701.43337-1-officialsohamkute@gmail.com>

On Sun, Mar 01, 2026 at 01:57:01AM +0530, Soham Kute wrote:
> Replace return -1 with proper kernel error codes:
> - -ENODEV when SPI device is NULL
> - -EINVAL when display size or buffer is invalid
> - -EOPNOTSUPP for unimplemented functions
> 
> Signed-off-by: Soham Kute <officialsohamkute@gmail.com>
> ---
>  drivers/staging/fbtft/fb_ra8875.c | 4 ++--
>  drivers/staging/fbtft/fbtft-bus.c | 4 ++--
>  drivers/staging/fbtft/fbtft-io.c  | 4 ++--
>  3 files changed, 6 insertions(+), 6 deletions(-)

Some of these functions are not called anywhere, so please remove them
instead entirely, and then fix up the remaining ones (after verifying
that the callers can handle the changed values you have made here.)
That can be a patch series.

thanks,

greg k-h
