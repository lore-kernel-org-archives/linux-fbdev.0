Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A68B123F372;
	Sat,  1 Mar 2025 12:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740832574; cv=none; b=tx6CPyWvClYWdZyoYb5pa/pP9zmVswTpBFcVW6aObMfNxJeZc0QUw76tPxZGwjzNJL+KjIPv2Ez2GbgaEEE8YZxqCeNd5oSUveoa/qMZWvOY1+F8WCvvVPtCnCFvFmD+r+5CgVfG/DQuT/ULfK3tFWThnPIaPvdHyBKJImW/ReU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740832574; c=relaxed/simple;
	bh=tQYPuG6Ii/l98cVIkI3pivmYR2x8MKY/gWKoA8SUagA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=biqYjVM6S+U+BIwLRo1Ic78tvE2LDt+OJC4L1W5p+oEJrEp+dMrd1UXDC0elnOGNDP+c0MW/vZPZ3ZLoWUsU7azmCJuU4vEZNBiGTXWpEQmi2ruyCICFzYDVbldfWcslZxWs8qp2aTM3IIy7h4k0L9j14G9nHkUtmcoQXPdXyak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=f/ye+d10; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="f/ye+d10"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
	:Subject; bh=P3/qjrfLtWYJDebvoDnNBB0jTi3XIrdnZ0O+aHW2BIM=; b=f/ye+d10lC3QiYvG
	pHW+c2INfQEuEYy1KkYauJBXMemdAujPqVC2eLg3iSKWj7XTsI+cNoLpTAYkJ+3RmUhZGIRIIM929
	K6GXPQ/Ls+1Lg994KqWr2jaxKvAZvstaMENOdvBCSlzmq7zyFi8KAdm3VZULsPfd/dAZnmqh8pERt
	DWYhubypGNXQIgSwx+q2uVk1/s9+0fgnJEhoG9m2iMbzVd4V54SlWxwIgz+GBniDhJtcaKUVrKOJ/
	pHu9Rm80WS2FJVeZkZEU9c7n+6TC4FK5WSKA4k4uZC1hmiTMaNddm87x++XfqJKK6nmsIMeG2EQFv
	FYdB29KiD8dOQXYUIg==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
	(envelope-from <dg@treblig.org>)
	id 1toM4S-001pv8-2I;
	Sat, 01 Mar 2025 12:35:56 +0000
Date: Sat, 1 Mar 2025 12:35:56 +0000
From: "Dr. David Alan Gilbert" <linux@treblig.org>
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: p.zabel@pengutronix.de, airlied@gmail.com, simona@ffwll.ch,
	deller@gmx.de, shawnguo@kernel.org, s.hauer@pengutronix.de,
	kernel@pengutronix.de, festevam@gmail.com,
	dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/7] gpu: ipu-v3: Remove unused functions
Message-ID: <Z8L_LOkOfRXUAKN6@gallifrey>
References: <20241226022752.219399-1-linux@treblig.org>
 <174082343297.2941786.11452976094065423321.b4-ty@linaro.org>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <174082343297.2941786.11452976094065423321.b4-ty@linaro.org>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-21-amd64 (x86_64)
X-Uptime: 12:35:40 up 296 days, 23:49,  1 user,  load average: 0.00, 0.00,
 0.00
User-Agent: Mutt/2.2.12 (2023-09-09)

* Dmitry Baryshkov (dmitry.baryshkov@linaro.org) wrote:
> On Thu, 26 Dec 2024 02:27:45 +0000, linux@treblig.org wrote:
> > From: "Dr. David Alan Gilbert" <linux@treblig.org>
> > 
> > Hi,
> >   This set removes a bunch of functions in ipu-v3 that
> > have been unused for a long time (since 2012-2017).
> > 
> >   No changes to functions are made, just full deletions.
> > 
> > [...]
> 
> Applied to drm-misc-next, thanks!

Thanks!

Dave

> [1/7] gpu: ipu-v3: ipu-ic: Remove unused ipu_ic_task_graphics_init
>       commit: 16e3bf497fb2d379f3d461fa0c85d14de0a3d183
> [2/7] gpu: ipu-v3: Remove unused ipu_rot_mode_to_degrees
>       commit: a52ba18c254c0a3819e632e6371554f1c6f5bd16
> [3/7] gpu: ipu-v3: Remove unused ipu_idmac_channel_busy
>       commit: 4f9c64e95c3510f4a5192bd401de5611c1dd5637
> [4/7] gpu: ipu-v3: Remove unused ipu_image_convert_* functions
>       commit: 96e9d754b35e87a5be2de7dce3c810ffdd769c84
> [5/7] gpu: ipu-v3: Remove unused ipu_vdi_unsetup
>       commit: 27985c86e283e1e5ac8a9809f189f03643a6f5f2
> [6/7] gpu: ipu-v3: ipu-csi: Remove unused functions
>       commit: c687c3147d5de801ed835b077802b68fe85d8a3d
> [7/7] gpu: ipu-v3 ipu-cpmem: Remove unused functions
>       commit: 2800028d5bdee8e9a3cda2fec782dadc32225d8d
> 
> Best regards,
> -- 
> With best wishes
> Dmitry
> 
> 
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/
