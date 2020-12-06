Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9320FC1B0D8
	for <linux-fbdev@archiver.kernel.org>; Sun,  6 Dec 2020 19:04:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 706462333D
	for <linux-fbdev@archiver.kernel.org>; Sun,  6 Dec 2020 19:04:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727819AbgLFTEe (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Sun, 6 Dec 2020 14:04:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727617AbgLFTEd (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Sun, 6 Dec 2020 14:04:33 -0500
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8B0BC08E85E
        for <linux-fbdev@vger.kernel.org>; Sun,  6 Dec 2020 11:03:20 -0800 (PST)
Received: by mail-lj1-x244.google.com with SMTP id i15so5315803ljg.9
        for <linux-fbdev@vger.kernel.org>; Sun, 06 Dec 2020 11:03:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GScDic0SzMOywiRur8mCpGJMaQJv67n1BqEnfhPYONM=;
        b=QMkRY6iR3O19IMJtlN+m8w86Axp8od1Z+Rd3idr23N4rt0HINNoZzNcNrb4mNMjjZu
         LtfD2LRDhh3DEyGEelRH+81cqqoQz6u2EGfaFSAaEV4zQVEQ7bdTSmG3CvppgGL4RgWj
         c7Oi5iOg63ZkdJPZC4t0TXvm2CwtDUzgfeudGj2JxAKG2JJV00RNILCmcFohVVoB5GRw
         Lc5MCgm2iKKHIevinvY7+ABLUGJ+6Wgt5evU5xN9dWXBW3BVnKhDDYg5UYkpaodDe+J6
         ppuuuQbWocz5KRVehMqi41+JufRzKHoQeL7FAeA3rqybqK6fKDkrVw+NwXOkDRqusUpM
         lMjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=GScDic0SzMOywiRur8mCpGJMaQJv67n1BqEnfhPYONM=;
        b=g1Vp2RkcP2qjd/dH0Pwfw3XTuRgVflFre8ws4Kk2gb2SFhpy4VnoAi6PpdAW7Ciqxu
         J/3HNF0I/JAtV5ocfqwFfgdi82PlHIJ+SlfxR04bI6Hb2viems4oToWpKVkuUckxMn66
         AnnP/bnzQvYloYRo1XWXCUVrEyCJ/p86C1eh+ZLVf1qwQ/PgO2aCpXRyvMRqHSQCvOXO
         quY8mnV2CWF1RnOhnar0F5yQn2MlJQEDRUFf9sTq92qjdWZZO7Q3ph7AjyOeIDNH26Br
         fPjnAKK4bZIKgUozCvID5xZn1tPQ2MF8O1SNXB5yo2W3ZYgi+M60NicbobzrOQmnwBUY
         LG5Q==
X-Gm-Message-State: AOAM530A+XdCFhSTbey44gz28VjnFDbCKDfg6qg2wZYly1SxkzMUR2zK
        T3zcvow1XnS9dDRvgpOsDK9ZecBfNJrvZA==
X-Google-Smtp-Source: ABdhPJxrMN/xtNgSlDAS8lye01CuFJ2naATPUBdhH/2vk8CwJU1fz9TzgghOkMOTq4Zk9C0n+Dp+gA==
X-Received: by 2002:a2e:b0d4:: with SMTP id g20mr7193569ljl.281.1607281399117;
        Sun, 06 Dec 2020 11:03:19 -0800 (PST)
Received: from saturn.localdomain ([2a00:fd00:8060:1c00:c1c3:bbc6:3ac5:732d])
        by smtp.gmail.com with ESMTPSA id v28sm2483865ljv.29.2020.12.06.11.03.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Dec 2020 11:03:18 -0800 (PST)
Sender: Sam Ravnborg <sam.ravnborg@gmail.com>
From:   Sam Ravnborg <sam@ravnborg.org>
To:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Lee Jones <lee.jones@linaro.org>
Cc:     Alexander Klimov <grandmaster@al2klimov.de>,
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
        Randy Dunlap <rdunlap@infradead.org>,
        Rich Felker <dalias@libc.org>, Sam Ravnborg <sam@ravnborg.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Thomas Winischhofer <thomas@winischhofer.net>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Tony Prisk <linux@prisktech.co.nz>
Subject: [PATCH v3 13/13] video: fbdev: sis: Drop useless call to SiS_GetResInfo()
Date:   Sun,  6 Dec 2020 20:02:47 +0100
Message-Id: <20201206190247.1861316-14-sam@ravnborg.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201206190247.1861316-1-sam@ravnborg.org>
References: <20201206190247.1861316-1-sam@ravnborg.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Coverity reported:

    Useless call (USELESS_CALL) side_effect_free: Calling
     SiS_GetResInfo(SiS_Pr, ModeNo, ModeIdIndex) is only useful for its
    return value, which is ignored.

And this is correct - so drop the call.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Reported-by: Colin Ian King <colin.king@canonical.com>
Addresses-Coverity: ("Useless call")
Cc: Colin Ian King <colin.king@canonical.com>
Cc: Thomas Winischhofer <thomas@winischhofer.net>
---
 drivers/video/fbdev/sis/init.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/video/fbdev/sis/init.c b/drivers/video/fbdev/sis/init.c
index b77ea1a8825a..b568c646a76c 100644
--- a/drivers/video/fbdev/sis/init.c
+++ b/drivers/video/fbdev/sis/init.c
@@ -2659,7 +2659,6 @@ SiS_SetCRT1ModeRegs(struct SiS_Private *SiS_Pr, unsigned short ModeNo,
    if(SiS_Pr->UseCustomMode) {
       infoflag = SiS_Pr->CInfoFlag;
    } else {
-      SiS_GetResInfo(SiS_Pr, ModeNo, ModeIdIndex);
       if(ModeNo > 0x13) {
 	 infoflag = SiS_Pr->SiS_RefIndex[RRTI].Ext_InfoFlag;
       }
-- 
2.27.0

