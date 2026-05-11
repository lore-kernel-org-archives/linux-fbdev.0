Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BABC441037
	for <linux-fbdev@vger.kernel.org>; Mon, 11 May 2026 17:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778520753; cv=none; b=skjZmbbW3f/jM+xhx1pNNChqsLjqlze7MeGwSMTeGvh5pQHd63yJ88kLPJPKz4qA6rBi4RYFcswZ1jX2mB85xQkHW7rwucOiCgyb9VhUwTrSGNIB1VwnWtzM78MNmZd7Py5G8aqM5uDYt6+jndTooyDqvLm3ZVwkpzclpq1FFI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778520753; c=relaxed/simple;
	bh=0tsonGuLAjOOBfecwNU/uqibLvBA9f7HI1hftO49/Qg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AEcycIyo88cg7yPu+WN1ff06tlzE0xo12lc45trw2mkPf0OP9PPt73eCZXGEvBlgQlwL3nvnsnrI0HxHMXIBqtmKBpIn/20RjAxrK28aGHAYe7Ln063OxdPfJuLka0OrnW55IgMI7mu2oaTIn0Nbkh269yf68D4MTKgqPBiB3Js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h8vUGnif; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h8vUGnif"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-43fe3e22e33so2722757f8f.0
        for <linux-fbdev@vger.kernel.org>; Mon, 11 May 2026 10:32:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778520750; x=1779125550; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=I8h3CCdf0Km9u5cro5J3wneh5qUHMPcQIY1Wc1jhAWo=;
        b=h8vUGnif2SgxRnxOP/eTlhvYb16jP5WdzVpRWkz1mZSUqAV5DliBVLq2SxF+NYqbxA
         DfiwG/0o+frBX1AiSNUuB2esDzS9s0AgYF9Ribspb5AmY68e94b4q2OGtwWPMnB98DWe
         1C8tYrtdzs5gsLs5RLHZ8AwTjsr7RzmpvAPXxYauknB0zEi8gw9/HzmLnraey/hNkFto
         MKioHVNR69X5+PZwGvDu/B2/qf4hI/LeXw3QOjjou+/qZcX7e0U0Dvy7ffQA6SidUcKS
         mhlePJaJnqa5S7GqMlrCOcKovUJwKlqR0DT8xUg2Ygb4b31Wg0JBEe4IzQnkz0V1RHM4
         qG+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778520750; x=1779125550;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I8h3CCdf0Km9u5cro5J3wneh5qUHMPcQIY1Wc1jhAWo=;
        b=dh2pF7U74RBfR8lVEyIFZsb+4/XvQoEcfknQyVZ+/VJQoUtwr0Qipkldekr/Kkj3bm
         SXd1B4f54DAg1mNWd+Sm/ccb9FO4zaerpF5peI9JQkXxl+cej2FXuNZX5fUDI49Qir+7
         9J87nfXnfh/XgOqnHh3zpzFfo6GW46lK/X3sJilPuKq0hS3FlGI1d3Z0ENHYDHlNgP8f
         1dBuxf/iL4cEwFEvv0o0TIqGopq657hGkoamGSXL23+pNn4Yw/SA6r9ObLNq5fPaIlFJ
         cL+exWvS8SniAdEa7LeExci4YaSk3YTeQvtE1iT9qc2RrQ2g6d4n/cXMeQ78WHGQ0AmN
         N/IA==
X-Forwarded-Encrypted: i=1; AFNElJ/lRyUBqXT9ez8hyS+G/sPocIhLdT6y3DZmXKmXjWdJ0LqYL9/qshDDR6xrU6EhJVxqDgW3I7GjFe3+fg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxNxg/x0r5Fu21IbEzqdc/4lR0F9/Qipqe9SRiuj7QZOys7IPck
	1aikvGfrgV2P8kLkRLxEqPbd837sagbbYzc2RfYcu3GhB9XpE6RS5oH0
X-Gm-Gg: Acq92OEPCULi1qXGpVgXkig+XuG16hn+uPcXvyMsHcYWA3BThkKVZiOsnun3bskNQR9
	9K1u3Qnh0NEocfR90syjcfb6QluAEF3s6x7O8B2plKP4S7v7k9VkXQcjw4PTx9eqv2ABmYoZEoC
	3e7TAMFFpU5funmdii0GPYp27Zpuq6u12D5I7CnfX6wZGkuB2b5dPNtV5rWXd2NQFmNar5pWX/X
	LZ0T2tiVL+K1lZmu0OMI5xXW2/kVE9Q7I3WFH/E0nag9NIgwlqpQrT419fPPjSjJldVbtrYuOJD
	/lcBiHOog0stOGVbxxfDt/Q0eJD+BJCWe9ElKTumyuXuxhkWw4GQS9M7eNev5Xowc69ERI47toC
	LQrMOhwRALJ2FEcEaTTXKwVip5jFUTB7MBk2yk5qQktFJa/F5OQO01nzSPJMTNd0wiVAWO/kIAr
	mWxmK18gIbT8R8yK0altcyP3OgSHC7Zg==
X-Received: by 2002:a05:6000:40dc:b0:43d:7b7b:ab77 with SMTP id ffacd0b85a97d-4515ad7673amr40455594f8f.11.1778520750159;
        Mon, 11 May 2026 10:32:30 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-458b3664e3esm11289940f8f.3.2026.05.11.10.32.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 10:32:29 -0700 (PDT)
Date: Mon, 11 May 2026 20:32:25 +0300
From: Dan Carpenter <error27@gmail.com>
To: Chhabilal Dangal <yogeshdangal66@gmail.com>
Cc: Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
	Teddy Wang <teddy.wang@siliconmotion.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: sm750fb: minor coding style cleanup
Message-ID: <agISqVe_mNkS2fzg@stanley.mountain>
References: <20260511160905.29938-1-yogeshdangal66@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260511160905.29938-1-yogeshdangal66@gmail.com>

On Mon, May 11, 2026 at 09:54:05PM +0545, Chhabilal Dangal wrote:
> Clean up various coding style issues including spacing in struct initializers and indentation of wrapped lines.
> 

This patch does too many things and quite a few are not really desired.
The changes have to be an obvious improvement, not just a matter of
opinion.  If everyone with an opinion changed the code then we'd just
be changing it back and forth forever.

> Signed-off-by: Alone <yogeshdangal66@gmail.com>

This need to be your real name.

> ---
>  drivers/staging/sm750fb/sm750.c | 203 ++++++++++++++++----------------
>  1 file changed, 103 insertions(+), 100 deletions(-)
> 
> diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
> index 9f3e3d37e82a..7fca2c9f6966 100644
> --- a/drivers/staging/sm750fb/sm750.c
> +++ b/drivers/staging/sm750fb/sm750.c
> @@ -33,7 +33,8 @@
>  static int g_hwcursor = 1;
>  static int g_noaccel;
>  static int g_nomtrr;
> -static const char *g_fbmode[] = {NULL, NULL};
> +/* intentionally non-const since array is modified at runtime */

This kind of comment is not required since it's obvious.

> +static const char *g_fbmode[] = { NULL, NULL };
>  static const char *g_def_fbmode = "1024x768-32@60";
>  static char *g_settings;
>  static int g_dualview;

[ snip ]

> @@ -120,8 +119,7 @@ static int lynxfb_ops_cursor(struct fb_info *info, struct fb_cursor *fbcursor)
>  
>  	sm750_hw_cursor_disable(cursor);
>  	if (fbcursor->set & FB_CUR_SETSIZE)
> -		sm750_hw_cursor_set_size(cursor,
> -					 fbcursor->image.width,
> +		sm750_hw_cursor_set_size(cursor, fbcursor->image.width,
>  					 fbcursor->image.height);
>  
>  	if (fbcursor->set & FB_CUR_SETPOS)

I'm fine with the original.  I like how "width" and "height" line up.
The truth is that I often split thing up on multiple lines more than
other people.

> @@ -134,19 +132,23 @@ static int lynxfb_ops_cursor(struct fb_info *info, struct fb_cursor *fbcursor)
>  		u16 fg, bg;
>  
>  		fg = ((info->cmap.red[fbcursor->image.fg_color] & 0xf800)) |
> -		     ((info->cmap.green[fbcursor->image.fg_color] & 0xfc00) >> 5) |
> -		     ((info->cmap.blue[fbcursor->image.fg_color] & 0xf800) >> 11);
> +		     ((info->cmap.green[fbcursor->image.fg_color] & 0xfc00) >>
> +		      5) |
> +		     ((info->cmap.blue[fbcursor->image.fg_color] & 0xf800) >>
> +		      11);

This is obviously worse than before.

[ snip ]

> @@ -556,8 +551,7 @@ static int lynxfb_ops_setcolreg(unsigned int regno,
>  	if (info->fix.visual == FB_VISUAL_TRUECOLOR && regno < 256) {
>  		u32 val;
>  
> -		if (var->bits_per_pixel == 16 ||
> -		    var->bits_per_pixel == 32 ||
> +		if (var->bits_per_pixel == 16 || var->bits_per_pixel == 32 ||
>  		    var->bits_per_pixel == 24) {
>  			val = chan_to_field(red, &var->red);
>  			val |= chan_to_field(green, &var->green);
> @@ -616,7 +610,8 @@ static int sm750fb_set_drv(struct lynxfb_par *par)
>  
>  	/* chip specific phase */
>  	sm750_dev->accel.de_wait = (sm750_dev->revid == SM750LE_REVISION_ID) ?
> -				    hw_sm750le_de_wait : hw_sm750_de_wait;
> +					   hw_sm750le_de_wait :
> +					   hw_sm750_de_wait;

These two changes are so weird because on the one you're combining
statements and on the other you're splitting them up.  When both
seems almost the same to me.  It's not consistent.

In the end, the original code was fine in both cases.  Just leave it.
> @@ -1112,8 +1111,12 @@ static int __init lynxfb_setup(char *options)
>  }
>  
>  static const struct pci_device_id smi_pci_table[] = {
> -	{ PCI_DEVICE(0x126f, 0x0750), },
> -	{0,}
> +	{
> +		PCI_DEVICE(0x126f, 0x0750),
> +	},
> +	{
> +		0,
> +	}
>  };

The original was better.

(I haven't reviewed it all.  This is just to give you an idea).

regards,
dan carpenter

