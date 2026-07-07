Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52706390229;
	Tue,  7 Jul 2026 09:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783415494; cv=none; b=JZ6cGoeMXlY95hvZtZSm6DpJ3JceLGALmNOBK2HIHaQyVYEAQXeLuqtqt3xUr7pxRGXPOrqaz4FijPABbMICVv5PTmWjGc8q2P1V540gmC4KfLvXfqR8EspCC4/+zPmlrQXDUi9TvDW3Zd7oR7DsQcTlPTSDQFqjpFRfUorkA9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783415494; c=relaxed/simple;
	bh=q6QRrlmtPDSpiE2ZSnszpV7TJrXeqexn1Wr4WbJ6FHw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PKxEsW40g6+P855NKX+UUZD8kgRuXZXUxL9MOZwR8XQboFIf9/Ryj1DgwG4Crfkmhxx/YHWTGlzfwi0TW4UQG5x2Q/YOzuLolFIgExgXAj2spL/BTC+YjZstvtFX6z3Ybon8FKT0sHZfBxTXfu6ySKdN6hPXbO/F8jlN1AX2CJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=sgs5GRzo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="sgs5GRzo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 290731F000E9;
	Tue,  7 Jul 2026 09:11:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1783415492;
	bh=wKkSJtuFmWOgT7B+qzyHht6dHGZjWtnBBwfPVn+a4uY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=sgs5GRzooulbS5YmnllK0uNG8G7A0/+/gquqdZVE6OR1nlxyMo8iyhcm7QhPTWXUk
	 IqVvDK3n4h91tyFX22hR893mndGQpAMhLNh35qsVmX47Df3K3WK2xpnFi+me7b7G+S
	 PVOokQn3Awde8QL4PxWud/XmIC4rQc8kXr/hUPAQ=
Date: Tue, 7 Jul 2026 11:11:30 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: =?iso-8859-1?Q?Andr=E9?= Moreira <andrem.33333@gmail.com>
Cc: sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com,
	linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: sm750fb: rename variables to avoid CamelCase
Message-ID: <2026070710-exact-unveiling-e321@gregkh>
References: <20260623220614.29682-1-andrem.33333@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260623220614.29682-1-andrem.33333@gmail.com>

On Tue, Jun 23, 2026 at 07:06:14PM -0300, André Moreira wrote:
> Rename 'pvReg' to 'pv_reg' and 'setAllEngOff' to 'set_all_eng_off'
> throughout the driver to comply with the Linux kernel coding style.
> 
> Signed-off-by: André Moreira <andrem.33333@gmail.com>
> ---
>  drivers/staging/sm750fb/sm750.c    |  6 +++---
>  drivers/staging/sm750fb/sm750.h    |  4 ++--
>  drivers/staging/sm750fb/sm750_hw.c | 12 ++++++------
>  3 files changed, 11 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
> index 89c811e0806c4..716a8935f58d1 100644
> --- a/drivers/staging/sm750fb/sm750.c
> +++ b/drivers/staging/sm750fb/sm750.c
> @@ -743,7 +743,7 @@ static int lynxfb_set_fbinfo(struct fb_info *info, int index)
>  	 * must be set after crtc member initialized
>  	 */
>  	crtc->cursor.offset = crtc->o_screen + crtc->vidmem_size - 1024;
> -	crtc->cursor.mmio = sm750_dev->pvReg +
> +	crtc->cursor.mmio = sm750_dev->pv_reg +

This variable name is still in hungarian notation, which is not allowed
in kernel variable names.

thanks,

greg k-h
