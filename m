Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4281C433F5
	for <linux-fbdev@archiver.kernel.org>; Wed, 27 Oct 2021 19:25:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8EBD361039
	for <linux-fbdev@archiver.kernel.org>; Wed, 27 Oct 2021 19:25:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239257AbhJ0T2W (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 27 Oct 2021 15:28:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232220AbhJ0T2W (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Wed, 27 Oct 2021 15:28:22 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A39ABC061570;
        Wed, 27 Oct 2021 12:25:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=g0dH9lUH9vPuYQ5RBQpLLtCKZuNR2X5ACKtS00x71Kw=; b=PxUBtFESwlvjxxr6Dimbwj55Tl
        eW5mYYUtBZSQwqGOGj647EFkxq6N6Znmn7EJYhiMZd2ZgrOngPZJkot34TISXBQbg4OK0I5sf66VN
        LABs5hSzkQddb7+0GC1ZYeytLjXzCf45XXjkePzy0HEeO8ce0X3yZob7Z8uKfSGoowKKTMLhiFAQJ
        gwNmPL9VIJIOZ2sNP06QvlTJywZOd+CUGxgEB6o8CAe9aSQlHwo57Vba6AMhUCJk9v7cjlT8x545C
        7BuNJyH/0fCMqkEk+fkIrymdMpf6ZOPiGZ8P7Nd+iLGltiWJ9hyV0CcOBSnHowTDGLUliTjlpqQDA
        y0jXwaoA==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mfoYX-005url-4B; Wed, 27 Oct 2021 19:25:49 +0000
Subject: Re: [PATCH 2/3] fbdev: rework backlight dependencies
To:     Arnd Bergmann <arnd@kernel.org>, dri-devel@lists.freedesktop.org
Cc:     linux-fbdev@vger.kernel.org, intel-gfx@lists.freedesktop.org,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>, Miguel Ojeda <ojeda@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jens Frederich <jfrederich@gmail.com>,
        Jon Nettleton <jon.nettleton@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Lars Poeschel <poeschel@lemonage.de>,
        Robin van der Gracht <robin@protonic.nl>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-staging@lists.linux.dev
References: <20211027132732.3993279-1-arnd@kernel.org>
 <20211027132732.3993279-2-arnd@kernel.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <e19f3eeb-e1c4-ff0e-cf97-f98bd420f842@infradead.org>
Date:   Wed, 27 Oct 2021 12:25:47 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211027132732.3993279-2-arnd@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On 10/27/21 6:27 AM, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> Rather than having CONFIG_FB_BACKLIGHT select CONFIG_BACKLIGHT_CLASS_DEVICE,
> make any driver that needs it have a dependency on the class device
> being available, to prevent circular dependencies.
> 
> This is the same way that the backlight is already treated for the DRM
> subsystem.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>   drivers/auxdisplay/Kconfig        |  1 +
>   drivers/macintosh/Kconfig         |  1 +
>   drivers/staging/fbtft/Kconfig     |  1 +
>   drivers/staging/olpc_dcon/Kconfig |  2 +-
>   drivers/video/fbdev/Kconfig       | 14 +++++++++++---
>   5 files changed, 15 insertions(+), 4 deletions(-)

Acked-by: Randy Dunlap <rdunlap@infraded.org>

Thanks.

-- 
~Randy
