Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ED485625E2
	for <linux-fbdev@vger.kernel.org>; Tue, 22 Sep 2026 16:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790093180; cv=none; b=D7cQElYKGA+hAppdz1HDTGhuC3y4c2qQpfFMDoa1nfWSikLpTU6sZQxMsCOSvjVkqzgYMBXM1ba/Ug0kPSsddMAambTGx2fXtzTkWFkwCSDk4vsSyOh+BbW5eSmfmDfw6vXUYtjx1cunQ1T3aGIR3TC5glG01bDumOnW1gP4eZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790093180; c=relaxed/simple;
	bh=AmGEvpoEhurmj8yaGnkYLsgknvbqePnIdxyWbvNO7Bg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sWREBaKMFzEtyMJ8+xbERB5s32CMXImXRWSRbZd2unKpb/XRKmXfpUuavim/dREBSCnrzMvC6em7+BHPFuu4Ag5A1z/yhw/gJcjxyIngl6JWNl7FmCleXGI8RXnpCARN9DZI88wcrfQeX1bSPHrlu7najgZerAUliZY9dtSIN9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dWs+ME5h; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dWs+ME5h"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49e66390995so23755265e9.2
        for <linux-fbdev@vger.kernel.org>; Tue, 22 Sep 2026 09:06:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790093177; x=1790697977; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=SkKczT0xLYYsxaNg2GK8Ovzvtfa19Alb51sjGmOPMSI=;
        b=dWs+ME5hJJU7v/lbt19smnzGKYRI0CR5N0PJVFYHBoPelJC2TXcFWrG6EIADgn6fzm
         27F5rXlLIvRf2gN/YOCLyILBjpvgAq7+vX/BWX0G21rDycbKxma7INEJBIcCRzPf3xkN
         4VfbmiXSi8moLgoE1diwxGTXMdpy7g29J+gxTB2eOXO9nSXDPe3DL6DxXZBmb9oT3WlP
         Nc7JhMIPtLB4MRkjjoSiqXbpk8NkNWx2j/CHVLwc3oO1fav6TUOM09M5yhsGMcXquj8D
         iqKsXG5svKErrl2UJqeiW2IL4RG3zPMDQ16PNZSexBa+pN0jLqLUjLbAozSsHUB9HlLX
         GRdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790093177; x=1790697977;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SkKczT0xLYYsxaNg2GK8Ovzvtfa19Alb51sjGmOPMSI=;
        b=cXP8CbuEhF0MMozwQDkMswZ6nh7t7zPnPiGZX9KGlI+mqJvtAukvoNJxd0Uogbkj8F
         tIHe2OVFeEwix4R45llpci/YIrMhCPAya+6C+HM0UUI24+dr1mXGX97yf5keLMitfYQ5
         c+EOEvQZOs549iWMLLlc24zuIMM1UcpWL4BkcsGiOHhwQEXxmZQHyVnEVhjsM1O0VjM8
         ixev7gXEN0BCY44dxu4G9JtnmCwqqdP2BaPd8p6/bmJIOlAUMB0NTDiisv75hyutZrEo
         XiKDhhMJXqYX3E84nM1cPV7D+54JemE/lNEEZEhsxn2o+iCKusQg8URAeTAja9+f7ilf
         USng==
X-Forwarded-Encrypted: i=1; AKwUvBx0pQtOo1yM4JqfC2Bs9SfxihvMRWFSAcvpbCAnCEKDcoQqeHaMxE6OXCCn5zqM815+WZB3LGpnC6CgNA==@vger.kernel.org
X-Gm-Message-State: AFuF++mD1/JYwuVA/a4DJ0lnqe4OM1saZk5LM6fp66k9AVTzEyjur5x1
	80O1jpU7MQnhH1mYKRBPvEBtFPxjunCwpyrtmZ9kBTjwCFB6psbnVDYi
X-Gm-Gg: AYBFou3XDXSRTC11bEatfk8hMKS9UYZLg2QZ56X/SVDbMOV6F3vFanj2y+ej8bXcwAd
	9xyKbqrVPmxlFZdqwgSfbN8Duam6F7djAQfUd3vp6m7fcumxhwr6FPSMmjKUgDhLY9hYS8fOq7V
	bCsAB3BrAl3rV508PGCS7uLnSA22a3dL536Fzlm5XCVvVz28ry0O178AuyTHKlfdjrz9mi9oG2A
	bfNdE/jDzPvofZG4e3PvrlJDAibf1jHQHhE9gPd/6MRhOSAX+igVS7tpiMcoe5InH2y8xXsz59f
	f8iG9EXQGCg1T7qQdTq8+pZr3PNJlYt4pPTcLdqgmVKtRl5t4VocajroIhvFDmnpmFVCpIoIPrb
	TZxR/w/Lxe4NYRyxqTiSbOHBOs+tjUmjIOJfoIpp13f4CFUoUM95sBvbklPAUKHRxODFabh0yaa
	Qfy6/HdN6sIf8MdB7dK1if7hzXUz/cC1E9fl+OPRvdjNA2YhbV4rmfqjyFc7lEIZeenvg=
X-Received: by 2002:a05:600c:1989:b0:49c:e42b:a4ac with SMTP id 5b1f17b1804b1-49fc5714d14mr214229925e9.11.1790093176406;
        Tue, 22 Sep 2026 09:06:16 -0700 (PDT)
Received: from localhost ([2c0f:3d00:6be:8900:ce5e:9212:ea4b:f30])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fdaa9dbd6sm66967855e9.2.2026.09.22.09.06.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 09:06:14 -0700 (PDT)
Date: Tue, 22 Sep 2026 19:06:11 +0300
From: Dan Carpenter <error27@gmail.com>
To: Lucas Costa <2000.costalucas@gmail.com>
Cc: Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
	Teddy Wang <teddy.wang@siliconmotion.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: sm750fb: free cmap on framebuffer release
Message-ID: <arKnc5rrOxe4l3Hf@stanley.mountain>
References: <20260922035302.167378-1-2000.costalucas@gmail.com>
 <20260922142851.46724-1-2000.costalucas@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260922142851.46724-1-2000.costalucas@gmail.com>

On Tue, Sep 22, 2026 at 11:28:51AM -0300, Lucas Costa wrote:
> The cmap is allocated by lynxfb_set_fbinfo() but never freed, so it is
> leaked when the framebuffer is torn down.  This happens on every unbind,
> and on the register_framebuffer() error path in
> sm750fb_framebuffer_alloc().
> 
> Add a lynxfb_unset_fbinfo() cleanup counterpart to lynxfb_set_fbinfo()
> which deallocates the cmap, and call it on teardown.  In the alloc error
> path it is only called once lynxfb_set_fbinfo() has succeeded, so the
> cmap is only freed when it was actually allocated.
> 
> Fixes: 81dee67e215b ("staging: sm750fb: add sm750 to staging")
> Suggested-by: Dan Carpenter <error27@gmail.com>
> Signed-off-by: Lucas Costa <2000.costalucas@gmail.com>
> ---
> v2:
>  - Move the cmap deallocation into a lynxfb_unset_fbinfo() cleanup
>    counterpart to lynxfb_set_fbinfo(), instead of open-coding
>    fb_dealloc_cmap() at each call site.
>  - In the alloc error path, only unwind the cmap once
>    lynxfb_set_fbinfo() has succeeded (Dan Carpenter).

Thanks!

Reviewed-by: Dan Carpenter <error27@gmail.com>

regards,
dan carpenter

