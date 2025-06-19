Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E38053085DB;
	Thu, 19 Jun 2025 15:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750346968; cv=none; b=aPJfq7hvozuER7B/eK+syKFhz4Mnl60vyzCDwVTmH0oVw+46sU8iKTfhsY5sihx5VJQqVvW3xqW+R63qhpvrqscE1qthkH00yjbxH95XOQCIwUl/Adb6u93vN6aS11efo+aPeb/MWg28xUH1ebujAL132bfH9aeg6QMUVgHH5B4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750346968; c=relaxed/simple;
	bh=LqEaOVXlb5nhUYPtW3KA8LsScIYIudvJF2Ua/lAq+ak=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SkYEMXfk1JwPvcXJ6YyErznZHYFCNzj4kKEETEPRQSO7+7Pg1X7xsJR2lMM1fXAocnbcuKIC0wBtFmqlbgUloDg4qIE1LgKy7DPr222yYh0BnGBMGivi44zUNdGoE28ODcyYg+pH/FohAbg7NW/sIEoUD0GT++JogP06ICRBjm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=A4yGovvm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="A4yGovvm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF606C4CEEA;
	Thu, 19 Jun 2025 15:29:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750346967;
	bh=LqEaOVXlb5nhUYPtW3KA8LsScIYIudvJF2Ua/lAq+ak=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=A4yGovvmpk6Tw5qK/Tref13CpSyUEuKdATBY9PjzZ332381njENYhwOaJcyaMQt0H
	 Dtne2grN1ZnvYcOhdSYE6qoGLxuF3FvwGAfwGFe2kuxarU9rxgg2NMEmJG9MjXi2Fd
	 VX6mxgADtJ9VOBJo28SCoopuNaVwgVMzRN1wgnqo=
Date: Thu, 19 Jun 2025 17:29:24 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Eric Florin <ericflorin@google.com>
Cc: teddy.wang@siliconmotion.com, sudipm.mukherjee@gmail.com,
	linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/6] staging: sm750fb: rename `sBase` parameter
Message-ID: <2025061908-snore-pesticide-1389@gregkh>
References: <cover.1748365488.git.ericflorin@google.com>
 <61e6984331cc7ff88a9f8207e187cd5b9ffd9c63.1748365488.git.ericflorin@google.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <61e6984331cc7ff88a9f8207e187cd5b9ffd9c63.1748365488.git.ericflorin@google.com>

On Tue, May 27, 2025 at 10:11:23AM -0700, Eric Florin wrote:
> Rename `sBase` to `s_base` in `sm750_hw_copyarea` to conform with style
> guidelines as reported by checkpatch.pl
> 
> CHECK: Avoid CamelCase: <sBase>
> 
> Signed-off-by: Eric Florin <ericflorin@google.com>
> ---
>  drivers/staging/sm750fb/sm750_accel.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/staging/sm750fb/sm750_accel.c b/drivers/staging/sm750fb/sm750_accel.c
> index 44b9e3fe3a41..74e4be8103ac 100644
> --- a/drivers/staging/sm750fb/sm750_accel.c
> +++ b/drivers/staging/sm750fb/sm750_accel.c
> @@ -132,7 +132,7 @@ int sm750_hw_fillrect(struct lynx_accel *accel,
>  /**
>   * sm750_hw_copyarea
>   * @accel: Acceleration device data
> - * @sBase: Address of source: offset in frame buffer
> + * @s_base: Address of source: offset in frame buffer

Wouldn't a better name be "source_base"?

thanks,

greg k-h
