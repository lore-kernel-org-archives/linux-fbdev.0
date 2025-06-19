Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93C67645;
	Thu, 19 Jun 2025 15:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750347147; cv=none; b=TBR+NrkIHvsRWOCC5n2Y+cbui/tG/V5iMndPIiYgkI/CpoZ17u7R6jYXo/R2oHy9zR4G9GT6wu5WsI/Ze6DvRxjBWd7gSVop3BVmZw17E/+J+lcxKl1/e5DAVMHKPdPllpyuv7pofQLVzfopLkEQ5ICAj14F3wJCdqEhleJ8YX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750347147; c=relaxed/simple;
	bh=WVMKZk4iaOiQONjoZDaaI3nckWfp3Cl9dhhXGGi3gTQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r5BP9yQCeUMMKgLFYtAaDG9Z9SerA/vPeLVJzs323670xmXlyBbP9SdGzCdWKB1P8dVTgh8ThqLy5H2JGUr+vrWKJ8V2MKxAIZ5QMszbpcInQl0n/NB6rxXN+9JVPu4Ep/4Ox1CRsvsNXCmP46uAZznpIYdY7VXl71jKThMzHDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KALVlUiF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KALVlUiF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BA84C4CEF0;
	Thu, 19 Jun 2025 15:32:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750347147;
	bh=WVMKZk4iaOiQONjoZDaaI3nckWfp3Cl9dhhXGGi3gTQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KALVlUiFiBttI7WFYMZtCCKISUp/M9nxtgBCyaUY/lbcDriHUOYYgSRPz/0sjRMzF
	 Ij5/5VA3gAXE0sgZ9QEvLv99X3IJ0L6p2sonkG3Ufh6aUunHdRm9nQBSZ1yTb9LXW1
	 On/T3Kr0ILzNZWKA8sSIgIjQ/ae9+cj0r25vFuHA=
Date: Thu, 19 Jun 2025 17:32:23 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: khalid.datamax@gmail.com
Cc: sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com,
	linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] staging: sm750fb: convert CamelCase function names
 to snake_case
Message-ID: <2025061906-doorframe-drearily-af3d@gregkh>
References: <20250531211319.55682-1-khalid.datamax@gmail.com>
 <20250531211319.55682-3-khalid.datamax@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250531211319.55682-3-khalid.datamax@gmail.com>

On Sun, Jun 01, 2025 at 02:41:03AM +0530, khalid.datamax@gmail.com wrote:
> From: Khalid Faisal <khalid.datamax@gmail.com>
> 
> This patch converts function names in the sm750fb driver from CamelCase to
> snake_case to comply with Linux kernel coding style.
> 
> No functional changes.
> 
> Signed-off-by: Khalid Faisal <khalid.datamax@gmail.com>
> ---
>  drivers/staging/sm750fb/ddk750_dvi.c    | 16 +++++------
>  drivers/staging/sm750fb/ddk750_sii164.c | 38 ++++++++++++-------------
>  drivers/staging/sm750fb/ddk750_sii164.h | 16 +++++------
>  3 files changed, 35 insertions(+), 35 deletions(-)

Are you sure this file is still in the tree?  I don't see it anymore :(
