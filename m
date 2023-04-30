Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1235FC77B60
	for <linux-fbdev@archiver.kernel.org>; Sun, 30 Apr 2023 18:16:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229519AbjD3SQw (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Sun, 30 Apr 2023 14:16:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbjD3SQv (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Sun, 30 Apr 2023 14:16:51 -0400
Received: from mailrelay2-1.pub.mailoutpod2-cph3.one.com (mailrelay2-1.pub.mailoutpod2-cph3.one.com [IPv6:2a02:2350:5:401::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E9D610EF
        for <linux-fbdev@vger.kernel.org>; Sun, 30 Apr 2023 11:16:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ravnborg.org; s=rsa1;
        h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
         from:date:from;
        bh=kq/ffk5faKaJEZvlb+dnAi49OSKaAbhhxEnotu8V53A=;
        b=sQ22DXR59lNfS1Is3n/GofLwKpx8Z3kkXxg9JAEQvG1zqzk4x/0Rw7u7sVlxU0Edv5T4JgRDIHrYm
         9k+ky2YXIfq7Ud1a6wEP/anhlL+wLeHqfnOOVXi8R72ijzX5zcHCDET+J5ZCoGSIc5UN3DZnMCBQkA
         lhGk0UMaNHtDIPgrEEMe0RHWlOBFSeRNfZwYe7dDSQZ7ZBpGQxKWS6Wp9PkIwgRVAypyQ9rLV6+Qbq
         FufFn/Sgxmr5agQwkrpV9bcGDtWIOHZDZ8lnXdLyXQYebULWbqs14F1YQ1jQwAJBHJ1mguq1/zQ7YE
         ZXrw9H1HFhsKHXopi4tN6k/2IM74wNA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
        d=ravnborg.org; s=ed1;
        h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
         from:date:from;
        bh=kq/ffk5faKaJEZvlb+dnAi49OSKaAbhhxEnotu8V53A=;
        b=JmK46QF3WtGoEdnDN9Yi9LIhPGUYG9UUdXKSyUz/saZXFsxJH/YH1S8wI8To3Xv0a6uPtn5GuqHGC
         rg1xaD+Dg==
X-HalOne-ID: 02db987e-e783-11ed-9ae6-13111ccb208d
Received: from ravnborg.org (2-105-2-98-cable.dk.customer.tdc.net [2.105.2.98])
        by mailrelay2 (Halon) with ESMTPSA
        id 02db987e-e783-11ed-9ae6-13111ccb208d;
        Sun, 30 Apr 2023 18:16:45 +0000 (UTC)
Date:   Sun, 30 Apr 2023 20:15:39 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Thomas Zimmermann <tzimmermann@suse.de>
Cc:     maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        airlied@gmail.com, daniel@ffwll.ch, javierm@redhat.com,
        deller@gmx.de, geert@linux-m68k.org, sudipm.mukherjee@gmail.com,
        teddy.wang@siliconmotion.com, linux-fbdev@vger.kernel.org,
        Sui Jingfeng <suijingfeng@loongson.cn>,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v2 19/19] drm/fb-helper: Use fb_{cfb,sys}_{read, write}()
Message-ID: <20230430181539.GB96757@ravnborg.org>
References: <20230428122452.4856-1-tzimmermann@suse.de>
 <20230428122452.4856-20-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230428122452.4856-20-tzimmermann@suse.de>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Fri, Apr 28, 2023 at 02:24:52PM +0200, Thomas Zimmermann wrote:
> Implement DRM fbdev helpers for reading and writing framebuffer
> memory with the respective fbdev functions. Removes duplicate
> code.
> 
> v2:
> 	* rename fb_cfb_() to fb_io_() (Geert)
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Tested-by: Sui Jingfeng <suijingfeng@loongson.cn>
> Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
> Acked-by: Helge Deller <deller@gmx.de>

Nice cleanup.
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
