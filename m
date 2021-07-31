Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43392C4338F
	for <linux-fbdev@archiver.kernel.org>; Sat, 31 Jul 2021 06:28:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 14BB560D07
	for <linux-fbdev@archiver.kernel.org>; Sat, 31 Jul 2021 06:28:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231786AbhGaG2u (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Sat, 31 Jul 2021 02:28:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbhGaG2t (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Sat, 31 Jul 2021 02:28:49 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDD89C06175F;
        Fri, 30 Jul 2021 23:28:42 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id mz5-20020a17090b3785b0290176ecf64922so23921979pjb.3;
        Fri, 30 Jul 2021 23:28:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=JI/AiDS71PLMhgUv0hBwFcFtgPLD6LDNF4PEDeob9ro=;
        b=MOr0BM39xVuj92jfaMMUBFIQ0dbZrOfjkySR61KBZFifIngNEgamqr8i6fT250V8Za
         dgE9kQMAB+H2ku+52DnI9evayG9+uQF7tBDAf7xl8fT8MSMQt73RTfvhJOC6H1GKhihE
         DWu0XwkEdr8zH0GWJsbOB8/MemoeIdaa1/u6zyicw/OxvaF1PKS9JV8W6CL3ev5TCk4w
         ms5NUqmAXXEd2V0DQp07UrKZQTTAGIqkvV4nFEduPgIFaBC2LOBe3Uq6MdOLxyHTnHov
         P2a1d0MclBg/nGeuSUTjkIylMUTlU+U6SeKEuwNdHJ4RBsdZyxslCJ65ORZjYDf9xRCx
         ggmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=JI/AiDS71PLMhgUv0hBwFcFtgPLD6LDNF4PEDeob9ro=;
        b=HL/i57KylezErnZfr/iJ2fnVmG9fATdfjV+9vY14la3MqBslv6XDCRrG91STgkfpJQ
         AQdymN7oly3MDcwnxsBBPwazxioK6HGYsj+70yc9KGRJzlJnXVTBh4FZ3AUVtxsml0v3
         9aXmdoW4jje/E63KEWgwAQuD1rzWqccuCaC6p6n6/nIZWbP8YxF+g1r/KNtzknQ+jF21
         GR7Vdxt8uNlQuANLEH5+qooxHRGi8fEYQbGoHHqH3A19XBNUN9uJv3uSzIvdx+kvSpkY
         FT+f843oBfGtbrtrryvOUgzB3XBROiu17fCMLR1b53gu8ZhZJtmQfMudQBdxXo6R6Xli
         3WmQ==
X-Gm-Message-State: AOAM530vLo3YiGghVDvl19RfKVnmzUdw/afngQ1RolQdcA1bPP54ozVo
        QFicmZtT430WQ+F+dtFzGItaasa3w5H7UA==
X-Google-Smtp-Source: ABdhPJzIpd2r4Hg0vSxNMPGAydkVCoSMg0Vn8hPVD1soJeL4Zhdd0jtTSvC5xzqIT+2msYDwWK3+KQ==
X-Received: by 2002:a17:903:41c1:b029:12c:a3eb:21c with SMTP id u1-20020a17090341c1b029012ca3eb021cmr422810ple.72.1627712922486;
        Fri, 30 Jul 2021 23:28:42 -0700 (PDT)
Received: from [10.106.0.50] ([45.135.186.29])
        by smtp.gmail.com with ESMTPSA id p3sm4255848pjt.0.2021.07.30.23.28.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Jul 2021 23:28:42 -0700 (PDT)
To:     thomas@winischhofer.net
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, baijiaju1990@gmail.com
From:   Li Tuo <islituo@gmail.com>
Subject: [BUG] video: fbdev: sis: possible uninitialized-variable access in
 SiS_SetCRT2FIFO_300()
Message-ID: <e0f988f3-f010-6299-d000-5c035e5f2e2e@gmail.com>
Date:   Sat, 31 Jul 2021 14:28:39 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Hello,

Our static analysis tool finds a possible uninitialized-variable access 
in the sis driver in Linux 5.14.0-rc3:

At the beginning of the function SiS_SetCRT2FIFO_300(), the variable 
modeidindex is not initialized.
If the following conditions are false, it remains uninitialized.
5346:    if(!SiS_Pr->CRT1UsesCustomMode)
5438:    if(!SiS_Pr->UseCustomMode)

But it is accessed at:
5466:    colorth = SiS_GetColorDepth(SiS_Pr,CRT2ModeNo,modeidindex) >> 1;

I am not quite sure whether this possible uninitialized-variable access 
is real and how to fix it if it is real.
Any feedback would be appreciated, thanks!

Reported-by: TOTE Robot <oslab@tsinghua.edu.cn>

Best wishes,
Tuo Li
