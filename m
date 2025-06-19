Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8C82224896;
	Thu, 19 Jun 2025 15:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750346978; cv=none; b=pN0VeB8Qxknz/HkZdOO/LuyF6L0+yea432O3d+Ttrdk57r/iHb72Bosk/AeseerwmboB293xeUlij0UZXLBq/78mg/W2rz1ik6UcJm6jVoM9m89Hz/1YfVSE16cBDm9a+vuEtAMUpDDwp4CNSgHwdFP9VKGdrFPHrHPSkt4jf/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750346978; c=relaxed/simple;
	bh=ghDCZ6yhZuJ+QYfKgFrS5+1CkwrTkdyRQ5F29OOI+Ug=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bJWaTffJU7ZAH0iGZz9fkECxYLQmJUaJGCvhmXctL/Sl3btdEDUyvHMYUYB8Cv0wMEaDVYlzHnNTCqKmO7q7j/bslYec3r+Hed9dCruZUpzu76c9lOR8ybooJ1T4/mhgVoIih2dYeRXcM+BzI6P8Pby7f8RYsjY/SVuaJdvqpYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SV6Y8k1c; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SV6Y8k1c"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 035B1C4CEEA;
	Thu, 19 Jun 2025 15:29:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750346977;
	bh=ghDCZ6yhZuJ+QYfKgFrS5+1CkwrTkdyRQ5F29OOI+Ug=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SV6Y8k1cCuF6979Za4qh5kUrbMSbAUjJ1wIXtWkmSpuI5GC1AQXwRjIEMtDGlxF0E
	 NHQ6VE5udrKed84q6Y5R9pHztQQruoOUFIgAacTDv4QXRGhEpk1oW7H7kipEagiQns
	 BfoHcZb7k7wMZa1zFQIOhPVeqCJsghTItQ5kBtQQ=
Date: Thu, 19 Jun 2025 17:29:34 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Eric Florin <ericflorin@google.com>
Cc: teddy.wang@siliconmotion.com, sudipm.mukherjee@gmail.com,
	linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/6] staging: sm750fb: rename `sPitch` parameter
Message-ID: <2025061926-headway-pork-c148@gregkh>
References: <cover.1748365488.git.ericflorin@google.com>
 <0ee15444dc0f9430b1c7836c565e305b6dab823a.1748365488.git.ericflorin@google.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0ee15444dc0f9430b1c7836c565e305b6dab823a.1748365488.git.ericflorin@google.com>

On Tue, May 27, 2025 at 10:11:24AM -0700, Eric Florin wrote:
> Rename `sPitch` to `s_pitch` in `sm750_hw_copyarea` to conform with
> kernel style guidelines as reported by checkpatch.pl
> 
> CHECK: Avoid CamelCase: <sPitch>
> 
> Signed-off-by: Eric Florin <ericflorin@google.com>
> ---
>  drivers/staging/sm750fb/sm750_accel.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/staging/sm750fb/sm750_accel.c b/drivers/staging/sm750fb/sm750_accel.c
> index 74e4be8103ac..029f5c013d91 100644
> --- a/drivers/staging/sm750fb/sm750_accel.c
> +++ b/drivers/staging/sm750fb/sm750_accel.c
> @@ -133,7 +133,7 @@ int sm750_hw_fillrect(struct lynx_accel *accel,
>   * sm750_hw_copyarea
>   * @accel: Acceleration device data
>   * @s_base: Address of source: offset in frame buffer
> - * @sPitch: Pitch value of source surface in BYTE
> + * @s_pitch: Pitch value of source surface in BYTE

"source_pitch"?
