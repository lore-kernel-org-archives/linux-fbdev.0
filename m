Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FC6BEB64D9
	for <linux-fbdev@archiver.kernel.org>; Thu,  6 Jul 2023 17:43:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232163AbjGFRnT (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Thu, 6 Jul 2023 13:43:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232134AbjGFRnT (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Thu, 6 Jul 2023 13:43:19 -0400
Received: from mailrelay6-1.pub.mailoutpod2-cph3.one.com (mailrelay6-1.pub.mailoutpod2-cph3.one.com [IPv6:2a02:2350:5:405::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6884910EA
        for <linux-fbdev@vger.kernel.org>; Thu,  6 Jul 2023 10:43:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ravnborg.org; s=rsa1;
        h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
         from:date:from;
        bh=bp7torwHPDd5eLPJe0WGi7efdWJvnoEKvs296k74Pf0=;
        b=aXlfRn9oO/QjRv5h6ryHLEbKiV2TMQyffeHBSueAJ3fOaseobTu/Yj0qttWfaNPaEVHIHc97AKiE0
         ZgUPPZYnOmJYhvL4cpu+0duR9V4dkBIuVV7DSEN6IPkKr43Jc1V0VGvyrww3zzgxgztg4SSmbpyFp/
         FilYpIFVVKTv5XR36vyeFv1lhAN5JOmsQtkzh9zRe78uK3yOHALj3gaTOzHl84YHf1toy5Q90EGJOf
         esNH3n1+/byr3aI0nldBXYnNZTX88SlOkxjRvZIokktgTxLpSrYGSD+v3eud6qaPYRh+4O/T6AgWNZ
         +uvWDqRctl69cF0T9JcxK28CbN5aFyA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
        d=ravnborg.org; s=ed1;
        h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
         from:date:from;
        bh=bp7torwHPDd5eLPJe0WGi7efdWJvnoEKvs296k74Pf0=;
        b=KZJrKC62SkbFOADYDfY2lTdet1592aTNhxb5/yVQSoMLhFd9jWNHmPN6GyCzA4P16zXfNSBF7YZny
         mqKXCMkAA==
X-HalOne-ID: 950f486c-1c24-11ee-b2ac-6f01c1d0a443
Received: from ravnborg.org (2-105-2-98-cable.dk.customer.tdc.net [2.105.2.98])
        by mailrelay6 (Halon) with ESMTPSA
        id 950f486c-1c24-11ee-b2ac-6f01c1d0a443;
        Thu, 06 Jul 2023 17:43:16 +0000 (UTC)
Date:   Thu, 6 Jul 2023 19:43:15 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Thomas Zimmermann <tzimmermann@suse.de>
Cc:     javierm@redhat.com, deller@gmx.de, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 00/10] fbdev: Generate deferred-I/O helpers
Message-ID: <20230706174315.GB226645@ravnborg.org>
References: <20230706151432.20674-1-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230706151432.20674-1-tzimmermann@suse.de>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Hi Thomas,

On Thu, Jul 06, 2023 at 05:08:43PM +0200, Thomas Zimmermann wrote:
> Generate the I/O callbacks for drivers with deferred I/O. As in
> the old, opencoded functions, the generated functions operate on
> system memory and trigger damage handling if necessary. Also bring
> the drivers' Kconfig options up to date.
> 
> Generating and initializing via helpers macros will later allow for
> a fine-grained setup, depending on Kconfig options. For example, it
> will be possible to leave out file I/O if FB_DEVICE has not been set.
> 
> Thomas Zimmermann (10):
>   fbdev/broadsheetfb: Select FB_SYS_HELPERS_DEFERRED
>   fbdev/broadsheetfb: Generate deferred I/O ops
>   fbdev/hecubafb: Select FB_SYS_HELPERS_DEFERRED
>   fbdev/hecubafb: Generate deferred I/O ops
>   fbdev/metronomefb: Select FB_SYS_HELPERS_DEFERRED
>   fbdev/metronomefb: Generate deferred I/O ops
>   fbdev/ssd1307fb: Select FB_SYS_HELPERS_DEFERRED
>   fbdev/ssd1307fb: Generate deferred I/O ops
>   fbdev/xen-fbfront: Select FB_SYS_HELPERS_DEFERRED
>   fbdev/xen-fbfront: Generate deferred I/O ops

Browsed the full series - nice reduction in complexity all over.
Everything looked good so:
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
