Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B045838AC9A
	for <linux-fbdev@vger.kernel.org>; Mon,  1 Jun 2026 11:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780312156; cv=none; b=jp6FQfI8mpbjCO8nNTZvh38wFUk51CkM0ZhLRgBL8hQ8Qzc/9KNsHz2grwPs61IqvSOXKUDc17l1kWI14O/1SzOl8R7P4dfCZTjtrCkUoS29bJeMnf10NF+ul+fsb3rm6cY79bejXO3CbuP8eXIryXiMe8TjdKTYICuLeR4wpis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780312156; c=relaxed/simple;
	bh=QpnjQudDF58V1/FPsPcDplOMFvOALDVksNq/0qRLSds=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=alDlfLBZzf/1uAAu0AquaimvKuxM+yRJzxYM/OMFalbOjszCOaPy6IIh+mpeg9ZtDBSAHznrsD+wiHtFmqiQ/UbEAHuHGWvKCHV5C6g7TCFUIMBFX6y/FN1vxzR0PkyeSkhz59aQmRlQbZuAXeGbgvSqVuVeMTvB7D8y6xq3fA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X5YsJ8Xj; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X5YsJ8Xj"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-bd9a71b565aso2088289066b.0
        for <linux-fbdev@vger.kernel.org>; Mon, 01 Jun 2026 04:09:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780312154; x=1780916954; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nvWyF+YOv3aLEiatSz6/qAj4smg4GeRiDdaf9XLf71g=;
        b=X5YsJ8XjvEqAff7VG9CFVQcQwOHENrto7PPqIFG+gGnOGT02mhkOsN2BVJl9eZoDVW
         eKDNvIZh2F/kj0VB1kYhAtsSTJqZ8vrfEsrDfrOJZWpbh5qRuJx1wSuZbco3lbVg1b0c
         6J3KdGrpUM7uP0a90zoiKqq8pqRFV37cPP7Xt2W1XH/mh3d6RLB2roA5RDLab/gh8/aJ
         YlkyLzNUx84YccOU97mKCVKri7LxUz1uTjM2tnbajdmBBkHReXvreTURBIGyn8zEwhD8
         MArHC77w4411elSSe6Jj7xo1QR0EAltoozRZEFFEvGfxbPq34n0OdT99+pQHkH/0W7xQ
         X3xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780312154; x=1780916954;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nvWyF+YOv3aLEiatSz6/qAj4smg4GeRiDdaf9XLf71g=;
        b=aG1y68+uJNLPUyTY5NB+I5CooFqn0EM1BhSMM/HnpIqUWTtnmoCtpdCBd6jGV/mhNw
         XmhpMcsbDhTN0zDPXvAb2Z1OwDHDzTTYlNzpuj9Iu3E6V9UFjdWe2eouiBiuyXfJ2+nu
         LWuZNQNadEjWvl5gTsRlCWtTI+5zuPTrYsK5Bd6ICPfGcX2K90Sjv6lYR0lWJ2y2ueYq
         4pnRDXva58uvSR4k3OIAKkVDku4Q9kKVimDsdpShHClg/k6yJCVhsp8gEp0c0nKYKwV3
         XLoXCwLPo8p5i0vOEInvRYCfMgH++BhXpwo6QTnB1T+FyM8zqiDZWPn/y5qebuoEuXE3
         0yDA==
X-Forwarded-Encrypted: i=1; AFNElJ+9KiVdmEWw1t3qWY7vFhtVXMGs5AR0citlthLbysq3fnyvpitHpD3ARIyxvOXkITy2McF6LyedT7OKMg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxSe6XYv7k88UhomiVofK2AkQxLQ5pNxHMxZg5JaAvKCwaXugXx
	U7mkhKLlxmnzGatlbc3x25OzQWTFh4GgRphKzSJRt9x9MScDXKM2Gf1ekZtBrA==
X-Gm-Gg: Acq92OErnG7Jud2Lc/nwv5cmpVYBxPn/A9r+Se/ISw8/bke8XoKanRHasmm3dtEjmye
	1vtInlt6uoF1sgEnZEwBfRlBifrh856pF6PibF/yKcqZQ8YFxBPHSS6vh4jdiNjBphQamh3aUki
	b/dSjAZU23BTJkeg1emq9EyMSi/HB1eako55Dnej5AIB/CqalzT8X7DsOfzIqQOZwNmVmXiUJd/
	zL/83pbKOqMlAnWqK5Y8ngq4RI+gCoHMKDsxEsFgGu1bVONdQ6T+KrJHr0XPDyXXPlIZQdGDpvd
	2XvHW15vI3p9Fa8JdgDHJ5ztbHIeyM8cQQRMQ8sbeLpkI7vzNtDbCfj1G6F06Ytw0XzXf0f5nLR
	ZBtPQWS4LgtNJJvEA75CumOKOnrVS145W6oKYF8NYVJMd869iqbKz3DhONq3xxh0c80RAaofdKN
	EvnttrYXv94cbZ+iuXLyMxRMmUI0UsZwVFkg==
X-Received: by 2002:a17:907:2843:b0:bec:64d4:3872 with SMTP id a640c23a62f3a-bec64e37d56mr245047366b.24.1780312153930;
        Mon, 01 Jun 2026 04:09:13 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bed94f9f82asm78921366b.20.2026.06.01.04.09.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 04:09:13 -0700 (PDT)
Date: Mon, 1 Jun 2026 14:09:09 +0300
From: Dan Carpenter <error27@gmail.com>
To: Hungyu Lin <dennylin0707@gmail.com>
Cc: sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com,
	gregkh@linuxfoundation.org, linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: sm750fb: remove duplicate init_status structure
Message-ID: <ah1oVeRAQMeaLJN-@stanley.mountain>
References: <20260530222432.4303-1-dennylin0707@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260530222432.4303-1-dennylin0707@gmail.com>

On Sat, May 30, 2026 at 10:24:32PM +0000, Hungyu Lin wrote:
> struct init_status duplicates struct initchip_param and is only used
> within the sm750fb driver.
> 
> Replace the remaining users of struct init_status with
> struct initchip_param, remove the duplicate structure and eliminate
> the unnecessary cast in hw_sm750_inithw().
> 
> No functional change intended.
> 
> Signed-off-by: Hungyu Lin <dennylin0707@gmail.com>
> ---

Looks good to me.  :)

Reviewed-by: Dan Carpenter <error27@gmail.com>

regards,
dan carpenter

