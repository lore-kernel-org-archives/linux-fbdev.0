Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E1013E63A8;
	Sun, 27 Sep 2026 16:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790527289; cv=none; b=S7pwkRRwlpD7sLUkdQ6WrbdPiTbjuED35YW3+FqydqA0F9/kCsZzmCpszEHM2Mw/bImaZHIJ6GULfmuzXLACQROM3n06E7BBA2zc+JVjMZzAzSH1l2nT6p71pxpxQ3PwfYArmg2V1oKmBGYqOe/hHo270liqKuhEZ4zP7w0bFtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790527289; c=relaxed/simple;
	bh=kLKzNfQgXMPofxWKAYPgYrrivmNKy0cJEajbMaJhcZo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AcuIWTTedIMd61qCtLy3o+bxw/6vu+rG6TAF3Yyb5GHZ1rfm+KuOdgCJAfVx8cn+SOQVA5p/PlXxjBXNWeFos6g3yyy/nZVIDHhypSuK6wsSl1gHLv1scx840H99EIq2HoHA3o5OHSEBdrnGrAkfoqaZSue0ys9/0rze9cfcSBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=IV4X067J; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="IV4X067J"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3436D1F000FF;
	Sun, 27 Sep 2026 16:41:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1790527287;
	bh=D6N0ka76+/dxsubKOKwa/GFQ3VXKzfJaU5NPUA6DuSU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=IV4X067JIQagFTorx2nsqMjUvRM5NSwWWvspgy6Iv541CJ/C6rwRfQWAhPJP54Zon
	 wtPtnyfqT4EtnlgjpZiT55kR3CfkQNVV/nnj7IIkXY5QF5wmJJiAKGfm7oeRnceGI4
	 oNicnc8Bskp7RXMyQHOsyNchu3TL1VDBkn53uqDA=
Date: Sun, 27 Sep 2026 18:41:25 +0200
From: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To: krishnanand G <krishnanandgeetheswaran@gmail.com>
Cc: andy@kernel.org, dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev
Subject: Re: [PATCH] staging: fbtft: fix spacing in macro calls
Message-ID: <2026092758-salary-wheat-735e@gregkh>
References: <CAG_41B+424_C5FA0PX9g1pDEPz2WX8JSeFhTWFpJ2TWgWLQjBw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG_41B+424_C5FA0PX9g1pDEPz2WX8JSeFhTWFpJ2TWgWLQjBw@mail.gmail.com>

On Sat, Sep 26, 2026 at 08:02:38PM +0530, krishnanand G wrote:
> The two calls to define_fbtft_write_reg() that use the default
> modifier have a space before the closing parenthesis. This triggers
> two checkpatch.pl errors.
> 
> Add an inline comment for the intentionally empty modifier argument.
> It satisfies the spacing check without changing the macro expansion.
> 
> Tests: scripts/checkpatch.pl --no-tree -f --terse --strict
>   drivers/staging/fbtft/fbtft-bus.c
> 
> A full kernel build was not run because the sparse checkout does not
> include the architecture makefiles.

Do not ever work with sparse checkouts,that's not how to do kernel
development.

> Signed-off-by: Krishnanand G <
> 118352827+Krishnanand-G@users.noreply.github.com>

There is no patch here :(
