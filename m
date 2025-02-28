Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AD1925DD1D;
	Fri, 28 Feb 2025 15:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740757345; cv=none; b=dpI8nON0MDmpTDjSVMSPGo8HLh8b6btb5s58pKlXI5FA3ajAsYPDtQm+cwD1WyojIRKwLVwjPc9fdMkBCQSIobnFf7mXj+DuCucGaMzPKZmWUqzlU4Qf+CBhtbSiOYuS1EeJhvtHr5jjW6wnDWl/cSzL4fn4qy5YFLSL3/11GzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740757345; c=relaxed/simple;
	bh=HpX8jK3ZmcUD3IyJx4wNfma93JabP/1U6yUFggcLjdU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NF96Vccu3X2SK3mNMUYrRN9VtzOobTmpIZdfqA5GTHh+83g1NCSwJU8Vt8T5CANNYxDE+GzdmbBVMOf/QFQVAovLVGQZCLuCCZoUctC4TEgN7DoleuVHf7ibznVIrqD8xq5JkfxuxTIhh2SGuvglUOf0aT0S7Sr2L3Fe1ZZx1/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=JLtXwvZY; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="JLtXwvZY"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
	:Subject; bh=QzjgdiXNQn2lVM94vvC1YOjh1DnAuEwZM6OUPbLdXjw=; b=JLtXwvZY9rod+vN/
	6zix4+Vc9e0yIA9MhNtdoGNIHovyFlBBn8P4lF9sMuFQ9qVwfCWkNPBpfz15TMrGpY6Vo7/Cezb9L
	ox2oOdEjwzmJTvgPqUezZT6aN9i0pYPsJmEEFp4PsBXl+nudrh8B+fvMxDR792jSBLMOdHLiTFF3L
	DihJk7VwIfSzKhdRAWh8/+U4jT2ywSaj1DsNVTUnNAJ8LCPNJpA8KZc5yXU2vdavYnbbyV1d8G+Cy
	PzWqlc7Qn7IrthdfZqlZbNpXS6rc2FdK6Rjsjr+N/jzMAtGZD91OfXNTsRUED08EwU7q90hbm5zT4
	UxVAQ7K8X2/euUVlxA==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
	(envelope-from <dg@treblig.org>)
	id 1to2VD-001g24-2A;
	Fri, 28 Feb 2025 15:42:15 +0000
Date: Fri, 28 Feb 2025 15:42:15 +0000
From: "Dr. David Alan Gilbert" <dave@treblig.org>
To: tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, p.zabel@pengutronix.de,
	deller@gmx.de, shawnguo@kernel.org, s.hauer@pengutronix.de,
	kernel@pengutronix.de, festevam@gmail.com,
	dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/7] gpu: ipu-v3: Remove unused functions
Message-ID: <Z8HZV3RuIeTtcd3a@gallifrey>
References: <20241226022752.219399-1-linux@treblig.org>
 <gugwtvw6qqknstlscr4hxfrvcgfa4gfwwgxdosr24mf7huk433@oh7axkbesrjs>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <gugwtvw6qqknstlscr4hxfrvcgfa4gfwwgxdosr24mf7huk433@oh7axkbesrjs>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-21-amd64 (x86_64)
X-Uptime: 15:40:47 up 296 days,  2:54,  1 user,  load average: 0.01, 0.02,
 0.00
User-Agent: Mutt/2.2.12 (2023-09-09)

Hi All,

* Dmitry Baryshkov (dmitry.baryshkov@linaro.org) wrote:
> On Thu, Dec 26, 2024 at 02:27:45AM +0000, linux@treblig.org wrote:
> > From: "Dr. David Alan Gilbert" <linux@treblig.org>
> > 
> > Hi,
> >   This set removes a bunch of functions in ipu-v3 that
> > have been unused for a long time (since 2012-2017).
> > 
> >   No changes to functions are made, just full deletions.
> > 
> >   Build tested only.
> > 
> > Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
> > 
> 
> 
> For the series:
> 
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

Could this be picked up for drm please?

Thanks,

Dave

> -- 
> With best wishes
> Dmitry
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/
