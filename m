Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794596773;
	b=L9cslxqOWrEk+Ae59G2niZ/Qyoc5PtZHpmXcHw5SWlz4mTS2NR8oSbc75NiqVCnXY75s
	 QVt56G0Fla5t9LBkEzWXAjnaoy12BfHGFjBSS1qvZcrntAsQ78GnJwcPnfwl4Jy0iNfkx
	 dFjM8RZa8GeuVl/Rjjzlz0oVIOY9skGNjbnHasBke36hBMMo5SN7/ZLqAnBLuzu0LhL5o
	 WS3hzNVzp1BvE3cQQnHu6W16Gz8EkOeHFlPtcYG8qVcaFwaSIaH0LfvBP3vGUFl//1uhW
	 RWjGfldVLUwL6ydBQQ9cAqzm2DcXQjClrx24S1KHl+v55ABCKf6+YbYb6SwNNljFZFg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794596773;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=cL8S/XqxcRvYdatGqNCRqCS1nB5EOhT90pF+3yj6n8I=;
	b=B1qTBtvW6NagWvvhqSrN+klhDa8QRDpSFCasnwFN3FYygpAekL7dS+eUK5yQ2RcAwDFf
	 22KMqaxuaRZMx11gPxVn2Lc2an0YgRLiLMw+IGnm1R+rdai9Z5kiDc0cXvWWOery5D3Z/
	 wM+OL/kzdLzfJ+s52UCmOSPTnoi2YW/Xc88bcI4wAcTT//++5RwlBZl/nJYj6atHhsP6m
	 Ol09v/vpRWSjJGgeop47gwrBGF35KvkNJIQUkKdKRQUWPtTPkfvYAbLO4tLMZW8LzVV9U
	 rknb4UoVpKzm4ZhNTqi5pKlP9mCE7FktbUCmWF2vAgJ2Iwn0OwHAKbf3HwBVK8FBfmg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jQ30UlO6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1A92606A327;
	Fri, 13 Nov 2026 19:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jQ30UlO6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C51F1F000C4;
	Fri, 13 Nov 2026 19:06:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794596773;
	bh=cL8S/XqxcRvYdatGqNCRqCS1nB5EOhT90pF+3yj6n8I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=jQ30UlO6deD0sM8Ipvji+bfs6IOnwdbfvWVbGqkrnOCID5EjlBCEHkCef2wm3rtiv
	 BORlIW690dLvWNYzzpaxS+tGFV/W+yGtfDZLYY8syXThsvlc62Ib+zP4rVWqKmSETl
	 F5ZQVPw+ImyJAZS3bD6wIDIj7Ell9Ry3G0WeGCIKwvyG58TWsgGVY4JvPnQdio5Crh
	 r/wxnGbIJyoHHtYN8rJcOnlgdLqtCn70OUalFXuvBjkE/aW1sbnq2tlqKj0oSv3ow/
	 3mL6T8XrcpSboGtxK8/UT3Oi8k7pgmtyb49sER4xOee+XZeiVLTABHkwHQQoQfkzMh
	 A//XszwPrFLdw==
Date: Fri, 13 Nov 2026 19:06:08 +0000
From: Lee Jones <lee@kernel.org>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Pavel Machek <pavel@kernel.org>,
	Griffin Kroah-Hartman <griffin@kroah.com>,
	Daniel Thompson <danielt@kernel.org>,
	Jingoo Han <jingoohan1@gmail.com>, Helge Deller <deller@gmx.de>,
	linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Subject: Re: [PATCH v1] video: leds: backlight: lm3533: Support getting LED
 sources from DT
Message-ID: <20261113190608.GK6323@joneslee-macbookpro.roam.internal>
References: <20261101142435.130520-1-clamor95@gmail.com>
 <179370032880.793788.4424159880220279586@kernel.org>
 <CAPVz0n1E2bLOzKEC6_2iiPM5ZZ6-NOXuOkwx+jQYn8BRvPXwSw@mail.gmail.com>
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Post: <mailto:linux-fbdev@vger.kernel.org>
List-Help: <mailto:linux-fbdev+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fbdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPVz0n1E2bLOzKEC6_2iiPM5ZZ6-NOXuOkwx+jQYn8BRvPXwSw@mail.gmail.com>

On Fri, 13 Nov 2026, Svyatoslav Ryhel wrote:

> пт, 13 лист. 2026 р. о 16:53 Lee Jones <lee@kernel.org> пише:
> >
> > Drop the 'video: ' part of the subject line.
> >
> > Please review, explain or fix the Sashiko review(s).
> >
> > > Add Control Bank to HVLED/LVLED muxing support based on the led-sources
> > > defined in the device tree.
> > >
> > > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > > Reviewed-by: Daniel Thompson (RISCstar) <danielt@kernel.org>
> > > ---
> > > This was part of the original LM3533 controller DT/OF conversion patchset,
> > > but it appears to have been accidentally separated during the final iteration.
> > > Therefore, I am sending it as a follow-up.
> > > ---
> > >  drivers/leds/leds-lm3533.c          | 60 +++++++++++++++++++++++++++++
> > >  drivers/video/backlight/lm3533_bl.c | 45 ++++++++++++++++++++++

[...]

> > > +     if (bl->num_leds) {
> > > +             for (int i = 0; i < bl->num_leds; i++) {
> > > +                     if (bl->led_strings[i] >= LM3533_HVCTRLBANK_COUNT)
> > > +                             continue;
> > > +
> > > +                     output_cfg_val |= ctrlbank << bl->led_strings[i];
> > > +                     output_cfg_mask |= BIT(bl->led_strings[i]);
> > > +             }
> >
> > This for loop doesn't need to be in the if statement.
> >
> 
> It is in if statement because if node has no "led-sources"
> LM3533_REG_OUTPUT_CONF1 should not be touched and must be left in its
> default state.

But it won't iterate if (!bl->num_leds), so it's being indented for no
reason.

-- 
Lee Jones
