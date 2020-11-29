Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3B99C3E8C5
	for <linux-fbdev@archiver.kernel.org>; Sun, 29 Nov 2020 21:54:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 86A092078D
	for <linux-fbdev@archiver.kernel.org>; Sun, 29 Nov 2020 21:54:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725950AbgK2Vxt (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Sun, 29 Nov 2020 16:53:49 -0500
Received: from asavdk3.altibox.net ([109.247.116.14]:40206 "EHLO
        asavdk3.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725882AbgK2Vxs (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Sun, 29 Nov 2020 16:53:48 -0500
Received: from ravnborg.org (unknown [188.228.123.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk3.altibox.net (Postfix) with ESMTPS id 1697720031;
        Sun, 29 Nov 2020 22:52:59 +0100 (CET)
Date:   Sun, 29 Nov 2020 22:52:57 +0100
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Thomas Zimmermann <tzimmermann@suse.de>
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Lee Jones <lee.jones@linaro.org>,
        Vaibhav Gupta <vaibhavgupta40@gmail.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Florian Tobias Schandinat <FlorianSchandinat@gmx.de>,
        Evgeny Novikov <novikov@ispras.ru>,
        Saeed Mirzamohammadi <saeed.mirzamohammadi@oracle.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Thomas Winischhofer <thomas@winischhofer.net>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Jani Nikula <jani.nikula@intel.com>,
        Aditya Pakki <pakki001@umn.edu>,
        Xiaofei Tan <tanxiaofei@huawei.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Alex Dewar <alex.dewar90@gmail.com>,
        Jason Yan <yanaijie@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Qilong Zhang <zhangqilong3@huawei.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Gustavo Silva <gustavoars@kernel.org>,
        Peter Rosin <peda@axentia.se>,
        George Kennedy <george.kennedy@oracle.com>,
        Kristoffer Ericson <kristoffer.ericson@gmail.com>,
        Alexander Klimov <grandmaster@al2klimov.de>,
        Jingoo Han <jingoohan1@gmail.com>,
        Joe Perches <joe@perches.com>,
        Peilin Ye <yepeilin.cs@gmail.com>,
        Mike Rapoport <rppt@kernel.org>
Subject: Re: [PATCH v2 28/28] video: fbdev: s1d13xxxfb: Fix kernel-doc and
 set but not used warnings
Message-ID: <20201129215257.GD1162850@ravnborg.org>
References: <20201128224114.1033617-1-sam@ravnborg.org>
 <20201128224114.1033617-29-sam@ravnborg.org>
 <18caca15-a6e7-cb4b-3028-c010922bda80@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <18caca15-a6e7-cb4b-3028-c010922bda80@suse.de>
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=Ibmpp1ia c=1 sm=1 tr=0
        a=S6zTFyMACwkrwXSdXUNehg==:117 a=S6zTFyMACwkrwXSdXUNehg==:17
        a=kj9zAlcOel0A:10 a=lyPckR2nilxX3eVW8GIA:9 a=CjuIK1q_8ugA:10
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Hi Thomas.

On Sun, Nov 29, 2020 at 10:59:22AM +0100, Thomas Zimmermann wrote:
> 
> 
> Am 28.11.20 um 23:41 schrieb Sam Ravnborg:
> > Fix following W=1 warnings:
> > - Fix set but not nused variables which was used only for logging.
> 
> s/nused/used
> 
> s/which was/that were
> 
> Otherwise
> 
> Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>

Fixed and applied to drm-misc-next.

Thanks for the a-b's and r-b. Are you up to take a look at the remaining
24 patches? It is all simple patches so should be doable in limited time.

	Sam
