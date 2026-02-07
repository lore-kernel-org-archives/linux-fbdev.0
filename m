Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 368BA1F0991;
	Sat,  7 Feb 2026 13:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770471089; cv=none; b=jr9t3onFhlUdHN162c7NR+nKVpmKEy1E8J79kN/wUjm8tiMPiUKDFKJY4tPiq3d10JYUTnC7XQ+e9WGYgd7w9pN0rTeIIbr4rTB9KZzKZtJJiGjpB8c7siwGLp8P00Uog5DHgGxkG3t6Ml1Ukn8c7lqbL7VtY+XyWRtlQyhyeA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770471089; c=relaxed/simple;
	bh=UEBdvrsdLzQebPlX6SesCXGogrQQYkIaMRLCjMVKaGA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jJ87yiBEOTiorqAzUSs7sbm7bNkikRK23Pr7HTd3MscSRiSHINkukBqMjStR9T61ZPLLx+XMTgBKVvinFgMAhMHcffHFgtIhV+ORa/3kEaposbyT54Br9KCfqRPENtIkhVhnJFU6YARiVvWzs3GQCKsMMinmJOngRqAl9KknTZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Re5amzWB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Re5amzWB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54E8CC116D0;
	Sat,  7 Feb 2026 13:31:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770471088;
	bh=UEBdvrsdLzQebPlX6SesCXGogrQQYkIaMRLCjMVKaGA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Re5amzWBGUm8IAAP17Z8reGp+YE/n58BqXGipkJd/uihLmulZzXtUE/leqMicnd0U
	 FVk339kGrMt/s99Bq814tGdazxmavP6IWIUuuMfKlKYRgCqTmVw5YGxiNe7S8pEILp
	 XgRNJS2iEwEIEu6DhjKgmRqeXuCTEtbVTuRlCQBY=
Date: Sat, 7 Feb 2026 14:31:25 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Artem Lytkin <iprintercanon@gmail.com>
Cc: Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
	Teddy Wang <teddy.wang@siliconmotion.com>,
	linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/5] staging: sm750fb: use strcmp() for exact option
 matching
Message-ID: <2026020712-creasing-portion-436f@gregkh>
References: <20260204120602.6715-1-iprintercanon@gmail.com>
 <20260204120602.6715-2-iprintercanon@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260204120602.6715-2-iprintercanon@gmail.com>

On Wed, Feb 04, 2026 at 12:05:59PM +0000, Artem Lytkin wrote:
> Replace strncmp(opt, "...", strlen("...")) with strcmp() in option
> parsing functions. Options from strsep() are complete null-terminated
> tokens, so prefix matching via strncmp() could cause false positives
> for options like "noaccelXYZ" matching "noaccel".
> 
> Fixes: 81dee67e215b ("staging: sm750fb: add sm750 to staging")
> Signed-off-by: Artem Lytkin <iprintercanon@gmail.com>
> ---
>  drivers/staging/sm750fb/sm750.c | 22 +++++++++++-----------
>  1 file changed, 11 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
> index 4c6e84c03..bd2d4a290 100644
> --- a/drivers/staging/sm750fb/sm750.c
> +++ b/drivers/staging/sm750fb/sm750.c
> @@ -937,21 +937,21 @@ static void sm750fb_setup(struct sm750_dev *sm750_dev, char *src)
>  		dev_info(&sm750_dev->pdev->dev, "opt=%s\n", opt);
>  		dev_info(&sm750_dev->pdev->dev, "src=%s\n", src);
>  
> -		if (!strncmp(opt, "swap", strlen("swap"))) {
> +		if (!strcmp(opt, "swap")) {

While I understand the feeling, again, this really isn't doing anything
except cause other code checkers to go "Wait, we can't call strcmp() we
must replace that with strncmp()!"

Please don't replace one warning with another.  Option parsing is a
pain, let's not make it any more of a pain than it is.  Ideally all of
the framebuffer drivers could make some "simple" helper functions to
handle this crazy logic for them, instead of forcing them to all do it
manually :(

Yet another reason all of us want to just delete all of these drivers...

thanks,

greg k-h
