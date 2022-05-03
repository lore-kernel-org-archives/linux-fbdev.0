Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49473C433EF
	for <linux-fbdev@archiver.kernel.org>; Tue,  3 May 2022 17:14:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240110AbiECRRm (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Tue, 3 May 2022 13:17:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240088AbiECRRl (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Tue, 3 May 2022 13:17:41 -0400
Received: from mailrelay3-1.pub.mailoutpod1-cph3.one.com (mailrelay3-1.pub.mailoutpod1-cph3.one.com [46.30.210.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44CEC1CFF1
        for <linux-fbdev@vger.kernel.org>; Tue,  3 May 2022 10:14:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ravnborg.org; s=rsa1;
        h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
         from:date:from;
        bh=Avi++YC8KXmzp+Qk4qV9sWm8T7rfgLH3Hf0948e2pMg=;
        b=qyPvWgeHzAGohjsYgc3ZWnjoDbna/uTaQSPPNwSL7xDnNOo1Q47Ji/02OMsMu4qBWHEu6Zw6EoIbG
         jw/g3SVlX16x2aepkBBJPnyX34OA3DWQ/NihzWddrQ2k6JAs11A18r26Pz9M9qrC0F2qIaNck20Cpi
         GmHNkHf68ifKepTvMlwvHGH3BbbfSsR5rJoRtbMv4p77iuhMtnZzEFn04JcMVMxW8UMA4i20S7yut7
         lluP0zUNnsVO8jjn4GqwUrE+2OrEJ4ApJpRqGSOWM6fEtLEedqtid9gw9e9hb1W0CYtggXCR2QwSiT
         aQAqFLXvqG4L+NU/1T0Zq8QFqBXzqEQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
        d=ravnborg.org; s=ed1;
        h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
         from:date:from;
        bh=Avi++YC8KXmzp+Qk4qV9sWm8T7rfgLH3Hf0948e2pMg=;
        b=gpVBElcBjr5YuapCgyRAXILEYvPvn0HuaE/FMglLwovc6+K2T5pSF4vgFkN7eX4GMg5X+ovByah0T
         B2hOLZlBA==
X-HalOne-Cookie: 4ebcfbef59c00a5378bef8f3cf6c7ffdddb91d2d
X-HalOne-ID: 6ec553c4-cb04-11ec-be6b-d0431ea8bb03
Received: from mailproxy1.cst.dirpod3-cph3.one.com (80-162-45-141-cable.dk.customer.tdc.net [80.162.45.141])
        by mailrelay3.pub.mailoutpod1-cph3.one.com (Halon) with ESMTPSA
        id 6ec553c4-cb04-11ec-be6b-d0431ea8bb03;
        Tue, 03 May 2022 17:14:04 +0000 (UTC)
Date:   Tue, 3 May 2022 19:14:02 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
        Junxiao Chang <junxiao.chang@intel.com>,
        dri-devel@lists.freedesktop.org, Maxime Ripard <maxime@cerno.tech>,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH] fbdev: Use helper to get fb_info in all file operations
Message-ID: <YnFi2nrK0I7893S2@ravnborg.org>
References: <20220503164616.663796-1-javierm@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220503164616.663796-1-javierm@redhat.com>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Hi Javier,

On Tue, May 03, 2022 at 06:46:16PM +0200, Javier Martinez Canillas wrote:
> A reference to the framebuffer device struct fb_info is stored in the file
> private data, but this reference could no longer be valid and must not be
> accessed directly. Instead, the file_fb_info() accessor function must be
> used since it does sanity checking to make sure that the fb_info is valid.
> 
> This can happen for example if the registered framebuffer device is for a
> driver that just uses a framebuffer provided by the system firmware. In
> that case, the fbdev core would unregister the framebuffer device when a
> real video driver is probed and ask to remove conflicting framebuffers.
> 
> Most fbdev file operations already use the helper to get the fb_info but
> get_fb_unmapped_area() and fb_deferred_io_fsync() don't. Fix those two.
> 
> Since fb_deferred_io_fsync() is not in fbmem.o, the helper has to be
> exported. Rename it and add a fb_ prefix to denote that is public now.
> 
> Reported-by: Junxiao Chang <junxiao.chang@intel.com>
> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
> ---
> 
>  drivers/video/fbdev/core/fb_defio.c |  5 ++++-
>  drivers/video/fbdev/core/fbmem.c    | 24 +++++++++++++++---------
>  include/linux/fb.h                  |  1 +
>  3 files changed, 20 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/video/fbdev/core/fb_defio.c b/drivers/video/fbdev/core/fb_defio.c
> index 842c66b3e33d..ac1c88b3fbb5 100644
> --- a/drivers/video/fbdev/core/fb_defio.c
> +++ b/drivers/video/fbdev/core/fb_defio.c
> @@ -68,12 +68,15 @@ static vm_fault_t fb_deferred_io_fault(struct vm_fault *vmf)
>  
>  int fb_deferred_io_fsync(struct file *file, loff_t start, loff_t end, int datasync)
>  {
> -	struct fb_info *info = file->private_data;
> +	struct fb_info *info = fb_file_fb_info(file->private_data);
This looks wrong. I assume you wanted to write:
> +	struct fb_info *info = fb_file_fb_info(file);


	Sam
