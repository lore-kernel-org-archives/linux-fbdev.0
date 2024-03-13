Received: from mailrelay1-1.pub.mailoutpod3-cph3.one.com (mailrelay1-1.pub.mailoutpod3-cph3.one.com [46.30.211.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DEF76FE3A
	for <linux-fbdev@vger.kernel.org>; Wed, 13 Mar 2024 17:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.30.211.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710352487; cv=none; b=lPH9tS8UU32Zw92dtlWqE+zC7BKLYXtN/ywMuXiMYPJVS1Ewv8bdT6e8Atq/MdmnV2+8L6xgAPPgPBIP+EfaPM40/FIhvoXH500ywFJAmdd5oRgzQXxJjFJWPGKlt2ndf/4v2rKHF6I1o/iWE1LtBqt/c460VVNG44HSmsoRgkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710352487; c=relaxed/simple;
	bh=UUwKPoYxVZAxVfghjFtyV/bduPt/4WokWoj91qWs8ys=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jVtgsh/OmIOnSPp1kV+rM8URZ58ynw6NPfHxGP9ohM+cXF6K7TIs07Fr1Lk1wf2B5J4B1guOiK5gRI0FG+3Dl2JibSm6fCt1/TMyFaWpwY5YMbwwH3dheEubzrTw6FkCz+VFMpGVFs+GQqbS2zBGq6oUxkgwIPoJcfgmpvCV9ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ravnborg.org; spf=none smtp.mailfrom=ravnborg.org; dkim=pass (2048-bit key) header.d=ravnborg.org header.i=@ravnborg.org header.b=wJQ0A8Lb; dkim=permerror (0-bit key) header.d=ravnborg.org header.i=@ravnborg.org header.b=UqBQ9eLR; arc=none smtp.client-ip=46.30.211.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ravnborg.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ravnborg.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ravnborg.org header.i=@ravnborg.org header.b="wJQ0A8Lb";
	dkim=permerror (0-bit key) header.d=ravnborg.org header.i=@ravnborg.org header.b="UqBQ9eLR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=ravnborg.org; s=rsa2;
	h=in-reply-to:content-transfer-encoding:content-type:mime-version:references:
	 message-id:subject:cc:to:from:date:from;
	bh=772gv0JFjk24UCM4cXblvdaXj1GC71JgGxfdqwm4GgA=;
	b=wJQ0A8Lbb1Xga0BFZIWaKqg16NJx7gVz/Wsn0pF+4poPI04akZHGDpSFAL1/8bmZymQcpMtG8jPYH
	 lf00fW1KOruhECI8D7QRJnifmgiO6V7RoH4o3wDxKASON30Z1zsgXvhVfKblLJUeCag1BgsIDYhRuY
	 pEPLEOh8YGNeJNJWMvAH1J5vOfEVq000HckKdtbA2CHHCsmIiBoZBDo887af40vwGpvycWvMr2mwL5
	 2B4O393PIY4AQ0xVcFnvD8pqILa3nuVXhXpffS15JuGXTNs10EDWRc1pyQv+PwfNqG+mca0GdZkiB8
	 f2TdKKUMSKIbkytdvCERBl8Q9t/RSRQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
	d=ravnborg.org; s=ed2;
	h=in-reply-to:content-transfer-encoding:content-type:mime-version:references:
	 message-id:subject:cc:to:from:date:from;
	bh=772gv0JFjk24UCM4cXblvdaXj1GC71JgGxfdqwm4GgA=;
	b=UqBQ9eLRkbthSkCT9NUcgsB2UZ89uLjCiqtU80xsUK47Vb7s9qpcv98ZurrTTlHtOyJwZw131xfEI
	 C2Vh64HDw==
X-HalOne-ID: c011b02b-e162-11ee-b64b-1ff1563c5748
Received: from ravnborg.org (2-105-2-98-cable.dk.customer.tdc.net [2.105.2.98])
	by mailrelay1.pub.mailoutpod3-cph3.one.com (Halon) with ESMTPSA
	id c011b02b-e162-11ee-b64b-1ff1563c5748;
	Wed, 13 Mar 2024 17:54:36 +0000 (UTC)
Date: Wed, 13 Mar 2024 18:54:34 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Thomas Zimmermann <tzimmermann@suse.de>,
	Andy Shevchenko <andy@kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>, lee@kernel.org,
	daniel.thompson@linaro.org, jingoohan1@gmail.com, deller@gmx.de,
	dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	Robin van der Gracht <robin@protonic.nl>,
	Miguel Ojeda <ojeda@kernel.org>
Subject: Re: [PATCH 1/6] auxdisplay/ht16k33: Replace use of fb_blank with
 backlight helper
Message-ID: <20240313175434.GA96726@ravnborg.org>
References: <20240313154857.12949-1-tzimmermann@suse.de>
 <20240313154857.12949-2-tzimmermann@suse.de>
 <CANiq72=5V_XChzDhaaWNC+B4LP7gqivPZj5Y10qqS4SkQTGB_A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANiq72=5V_XChzDhaaWNC+B4LP7gqivPZj5Y10qqS4SkQTGB_A@mail.gmail.com>

Hi Miguel.

On Wed, Mar 13, 2024 at 05:08:08PM +0100, Miguel Ojeda wrote:
> Hi Thomas,
> 
> Thanks for this!
> 
> Cc'ing Andy and Geert -- the new maintainer and reviewer.
> 
> Also, a couple quick notes below since I am here...
> 
> On Wed, Mar 13, 2024 at 4:49 PM Thomas Zimmermann <tzimmermann@suse.de> wrote:
> >
> > Replace the use of struct backlight_properties.fb_blank with a
> > call to backlight_get_brightness(). The helper implement the same
> > logic as the driver's function.
> 
> It is not exactly the same logic since `backlight_is_blank` accounts
> for `BL_CORE_SUSPENDED`.

The driver does not set BL_CORE_SUSPENDRESUME so that part is a nop.

	Sam
