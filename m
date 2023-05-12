Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10220C77B7C
	for <linux-fbdev@archiver.kernel.org>; Fri, 12 May 2023 15:10:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241188AbjELPKh (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Fri, 12 May 2023 11:10:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241757AbjELPKf (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Fri, 12 May 2023 11:10:35 -0400
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 385187695;
        Fri, 12 May 2023 08:10:26 -0700 (PDT)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 4D7391C0ABB; Fri, 12 May 2023 17:10:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
        t=1683904224;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=m+tuCGTpWa1yn/iDsjxKmoSoh9Y6nyn25fuTmBqNyqo=;
        b=YPWarCic8gSCff9zOS5ukcu0QErdCHhYcqvd+5PE0F9EtHhoeKtCfXuMAJVYrr9oUIDjVo
        uavrz8JnHpV2uxRg69NUiExtZeDf75S3H4ltUN4Ez8A5qnJ7IolKBLFZHqkJvjkn99ljuD
        N9c0F8PZbOMGvnQW2qcwM3RpXEktfKg=
Date:   Fri, 12 May 2023 17:09:57 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     Thomas Zimmermann <tzimmermann@suse.de>,
        Sui Jingfeng <suijingfeng@loongson.cn>,
        Maxime Ripard <mripard@kernel.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, Li Yi <liyi@loongson.cn>,
        Christian Koenig <christian.koenig@amd.com>,
        Helge Deller <deller@gmx.de>,
        Lucas De Marchi <lucas.demarchi@intel.com>,
        linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] video/aperture: fix typos
Message-ID: <ZF5WxRrQwVjUuD6z@localhost>
References: <20230404040101.2165600-1-suijingfeng@loongson.cn>
 <0ad03743-0224-b154-a149-e3e4d54b252d@suse.de>
 <87355fex1f.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87355fex1f.fsf@minerva.mail-host-address-is-not-set>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Hi!

> > Am 04.04.23 um 06:01 schrieb Sui Jingfeng:
> >>   EFI FB, VESA FB or VGA FB etc are belong to firmware based framebuffer
> >>   driver.
> >
> 
...
> I fixed that before applying, also removed the "are" in the sentence
> above, since it sounded off and repharsed subject line as "Fix typos
> in comments".

I seem to remember that 'all your bases are belong to us' is an old
meme, but that was probably not intentional here.

Best regards,
						Pavel

-- 
