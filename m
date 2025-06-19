Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DA042673A9;
	Thu, 19 Jun 2025 15:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750347038; cv=none; b=NCGov0J5ODaDw8N040FLN3gYHz0P7AQCNC3nFFlAZ6s7HYYbCi30wKQtUuRV5ZSLCJ2Te7fpMjFNP6iKfVoRlrxJ1dciQbGiAGgVMP1dujNiTgDpQMEsDRXd37/vy1BAoZcXbSReO/LMK2lTGtghwyIPcZFxkzXh596HQ9sjKl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750347038; c=relaxed/simple;
	bh=SjgNtYS85/qA/tiE5bruaWO1VhRfhT9MP9zsvpZ7vKQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hco0qS+TuqF72+5wwsmPnr+y/8wr4Kx0Js/NowtxbPM/2RD4jH1QNixHcoyZEPoOiwNKGH5RgSw7v0uhX3Wpd+DBxuMabzZumMipw7EMFQJeUbFRMhaVjTMn6RpfAxRex8vss0cbqulB5jRHuHhF/QF3CAyZ6AQ2HdfQp3U1nRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=urUEHbAl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="urUEHbAl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5079BC4CEEA;
	Thu, 19 Jun 2025 15:30:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750347037;
	bh=SjgNtYS85/qA/tiE5bruaWO1VhRfhT9MP9zsvpZ7vKQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=urUEHbAlsJAvmNhLMnAIZW9UCxGL8YqxtBXIexZQ3esluEnatuHFtocbAMjj1bVIu
	 gtGLZbNOa3G7n+zzOBJvlt9jV0bVKzjSJ/hz64NPKJJtjpqCEydHiGDTGE2OyD/LyA
	 iYraO4z78Rub9kZ7AlfFndYNkH02AG7BXWi+5xkU=
Date: Thu, 19 Jun 2025 17:30:34 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Eric Florin <ericflorin@google.com>
Cc: teddy.wang@siliconmotion.com, sudipm.mukherjee@gmail.com,
	linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/6] staging: sm750fb: rename `dBase` parameter
Message-ID: <2025061928-coasting-grain-46f8@gregkh>
References: <cover.1748365488.git.ericflorin@google.com>
 <b46e54ed9006f7a5b4439b8d4bb1fc36bd9c3ca0.1748365488.git.ericflorin@google.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b46e54ed9006f7a5b4439b8d4bb1fc36bd9c3ca0.1748365488.git.ericflorin@google.com>

On Tue, May 27, 2025 at 10:11:25AM -0700, Eric Florin wrote:
> Rename `dBase` to `d_base` in `sm750_hw_copyarea` to conform with kernel
> style guidelines as reported by checkpatch.pl
> 
> CHECK: Avoid CamelCase: <dBase>
> 
> Signed-off-by: Eric Florin <ericflorin@google.com>
> ---
>  drivers/staging/sm750fb/sm750_accel.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/staging/sm750fb/sm750_accel.c b/drivers/staging/sm750fb/sm750_accel.c
> index 029f5c013d91..e5f1f021768b 100644
> --- a/drivers/staging/sm750fb/sm750_accel.c
> +++ b/drivers/staging/sm750fb/sm750_accel.c
> @@ -136,7 +136,7 @@ int sm750_hw_fillrect(struct lynx_accel *accel,
>   * @s_pitch: Pitch value of source surface in BYTE
>   * @sx: Starting x coordinate of source surface
>   * @sy: Starting y coordinate of source surface
> - * @dBase: Address of destination: offset in frame buffer
> + * @d_base: Address of destination: offset in frame buffer

"dest_base"?
