Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4828A23D7DE
	for <linux-fbdev@vger.kernel.org>; Sat, 24 Jan 2026 16:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769273609; cv=none; b=kpnlMZhQlsBkrryQ/tOXTGdbn7uZZ8Unt3NyDY89S+F92v/UOK0pP22OXnXEj6JLoHc17acmOnGQ1DR4fwv1a06Oh2UACs1QeAmynhMg6sJ3QCehtwi63p53lQLGmUur+g3skZo3HXSTyNFZ2ECZifZFcJM2AvPTBVzrgvhdMlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769273609; c=relaxed/simple;
	bh=3R9lMRHWCtCxO4kGA5oFqpdk6KhCLGV5V5f7/hjyrWU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JMVXO6+jH66kV4IxgiliOfskXzHWqd6vXQHqsofjC5PPGFJjrAdYNam0dU2XOYvhBKA4g3Wk1iAzHUR+Zl/7czlDbM8AieYyIOc04O1ujgRNC2Pzj9wrS2rniSxvNVo36/ZK1axi9yQ/wYIIbmxYlSg/7yeTyt7dhRxbfz2Nt5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RAq0EVEH; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RAq0EVEH"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-47eddddcdcfso19162505e9.1
        for <linux-fbdev@vger.kernel.org>; Sat, 24 Jan 2026 08:53:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769273607; x=1769878407; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+BQn+P/UOseTbGGqnJNsSGMZHqICVJmpni1h8D5Uppc=;
        b=RAq0EVEHwUw5lfo2u/uUicn6Pbvqq+mdQ8ypgOW2IIxlAkdeIq6CCwtNJJ7uig0JiD
         8tBK8DWTtuFkLxqa0mt0ksXiufKsjfBjJEJ+1N/rjFkAMDWHjrT2PqJCiygJieIhgpj/
         5yuNk419Shmz+VOmUwILX6gxhjH4K3dGCB4sThAzNdcf4rquIpETjtapBsBQk/xfEaRq
         fcb+og2x5aZIZzFrMEgQwpFF1Bkixj7wjXWAPFekygEzJgqIaN3oiePkT9ldVVtQLRVE
         +wRI/sgJaZjM5HWyfrP59WWasaGGxHc1ucwF7IxtsIcmeGoOM8bcqH52+NnZLRXHFOKn
         ClQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769273607; x=1769878407;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+BQn+P/UOseTbGGqnJNsSGMZHqICVJmpni1h8D5Uppc=;
        b=vH5PGssqM1xTJ30RVRRb8gQGkwNpra0v/41A7NbTiEcPQtq7436e0uynSRNnAWcxci
         WypXMrV7gFefO7MgYf6wJAEqsgy+ia6Zk8sQ8C321beYoxooPuVDKwyGwTBoTvfXim7M
         0nMTzV73yvfhK9ws4L7FiZrLNhgWQzWgLyDGjzyBr/f2Mdgop4Yox0kL899kzew3BKCw
         C+9Vamyy5fDqwTq09n87EabXHzjIfSgeVhzsuDRUkiWEZa38JsPSmDbEx5Uk6LrLKZ8B
         ggDHGua2djxsHMQsykNsl0j7FseHlBeMzu8W9CAA9qkam7vbXh/SvsR1wCAGBhmNWE2V
         U9Nw==
X-Forwarded-Encrypted: i=1; AJvYcCU6zOBMhT37ZXJMZndAAtRo1JGR3RIWZtbywJ9dUZzXoREwjK/TUpHr5f/LyYY2YzTvljWStBdU3f0WMA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyhKPxvyinep/sly4Z/p8PuOZjlgctw/sHOl82iS0DhJqrsVgRP
	iUzCj8IHOQRw6zbyKo+VhkOwtdf+BQfKR3jzWuG2fEvnQfoaH55n2IsX
X-Gm-Gg: AZuq6aI4WdZ1rxf6gHC0mY4YW3Wpes5ScbS/i2v9k6rFetN8HlExfCS/XoICorLzaGX
	V6D9W5/YAT0ZKtr42OVeFS1AZaPCwZ8sP8+Hb+DWfNBTwT7L01/Geg8i2/4wy0VtlYzNfZMcgVs
	BT6SC5Wl/hnGLGQJnOGnHAiKqiqqimTOc7xYynY1evWF/JGff0bb9H4xEJsw2WluypDniUXFmfU
	ZKijseL3mrbBQy75xi6LVXQ7TbKrILucT+edTdS7WfPnobgNZ+5B/DZgtFfRxsfsgK8v+LWagPG
	AS8W+RevoKvGal0DFF9H4opQo6VIOAXpTgtZbf9f6oD6xqf4q9gjVUpkRlenTmGx5WMaBDNnLfg
	dTqn7Wx6VUbkyl6TJwlReUUbhYkxF7OnZMvu3c4u7cp1P3oOW7/utgTqA3mQ6F8LB+3ZynUpWtg
	dwNFhwdDt6xt8Kj1Qt0LS8yP/9gBdps2ZWc6K/mYSOU1k=
X-Received: by 2002:a05:600c:4fd6:b0:480:1d16:2538 with SMTP id 5b1f17b1804b1-4804c9b21b0mr112717765e9.23.1769273606608;
        Sat, 24 Jan 2026 08:53:26 -0800 (PST)
Received: from osama ([156.223.77.192])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4804d85d146sm148011875e9.8.2026.01.24.08.53.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Jan 2026 08:53:26 -0800 (PST)
Date: Sat, 24 Jan 2026 17:53:23 +0100
From: Osama Abdelkader <osama.abdelkader@gmail.com>
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Zsolt Kajtar <soci@c64.rulez.org>, Simona Vetter <simona@ffwll.ch>,
	Helge Deller <deller@gmx.de>, linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	syzbot+7a63ce155648954e749b@syzkaller.appspotmail.com
Subject: Re: [PATCH] fbdev: sys_fillrect: Add bounds checking to prevent
 vmalloc-out-of-bounds
Message-ID: <aXT5A6vBSNIry3os@osama>
References: <20260118001852.70173-1-osama.abdelkader@gmail.com>
 <5bc62c51-308c-483f-a92d-29354f2deeac@suse.de>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5bc62c51-308c-483f-a92d-29354f2deeac@suse.de>

On Mon, Jan 19, 2026 at 08:38:31AM +0100, Thomas Zimmermann wrote:
> Hi,
> 
> thanks for the patch.
> 
> Am 18.01.26 um 01:18 schrieb Osama Abdelkader:
> > The sys_fillrect function was missing bounds validation, which could lead
> > to vmalloc-out-of-bounds writes when the rectangle coordinates extend
> > beyond the framebuffer's virtual resolution. This was detected by KASAN
> > and reported by syzkaller.
> > 
> > Add validation to:
> > 1. Check that width and height are non-zero
> > 2. Verify that dx and dy are within virtual resolution bounds
> > 3. Clip the rectangle dimensions to fit within virtual resolution if needed
> 
> This is rather a problem with the caller of the fillrect helper and affects
> all drivers and all implementations of fb_fillrect. Clipping should happen
> in the fbcon functions before invoking ->fb_con.
> 
> Best regards
> Thomas
> 
> > 
> > This follows the same pattern used in other framebuffer drivers like
> > pm2fb_fillrect.
> > 
> > Reported-by: syzbot+7a63ce155648954e749b@syzkaller.appspotmail.com
> > Closes: https://syzkaller.appspot.com/bug?extid=7a63ce155648954e749b
> > Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>
> > ---
> >   drivers/video/fbdev/core/sysfillrect.c | 21 ++++++++++++++++++++-
> >   1 file changed, 20 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/video/fbdev/core/sysfillrect.c b/drivers/video/fbdev/core/sysfillrect.c
> > index 12eea3e424bb..73fc322ff8fd 100644
> > --- a/drivers/video/fbdev/core/sysfillrect.c
> > +++ b/drivers/video/fbdev/core/sysfillrect.c
> > @@ -7,6 +7,7 @@
> >   #include <linux/module.h>
> >   #include <linux/fb.h>
> >   #include <linux/bitrev.h>
> > +#include <linux/string.h>
> >   #include <asm/types.h>
> >   #ifdef CONFIG_FB_SYS_REV_PIXELS_IN_BYTE
> > @@ -18,10 +19,28 @@
> >   void sys_fillrect(struct fb_info *p, const struct fb_fillrect *rect)
> >   {
> > +	struct fb_fillrect modded;
> > +	int vxres, vyres;
> > +
> >   	if (!(p->flags & FBINFO_VIRTFB))
> >   		fb_warn_once(p, "%s: framebuffer is not in virtual address space.\n", __func__);
> > -	fb_fillrect(p, rect);
> > +	vxres = p->var.xres_virtual;
> > +	vyres = p->var.yres_virtual;
> > +
> > +	/* Validate and clip rectangle to virtual resolution */
> > +	if (!rect->width || !rect->height ||
> > +	    rect->dx >= vxres || rect->dy >= vyres)
> > +		return;
> > +
> > +	memcpy(&modded, rect, sizeof(struct fb_fillrect));
> > +
> > +	if (modded.dx + modded.width > vxres)
> > +		modded.width = vxres - modded.dx;
> > +	if (modded.dy + modded.height > vyres)
> > +		modded.height = vyres - modded.dy;
> > +
> > +	fb_fillrect(p, &modded);
> >   }
> >   EXPORT_SYMBOL(sys_fillrect);
> 
> -- 
> --
> Thomas Zimmermann
> Graphics Driver Developer
> SUSE Software Solutions Germany GmbH
> Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
> GF: Jochen Jaser, Andrew McDonald, Werner Knoblich, (HRB 36809, AG Nürnberg)
> 
> 

Thanks for the info.

Best regards,
Osama

