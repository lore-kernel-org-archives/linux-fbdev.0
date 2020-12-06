Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DF64C4361B
	for <linux-fbdev@archiver.kernel.org>; Sun,  6 Dec 2020 21:50:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B51722581
	for <linux-fbdev@archiver.kernel.org>; Sun,  6 Dec 2020 21:50:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727375AbgLFVu1 (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Sun, 6 Dec 2020 16:50:27 -0500
Received: from asavdk4.altibox.net ([109.247.116.15]:39386 "EHLO
        asavdk4.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727040AbgLFVu0 (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Sun, 6 Dec 2020 16:50:26 -0500
Received: from ravnborg.org (unknown [188.228.123.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk4.altibox.net (Postfix) with ESMTPS id 643A4804EF;
        Sun,  6 Dec 2020 22:49:39 +0100 (CET)
Date:   Sun, 6 Dec 2020 22:49:38 +0100
From:   Sam Ravnborg <sam@ravnborg.org>
To:     kernel test robot <lkp@intel.com>
Cc:     linux-fbdev@vger.kernel.org, Rich Felker <dalias@libc.org>,
        kbuild-all@lists.01.org,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Gustavo A R Silva <gustavoars@kernel.org>,
        dri-devel@lists.freedesktop.org,
        Andrzej Hajda <a.hajda@samsung.com>,
        Peter Jones <pjones@redhat.com>,
        Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v3 05/13] sh: Fix set but not used warnings with
 !CONFIG_MMU
Message-ID: <20201206214938.GA1935298@ravnborg.org>
References: <20201206190247.1861316-6-sam@ravnborg.org>
 <202012070518.yJA9Vbbo-lkp@intel.com>
 <20201206214814.GA1884161@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201206214814.GA1884161@ravnborg.org>
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=Itgwjo3g c=1 sm=1 tr=0
        a=S6zTFyMACwkrwXSdXUNehg==:117 a=S6zTFyMACwkrwXSdXUNehg==:17
        a=IkcTkHD0fZMA:10 a=7gkXJVJtAAAA:8 a=oPZtxxbveF9zbOjJoJsA:9
        a=QEXdDO2ut3YA:10 a=E9Po1WZjFZOl8hwRPBS3:22
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Hi "kernel test robot"
On Sun, Dec 06, 2020 at 10:48:14PM +0100, Sam Ravnborg wrote:
> commit aa1f4345b5480502a4e61addf5c59d606fdbce8f
> Author: Sam Ravnborg <sam@ravnborg.org>
> Date:   Mon Nov 30 22:09:29 2020 +0100
> 
>     sh: Fix set but not used warnings with !CONFIG_MMU
>     
>     Building fbdev drivers for sh with W=1 produces the following warning:
>     
>         tmiofb.c: In function ‘tmiofb_remove’:
>         tmiofb.c:805:21: warning: variable ‘par’ set but not used
>     
>     This is with allmodconfig and ARCH=sh
>     
>     This boiled down to iounmap() defined as empty for !CONFIG_MMU.
>     Fix this by by adding "(void)addr;" to tell the compiler the
>     argument to iounmap() should be considered used.
>     
>     v4:
>       - Fix build error of ethernet driver (kernel test robot)
>         Added missing () around macro parameter

Thanks for thee quick report - it was easy to reproduce.
I hope this is enough for the robot to pick up the updated patch.

	Sam
