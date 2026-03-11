Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6B754A33;
	Wed, 11 Mar 2026 14:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773241022; cv=none; b=TDURNTPx3F7CvOG6TDHegL10fvFENYRXF/TcXN7dpuR+vmJoFoUze3/MmsMqRYYl9E2sC/JH0uSAynkp6aPKy6nqAE4yqYfDYsgB9vkY5TzrIZl1Ycb53AbAuyqSHD88VyWjucPLnE07q13BX3+KmwaKVURP4ER/SXoR2nIXOXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773241022; c=relaxed/simple;
	bh=10tQazNeIGFnsWcgwk76le6RPUpdLK86sNU/apn2tvs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DT4hqOWBiEpeooqB3kmTSpR6q2IotMHHDygZRosk+lbXwIEaNgr9+ObzpO1wGtVV5E2Fw5TrFAjD3IFIn7oYnQ2Atf2Ak07q/fcEi7qaQmQixqWqdr72IYH1y8r9ZMJxGkbBsIVk9kR8oG9rS8tCaRW2fZtSlt+RJH7Pz1e6Jeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SMHvpRj4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SMHvpRj4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0A29C4CEF7;
	Wed, 11 Mar 2026 14:57:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773241021;
	bh=10tQazNeIGFnsWcgwk76le6RPUpdLK86sNU/apn2tvs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SMHvpRj4iYTvHzWzOOsVI7uyXIk/fX+3/Uo44qPzGxU4Hk9ynq8aI1NC8alo3YTZI
	 pOa3SDEkPpzOWMAIBUZ2fe36/LhgVPeJV7dRGYkVyfWdSBgqtpVfJu66mS+eYekjD2
	 AYv02EUhWVnDLrN35w0jG5kdidhKc91LIE2ZupRs=
Date: Wed, 11 Mar 2026 15:56:57 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Anas Iqbal <mohd.abd.6602@gmail.com>
Cc: andy@kernel.org, linux-staging@lists.linux.dev,
	dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: fbtft: fb_tinylcd: replace udelay() with
 usleep_range()
Message-ID: <2026031106-gliding-oat-2b52@gregkh>
References: <20260311142407.35403-1-mohd.abd.6602@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260311142407.35403-1-mohd.abd.6602@gmail.com>

On Wed, Mar 11, 2026 at 02:24:07PM +0000, Anas Iqbal wrote:
> Replace udelay() with usleep_range() for a 250 microsecond delay
> as recommended by checkpatch.pl. usleep_range() avoids busy
> waiting and allows the scheduler to schedule other tasks.
> 
> Signed-off-by: Anas Iqbal <mohd.abd.6602@gmail.com>
> ---
>  drivers/staging/fbtft/fb_tinylcd.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/fbtft/fb_tinylcd.c b/drivers/staging/fbtft/fb_tinylcd.c
> index 9469248f2c50..51e6493b050f 100644
> --- a/drivers/staging/fbtft/fb_tinylcd.c
> +++ b/drivers/staging/fbtft/fb_tinylcd.c
> @@ -38,10 +38,10 @@ static int init_display(struct fbtft_par *par)
>  	write_reg(par, 0xE5, 0x00);
>  	write_reg(par, 0xF0, 0x36, 0xA5, 0x53);
>  	write_reg(par, 0xE0, 0x00, 0x35, 0x33, 0x00, 0x00, 0x00,
> -		       0x00, 0x35, 0x33, 0x00, 0x00, 0x00);
> +		  0x00, 0x35, 0x33, 0x00, 0x00, 0x00);

Don't you think the original formatting makes more sense?  And you did
not describe this change in the changelog :(

>  	write_reg(par, MIPI_DCS_SET_PIXEL_FORMAT, 0x55);
>  	write_reg(par, MIPI_DCS_EXIT_SLEEP_MODE);
> -	udelay(250);
> +	usleep_range(250, 500);

This is a totally different change than above.  And also one that keeps
getting rejected, please see the mailing list archives for details.

thanks,

greg k-h
