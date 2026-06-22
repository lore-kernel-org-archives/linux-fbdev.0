Received: from flow-b2-smtp.messagingengine.com (flow-b2-smtp.messagingengine.com [202.12.124.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AE76313545;
	Mon, 22 Jun 2026 15:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782142827; cv=none; b=jz7KpzXQtxa3ttzvipEz25IFpv5GlPAffV2dDPWagyt/wu+jBwRccBUq9TL1teweJH8uEw9VoXNyJRg9j1483eyWT0EA73OY/MFZl4pNQMvRdSvc86SWmZ+Twmj0kJICK80i1ZVpP+OtCjbETrvYSvjWOkify/YdogX9FJe7LPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782142827; c=relaxed/simple;
	bh=u0/SXsldoKxXhIiV9Qp4QD1E4AUPEUcopctnN58PXgU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hk+znltbxNpKsopu3FhuQlz7viNfEJk+FMDBvBK2GrAVCHh/mixYyPzFeQO24rtBV/d1lgqolF5KYsgdrJ5fDK8+SRlApFN8fQbvDkTCPjg/vFizRal2wBNBAS9SfKB0DlsDH7QSgdR+y1Y1F6VzpkQ59Y0EaMNy+WQY/BgOJ5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.org; spf=pass smtp.mailfrom=fastmail.org; dkim=pass (2048-bit key) header.d=fastmail.org header.i=@fastmail.org header.b=c2JhUSCw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Mz/h77Hz; arc=none smtp.client-ip=202.12.124.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.org header.i=@fastmail.org header.b="c2JhUSCw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Mz/h77Hz"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailflow.stl.internal (Postfix) with ESMTP id 78C7E1300525;
	Mon, 22 Jun 2026 11:40:23 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Mon, 22 Jun 2026 11:40:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1782142823;
	 x=1782146423; bh=HdXmiLjFCtewYnaNmICznmxrLACPW5YYb76z+fsRb18=; b=
	c2JhUSCw2ny1UvfLXkcr4RWrVQ8QHarN0TwJd+2QEQBOKxSKtf1mlNNPiQWnY2Zl
	5edogZs5DeDEIQXs8TL1O4lcxEf6VmaDjxe+gSp3Muyu5sTSMIQx57u19S1OZTjG
	29UJeW9xc5loUXC3ldRKwusRSXzfIBa+G7cbwtUE4TSzbrJ+CEdDEqDvkCbC2TmP
	P8fILzW864Em+nypoNolIpc/vb3RvIA3uBCDdQ4SNdld24bwu2e5+tDix6qhBf49
	w+9Bm+nfJ752sdjZhr1ZtMcqrpXv6w/3oLIHQDW0mD6F7tskfXMcX86dXo/MSKb3
	hW8fcTPt60Qx6V4wro2TfQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1782142823; x=
	1782146423; bh=HdXmiLjFCtewYnaNmICznmxrLACPW5YYb76z+fsRb18=; b=M
	z/h77HzLhkLrTAJMvhyrn0vxwItuI2Ellq4HFa1jv9gEW2uPeNnEGAo7zUb5VrkW
	sRxvgwpGFiLKBhbnbTnsaoBDgLBc1dYFxSkdBMG0iIP2bPAtimpM8BGyXHnOr0Pb
	Qndwvvbbepgo5Zprncbe+or2lqNGIkm49LnxKl/AKfRUaaUYlyjZxbgJmMYRgtka
	mnbEt35M4n8KPfyI0l+tEwohLiDn5Zx5O1211bparbi4iDE5M6H6BEq6kI/OtQHE
	8pSCrqK4b4HKXvjRoojnV6b00i/klxvoQHvArZyI2QQnG7rOk+CTc/cS2mAVmSVO
	+cMfDjzIpu4Z+1L0yKzOw==
X-ME-Sender: <xms:Zlc5alLBLBVKBly1TqhSTE70zdfsF8JN6RcBEGysqGure2VqL-BHMg>
    <xme:Zlc5ajYAJIyOQRvo0fcMf-Sgz2ySASW8EgFYBYM9XzO84kr7tigLyFZ5B5jdUDAxT
    NIUTJeazMJNOAVC5ycHbOaDWpXIv9AgSJ7Xx6XZLnDh1dQgdvT28ZA>
X-ME-Received: <xmr:Zlc5av92kPTiW5VQI22tfipKxc3tl6YmuVAXIJvNoVhJrcJZcDmfT-wuUJM>
X-ME-Proxy-Cause: dmFkZTFbSqkzJcDuTJ6NXheCBDU8nHXFmKAvMGPiYbtwFQOeJRVaI++l2BH7FF00TAVvJj
    ssN5ST8jPIkYKr4nrtzIDG3wTa3y+3110hJWizubP/a7XSVsQxl9pMB9U/k1dqr1ywlpP9
    4gPlaPPO0HnKcPb9RXvN8xTdcRxW8xb7rP7pEUHeeUSb5XQqFSuudYero8/6WOTLO4LYUe
    93+l0KugHcnRW7JMHo4KasW0ZqaH14srkulEB3Nsa33kGwnD+hFOlhvQ14D3Z3J0srDbdX
    tQ/HCS/yTD9q45tguGkGug8dO64d1QJB1Qvdlkmd3F3HSO4P1oPtc5H0c1Y0ARrAp41ClJ
    88nqTVZc4pjOx4Kxt7hOEwkXr2dVlvq8qp+HGWDlOD6cuZ0gaxeVfrL6fA5ckSlN/P/r7F
    Fys8Jj/vAV4JHIPWfhcwntpcTiWBKyKyPdCBarQQyuDhzQYs+S2TzYn/4yS0CrnUWXFlSM
    +KzUbxN5t3jA9RtF4MZDO44zBh1f1xxuJ5Bvdn9PFzaQtUdjaSwksb4YHvEorB+brMwObB
    VJgIaU2SA/HwqnzL2Y6k8quIok6JN9H7FvR1WZexhENK/drS5GeTZU244zMxJJFnDPwbKS
    ZLZ3iCTYPasakSLPAHDOMutafZDKWcYrxka6pguCAofdhZqRtQuntSGMIoJg
X-ME-Proxy: <xmx:Zlc5asYyL1B8W2ppg19mSqNSdl-UAfvthGvMxR2oRp3_J8n7g18yfQ>
    <xmx:Zlc5arNW81VrUdlyhfGdt5Mwa9bVXlhmdGHTPqxedMVTkOZFnjqu-g>
    <xmx:Zlc5agAc0rEFKsJj-pGrVDPFoIMcfyMeeh_MHEUGRalD_jf5BbRVlg>
    <xmx:Zlc5aqJHeL9hb5sVabQ8M51Cb9S_J5GMvr86l0d5dw8Z653umjHTVQ>
    <xmx:Zlc5asGwe6nukOJLHXqg-czX5yPWEWw5bwRPSj17oU5RQwirZnD0snAW>
Feedback-ID: ib53e4b78:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 22 Jun 2026 11:40:22 -0400 (EDT)
Date: Mon, 22 Jun 2026 10:40:20 -0500
From: Ian Bridges <icb@fastmail.org>
To: sashiko-reviews@lists.linux.dev
Cc: Simona Vetter <simona@ffwll.ch>, Helge Deller <deller@gmx.de>,
	linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fbdev: fix use-after-free of fb_display[i].mode in
 store_modes()
Message-ID: <ajlXZL7nVHxH6mxh@dev>
References: <ajjoDhAi2y4ArSlz@dev>
 <20260622080749.D7FC61F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260622080749.D7FC61F000E9@smtp.kernel.org>

On Mon, Jun 22, 2026 at 08:07:49AM +0000, sashiko-bot@kernel.org wrote:

I'm new to submitting kernel patches, so please correct me if I have
handled this wrong. All four findings are pre-existing and none are
introduced by this patch, which I scoped to the reported
fb_display[i].mode use-after-free. Responses inline.

> Thank you for your contribution! Sashiko AI review found 4 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] Use-After-Free in show_mode() due to dangling fb_info->mode pointer.
> - [High] Data Race and potential Use-After-Free / list corruption when iterating fb_info->modelist.
> - [High] NULL pointer dereference in fbcon_new_modelist() for unallocated consoles.
> - [Medium] Data Race and locking violation modifying fb_display in do_unregister_framebuffer().
> --
> 
> commit 5e256dfc1372231ec16feb6ee8a3218859b0dd4f
> Author: Ian Bridges <icb@fastmail.org>
> 
> fbdev: fix use-after-free of fb_display[i].mode in store_modes()
> 
> store_modes() replaces a framebuffer's modelist and frees the old entries
> with fb_destroy_modelist(), but fb_display[i].mode was left dangling.
> This commit fixes the use-after-free by clearing the stale pointers with
> fbcon_delete_modelist() before freeing the old list.
> 
> Closes: https://syzkaller.appspot.com/bug?extid=81c7c6b52649fd07299d
> 
> > diff --git a/drivers/video/fbdev/core/fbsysfs.c b/drivers/video/fbdev/core/fbsysfs.c
> > index baa2bae0fb5b3..c761dcf21dafb 100644
> > --- a/drivers/video/fbdev/core/fbsysfs.c
> > +++ b/drivers/video/fbdev/core/fbsysfs.c
> > @@ -111,8 +111,10 @@ static ssize_t store_modes(struct device *device,
> >  	if (fb_new_modelist(fb_info)) {
> 
> [Severity: High]
> This isn't a bug introduced by this patch, but can this fb_new_modelist()
> call lead to a NULL pointer dereference for unallocated consoles?
> 
> If an unallocated console (where vc_cons[i].d is NULL) is mapped to a
> framebuffer, fbcon_set_disp() populates fb_display[i].mode and returns early.
> 
> When store_modes() calls fb_new_modelist() -> fbcon_new_modelist(),
> it checks if con2fb_map and fb_display[i].mode are set. Could it then fetch
> vc = vc_cons[i].d and unconditionally dereference vc->vc_num?
> 
> drivers/video/fbdev/core/fbcon.c:fbcon_new_modelist() {
>     ...
>     vc = vc_cons[i].d;
>     ...
>     fbcon_set_disp(info, &var, vc->vc_num);
>     ...
> }

Confirmed. fbcon_new_modelist() dereferences vc_cons[i].d without a NULL
check, and a console can have con2fb_map and fb_display[i].mode set while
vc_cons[i].d is NULL. I hit this while writing the reproducer for this bug.
It is a separate issue, so I'd argue it needs its own patch adding the NULL
check.

> 
> >  		fb_destroy_modelist(&fb_info->modelist);
> >  		list_splice(&old_list, &fb_info->modelist);
> > -	} else
> > +	} else {
> > +		fbcon_delete_modelist(&old_list);
> 
> [Severity: Medium]
> This is a pre-existing issue, but since we are properly calling
> fbcon_delete_modelist() under console_lock() here, should other callers do
> the same?
> 
> Looking at do_unregister_framebuffer(), it executes without holding
> console_lock():
> 
> drivers/video/fbdev/core/fbmem.c:do_unregister_framebuffer() {
>     ...
>     fbcon_delete_modelist(&fb_info->modelist);
>     ...
> }

Agreed. do_unregister_framebuffer() runs under registration_lock, not
console_lock, so the fbcon_delete_modelist() call added by a1f305893074
writes fb_display[] without console_lock. The call this patch adds to
store_modes() runs under console_lock and is safe. The unregister call site
looks worth a separate fix.

> 
> Since fbcon_delete_mode() iterates the global fb_display array and locklessly
> assigns NULL to fb_display[i].mode, could this cause a data race with
> concurrent readers like FBIOPUT_VSCREENINFO?
> 
> >  		fb_destroy_modelist(&old_list);
> 
> [Severity: High]
> This is a pre-existing issue, but does destroying old_list leave
> fb_info->mode dangling?
> 
> If fb_info->mode was previously set to point into a struct fb_modelist
> element from this list, it doesn't appear to be cleared before the list
> is freed.
> 
> Could a subsequent read of the sysfs mode attribute trigger a use-after-free
> here:
> 
> drivers/video/fbdev/core/fbsysfs.c:show_mode() {
>     ...
>     return mode_string(buf, 0, fb_info->mode);
> }

Confirmed, and it still reproduces with this patch applied. store_modes()
frees the old modelist that fb_info->mode points into, and this patch only
clears fb_display[i].mode. Writing a mode to /sys/class/graphics/fb0/mode,
then a new list to /sys/class/graphics/fb0/modes, then reading
/sys/class/graphics/fb0/mode faults in mode_string() called from
show_mode(). Since it is the same free in store_modes(), I will fold the
fix into a v2 of this patch and clear fb_info->mode alongside
fb_display[i].mode.

> 
> [Severity: High]
> This is also a pre-existing issue, but does modifying fb_info->modelist
> under lock_fb_info() race with sysfs readers?
> 
> Looking at show_modes() and store_mode(), they appear to iterate
> fb_info->modelist locklessly:
> 
> drivers/video/fbdev/core/fbsysfs.c:show_modes() {
>     ...
>     list_for_each_entry(modelist, &fb_info->modelist, list) {
>     ...
> }

Agreed. show_modes() and store_mode() walk fb_info->modelist without
lock_fb_info(), so they can race the splice and free in store_modes(). This
looks like a separate locking fix.

> 
> Since store_modes() splices, modifies, and destroys this list, could a
> concurrent sysfs read/write follow corrupted pointers into freed memory?
> 
> > +	}
> >  
> >  	unlock_fb_info(fb_info);
> >  	console_unlock();
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/ajjoDhAi2y4ArSlz@dev?part=1

To summarise, I will send a v2 of this patch that clears both stale pointers
in store_modes() (fb_display[i].mode and fb_info->mode), and keep the
fbcon_new_modelist() NULL check and the two locking issues as separate
patches.

Thanks,
Ian
