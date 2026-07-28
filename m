Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9986D3546D6;
	Tue, 28 Jul 2026 07:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785222817; cv=none; b=m5oEoD/WytcMD1I2NpFQPycrF9QoGhaQO6asGJs5t3gLAXftsRXD10EM6ef/eS5oEBm/Lwxlj5Ru+EHzM5z8EO7oBGI8j92KlwT99pb3kwUVBxKGGGcryGm8Ei3qnruY7fVSG+gw/BghUgmSwG/B/5ooTZS6ByQCm3pceH+awpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785222817; c=relaxed/simple;
	bh=TY4fAbumHIzRl2Kmeuh+HbeT2kCSI/nAGHP1tukmNLs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N+1kEN9TBGYyt2+Dr0bKL83cyBEefUmjC1Tvah/k+FAkNLuaQ6uqTGlyQ8XSWDZvWb4yNzeoOcnylsk4OOcn2nwX/aKpArMWChNS9aryynYu466CBgFgD5O180+DlqgA96Ibg0HcfhudzePVY2ZG2vezqnV80ufg1RMBtGZlw9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Ut2QWjG/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Ut2QWjG/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88F891F000E9;
	Tue, 28 Jul 2026 07:13:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785222816;
	bh=8grsjfEHRYE9amg7lq609+UDA5ow4FV3/sky6nA0x08=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Ut2QWjG/SMxCpEZCzXRn4ImiTyS4Ak6cJGafORVCQ/f3WNo8UYYlS2eGfa8WLPjmn
	 Fajx6oDg0jmnFLtDf+9s/6GLBGkgWmDpwEvw7+IwH2y3K98vSLHT51qTxzZiTmWdun
	 IbXF1PKo8RiMk3wQAqOm45LnTUyV6WZLqe/7r43U=
Date: Tue, 28 Jul 2026 09:13:22 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Nils Lehnen <nils.lehnen@proton.me>
Cc: Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
	Teddy Wang <teddy.wang@siliconmotion.com>,
	linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] staging: sm750fb: remove dead VALIDATION_CHIP
 conditionals
Message-ID: <2026072845-curliness-overcook-68a0@gregkh>
References: <20260724131121.438-1-nils.lehnen@proton.me>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260724131121.438-1-nils.lehnen@proton.me>

On Fri, Jul 24, 2026 at 01:12:59PM +0000, Nils Lehnen wrote:
> @@ -1020,9 +996,7 @@
>  #define CRT_DISPLAY_CTRL_CRTSELECT                    BIT(25)
>  #define CRT_DISPLAY_CTRL_RGBBIT                       BIT(24)
>  
> -#ifndef VALIDATION_CHIP
>      #define CRT_DISPLAY_CTRL_CENTERING                BIT(24)
> -#endif

But this define isn't used anywhere.

>  #define CRT_DISPLAY_CTRL_LOCK_TIMING                  BIT(23)
>  #define CRT_DISPLAY_CTRL_EXPANSION                    BIT(22)
>  #define CRT_DISPLAY_CTRL_VERTICAL_MODE                BIT(21)
> @@ -1121,22 +1095,17 @@
>  
>  /* This vertical expansion below start at 0x080240 ~ 0x080264 */
>  #define CRT_VERTICAL_EXPANSION                        0x080240
> -#ifndef VALIDATION_CHIP
>      #define CRT_VERTICAL_CENTERING_VALUE_MASK         (0xff << 24)
> -#endif

And neither is this.  And now the indentation for all of these does not
make any sense, right?

thanks,

greg k-h
