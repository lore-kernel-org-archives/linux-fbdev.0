Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E148633F8A7;
	Wed, 14 Jan 2026 06:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768373724; cv=none; b=QIfQiW83kV91/OtxhkeLFvM2PxbG9ViurgAq1+fajAR/OEvnSGKiF5ko055mcr1MIYO87KHQeuVEQMOMLIoqNp71GK9DsGTSY8iKw5JF8ftj/WU+AMeHweclIA4o83rt+ECwYR7m6TtqVwjkWGQlOVbKqeT6z1zCdApJGdBaY/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768373724; c=relaxed/simple;
	bh=jAU13ANnoHREg4tq8eq6SJekJk5aOvQhMYOQD9AiiyM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mi4KLztco91RsL+8tluoXsU1YpH79DRUeiOpTQHhD4j3ULho0sjhOIRBK0r8tHgayXBuH48h+AkFFfL/Nk3KcEXMgquCTOWCxXp+yx8F62RZelZ1srNOemvR8Q+RsqxULDQCgmPwJEcv7SvwIFg35JwmipG2UTC+s7IgKi6N+hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wLy0+VHF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wLy0+VHF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 848C2C4CEF7;
	Wed, 14 Jan 2026 06:55:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1768373723;
	bh=jAU13ANnoHREg4tq8eq6SJekJk5aOvQhMYOQD9AiiyM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=wLy0+VHFuKyl80wtCYn90C1oJlp4fr0a6PL+eNsBMKBKl5ixsjWyTxn32I7+exbo2
	 DsoPvx1leqaitLTQjvm6e1aM3JJh26k2vJgCnOZfrxGNvbQIcJ9tOVzSWneVlDi0Pv
	 DQHEuvenFTHPGO+HcPuUPJGS9OCZbUl9jyrBT+xM=
Date: Wed, 14 Jan 2026 07:55:19 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Gideon Adjei <gideonadjei.dev@gmail.com>
Cc: Andy Shevchenko <andy@kernel.org>,
	Abdun Nihaal <abdun.nihaal@gmail.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Jianglei Nie <niejianglei2021@163.com>,
	Matthew Wilcox <willy@infradead.org>,
	dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] staging: fbtft: Change udelay() to fsleep()
Message-ID: <2026011432-disliking-boxlike-fcb3@gregkh>
References: <20260113221722.5157-1-gideonadjei.dev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260113221722.5157-1-gideonadjei.dev@gmail.com>

On Tue, Jan 13, 2026 at 02:17:22PM -0800, Gideon Adjei wrote:
> Replace udelay() calls >= 100us with fsleep() to avoid busy-waiting.
> 
> The delays are used in init_display() callbacks. These callbacks are
> invoked by fbtft_probe_common() during the driver's probe path. The
> probe path runs in process context which already uses sleeping APIs.
> This makes fsleep() safe to use in these situations.
> 
> Signed-off-by: Gideon Adjei <gideonadjei.dev@gmail.com>
> ---
>  drivers/staging/fbtft/fb_tinylcd.c   | 2 +-
>  drivers/staging/fbtft/fb_upd161704.c | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/staging/fbtft/fb_tinylcd.c b/drivers/staging/fbtft/fb_tinylcd.c
> index 9469248f2c50..3fb15df31592 100644
> --- a/drivers/staging/fbtft/fb_tinylcd.c
> +++ b/drivers/staging/fbtft/fb_tinylcd.c
> @@ -41,7 +41,7 @@ static int init_display(struct fbtft_par *par)
>  		       0x00, 0x35, 0x33, 0x00, 0x00, 0x00);
>  	write_reg(par, MIPI_DCS_SET_PIXEL_FORMAT, 0x55);
>  	write_reg(par, MIPI_DCS_EXIT_SLEEP_MODE);
> -	udelay(250);
> +	fsleep(250);

Without the hardware and specifications to test this with, we can't take
this type of patch.  Please see the mailing list archives for the
multitude of times it has been rejected in the past.

sorry, but checkpatch can be ignored here.

thanks,

greg k-h
