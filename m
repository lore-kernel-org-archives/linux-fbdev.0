Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B39C224896;
	Thu, 19 Jun 2025 15:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750346989; cv=none; b=u/hUQLK55dY1HCShEvO641CdH5PWiyixxdn5NWIb/fctweeyO9ajYNdqOPskK7Ou+LlErybjX9cyNo4lWX6ek6sBtcb2WR4dhmAM348hCStelPTzmkgbbQIl1suNO4jDaRPSEUE7y7jRbUQrrpDrQ8PEHCogDzHSA1BDK0yhtjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750346989; c=relaxed/simple;
	bh=U5lFTLvdSLcYjVsJ5VL23WXO8JuKFI9H2+EmycoVw/8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mi4sHj4uyw3FZ6uXJz3PomQKZUTQoyD/jlcDJE4zsSUg8NvuM1s4k3aqNtJ7Z5NYpHlddQXt7RiCmKsgO5lXTcX19z1aOKoaVQUJb0Krl25IETLpIU4pTqV5evlXpmsX2y1TvGgc5Lvgpp3nrb+gMNwpGCioYmxHFwtGlGWjDSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LgOEtwQn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LgOEtwQn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8902C4CEEA;
	Thu, 19 Jun 2025 15:29:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750346989;
	bh=U5lFTLvdSLcYjVsJ5VL23WXO8JuKFI9H2+EmycoVw/8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LgOEtwQnxyhuj+SZ0b2X5yb5YuQQVaFC+psIoykQRoXdH1MtnNM4uBgOgf/7UTl3+
	 LY3DBhzTwHRxjyDsSJh0i2CNaagw6v9nViOlMrikfn7n0PkwD3eRbs/qyZS5HqKCQG
	 KICkFjB4x5Oq2X9InX4T5bAp6+t0oRXuzQn+g6Fc=
Date: Thu, 19 Jun 2025 17:29:46 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Eric Florin <ericflorin@google.com>
Cc: teddy.wang@siliconmotion.com, sudipm.mukherjee@gmail.com,
	linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/6] staging: sm750fb: rename `dPitch` parameter
Message-ID: <2025061937-commend-tabloid-aa12@gregkh>
References: <cover.1748365488.git.ericflorin@google.com>
 <5250c76b824f133c04135b0d82b18d85cd958852.1748365488.git.ericflorin@google.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5250c76b824f133c04135b0d82b18d85cd958852.1748365488.git.ericflorin@google.com>

On Tue, May 27, 2025 at 10:11:26AM -0700, Eric Florin wrote:
> Rename `dPitch` to `d_pitch` in `sm750_hw_copyarea` to conform with
> kernel style guidelines as reported by checkpatch.pl
> 
> CHECK: Avoid CamelCase: <dPitch>
> 
> Signed-off-by: Eric Florin <ericflorin@google.com>
> ---
>  drivers/staging/sm750fb/sm750_accel.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/staging/sm750fb/sm750_accel.c b/drivers/staging/sm750fb/sm750_accel.c
> index e5f1f021768b..ea64e10d4814 100644
> --- a/drivers/staging/sm750fb/sm750_accel.c
> +++ b/drivers/staging/sm750fb/sm750_accel.c
> @@ -137,7 +137,7 @@ int sm750_hw_fillrect(struct lynx_accel *accel,
>   * @sx: Starting x coordinate of source surface
>   * @sy: Starting y coordinate of source surface
>   * @d_base: Address of destination: offset in frame buffer
> - * @dPitch: Pitch value of destination surface in BYTE
> + * @d_pitch: Pitch value of destination surface in BYTE

"dest_pitch"?
