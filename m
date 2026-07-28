Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69C603C9893;
	Tue, 28 Jul 2026 07:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785222883; cv=none; b=mOsQWE2XO100FHNHMF6MSX4rYl3aPvljKQPCinXm7mK7O4nfx14cUMnnQokJaPFjdOj1wAocgMJisu4wNdnJDONqrPsBMl/lSkv3SqmVWIHxwVICD3bRLKsKZSQ5TQ9Ew58zvMOBJnmtm6eqO5ADKzkBu0A67PMPHNAAPr+LxEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785222883; c=relaxed/simple;
	bh=pH+aYJgbOn0P0qKWIwglvbJdVlGjKnKkjw9IseUdwvM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XW46gSOaaFP/jR1QTUz75KtCgtmslEtaSlJQPRHnOGjin0qj9tPgdC8UL1F2/kVuUuoZ7ABoMJxJxYrJn0O7Soh4X4pP9WlzmL/vwXjRUzmOW/lUfS2mxBipbZqlCdnb+VRv/XAhOyJaSkjelme9fdegcPJSATycIcOBEpRGN4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QVdXfW0r; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QVdXfW0r"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B59571F000E9;
	Tue, 28 Jul 2026 07:14:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785222882;
	bh=bLOm4DZuYRPGDME/xcXZ2fDFNEQdpE2f6dkBtC2gS/w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=QVdXfW0rVp7kOZSPQnaDbpF6I78PHzOHutXdrb1xb0b6hH9FEXtOReUIYCsA9djAM
	 2UtiTPKO+V20kzxMPzsTog4Etzuboc2rON5m+IjO/1nMYIwUIr2uW3F/qpx83uZ6FD
	 jUYggNfqGKEYTIiSHG2PyaDCsCSKgenERGriuzlQ=
Date: Tue, 28 Jul 2026 09:14:29 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Mohit Mishra <mishraloopmohit@gmail.com>
Cc: Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
	Teddy Wang <teddy.wang@siliconmotion.com>,
	linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] staging: sm750fb: Remove dead VALIDATION_CHIP
 preprocessor blocks
Message-ID: <2026072852-whole-commuting-cd30@gregkh>
References: <20260725090750.113598-1-mishraloopmohit@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260725090750.113598-1-mishraloopmohit@gmail.com>

On Sat, Jul 25, 2026 at 02:37:48PM +0530, Mohit Mishra wrote:
> @@ -1020,9 +994,7 @@
>  #define CRT_DISPLAY_CTRL_CRTSELECT                    BIT(25)
>  #define CRT_DISPLAY_CTRL_RGBBIT                       BIT(24)
>  
> -#ifndef VALIDATION_CHIP
>      #define CRT_DISPLAY_CTRL_CENTERING                BIT(24)
> -#endif

The indentation makes no sense here now, right?

>  #define CRT_DISPLAY_CTRL_LOCK_TIMING                  BIT(23)
>  #define CRT_DISPLAY_CTRL_EXPANSION                    BIT(22)
>  #define CRT_DISPLAY_CTRL_VERTICAL_MODE                BIT(21)
> @@ -1121,22 +1093,17 @@
>  
>  /* This vertical expansion below start at 0x080240 ~ 0x080264 */
>  #define CRT_VERTICAL_EXPANSION                        0x080240
> -#ifndef VALIDATION_CHIP
>      #define CRT_VERTICAL_CENTERING_VALUE_MASK         (0xff << 24)
> -#endif

Same here :(

And elsewhere in this patch.

Always look at the end result of your change please.

thanks,

greg k-h
