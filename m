Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9474848EBE0;
	Thu, 15 Oct 2026 08:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792053639; cv=none; b=d1utvA1E6y5sP/pLyr3Z9GQmzuo3vJS+0gkn5RclARW6PJ0tAmLs4XMByWn1nx2NKOo/40+pF3wWmWYtRZ8hEb/VhOWk7wmNNbz2NaNCQkqZacaU4PsrEK4TjKSOEdg04/mPQTRSRrVkRiDfukpL8U26lD6FJrnslMLIJbvrz8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792053639; c=relaxed/simple;
	bh=w5BMm19PJ33HpV6ZWCbKyYRyOqaOUmagn0q+cNwOEmM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cYhgoSMmvydkX8ysuzV7t5tPTRE8Fd2Lrp0EbZ0y9tlhWYYSbXzVxUjoSbvXoAMSad6+f3d3nOVfysWg92IGYjCDhZAukcug7eAUTdBh9A9Jfh6L+D7afuCvyrI/HsGYLcQmw1+JpmgrhhZAMtkivjltTe+8q/XhwrmGtnQ4h8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fCwGdrEc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fCwGdrEc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 594291F000C4;
	Thu, 15 Oct 2026 08:40:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1792053635;
	bh=hHpS+p9lGwQCMKx26qeblqdx1O0Ib5iNvx4yJYRqSTI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=fCwGdrEcyW1vOmNZxQFUab2qaEWx75ygDgT/iGEV47cHAHKPIb2TqYOCVUbGgNdRw
	 xfBcxcSix7T3y8CqQ0psswKZBRGHRGICEkB3ikmzy0apkSF/7StaC4AWY18IkJHuEx
	 3DeNyCJO/piUu8yVtbv8mndGqzaL0CsTSTC4Wlvo=
Date: Thu, 15 Oct 2026 10:40:39 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Xia Yan <yana06070@163.com>
Cc: sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com,
	linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: sm750fb: remove unused CRTC cursor fields
Message-ID: <2026101530-upstage-schnapps-5503@gregkh>
References: <20261015082757.10371-1-yana06070@163.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261015082757.10371-1-yana06070@163.com>

On Thu, Oct 15, 2026 at 04:27:57PM +0800, Xia Yan wrote:
> The v_cursor and o_cursor members of struct lynxfb_crtc are never read
> or written. The cursor setup and update paths use cursor.vstart and
> cursor.offset in the embedded struct lynx_cursor instead.
> 
> Remove the unused members to avoid keeping a second, unused set of
> cursor location fields. No functional change is intended.
> 
> Assisted-by: LLM
> Signed-off-by: Xia Yan <yana06070@163.com>
> ---
> 
> Notes (validation):
>     Compile-tested on x86_64 with GCC 12.3.1 and CONFIG_FB_SM750=m, using W=1.
>     All driver objects and the combined sm750fb.o built successfully.

Please read:
	https://lore.kernel.org/r/2026080354-skater-urgent-31b2@gregkh
