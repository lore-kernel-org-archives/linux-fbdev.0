Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07767633E9;
	Fri, 23 Feb 2024 10:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708685819; cv=none; b=BPbDjzdxvmMXa0M0LACr2Au8VZgiKqw6nIH01hn2gk7cUnRX+PVq9uOWq7r8vM5sGYNhw+w74zzxTU0QMIgRnT3GKVtpI2CBBY608q0pDirxG8h1Uk85uPcz2xD7ht5J6nH0tjy7vc3BzkrSNUMkwmkSrJe0sEw1HLKQS2l3xwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708685819; c=relaxed/simple;
	bh=wpuR+EilBGzruVMBpMve5kxH6P2DEnFv9bDGobFvHBo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UrlWnbkZprWJdRDrL6qyzc/QQ2PwcNBEu5a1IXM6DSMyGBT2S6Gia/tEqdcN690J/kwzJ6fPaJmB5UCuKMp3/ljVfTcLRnn4gAz9PkI/6tX1YcaxuisP3tWc1OkKekxBm9efgM5W6tom2wzEJiKU3Gpdbwf4voWO7o/53ML8CO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=phxydC6i; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="phxydC6i"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E60FC433F1;
	Fri, 23 Feb 2024 10:56:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708685818;
	bh=wpuR+EilBGzruVMBpMve5kxH6P2DEnFv9bDGobFvHBo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=phxydC6iNaesOvsAy4b3GQ9bBiLI0UKgfGTzH5GBzMYCXrYN1Hmlvc6u5VjuZxP/t
	 JQNDJOKk80ofPt4yKF0qKrQmAzOzK7p1OLYazAvmAYwTR2yneN00C60K/Mw5L/I2jM
	 Ih5JiaSo1GBcuSjELOod0ZUqVjdb8mWkXts1qLUirg5gczIdlxe+YOr0pIziRDR46f
	 Gev1EsdXG/PTfJQb0DV9DwW7oH3fYn9mbsHAnnyQL5fO2j3htBvpSbjrSo5Y5a6XQV
	 OeEVg5geBlspbPGxiaUbpTtrsHEnIQ3nnXB5vWGBuLDwJANGfqk+RT3QkFyFJIhJem
	 D5z5Sn8wpU1Ow==
Date: Fri, 23 Feb 2024 10:56:52 +0000
From: Lee Jones <lee@kernel.org>
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: deller@gmx.de, kherbst@redhat.com, lyude@redhat.com, dakr@redhat.com,
	jani.nikula@linux.intel.com, daniel@ffwll.ch, airlied@gmail.com,
	gregkh@linuxfoundation.org,
	Daniel Thompson <daniel.thompson@linaro.org>,
	Jingoo Han <jingoohan1@gmail.com>, linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
	linux-staging@lists.linux.dev
Subject: Re: [PATCH v3 1/9] backlight/corgi-lcd: Include <linux/backlight.h>
Message-ID: <20240223105652.GT10170@google.com>
References: <20240219093941.3684-1-tzimmermann@suse.de>
 <20240219093941.3684-2-tzimmermann@suse.de>
 <1e577f18-c6f7-44e7-b50f-720915f257eb@suse.de>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1e577f18-c6f7-44e7-b50f-720915f257eb@suse.de>

On Wed, 21 Feb 2024, Thomas Zimmermann wrote:

> cc'ing backlight maintainers

I cannot review/accept patches like this.

Please submit a [RESEND].

> Am 19.02.24 um 10:37 schrieb Thomas Zimmermann:
> > Resolves the proxy include via <linux/fb.h>, which does not require the
> > backlight header.
> > 
> > Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> > ---
> >   drivers/video/backlight/corgi_lcd.c | 1 +
> >   1 file changed, 1 insertion(+)
> > 
> > diff --git a/drivers/video/backlight/corgi_lcd.c b/drivers/video/backlight/corgi_lcd.c
> > index 0a57033ae31d1..dd765098ad989 100644
> > --- a/drivers/video/backlight/corgi_lcd.c
> > +++ b/drivers/video/backlight/corgi_lcd.c
> > @@ -11,6 +11,7 @@
> >    *	by Eric Miao <eric.miao@marvell.com>
> >    */
> > +#include <linux/backlight.h>
> >   #include <linux/module.h>
> >   #include <linux/kernel.h>
> >   #include <linux/init.h>
> 
> -- 
> --
> Thomas Zimmermann
> Graphics Driver Developer
> SUSE Software Solutions Germany GmbH
> Frankenstrasse 146, 90461 Nuernberg, Germany
> GF: Ivo Totev, Andrew Myers, Andrew McDonald, Boudien Moerman
> HRB 36809 (AG Nuernberg)
> 

-- 
Lee Jones [李琼斯]
