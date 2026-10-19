Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0C1178F3A
	for <linux-fbdev@vger.kernel.org>; Mon, 19 Oct 2026 00:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.134.164.83
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792369751; cv=none; b=frwaUKiOad+IduT0T6zOR4BEAtj3v9HJeUwkZyr5crPF3GZ5ucgamez38Rbl7IxYCNfWTqXEC0cOI4Kbo8FNxzX4w2bCmzS3WHTPpJzc2b4XSD0yXLiDQUkCzuhBpCS5M7tAZIh47UdiqRxqn1JQEEbb4BZ10hd3821QmOensx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792369751; c=relaxed/simple;
	bh=m6Zj10IoU6U9egtozcmN0uHeXQWn+gwLqE0GJfQ24Ew=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=WhZ0VVuSs6z4eUKGmxyYUdO7IKh66NpsHmKSWi6IqgSRmlj40Wkbd2nvQGyLpr9VXA0LNQjGI3YaTcw4C2pkyjPqt+tvj4QhCjV5l5RdDnsJ+Rys6iNhK8FdKdULfyZlUsmhCVzaB3yy1Hlj1+MD92hyBHdMi19HLu82jFQHzso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr; spf=pass smtp.mailfrom=inria.fr; dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b=S45bTdRV; arc=none smtp.client-ip=192.134.164.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inria.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b="S45bTdRV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=PX9P4epPwQGrFseDhd6txC4pMNLWfiLbHeHoD9TPFYg=;
  b=S45bTdRVqIqKRLHuDeIcwLUVNoWdl+fDC2+tNKm4l3BHe/IiGO/Q1fYM
   mL3Pr+5hKnqsJBqL1lX8sFJTlyZCoD3lu9IpuoUVJEJhPNadHNDpAgTS9
   0ItLtnmjNZ8rkiyqCBDE938QFTbQvpXJ6Hh0MXezy4gx/yLj6wiZU2Rk7
   o=;
X-CSE-ConnectionGUID: ZX1RDQVJTku0PRIMR/E0VA==
X-CSE-MsgGUID: fVzwDvrMQ1yHSljIa7uTtQ==
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.27,166,1787004000"; 
   d="scan'208";a="300770566"
Received: from c-76-123-3-53.hsd1.va.comcast.net (HELO hadrien) ([76.123.3.53])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2026 02:29:05 +0200
Date: Sun, 18 Oct 2026 20:29:02 -0400 (EDT)
From: Julia Lawall <julia.lawall@inria.fr>
To: Bashirah Lawal <bashirahlawal017@gmail.com>
cc: andy@kernel.org, gregkh@linuxfoundation.org, 
    dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, 
    linux-staging@lists.linux.dev, outreachy@lists.linux.dev
Subject: Re: [PATCH] staging: fbtft: Fix continuation line alignment
In-Reply-To: <20261018123430.148379-1-bashirahlawal017@gmail.com>
Message-ID: <d1df7421-8b3-132-68c1-feb29ed47b41@inria.fr>
References: <20261018123430.148379-1-bashirahlawal017@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII



On Sun, 18 Oct 2026, Bashirah Lawal wrote:

Hello Bashirah,

As noted by Greg's automatic message, you can't rely on the subject line
to explain everything.  Every patch must have a comment saying what you
have done and why.

julia

> Signed-off-by: Bashirah Lawal <bashirahlawal017@gmail.com>
> ---
>  drivers/staging/fbtft/fb_tinylcd.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/staging/fbtft/fb_tinylcd.c b/drivers/staging/fbtft/fb_tinylcd.c
> index afa8f1c740c5..d58b1247262b 100644
> --- a/drivers/staging/fbtft/fb_tinylcd.c
> +++ b/drivers/staging/fbtft/fb_tinylcd.c
> @@ -38,7 +38,7 @@ static int init_display(struct fbtft_par *par)
>  	write_reg(par, 0xE5, 0x00);
>  	write_reg(par, 0xF0, 0x36, 0xA5, 0x53);
>  	write_reg(par, 0xE0, 0x00, 0x35, 0x33, 0x00, 0x00, 0x00,
> -		       0x00, 0x35, 0x33, 0x00, 0x00, 0x00);
> +		  0x00, 0x35, 0x33, 0x00, 0x00, 0x00);
>  	write_reg(par, MIPI_DCS_SET_PIXEL_FORMAT, 0x55);
>  	write_reg(par, MIPI_DCS_EXIT_SLEEP_MODE);
>  	fsleep(250);
> --
> 2.53.0
>
>
>
