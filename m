Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 636A03A8747;
	Mon, 11 May 2026 07:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778486230; cv=none; b=WpQvLSIOb/Z0rG3WKV3BsMxB2RlWVf57jVZTJtORhzJzA38TEPt8IEE0SnC9RiBaZBqkRX72XKJahJSoRWlVSO6quxdifh6Mw38tjC3bgPj96fzzW9i9eYtElCTiZXxHjSyIN0UgzkPTWXjMzPMTXjP6PTipvqFItL+kEPiZSNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778486230; c=relaxed/simple;
	bh=xoszqIFclkt39j6kHtik7JNlZe/Gte788UPg1TZKhMY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sWfsb/AFaBpe33jYa3Phfmcaj/VfQULEt31mZJN1usFkKyUBJ3C0I9Xf17pMTBnBV8F0Kh234XR41vMNJBQMKXczqd8HMpXCS3b0qlbq8d/aMFeXyX8yxL/a1nAmYWZuekrJFdmKEuKz8kXFs+vi5tG9K67qzAdsUTXxbMHKEyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bwG/OdZD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bwG/OdZD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24A8CC2BCB0;
	Mon, 11 May 2026 07:57:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778486229;
	bh=xoszqIFclkt39j6kHtik7JNlZe/Gte788UPg1TZKhMY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bwG/OdZDnPQdEit0udfb4xs/Mql+f6PNtb6wLs5eW9tZmlYYgskmzpyYCAqsgyscg
	 htcmZlBq1Q+CuCHuY7vzPbuQPVgmatQvHiFFV0nT4LWYUimr6LumWDYAbo0FWgZP7D
	 pqQcVJMlaRHrOk46babTBr1BGmHqTwUpX6sd5mKo=
Date: Mon, 11 May 2026 09:57:07 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Alone <yogeshdangal66@gmail.com>
Cc: Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
	Teddy Wang <teddy.wang@siliconmotion.com>,
	linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: sm750fb: Add const to g_fbmode array
Message-ID: <2026051100-mankind-disown-5cf3@gregkh>
References: <20260509164057.71722-1-yogeshdangal66@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260509164057.71722-1-yogeshdangal66@gmail.com>

On Sat, May 09, 2026 at 10:25:57PM +0545, Alone wrote:
> From: Chhabilal Dangal <yogeshdangal66@gmail.com>
> 
> Add const qualifier to g_fbmode array since the array
> itself is not modified after initialization.
> 
> Signed-off-by: Chhabilal Dangal <yogeshdangal66@gmail.com>
> ---
>  drivers/staging/sm750fb/sm750.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
> index 9f3e3d37e..19c3da654 100644
> --- a/drivers/staging/sm750fb/sm750.c
> +++ b/drivers/staging/sm750fb/sm750.c
> @@ -33,7 +33,7 @@
>  static int g_hwcursor = 1;
>  static int g_noaccel;
>  static int g_nomtrr;
> -static const char *g_fbmode[] = {NULL, NULL};
> +static const char * const g_fbmode[] = {NULL, NULL};
>  static const char *g_def_fbmode = "1024x768-32@60";
>  static char *g_settings;
>  static int g_dualview;
> -- 
> 2.54.0
> 
> 

Please always test-build your patches :(
