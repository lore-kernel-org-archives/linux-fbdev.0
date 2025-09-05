Received: from mailrelay-egress4.pub.mailoutpod2-cph3.one.com (mailrelay-egress4.pub.mailoutpod2-cph3.one.com [46.30.211.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50C3D279780
	for <linux-fbdev@vger.kernel.org>; Fri,  5 Sep 2025 18:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.30.211.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757098444; cv=none; b=TdVLsFSLcJIJTzLGfvKgRwfeQAOeWLFZc/LabctsKI6EqE2sGfQeurpc9DRmfiSIHU7W6nZok7JJ+THI7/9VlA7x+vCbKIeRluA1RIMLAjjAbsZ/jlv7mPEFZqkX8ALegZIdfpSyePZgQicVZmMwuKMCv9wGzbcugyNhirBKWTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757098444; c=relaxed/simple;
	bh=ZvuXIb5M91fgkkHiJ7YVxRV9Ppa07NebU+vIPN6dQ0E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dQ4v9ZaP3kYw+ly+MGjjNh83LcrTG1kmt8jnNzrYS1k5MsdNtmOl8CBnoYq6J3/vdPJEPfi7yiaPVkpkbwoMF09e8idy5O43HWtIWVapKfXxyqNyj4m7C8wc+nAZ9y9hpNAQPjIOK1ANnSMt1IXH43ce25U62d2qBWO5RmNAqNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ravnborg.org; spf=none smtp.mailfrom=ravnborg.org; dkim=pass (2048-bit key) header.d=ravnborg.org header.i=@ravnborg.org header.b=AeEd6qCU; dkim=permerror (0-bit key) header.d=ravnborg.org header.i=@ravnborg.org header.b=FY2u5rVd; arc=none smtp.client-ip=46.30.211.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ravnborg.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ravnborg.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ravnborg.org header.i=@ravnborg.org header.b="AeEd6qCU";
	dkim=permerror (0-bit key) header.d=ravnborg.org header.i=@ravnborg.org header.b="FY2u5rVd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1757098439; x=1757703239;
	d=ravnborg.org; s=rsa1;
	h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
	 from:date:from;
	bh=Rp8QvMDkqRWorfuh6XNKbpaQu3Sv/rPZIcu6CVHbFO4=;
	b=AeEd6qCUcN2/whahq4sGxJKJv7S1+QvKhPYb6F5TniwiLP6GLOPiy9xIJk+KZyArO3utSXXJrCrCn
	 xnli0OmIygOeSLYYAIKCH3tfy48n5FdiP5BG6UOT+yVsHZI0BPpv4JBWJWiS9zMMoMTzlZYXl09kE+
	 r4++Wj1mkr+rW8bXSIxUhAZVtGIhwBTajPTVWrQwY56P3bYxlnH9LpwNEanb3GoNkx7l9MjzMUW9FB
	 dG5ZJAe+mBMSMBhyorNh9pYNUhVYoF9hRWX57Qi32BJHgA92UjKvL/OWN1vU/7qzVns20gXx+m2wz1
	 Uy8JAtnm/OyiAGjoH5QDUJoRCpr2I1A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1757098439; x=1757703239;
	d=ravnborg.org; s=ed1;
	h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
	 from:date:from;
	bh=Rp8QvMDkqRWorfuh6XNKbpaQu3Sv/rPZIcu6CVHbFO4=;
	b=FY2u5rVdT37ucKn4KYuYewbTUpwcg3M/MiBZr2aeIWoFIE2k7w6NRDUwSMpWSe0xksW6UNgo2yjFg
	 7cqrqHkCQ==
X-HalOne-ID: addad8e8-8a89-11f0-87ea-632fe8569f3f
Received: from ravnborg.org (2-105-16-150-cable.dk.customer.tdc.net [2.105.16.150])
	by mailrelay2.pub.mailoutpod3-cph3.one.com (Halon) with ESMTPSA
	id addad8e8-8a89-11f0-87ea-632fe8569f3f;
	Fri, 05 Sep 2025 18:53:59 +0000 (UTC)
Date: Fri, 5 Sep 2025 20:53:58 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: simona@ffwll.ch, deller@gmx.de, linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/6] fbcon: Move fbcon callbacks into struct fbcon_bitops
Message-ID: <20250905185358.GA361827@ravnborg.org>
References: <20250818104655.235001-1-tzimmermann@suse.de>
 <20250818104655.235001-5-tzimmermann@suse.de>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250818104655.235001-5-tzimmermann@suse.de>

Hi Thomas.

On Mon, Aug 18, 2025 at 12:36:39PM +0200, Thomas Zimmermann wrote:
> Depending on rotation settings, fbcon sets different callback
> functions in struct fbcon from within fbcon_set_bitops(). Declare
> the callback functions in the new type struct fbcon_bitops. Then
> only replace the single bitops pointer in struct fbcon.
> 
> Keeping callbacks in constant instances of struct fbcon_bitops
> makes it harder to exploit the callbacks. Also makes the code slightly
> easier to maintain.
> 
> For tile-based consoles, there's a separate instance of the bitops
> structure.
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---
>  drivers/video/fbdev/core/bitblit.c   | 17 ++++---
>  drivers/video/fbdev/core/fbcon.c     | 67 +++++++++++++++-------------
>  drivers/video/fbdev/core/fbcon.h     |  7 ++-
>  drivers/video/fbdev/core/fbcon_ccw.c | 18 +++++---
>  drivers/video/fbdev/core/fbcon_cw.c  | 18 +++++---
>  drivers/video/fbdev/core/fbcon_ud.c  | 18 +++++---
>  drivers/video/fbdev/core/tileblit.c  | 16 ++++---
>  7 files changed, 94 insertions(+), 67 deletions(-)
> 
> diff --git a/drivers/video/fbdev/core/bitblit.c b/drivers/video/fbdev/core/bitblit.c
> index a2202cae0691..267bd1635a41 100644
> --- a/drivers/video/fbdev/core/bitblit.c
> +++ b/drivers/video/fbdev/core/bitblit.c
> @@ -384,15 +384,18 @@ static int bit_update_start(struct fb_info *info)
>  	return err;
>  }
>  
> +static const struct fbcon_bitops bit_fbcon_bitops = {
> +	.bmove = bit_bmove,
> +	.clear = bit_clear,
> +	.putcs = bit_putcs,
> +	.clear_margins = bit_clear_margins,
> +	.cursor = bit_cursor,
> +	.update_start = bit_update_start,
> +};
> +
>  void fbcon_set_bitops(struct fbcon *confb)
>  {
> -	confb->bmove = bit_bmove;
> -	confb->clear = bit_clear;
> -	confb->putcs = bit_putcs;
> -	confb->clear_margins = bit_clear_margins;
> -	confb->cursor = bit_cursor;
> -	confb->update_start = bit_update_start;
> -	confb->rotate_font = NULL;
> +	confb->bitops = &bit_fbcon_bitops;
>  
>  	if (confb->rotate)
>  		fbcon_set_rotate(confb);

fbcon_set_rotate() is only used to set the correct bitops.

It would be simpler to just do

	if (confb->rotate)
		confb->bitops = fbcon_rotate_get_ops();

And rename fbcon_set_rotate() to fbcon_rotate_get_ops() and return the
pointer to the struct.

The no need to pass the struct, and it is obvious that the bitops are
overwritten.

	Sam

