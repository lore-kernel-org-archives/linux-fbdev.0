Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10D94421A16;
	Wed,  4 Feb 2026 15:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770220461; cv=none; b=neVk35USwKsTpFqYzCE6I3nowJ/D0KlaKLt4RxHTof/TTDKbioqaDNPzxLQGeWtWLd4xPBpVnu0c3lPQJS3j+LdQHav0z9MezdeZ0KCnloAy++5/RLHjfIb9Jk8kz5ZhZRrHhOEXJss977auYuZm7cAHY/SLdxLDjXUjZkshDTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770220461; c=relaxed/simple;
	bh=RSORJ03ne4P+AXQgsb8E2FO6orKfDo+ustVJgXpZ7+I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=blNtMRmWibM+FGxreYfaCTQNhB7E+c0zTERRq4vxNt9PHyGNVulwpq4Vdeax/cN+L5VELhjPkh9y8JUQ1yScAvl+uUy7ez9fFKUys8jwwJdJYT8/PWbhevSuR7xbd+Un9WDvr8/i154EAEKTsOyMdg+caiGpaY9z8qxFgSV+BGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=OMj4Dl5F; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="OMj4Dl5F"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 371C8C19423;
	Wed,  4 Feb 2026 15:54:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770220460;
	bh=RSORJ03ne4P+AXQgsb8E2FO6orKfDo+ustVJgXpZ7+I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OMj4Dl5FLduGGkbiXRA0GeeiD5moSjai0zPSDfAcAyMaTXsmx5vaPBi11IBLr+HX6
	 TmTIvOT+QsmKqRekKAaCDdNmsKNw7QDD4J6guvsgHlFKAizmt3NtMLTjmydziubYrQ
	 7kyuHEKwUUZ8B16HFP9LSfolLsHM9AT0I8XcqaK8=
Date: Wed, 4 Feb 2026 16:54:17 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Sarah Schwartz <sarah.schwartz025@gmail.com>
Cc: sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com,
	linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: sm750fb: fix CamelCase warning for dBase
Message-ID: <2026020450-shindig-starry-32fc@gregkh>
References: <20260204153856.23277-1-sarah.schwartz025@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260204153856.23277-1-sarah.schwartz025@gmail.com>

On Wed, Feb 04, 2026 at 03:38:56PM +0000, Sarah Schwartz wrote:
> Rename variable dBase to d_base to fix a CamelCase warning reported by checkpath.pl
> This aligns the code with the Linux kernel coding style.
> 
> Signed-off-by: Sarah Schwartz <sarah.schwartz025@gmail.com>
> ---
>  drivers/staging/sm750fb/sm750_accel.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/staging/sm750fb/sm750_accel.c b/drivers/staging/sm750fb/sm750_accel.c
> index 046b9282b..c77b0fe3b 100644
> --- a/drivers/staging/sm750fb/sm750_accel.c
> +++ b/drivers/staging/sm750fb/sm750_accel.c
> @@ -136,7 +136,7 @@ int sm750_hw_fillrect(struct lynx_accel *accel,
>   * @sPitch: Pitch value of source surface in BYTE
>   * @sx: Starting x coordinate of source surface
>   * @sy: Starting y coordinate of source surface
> - * @dBase: Address of destination: offset in frame buffer
> + * @d_base: Address of destination: offset in frame buffer

what does the "d_" stand for here?

Should that be dest_base instead?

>   * @dPitch: Pitch value of destination surface in BYTE

Why ignore all of these other variables as well?

thanks,

greg k-h
