Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4C15332621;
	Sun, 27 Sep 2026 16:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790527209; cv=none; b=httEJBY3C4w27U7BhfiI38/tUv4J4fXEIt0Fe3X2xht/tHHHBIjs8geoLecrOmb2Yg1l7tf7Q0LiXnagchnvgxe0dMHTMgKPGy+dN51jF/ZH7TUcNnOkA0ejTtqk3zJDPCZqPWZ6zHK/Oih40O4aU+ABGVdY9yz/qu+NNORH6GY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790527209; c=relaxed/simple;
	bh=XBofaJSwVq+dKoD/BnWEUCa2r8DAc4GFKsFJNI7wzJc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NMdMCVxaCgPWqbYkJV54Ou46hRjAzE5asnF70+WL7UqD+wQ5wwMThgJkTE9zWpeh9uGWW2P1VtNMgOZ9yDrPKN+S5cGW0mlLU2Ga/wcHbZe50FZRld/QnqfBV/eeDlUQu7Ui8dqzBWuKbuVnjPCYijiFn0wxpHSoFm9MO2gARmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ObR+bLCN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ObR+bLCN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DFC71F000FF;
	Sun, 27 Sep 2026 16:40:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1790527208;
	bh=QVOQ34sr18ixV7r32sVe/ehF+3x2MfGvdAz1mNuDkgo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ObR+bLCNpIwVDuYFB6Yp+nLHdXusXw8YzDu0btdpUPKvtS4eYAOhuvBG8vTUxArTP
	 1UDYUqqk3imKBQn9dnOpOD7rGnFZxB8VbTKluAMq+/WYkkMJqfri4qbxVFohqrGu/F
	 zsladJGT0KjzkPcYhcotTsuZmWf4O1Crmgm7GBVA=
Date: Sun, 27 Sep 2026 18:40:04 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: krishnanand G <krishnanandgeetheswaran@gmail.com>
Cc: andy@kernel.org, dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev
Subject: Re: [PATCH] staging: fbtft: fix spacing in macro calls
Message-ID: <2026092736-problem-crayon-031b@gregkh>
References: <CAG_41BL-nu7tDFjGgehz9Bf+KKPty8kR6A0RUUUfpepJu4doHQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG_41BL-nu7tDFjGgehz9Bf+KKPty8kR6A0RUUUfpepJu4doHQ@mail.gmail.com>

On Sun, Sep 27, 2026 at 02:48:40AM -0700, krishnanand G wrote:
> >From 5473fd52eeda7ab1f608c414e386dad0ea40bef4 Mon Sep 17 00:00:00 2001
> From: Krishnanand G <118352827+Krishnanand-G@users.noreply.github.com>
> Date: Sat, 26 Sep 2026 19:41:06 +0530
> Subject: [PATCH] staging: fbtft: fix spacing in macro calls
> 
> The two calls to define_fbtft_write_reg() that use the default
> modifier have a space before the closing parenthesis. This triggers
> two checkpatch.pl errors.
> 
> Add an inline comment for the intentionally empty modifier argument.
> It satisfies the spacing check without changing the macro expansion.
> 
> Tests: scripts/checkpatch.pl --no-tree -f --terse --strict
>   drivers/staging/fbtft/fbtft-bus.c
> Signed-off-by: Krishnanand G <118352827+Krishnanand-G@users.noreply.github.com>
> Assisted-by: LLM

Please read the email archives for why both this will not work, AND why
you can not use LLMs on this part of the kernel.

Also, your email address isn't valid :(
