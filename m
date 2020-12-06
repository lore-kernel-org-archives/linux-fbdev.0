Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35336C4361B
	for <linux-fbdev@archiver.kernel.org>; Sun,  6 Dec 2020 21:49:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 760BC22581
	for <linux-fbdev@archiver.kernel.org>; Sun,  6 Dec 2020 21:49:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727557AbgLFVtG (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Sun, 6 Dec 2020 16:49:06 -0500
Received: from asavdk4.altibox.net ([109.247.116.15]:39320 "EHLO
        asavdk4.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727427AbgLFVtF (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Sun, 6 Dec 2020 16:49:05 -0500
Received: from ravnborg.org (unknown [188.228.123.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk4.altibox.net (Postfix) with ESMTPS id 0BE65804EF;
        Sun,  6 Dec 2020 22:48:15 +0100 (CET)
Date:   Sun, 6 Dec 2020 22:48:14 +0100
From:   Sam Ravnborg <sam@ravnborg.org>
To:     kernel test robot <lkp@intel.com>
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Lee Jones <lee.jones@linaro.org>, kbuild-all@lists.01.org,
        Rich Felker <dalias@libc.org>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Gustavo A R Silva <gustavoars@kernel.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Peter Jones <pjones@redhat.com>
Subject: Re: [PATCH v3 05/13] sh: Fix set but not used warnings with
 !CONFIG_MMU
Message-ID: <20201206214814.GA1884161@ravnborg.org>
References: <20201206190247.1861316-6-sam@ravnborg.org>
 <202012070518.yJA9Vbbo-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <202012070518.yJA9Vbbo-lkp@intel.com>
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=Itgwjo3g c=1 sm=1 tr=0
        a=S6zTFyMACwkrwXSdXUNehg==:117 a=S6zTFyMACwkrwXSdXUNehg==:17
        a=IkcTkHD0fZMA:10 a=7gkXJVJtAAAA:8 a=QyXUC8HyAAAA:8 a=KKAkSRfTAAAA:8
        a=hAG5_4vcAAAA:8 a=VwQbUJbxAAAA:8 a=yC-0_ovQAAAA:8 a=JfrnYn6hAAAA:8
        a=Z4Rwk6OoAAAA:8 a=kDhuXSaoqpb3RoiJoOIA:9 a=QEXdDO2ut3YA:10
        a=E9Po1WZjFZOl8hwRPBS3:22 a=cvBusfyB2V15izCimMoJ:22
        a=8Bh8Pg2EFav9IBZ9i9Tn:22 a=AjGcO6oz07-iQ99wixmX:22
        a=1CNFftbPRP8L7MoqJWF3:22 a=HkZW87K1Qel5hWWM3VKY:22
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

commit aa1f4345b5480502a4e61addf5c59d606fdbce8f
Author: Sam Ravnborg <sam@ravnborg.org>
Date:   Mon Nov 30 22:09:29 2020 +0100

    sh: Fix set but not used warnings with !CONFIG_MMU
    
    Building fbdev drivers for sh with W=1 produces the following warning:
    
        tmiofb.c: In function ‘tmiofb_remove’:
        tmiofb.c:805:21: warning: variable ‘par’ set but not used
    
    This is with allmodconfig and ARCH=sh
    
    This boiled down to iounmap() defined as empty for !CONFIG_MMU.
    Fix this by by adding "(void)addr;" to tell the compiler the
    argument to iounmap() should be considered used.
    
    v4:
      - Fix build error of ethernet driver (kernel test robot)
        Added missing () around macro parameter
    
    Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
    Cc: kernel test robot <lkp@intel.com>
    Cc: Thomas Zimmermann <tzimmermann@suse.de>
    Cc: Lee Jones <lee.jones@linaro.org>
    Cc: Rich Felker <dalias@libc.org>
    Cc: Arnd Bergmann <arnd@arndb.de>
    Cc: Geert Uytterhoeven <geert+renesas@glider.be>
    Cc: Mike Rapoport <rppt@kernel.org>
    Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
    Cc: Peter Zijlstra <peterz@infradead.org>
    Cc: Sam Ravnborg <sam@ravnborg.org>
    Cc: Andrew Morton <akpm@linux-foundation.org>

diff --git a/arch/sh/include/asm/io.h b/arch/sh/include/asm/io.h
index 6d5c6463bc07..45082bcbd9aa 100644
--- a/arch/sh/include/asm/io.h
+++ b/arch/sh/include/asm/io.h
@@ -271,7 +271,7 @@ static inline void __iomem *ioremap_prot(phys_addr_t offset, unsigned long size,
 #endif /* CONFIG_HAVE_IOREMAP_PROT */
 
 #else /* CONFIG_MMU */
-#define iounmap(addr)		do { } while (0)
+#define iounmap(addr)		do { (void)(addr); } while (0)
 #define ioremap(offset, size)	((void __iomem *)(unsigned long)(offset))
 #endif /* CONFIG_MMU */
 
