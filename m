Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBD61C64E7B
	for <linux-fbdev@archiver.kernel.org>; Tue,  1 Dec 2020 12:25:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9082720679
	for <linux-fbdev@archiver.kernel.org>; Tue,  1 Dec 2020 12:25:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728651AbgLAMZU (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Tue, 1 Dec 2020 07:25:20 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:55831 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727374AbgLAMZT (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Tue, 1 Dec 2020 07:25:19 -0500
Received: from 1.general.cking.uk.vpn ([10.172.193.212])
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1kk4hy-0001m8-EW; Tue, 01 Dec 2020 12:24:38 +0000
To:     Sam Ravnborg <sam@ravnborg.org>
From:   Colin Ian King <colin.king@canonical.com>
Subject: re: video: fbdev: sis: Fix set but not used warnings in init.c
Cc:     Thomas Zimmermann <tzimmermann@suse.de>,
        Lee Jones <lee.jones@linaro.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>
Message-ID: <575ea853-5a18-0a7c-a84b-0136ecf2cc90@canonical.com>
Date:   Tue, 1 Dec 2020 12:24:37 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Hi,

Static analysis on linux-next with Coverity had detected a minor issue
in the following commit:

commit 2a74e8682a39d00e04ca278459ae7d7ecbdfb394
Author: Sam Ravnborg <sam@ravnborg.org>
Date:   Sat Nov 28 23:40:55 2020 +0100

    video: fbdev: sis: Fix set but not used warnings in init.c


The analysis is as follows:

2659   if(SiS_Pr->UseCustomMode) {
2660      infoflag = SiS_Pr->CInfoFlag;
2661   } else {

Useless call (USELESS_CALL) side_effect_free: Calling
 SiS_GetResInfo(SiS_Pr, ModeNo, ModeIdIndex) is only useful for its
return value, which is ignored.

2662      SiS_GetResInfo(SiS_Pr, ModeNo, ModeIdIndex);
2663      if(ModeNo > 0x13) {
2664         infoflag = SiS_Pr->SiS_RefIndex[RRTI].Ext_InfoFlag;
2665      }
2666   }

.. SiSGetResInfo() just returns an unsigned short and this returns a
values is not being used. The function does not side effect anything, so
it does look like a redundant call. Is this intentional?

3044 unsigned short
3045 SiS_GetResInfo(struct SiS_Private *SiS_Pr, unsigned short ModeNo,
unsigned short ModeIdIndex)
3046 {
3047   if(ModeNo <= 0x13)
3048      return ((unsigned
short)SiS_Pr->SiS_SModeIDTable[ModeIdIndex].St_ResInfo);
3049   else
3050      return ((unsigned
short)SiS_Pr->SiS_EModeIDTable[ModeIdIndex].Ext_RESINFO);
3051 }

Colin
