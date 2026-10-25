Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792907738;
	b=Y2yQorwtlB3m+XhS6lzQ4Pwfv4S+mlVmE1NWIq/tsNqYK7g5n5rvwU69zYmZYBKd2efy
	 n6g9APG1W+zkVjCkVmpvoXSZ8o/9H3eDX3sNZpa5f51WG0GU3205N2sIRXZInpxAxMK9+
	 cBQrXd6OUvRXOIDTbF7sUd9Q4UKsTxX0I1LxsVTKjUFFek9Sv1sZGGee0rZ1ucea8Eddu
	 ivcpP5NaATlfHvOrn8NZ+OoYIfhhRRnAG6LADc5HETfZrxBKiYkFK4qA96p2iqBufMUs2
	 z3lqi1slFcdnbfleIzGVLXSpsDXXNxwBwuRF4SUdawCazwqlE0sx898MRP2SePM1N8Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792907738;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=WTcOXp7jRbhT7DDBNRcTdM1HTdeP3FAq6cpW563Fmvc=;
	b=0xG14PzitKtTHDDCwrxvs5mCfmZ9ZfM63aBkZiELZ5FnaVpth+WnDPuDI2tYoySspod1
	 jX1ba0k7SuZK/xXAB9EhM1zFw8bTQlIThl5ah6zoSRg106TwOYFCBxDlAP1DXLwpMh7pV
	 tNHG6xNsmteFKqW6u2uwijNJPbkkxnRDJB+lkVGEVyz2xvUgX4Bm/27BXf/YOUh8UUhBh
	 dIlp+1UVjiF+7isASw/FqsX6Mx+kY/Ad4e62caQFXB2qCtXp41zBQY2SwPp2vDqsIrNfl
	 GDqEddKxhO7/tpYLrdWRwjgPFkrlsawhAeeRF3VlC8lklOoJtAXSKgoTFZxi4xsDb+w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=Y6+EEKjy;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77C16606A32A;
	Sun, 25 Oct 2026 05:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=Y6+EEKjy
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8855D1F01828;
	Sun, 25 Oct 2026 05:55:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1792907738;
	bh=WTcOXp7jRbhT7DDBNRcTdM1HTdeP3FAq6cpW563Fmvc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Y6+EEKjyNojqgRd/Lim4Ovq+wn39ENkOzqvd1qnW5Ml0ht4Ey7ac2qzwJro3+D2MY
	 2m5YlnulKjoPqy7Xy6QrpTfheaXhxlJrxGtIkYulsHyV3ngoImhEXurtef5IEQIXY5
	 IPIx90sW2fJqut7V8fXgvrTrScQ45H0bDFvDBXso=
Date: Sun, 25 Oct 2026 06:55:34 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Aditya Nagar <dev.adityanagar@gmail.com>
Cc: Andy Shevchenko <andy@kernel.org>, linux-staging@lists.linux.dev,
	linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: fbtft: remove unused argument from
 FBTFT_SPI_DRIVER()
Message-ID: <2026102519-polymer-gorged-bc90@gregkh>
References: <20261025052136.389541-1-dev.adityanagar@gmail.com>
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Post: <mailto:linux-fbdev@vger.kernel.org>
List-Help: <mailto:linux-fbdev+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fbdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261025052136.389541-1-dev.adityanagar@gmail.com>

On Sun, Oct 25, 2026 at 10:51:36AM +0530, Aditya Nagar wrote:
> The _compatible argument of FBTFT_SPI_DRIVER() is never used in the
> macro body. The device tree match table is created separately by
> FBTFT_DT_TABLE() in both callers, FBTFT_REGISTER_DRIVER() and
> FBTFT_REGISTER_SPI_DRIVER().
> 
> Drop the argument and update both callers. No functional change.
> 
> The argument has been unused since the macro was introduced in commit
> c222ea5d2f33 ("staging: fbtft: Deduplicate driver registration macros").
> 
> Found with checkpatch.pl (MACRO_ARG_UNUSED). The change was prepared
> with the help of an AI coding assistant (Claude); I reviewed it and
> build-tested all fbtft drivers with W=1.
> 
> Signed-off-by: Aditya Nagar <dev.adityanagar@gmail.com>

Sorry, but please read:
	https://lore.kernel.org/r/2026080354-skater-urgent-31b2@gregkh
