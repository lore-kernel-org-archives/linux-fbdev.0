Received: from h5.fbrelay.privateemail.com (h5.fbrelay.privateemail.com [162.0.218.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C49426B2D7;
	Tue, 21 Oct 2025 08:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.0.218.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761034401; cv=none; b=TziluhR4TF8BRNYg6ZcRcy12jCiUSwuksdLIbJnkqjSNdEJxNpT6fZM6ELKaL3YBa813qv5cw+hMVjX0JJksQrr7pzqQLMmGwhMN6HkrByHpd5LtC1sUsQ4JDjsnGpzoUP61+QNKQrW/3+AqLE3wpNaOAeFvqNFOGBJf3ruFj40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761034401; c=relaxed/simple;
	bh=21tz4INp76XZE73YF39d4OhuGExWH86i52/5vzcfF/g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=itD+zd2QTP+zoZRQIuLyR0y4lNnDC7HT4FPNAfitJ+8DJUiYbiRBcizram4VAOp9Id4eBv3QtRtOdILdU2t8ePDbgCT+93xh3RcHdaIUmyXmfki9UgBLZpzWGZrbTaPGNWza14W6o2NXHlwl0XVfPALUr4tGar6OOTM5OvcIrtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lukowski.dev; spf=pass smtp.mailfrom=lukowski.dev; dkim=pass (2048-bit key) header.d=lukowski.dev header.i=@lukowski.dev header.b=YsTqt2fd; arc=none smtp.client-ip=162.0.218.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lukowski.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lukowski.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lukowski.dev header.i=@lukowski.dev header.b="YsTqt2fd"
Received: from MTA-13-4.privateemail.com (mta-13-1.privateemail.com [198.54.122.107])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by h5.fbrelay.privateemail.com (Postfix) with ESMTPSA id 4crQ646kWkz2xLr;
	Tue, 21 Oct 2025 08:13:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=lukowski.dev;
	s=default; t=1761034388;
	bh=21tz4INp76XZE73YF39d4OhuGExWH86i52/5vzcfF/g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YsTqt2fdlrinIEsrbq0Yd8KxA06pQ+fD7p78ggFYqeuI1tjtSOP4izSW8cmoBN0Ar
	 qMFOcJAXFrM6f0eCZYh/90f9lZ06ojqvju+zAjd8/02N7FOjzUd2yIG3SPeWZn/4b8
	 9Un/gO4T+/lH+m3rp0dt0Cvq4cjK0r1jPxuzOfNEJaxNseXItNEfi9ziVTB1XG5PYG
	 q53kLyWsj6LwgiXsz2EvjNekNogA0tBA9BIsZi9XvZWQnAbysJgO8IaGwznutQmJlE
	 CMIcJfe/Td7Hum+D9W8j+xZUhSkFOwyIgdPdOGs71KmmzuZnuho9rJPnPfd14Vh9nb
	 CeqkzZ3fZrKEQ==
Received: from mta-13.privateemail.com (localhost [127.0.0.1])
	by mta-13.privateemail.com (Postfix) with ESMTP id 4crQ5w6T8tz3hhZK;
	Tue, 21 Oct 2025 04:13:08 -0400 (EDT)
Received: from Olles-MacBook-Air.local (unknown [150.228.61.72])
	by mta-13.privateemail.com (Postfix) with ESMTPA;
	Tue, 21 Oct 2025 04:13:01 -0400 (EDT)
Date: Tue, 21 Oct 2025 11:12:56 +0300
From: Olle Lukowski <olle@lukowski.dev>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Andy Shevchenko <andy@kernel.org>, dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: fbtft: fb_ra8875: replace udelay with
 usleep_range
Message-ID: <aPdAiG8h_bY34vfV@Olles-MacBook-Air.local>
References: <20251020-staging-fbtft-ra8875-usleep-v1-1-9592dd390c13@lukowski.dev>
 <2025102120-ride-repaint-7a22@gregkh>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2025102120-ride-repaint-7a22@gregkh>
X-Virus-Scanned: ClamAV using ClamSMTP
X-Rspamd-Queue-Id: 4crQ646kWkz2xLr

Hi Greg,

On Tue, Oct 21, 2025 at 09:37:50AM +0200, Greg Kroah-Hartman wrote:
> As per this type of change, have you tested it on real hardware?
> Without that, we can't accept this change, and such checkpatch.pl
> comments should be ignored.

Thanks for clarifying!

I don't have access to the hardware for this driver, so I'll skip these
types of timing-related changes for now and focus on other
non-functional cleanups in staging instead.

Thanks again,
Olle
