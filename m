Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CBE8C0018C
	for <linux-fbdev@archiver.kernel.org>; Mon,  7 Dec 2020 17:13:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D763323884
	for <linux-fbdev@archiver.kernel.org>; Mon,  7 Dec 2020 17:13:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727678AbgLGRNs (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 7 Dec 2020 12:13:48 -0500
Received: from asavdk4.altibox.net ([109.247.116.15]:40302 "EHLO
        asavdk4.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727235AbgLGRNs (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Mon, 7 Dec 2020 12:13:48 -0500
Received: from ravnborg.org (unknown [188.228.123.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk4.altibox.net (Postfix) with ESMTPS id 95917806C8;
        Mon,  7 Dec 2020 18:12:58 +0100 (CET)
Date:   Mon, 7 Dec 2020 18:12:57 +0100
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Thomas Zimmermann <tzimmermann@suse.de>,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Lee Jones <lee.jones@linaro.org>,
        Alexander Klimov <grandmaster@al2klimov.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Colin Ian King <colin.king@canonical.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Douglas Anderson <dianders@chromium.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Gustavo A R Silva <gustavoars@kernel.org>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        linux-arm-kernel@lists.infradead.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Mike Rapoport <rppt@kernel.org>,
        Peter Jones <pjones@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Qilong Zhang <zhangqilong3@huawei.com>,
        Rich Felker <dalias@libc.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Thomas Winischhofer <thomas@winischhofer.net>
Subject: Re: [PATCH v3 02/13] video: fbdev: core: Fix kernel-doc warnings in
 fbmon + fb_notify
Message-ID: <20201207171235.GA2057731@ravnborg.org>
References: <20201206190247.1861316-1-sam@ravnborg.org>
 <20201206190247.1861316-3-sam@ravnborg.org>
 <0fb6ff8b-bea3-c5bc-0d37-8a5fdab41abc@infradead.org>
 <dd81dd0e-9701-8332-63eb-2f159c535d02@suse.de>
 <d144fe12-8f05-464e-3c1f-272999b39311@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d144fe12-8f05-464e-3c1f-272999b39311@infradead.org>
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=Itgwjo3g c=1 sm=1 tr=0
        a=S6zTFyMACwkrwXSdXUNehg==:117 a=S6zTFyMACwkrwXSdXUNehg==:17
        a=kj9zAlcOel0A:10 a=Ajc6Bj9iDLzteYZn-LwA:9 a=CjuIK1q_8ugA:10
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Hi Randy,
> >>
> >> Yes, RETURNS: will work. It just looks like any kernel-doc section name,
> >> such as Context: or Note:.
> >> However, the documented format for return info is "Return:".
> >> (see Documentation/doc-guide/kernel-doc.rst)
> > 
> > Thanks for the note. I asked for RETURNS: because the rest of the file appears to be using it. Returns: is certainly the better alternative. I didn't know there was a difference.
> > 
> > Best regards
> > Thomas
> > 
> 
> I'm not insisting on using Return:
> It can stay the same as the rest of the file IMO.

fb_notify.c contains only the three functions modified in this patch.

So it is consistent within this file, but other fbdev/core/ files uses
RETURNS. git grep shows 5 hits only.

So we will stick with the documented practice here.

	Sam
