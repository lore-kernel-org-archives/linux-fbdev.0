Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA9206BFCE
	for <linux-fbdev@vger.kernel.org>; Thu, 14 Mar 2024 09:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710410039; cv=none; b=Vq4qbPPeOXFwQuInF/r7FutY56mDLWUaqFkexeHA3MjzDdo4qBYM7nH2OVB72JGNwM9U5DIgQMzi7EbDGCYHkL6PhnA8JAsepqNpht8KfSEOCcTRB88grnxzwDj7cnOd8XKF3fXoDIsQB0TIvVnlVbAVrwrNdyz2k8tJwm3dgqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710410039; c=relaxed/simple;
	bh=ZXzoLZZIrj8mYhJx84IE0GbYw8tng/PqR1C9MWyBRbM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=noHZmoJ2P+2i1Ckzgz9KfGINTHL86ir/UVHmGBaRZzYffFdfws9CEdTMtmkB9Kcu7dE2fvB+z3Px0iWcgPUzDP83Ol1PmzAipjM4GSsZmdP4xZopaghxVPQ8j4SsWGyUVUB4YUpGxhuyTIoHLVtmPjg3zPChLjZcqcgrCMcj+zM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QQJcePum; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QQJcePum"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-413f1c0edb6so2517785e9.0
        for <linux-fbdev@vger.kernel.org>; Thu, 14 Mar 2024 02:53:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710410036; x=1711014836; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ro4Imx7CWEZLX3AK8r2FNrfVWmfUpKd6vZ6AbyKyoK8=;
        b=QQJcePum5ohVRutEWoOaSf4d4Svn0GHdySNFCK2sOQ2065Ofvkpn8GJcSLYOApzEd7
         Lg7s36A1GfdPdPyoqLJQIposle5TQGzqBTDlVc9i/PWam+yMfDPKDfWKwu4E1JakpwrD
         bePYC9AdWBN/JRVIekGHBSnKfMLKByzUy9sFSNeptU681lcfpn1bXWpvmHymnA3kyNam
         COsE3y5VfriPmqAQxtSXDYXdKvPgBcm1r7ankg+M0N9J3t9kdhZ3qyacg9C5OEtqXvc+
         fBf6R3E0Wug8UNiNccL0TjU5lG5u66ReLqD9B3n1u03cYs4tEVvL5ZVEQxFh7MAy3Ta+
         EEYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710410036; x=1711014836;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ro4Imx7CWEZLX3AK8r2FNrfVWmfUpKd6vZ6AbyKyoK8=;
        b=G0rpKR6yiCmvsFQnr2Wm2AK7FaMMcdBnzB7xNHtfRMpDKfsVoWW2+wW/4k5bWSLIMt
         JEGkF1+2vm0rS8FZW5yJ1hQ6YTx2X/lVruM/o0iyUDFsRy1jkISNZbQaxT4GRhsJSFLf
         cQL0AXeVRPnFgUFOgXumssgtgBiNjyPv9B+P+HAnTisnxdN+Tv5Efectu1TTfqbVk9TV
         J0UFulcRsRpgWJSw6FMRZ+Ou0v5gBZB+lVzUHN7jwXdmTAmZGInAfSoBcQmp1W3s+tT3
         Wz6BlMAKoLCapSr7xMDqUjpvQbo5T37AOtpcEhV9siLS7Z/OEtuOD06vELq/0oKlmt0B
         XHWw==
X-Forwarded-Encrypted: i=1; AJvYcCUGHJNOo2YI+UncMfhb/QGxr1xh83SK554J3nD/KqTNfW7vfqjSTv/jrvl4sBJ01cOmGALOyA0iH2l+296aPm8mYOMpH/7gjIYCCLo=
X-Gm-Message-State: AOJu0YzURQaXiV8rtbPizlb0rAASvAcA4cwVq5ZwQDpJmBnLzN+esq6O
	1dMnJHvP2ihlbKFrq4eUc2Cigth6m4/OLrw2oFgnLg/VjdPRgNAq8igNaQfsBMA=
X-Google-Smtp-Source: AGHT+IFfVOj3Qr+ozdglLc5ukbVAJ7wK9H9tgRhtsfi5cNpUPOjNIC73zdH1T1xqVqvsxyWWZ8WGAA==
X-Received: by 2002:a5d:46c3:0:b0:33e:c070:686c with SMTP id g3-20020a5d46c3000000b0033ec070686cmr839550wrs.45.1710410036059;
        Thu, 14 Mar 2024 02:53:56 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id x11-20020a5d60cb000000b0033eca2cee1asm349346wrt.92.2024.03.14.02.53.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Mar 2024 02:53:55 -0700 (PDT)
Date: Thu, 14 Mar 2024 12:53:52 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Sam Ravnborg <sam@ravnborg.org>, lee@kernel.org,
	daniel.thompson@linaro.org, jingoohan1@gmail.com, deller@gmx.de,
	dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev
Subject: Re: [PATCH 3/6] backlight/omap1-bl: Replace FB_BLANK_ states with
 simple on/off
Message-ID: <f3e2f6ed-d915-4b32-aba8-9e9cfe9c0b3f@moroto.mountain>
References: <20240313154857.12949-1-tzimmermann@suse.de>
 <20240313154857.12949-4-tzimmermann@suse.de>
 <20240313180027.GB96726@ravnborg.org>
 <bf7b7e88-a7b4-427d-b38c-d3c9cc568aaf@suse.de>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bf7b7e88-a7b4-427d-b38c-d3c9cc568aaf@suse.de>

On Thu, Mar 14, 2024 at 09:16:15AM +0100, Thomas Zimmermann wrote:
> Hi
> 
> Am 13.03.24 um 19:00 schrieb Sam Ravnborg:
> > Hi Thomas,
> > 
> > On Wed, Mar 13, 2024 at 04:45:02PM +0100, Thomas Zimmermann wrote:
> > > The backlight is on for fb_blank eq FB_BLANK_UNBLANK, or off for
> > > any other value in fb_blank. But the field fb_blank in struct
> > > backlight_properties is deprecated and should not be used any
> > > longer.
> > > 
> > > Replace the test for fb_blank in omap's backlight code with a
> > > simple boolean parameter and push the test into the update_status
> > > helper. Instead of reading fb_blank directly, decode the backlight
> > > device's status with backlight_is_blank().
> > > 
> > > Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> > My biased opinion is that the approach in this patch is a little bit
> > better:
> > https://lore.kernel.org/lkml/20230107-sam-video-backlight-drop-fb_blank-v1-13-1bd9bafb351f@ravnborg.org/
> > 
> > I never came around resending this series it seems.
> 
> Oh, that series has been around for over a year. I don't care about which
> patches go in as long as they remove the dependency on <linux/fb.h>. I saw
> that Dan has already r-b'ed the current patchset, but if you prefer I'll
> adopt yours.

I hadn't seen Sam's patch.  It's a little bit more daring, but it's
really nice code and I trust him.

regards,
dan carpenter

