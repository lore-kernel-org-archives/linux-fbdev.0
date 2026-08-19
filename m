Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34D752C0F93;
	Wed, 19 Aug 2026 23:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787183963; cv=none; b=B/znd0s7mYZBzCXHa8hpQYX420iDDXo+enqH16oLpefzlsROJR1fSrGiGwh0EN4G6yT/cz1SrTuf6GAzwB1D5HqYHVR2OtT6YoB0KopxZsmnwTe63j2r+qi5qsmC+vVbOtwH97kxFoGFQyUcahk2LyA6c+HUatM1+7fT6fewOyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787183963; c=relaxed/simple;
	bh=NbKwT/cL4uiUAO0UmhpfW0euV6tzHj78wprytVCnxlI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F6sjp2CRAwXund79dqtKxHbZ6Lgf8jEPimQyHfejed8vNDSugCAJOioPXVkLs7+4AKs+K8mpPzhpa3PPYIzNAF8fhCfxY/eqAKSZSKp+HSdAYLYhpysIK9CGesHQVku0wj2zPUTGZHq7oiwQJPAN8abYps4MhETrBLsYzLWLaXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iQmLtUCi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iQmLtUCi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB66A1F000E9;
	Wed, 19 Aug 2026 23:59:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787183961;
	bh=542D42S9i6oOtsYocYjmFnLfSJcSBvSdQiDDr9SR4ZQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=iQmLtUCiRO/JEj8Q23uHO6q5qta+wLu5UDIZBz2t8jiFY/TOuai3+y3BM9bTw3Xux
	 hDbRz4dNHnoxIf7ytikyjxZWhZUEPW7LCYnJn1txEF2f1wZQE5DFaSpYLPWeLyY/oC
	 9P2eUi1A9/oFXhlMJM9GNNQ9BtDtiaLxZDtQHKqcd4w9JRt8bAlntpzo/mZQQ/oa6Q
	 49GNIr2myuTuObHs3oDMyb9yIaSrOtjK0YgbOu0tYyUe9kLvmmqDruQWEE+k0jA3NG
	 s13m+/nVEm7kE++HykN+tFlhJXzPQMoC22lw9mCZtuGxNU5G+egwd9wE/I/k/MJW6o
	 NxW58iA8JhgcQ==
Date: Wed, 19 Aug 2026 16:59:18 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Helge Deller <deller@gmx.de>
Cc: yuebingkun <yuebingkun@kylinos.cn>, linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] fbdev: platinumfb: add error checking for ioremap
 calls
Message-ID: <20260819235918.GA2021182@ax162>
References: <20260817063942.308926-1-yuebingkun@kylinos.cn>
 <5164081e-2eaf-498e-a320-c26c50b6f9e2@gmx.de>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5164081e-2eaf-498e-a320-c26c50b6f9e2@gmx.de>

On Tue, Aug 18, 2026 at 11:03:07AM +0200, Helge Deller wrote:
> On 8/17/26 08:39, yuebingkun wrote:
> > The ioremap() and ioremap_wt() calls in platinumfb_probe() were not
> > checked for failure. If any of these mappings fail, the driver would
> > dereference NULL pointers, leading to a kernel panic.
> > 
> > Add proper error checking and use goto-based cleanup to avoid code
> > duplication across the error paths.
> > 
> > Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> 
> That Fixes line ^^^ has no value, so I dropped it.
> 
> > Signed-off-by: yuebingkun <yuebingkun@kylinos.cn>
> 
> Would be nice to have your Name written out here, e.g. Yue Bing Kun (or something),
> but I've left it as-is for now. In case you resend with full name, I can replace it
> in the git tree.
> 
> >   drivers/video/fbdev/platinumfb.c | 36 ++++++++++++++++++++++++++------
> >   1 file changed, 30 insertions(+), 6 deletions(-)
> Patch applied (with the Fixes line dropped).

This patch introduces a compiler warning for me:

  drivers/video/fbdev/platinumfb.c: In function 'platinumfb_probe':
  drivers/video/fbdev/platinumfb.c:650:1: warning: label 'err_unmap_regs' defined but not used [-Wunused-label]
    650 | err_unmap_regs:
        | ^~~~~~~~~~~~~~

As far as I can tell, it is unnecessary, so maybe this could be folded
in? Otherwise, I can send a formal patch.

diff --git a/drivers/video/fbdev/platinumfb.c b/drivers/video/fbdev/platinumfb.c
index f74c937c839f..81fdaa3541db 100644
--- a/drivers/video/fbdev/platinumfb.c
+++ b/drivers/video/fbdev/platinumfb.c
@@ -647,7 +647,6 @@ static int platinumfb_probe(struct platform_device* odev)
 	iounmap(pinfo->cmap_regs);
 err_release_cmap:
 	release_mem_region(pinfo->cmap_regs_phys, 0x1000);
-err_unmap_regs:
 	iounmap(pinfo->platinum_regs);
 err_unmap_fb:
 	iounmap(pinfo->frame_buffer);
-- 
Cheers,
Nathan
