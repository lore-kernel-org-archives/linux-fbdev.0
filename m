Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F084C433EF
	for <linux-fbdev@archiver.kernel.org>; Wed, 23 Feb 2022 20:34:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241268AbiBWUfC (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 23 Feb 2022 15:35:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240361AbiBWUfB (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Wed, 23 Feb 2022 15:35:01 -0500
Received: from mx2.smtp.larsendata.com (mx2.smtp.larsendata.com [91.221.196.228])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5169E457AF
        for <linux-fbdev@vger.kernel.org>; Wed, 23 Feb 2022 12:34:33 -0800 (PST)
Received: from mail01.mxhotel.dk (mail01.mxhotel.dk [91.221.196.236])
        by mx2.smtp.larsendata.com (Halon) with ESMTPS
        id 0d61aa81-94e8-11ec-b2df-0050568cd888;
        Wed, 23 Feb 2022 20:34:51 +0000 (UTC)
Received: from ravnborg.org (80-162-45-141-cable.dk.customer.tdc.net [80.162.45.141])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: sam@ravnborg.org)
        by mail01.mxhotel.dk (Postfix) with ESMTPSA id AB273194B4E;
        Wed, 23 Feb 2022 21:34:35 +0100 (CET)
Date:   Wed, 23 Feb 2022 21:34:29 +0100
X-Report-Abuse-To: abuse@mxhotel.dk
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Thomas Zimmermann <tzimmermann@suse.de>
Cc:     daniel@ffwll.ch, deller@gmx.de, javierm@redhat.com,
        geert@linux-m68k.org, kraxel@redhat.com, ppaalanen@gmail.com,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Subject: Re: [PATCH v3 5/5] drm: Add TODO item for optimizing format helpers
Message-ID: <YhaaVSc0oV824aUh@ravnborg.org>
References: <20220223193804.18636-1-tzimmermann@suse.de>
 <20220223193804.18636-6-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220223193804.18636-6-tzimmermann@suse.de>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Wed, Feb 23, 2022 at 08:38:04PM +0100, Thomas Zimmermann wrote:
> Add a TODO item for optimizing blitting and format-conversion helpers
> in DRM and fbdev. There's always demand for faster graphics output.
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---
>  Documentation/gpu/todo.rst | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 
> diff --git a/Documentation/gpu/todo.rst b/Documentation/gpu/todo.rst
> index 7bf7f2111696..7f113c6a02dd 100644
> --- a/Documentation/gpu/todo.rst
> +++ b/Documentation/gpu/todo.rst
> @@ -241,6 +241,28 @@ Contact: Thomas Zimmermann <tzimmermann@suse.de>, Daniel Vetter
>  
>  Level: Advanced
>  
> +Benchmark and optimize blitting and format-conversion function
> +--------------------------------------------------------------
> +
> +Drawing to dispay memory quickly is crucial for many applications'
              display
> +performance.
> +
> +On at least x86-64, sys_imageblit() is significantly slower than
   On, at least x86-64, ...
   To me the extra comma makes sense, but grammar is not my strong side.
 
> +cfb_imageblit(), even though both use the same blitting algorithm and
> +the latter is written for I/O memory. It turns out that cfb_imageblit()
> +uses movl instructions, while sys_imageblit apparently does not. This
> +seems to be a problem with gcc's optimizer. DRM's format-conversion
> +heleprs might be subject to similar issues.
   helpers
> +
> +Benchmark and optimize fbdev's sys_() helpers and DRM's format-conversion
> +helpers. In cases that can be further optimized, maybe implement a different
> +algorithm, For micro-optimizations, use movl/movq instructions explicitly.
   algorithm. (period, not comma)
> +That might possibly require architecture specific helpers (e.g., storel()
> +storeq()).
> +
> +Contact: Thomas Zimmermann <tzimmermann@suse.de>
> +
> +Level: Intermediate

With the small fixes above:
Acked-by: Sam Ravnborg <sam@ravnborg.org>

Another option would be to re-implement imageblit() to be drm specific.
Maybe we can then throw out some legacy code and optimize only for the drm
use. And then maybe only a small part of the code would differ if this
is I/O memory or direct accessible memory.

	Sam
