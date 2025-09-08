Received: from mailrelay-egress4.pub.mailoutpod2-cph3.one.com (mailrelay-egress4.pub.mailoutpod2-cph3.one.com [46.30.211.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F064031D757
	for <linux-fbdev@vger.kernel.org>; Mon,  8 Sep 2025 18:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.30.211.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757357485; cv=none; b=m7df6kxKCusWkV+lIzi6skr6SsH+pIDdWQSZQDqfH842ET/q1Y/88ya0WcunNKpSDyEITfPzmZIG4QBUs3ufyh3u9qKT2JajERgRjAOk55YLIYaFUhMD6heUMKVF4QekA9FJ3CzQp8JnikBimAyY5cUtGje6v1N6o8U+3Gt4SJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757357485; c=relaxed/simple;
	bh=c+tXIw22H7GmL5X/H+OdpBd4RRRzRwrd6dquWXNLbEE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JiAuXAEawyHdzMv+LyEaxPA8Eqeu11fy/zL5f/mcB+rY9x8S+A3XAR5l+YSoqDH6Bgr9lQJFP1qOw7JgFXLwDtDqclFd1TyAFrWyxAMkLXpQcC1WTAyKuwoTiMbzg6bxkmM+Z/9wAyEEtX1j1jGPofIkKJJaDG9jtyUNLy/rCDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ravnborg.org; spf=none smtp.mailfrom=ravnborg.org; dkim=pass (2048-bit key) header.d=ravnborg.org header.i=@ravnborg.org header.b=Y6/o9/tB; dkim=permerror (0-bit key) header.d=ravnborg.org header.i=@ravnborg.org header.b=NfvqCtXf; arc=none smtp.client-ip=46.30.211.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ravnborg.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ravnborg.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ravnborg.org header.i=@ravnborg.org header.b="Y6/o9/tB";
	dkim=permerror (0-bit key) header.d=ravnborg.org header.i=@ravnborg.org header.b="NfvqCtXf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1757357470; x=1757962270;
	d=ravnborg.org; s=rsa1;
	h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
	 from:date:from;
	bh=b0OrA6ztwdprbIrsGVPpqZHoL8FCk7RDtGNiYi1AB8A=;
	b=Y6/o9/tBKmtzr/qxtociDT2bSMVYXoJelswDHk9m2iR4vQdq35lnruQ2xglgwYKhni2ZAwIxnwlqP
	 VD5k0FtAnnsceOOutHj58w8inTRoqhI08hzL1HF2gf1qe8PZStFEoKk8lUX0jzPmYewJS6VhB716vf
	 0yXcKczAaQguQdZetbLYRXxAkl9CxYQaGHQqBmdRbrv6JPlK8qv617DhGZ8eGS62HdqrhV7MRCgYVH
	 nfKAhVS0YcZqTt5RakpksQbs35GWQRMGcBelJJ216+nP29iUNruohIgsEhYpdXkwGb1GoRxv0FTuEY
	 OBoHm+sNa7bcKWkVuHNpwDUuMj2E1hw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1757357470; x=1757962270;
	d=ravnborg.org; s=ed1;
	h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
	 from:date:from;
	bh=b0OrA6ztwdprbIrsGVPpqZHoL8FCk7RDtGNiYi1AB8A=;
	b=NfvqCtXf73TsWDArjFg7yJk5dZykcxaHg4dbLfDJiNGSRV6blOrNGpFrbeiFjML83ZdBkxLFb6igR
	 uUjLHMzDw==
X-HalOne-ID: c85cbffc-8ce4-11f0-9fa4-d510462faafc
Received: from ravnborg.org (2-105-16-150-cable.dk.customer.tdc.net [2.105.16.150])
	by mailrelay4.pub.mailoutpod3-cph3.one.com (Halon) with ESMTPSA
	id c85cbffc-8ce4-11f0-9fa4-d510462faafc;
	Mon, 08 Sep 2025 18:51:10 +0000 (UTC)
Date: Mon, 8 Sep 2025 20:51:09 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: simona@ffwll.ch, deller@gmx.de, linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/6] fbcon: Move fbcon callbacks into struct fbcon_bitops
Message-ID: <20250908185109.GA643261@ravnborg.org>
References: <20250818104655.235001-1-tzimmermann@suse.de>
 <20250818104655.235001-5-tzimmermann@suse.de>
 <20250905185358.GA361827@ravnborg.org>
 <c1674a81-3435-445c-b359-e2b094b7f8a5@suse.de>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c1674a81-3435-445c-b359-e2b094b7f8a5@suse.de>

Hi Thomas.

On Mon, Sep 08, 2025 at 03:06:46PM +0200, Thomas Zimmermann wrote:
> Hi Sam,
> 
> thanks for doing the review.
> 
> Am 05.09.25 um 20:53 schrieb Sam Ravnborg:
> > Hi Thomas.
> > 
> > On Mon, Aug 18, 2025 at 12:36:39PM +0200, Thomas Zimmermann wrote:
> > > Depending on rotation settings, fbcon sets different callback
> > > functions in struct fbcon from within fbcon_set_bitops(). Declare
> > > the callback functions in the new type struct fbcon_bitops. Then
> > > only replace the single bitops pointer in struct fbcon.
> > > 
> > > Keeping callbacks in constant instances of struct fbcon_bitops
> > > makes it harder to exploit the callbacks. Also makes the code slightly
> > > easier to maintain.
> > > 
> > > For tile-based consoles, there's a separate instance of the bitops
> > > structure.
> > > 
> > > Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> > > ---
> > >   drivers/video/fbdev/core/bitblit.c   | 17 ++++---
> > >   drivers/video/fbdev/core/fbcon.c     | 67 +++++++++++++++-------------
> > >   drivers/video/fbdev/core/fbcon.h     |  7 ++-
> > >   drivers/video/fbdev/core/fbcon_ccw.c | 18 +++++---
> > >   drivers/video/fbdev/core/fbcon_cw.c  | 18 +++++---
> > >   drivers/video/fbdev/core/fbcon_ud.c  | 18 +++++---
> > >   drivers/video/fbdev/core/tileblit.c  | 16 ++++---
> > >   7 files changed, 94 insertions(+), 67 deletions(-)
> > > 
> > > diff --git a/drivers/video/fbdev/core/bitblit.c b/drivers/video/fbdev/core/bitblit.c
> > > index a2202cae0691..267bd1635a41 100644
> > > --- a/drivers/video/fbdev/core/bitblit.c
> > > +++ b/drivers/video/fbdev/core/bitblit.c
> > > @@ -384,15 +384,18 @@ static int bit_update_start(struct fb_info *info)
> > >   	return err;
> > >   }
> > > +static const struct fbcon_bitops bit_fbcon_bitops = {
> > > +	.bmove = bit_bmove,
> > > +	.clear = bit_clear,
> > > +	.putcs = bit_putcs,
> > > +	.clear_margins = bit_clear_margins,
> > > +	.cursor = bit_cursor,
> > > +	.update_start = bit_update_start,
> > > +};
> > > +
> > >   void fbcon_set_bitops(struct fbcon *confb)
> > >   {
> > > -	confb->bmove = bit_bmove;
> > > -	confb->clear = bit_clear;
> > > -	confb->putcs = bit_putcs;
> > > -	confb->clear_margins = bit_clear_margins;
> > > -	confb->cursor = bit_cursor;
> > > -	confb->update_start = bit_update_start;
> > > -	confb->rotate_font = NULL;
> > > +	confb->bitops = &bit_fbcon_bitops;
> > >   	if (confb->rotate)
> > >   		fbcon_set_rotate(confb);
> > fbcon_set_rotate() is only used to set the correct bitops.
> > 
> > It would be simpler to just do
> > 
> > 	if (confb->rotate)
> > 		confb->bitops = fbcon_rotate_get_ops();
> > 
> > And rename fbcon_set_rotate() to fbcon_rotate_get_ops() and return the
> > pointer to the struct.
> > 
> > The no need to pass the struct, and it is obvious that the bitops are
> > overwritten.
> 
> I tried to keep the changes here to a minimum and avoided changing the
> function interfaces too much.
> 
> But did you read patch 5 already? I think the cleanup you're looking for is
> there. fbcon_set_rotate() will be gone. And the update bit-op selection is
> contained in fbcon_set_bitops(). I guess this could be renamed to
> fbcon_update_bitops() to make it clear that it updates from internal state.

Patch 5 looks good, and is again a nice cleanup.
I like that the code is now more explicit in what it does and do not
do overwrites.

Returning a pointer or adding the assignment in a helper is not a big
deal.

With or without the suggested renaming both patch 4 + 5 are r-b.

That said, I am not expert in this field, but at least you had another
pair of eyes on the changes.
I look forward to see the next batches of refactoring you have planned.

	Sam
