Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF8B9C4361A
	for <linux-fbdev@archiver.kernel.org>; Thu,  3 Dec 2020 19:19:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 90FA5221EA
	for <linux-fbdev@archiver.kernel.org>; Thu,  3 Dec 2020 19:19:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726661AbgLCTTD (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Thu, 3 Dec 2020 14:19:03 -0500
Received: from wout3-smtp.messagingengine.com ([64.147.123.19]:43677 "EHLO
        wout3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725793AbgLCTTC (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Thu, 3 Dec 2020 14:19:02 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id F3395118E;
        Thu,  3 Dec 2020 14:17:56 -0500 (EST)
Received: from imap21 ([10.202.2.71])
  by compute4.internal (MEProxy); Thu, 03 Dec 2020 14:17:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aeam.us; h=
        mime-version:message-id:date:from:to:subject:content-type; s=
        fm3; bh=0QKkKaOlfBtPrPmktIoa9gtE6Rl3VEYghJFS+T/ppBE=; b=14xcV8Dg
        zTZx/VnBAhsaQu9gXG5QmPZmWj0h1qvaSOKJDaQT/GQ4uxUdHoQb/2z2m1ZyfTYS
        O6VUHNVnqsPyp7MZZsJhnswsOPU/pQFRSAs33ChIiteUbGs8FU4joNagMT7U4iWX
        G2NydrUeTSgAVapky0T5Xu1gJyMAhch68odfJZt7Z7fV62hakKeN2IryH1/xg1x6
        gHAIIMkMLZI+qIwtEiqtnb5VypOOzCODSPFPfsbHkFh94oX5mLnMgD8xaE/PIgVi
        Cdx2sozDqiEdzH1+qd0kFRlLn+hOizL7MqfcPRk464iY7qgMQLgEv40XWQHRYfDq
        dVMP2UDGCarkAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-type:date:from:message-id
        :mime-version:subject:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm1; bh=0QKkKaOlfBtPrPmktIoa9gtE6Rl3V
        EYghJFS+T/ppBE=; b=briFTnrCy26ZeC9oIU2r4lr80AoTLLnYZIm8SU7RNcdac
        ed04M7i5JcPpbyNYYVJkemt7V3J0vOCLSr2mLkSYCvMLSuNyfxTWnIoWLigbpOQ7
        TsYcyFtNq3ihfEAtOXNeY5cIJAycL/96WNiyfkA+kBGx6yvm+BuIAjaNusNoQaNE
        eUCnV3qG1DNfPZv7sPYQV5/KAu4vx4rAddiEZLF2Zae7qfXdM04Xit2yV8DD0YqU
        jzqI/Hu5PiNoDh/KOkx6yL3dCTa97tIriqPM3+0R9v0c9dfCNGjrvdmZHTkbEfs0
        o/E1x8ZQ1Wnl0TvZtXwRPsxYkwgHho5Nq72Zil4sg==
X-ME-Sender: <xms:5DnJX3X3v1fppnh2Q-wMYr1-FTMsTkNRdUovFljQlH5-du_6R9TH9w>
    <xme:5DnJX_mW4bJuRgTZc9wWz_FbNkQuKHPc7pGICdQMWosNXJRnSMdjQ4ZerOCSofwG-
    ShmRupOcziYstTkLjs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrudeiiedguddvgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepofgfggfkfffhvffutgesthdtre
    dtreertdenucfhrhhomhepfdfuihguucfuphhrhidfuceoshhiugesrggvrghmrdhusheq
    necuggftrfgrthhtvghrnhepueekheeiueeugeevvdejhfeiuefgvdekvdduvdegudfghe
    efvedtgeetvdehudetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghi
    lhhfrhhomhepshhiugesrggvrghmrdhush
X-ME-Proxy: <xmx:5DnJXzZWneqKrYs5OOwcAZCK3wXsDSDjp2qZGI_FbfqHa9faOH8RXQ>
    <xmx:5DnJXyWlHdMplmY_lfNuuYMBWpTvE3sWyR4nIsXEsoviN52Ti7oAAg>
    <xmx:5DnJXxlTXhbb3T-AxKjKZbBJDOEZ2yuz_Qvd1h7lr9rWznZOXPFHLA>
    <xmx:5DnJX_RPmhSdVQghR9-KJBZiyhHEe-ST_hbiQtsTU3RNW6wOJskzFw>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id B4A4D6F6005E; Thu,  3 Dec 2020 14:17:39 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.3.0-622-g4a97c0b-fm-20201115.001-g4a97c0b3
Mime-Version: 1.0
Message-Id: <f2317141-18db-473a-b025-98c01e115e0a@www.fastmail.com>
Date:   Thu, 03 Dec 2020 13:17:35 -0600
From:   "Sid Spry" <sid@aeam.us>
To:     arm-linux-msm@vger.kernel.org, linux-fbdev@vger.kernel.org
Subject: msm_fb data readout, writeback panel readout
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Hello, how do I read out the data currently on a display?  My device is
a msm-based Android phone, the device nodes are at /dev/graphics/fb{0,1} using
msm_fb. The fb1 device is a "writeback panel" which in my understanding
maintains a readable buffer meant for things like screen capture.

I can't find any information on getting data from the buffer, and was informed
there may be compression getting in the way. I found reference to the flag to
turn it off, but would prefer to make use of it. Can anyone help?

Thanks in advance!
