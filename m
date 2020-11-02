Return-Path: <SRS0=+7Ut=EI=vger.kernel.org=linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03E84C00A89
	for <linux-fbdev@archiver.kernel.org>; Mon,  2 Nov 2020 09:38:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A09732225E
	for <linux-fbdev@archiver.kernel.org>; Mon,  2 Nov 2020 09:38:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728132AbgKBJih (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 2 Nov 2020 04:38:37 -0500
Received: from mail-out.m-online.net ([212.18.0.9]:32853 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728078AbgKBJih (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Mon, 2 Nov 2020 04:38:37 -0500
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 4CPnsk19chz1qqks;
        Mon,  2 Nov 2020 10:38:34 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 4CPnsk0Xx5z1qqkM;
        Mon,  2 Nov 2020 10:38:34 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id CmyOEtz0YXK0; Mon,  2 Nov 2020 10:38:33 +0100 (CET)
X-Auth-Info: vplb4A9Mffz9mw/154BQo0iSdT45pj9bltXPIjXlwTMuknypqtdCIHcnZ+VsrgmB
Received: from igel.home (ppp-46-244-190-239.dynamic.mnet-online.de [46.244.190.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Mon,  2 Nov 2020 10:38:33 +0100 (CET)
Received: by igel.home (Postfix, from userid 1000)
        id DB5282C3677; Mon,  2 Nov 2020 10:38:32 +0100 (CET)
From:   Andreas Schwab <schwab@linux-m68k.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Sam Ravnborg <sam@ravnborg.org>,
        Michael Schmitz <schmitzmic@gmail.com>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        "Linux/m68k" <linux-m68k@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH/RFC v2] video: fbdev: atari: Fix TT High video mode
References: <20201101102941.2891076-1-geert@linux-m68k.org>
        <20201101112915.GB1263673@ravnborg.org> <874km91by4.fsf@igel.home>
        <CAMuHMdUMF4R91Nt6mv9Tqz0zSaNh7AV8mghUoKL+uO-_PUH2aQ@mail.gmail.com>
X-Yow:  Now, I think it would be GOOD to buy FIVE or SIX STUDEBAKERS
 and CRUISE for ARTIFICIAL FLAVORING!!
Date:   Mon, 02 Nov 2020 10:38:32 +0100
In-Reply-To: <CAMuHMdUMF4R91Nt6mv9Tqz0zSaNh7AV8mghUoKL+uO-_PUH2aQ@mail.gmail.com>
        (Geert Uytterhoeven's message of "Mon, 2 Nov 2020 09:39:47 +0100")
Message-ID: <87mu0014kn.fsf@igel.home>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Nov 02 2020, Geert Uytterhoeven wrote:

> 95 ns?

No, 95 MHz.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."
