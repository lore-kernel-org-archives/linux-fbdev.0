Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC747EB64DD
	for <linux-fbdev@archiver.kernel.org>; Fri, 28 Jul 2023 21:18:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231135AbjG1VSD (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Fri, 28 Jul 2023 17:18:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjG1VSC (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Fri, 28 Jul 2023 17:18:02 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D2FAC3
        for <linux-fbdev@vger.kernel.org>; Fri, 28 Jul 2023 14:18:01 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 1932E5C0062;
        Fri, 28 Jul 2023 17:18:01 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Fri, 28 Jul 2023 17:18:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1690579081; x=1690665481; bh=Xg
        gbXECvf64i3uZBmCw1LxxwW/3QxqMj5kxf9+a5d1U=; b=n+J8sjMIlnocYM9d3O
        j3D34+PZmp0gERawFm2rQgf0hI+ctf0zWlomwZ5cvznbyOjxIYddWWZzR/+Zhi0X
        /6L0C04dxUQwFL/0JbAy5h5UwQvGeBha7cKJBLJ9y0i9fUaYDn5ygHS3SDjgSIgw
        ZP8VdELhzzEOt8n4HHKt4bzQQfw8w/HGkabhrEaOozwoKScXJXBI2+Mq1Pkd06pd
        LyYHfwYnpFAUuQcClsoR4ThHuzz2LXoGbbbisIWE0caMZNYoNg8bIJruxhemDmJ2
        5urk9fNMB+Gpeq5H+KVWAS+jy+uyNV+a/E1xKt6SJX9KHP7py841or4u5IZUibDs
        pktw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1690579081; x=1690665481; bh=XggbXECvf64i3
        uZBmCw1LxxwW/3QxqMj5kxf9+a5d1U=; b=pF0EmoAg5eqJm+0pBqza3M+YhsD29
        RDTiFUGGJnMCtacp0b1izu/gV+67Mf0Bqn7dzohenpeHljKR9J80MTgqo/C0dvjc
        gGmvUHIuQRs5ezVXoXS4pXgtMn0X/OqTtqBWMHnkSE/L68b9vLwoBmeT+fuA/cwc
        oqB7YMmTpqwuojGQyV4bm1f9R+G15m1QDABC2YaZ0ZKQ3g/aE0sBHaQQHZJ5evIX
        +hj/fwha6oJxSILVq72tdz297Xo1JTAWX4dL8LPlfDhBj5WKFsG71K1zrRtKukSF
        HJtAUjIYnYIMmoGh9gVqhPfIS7ZuDUi+rcVQ+IZm7XN17jUBBH5hpg5kA==
X-ME-Sender: <xms:iDDEZFKeEq8QUgKCRgJjw7JWB8pfttHHiEKIKIpBKfuQ8IJ8RayIOQ>
    <xme:iDDEZBIxuZxCsJ9yZfyxc6zj56jDfHy2Q2UaFxsOw-VrqkWOZtNK6RGUfqE69ASZJ
    w9aZTYBOWyj7hXgdUs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrieeigdduheehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:iDDEZNto6OzBwaRtFU_hlyvgKftuFt6949uWfnZ2IMrFqN7q7u7KOA>
    <xmx:iDDEZGbT8IXuZugOx42bVnMtWZpoJKehNlXx_VrFDBPbFCGRxJbiYA>
    <xmx:iDDEZMZqw_fHqxUX-hA4L-H98E2aZLEm0BEslLi-DTuOz79I11Zt0g>
    <xmx:iTDEZHylbNp-ccEN12qc1L-TiGS8_DMj17ag1ArtEGpJd8-1_adcQg>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id A6E68B60089; Fri, 28 Jul 2023 17:18:00 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-592-ga9d4a09b4b-fm-defalarms-20230725.001-ga9d4a09b
Mime-Version: 1.0
Message-Id: <c0c997f7-a67a-4c5d-90ef-1bc57e776b54@app.fastmail.com>
In-Reply-To: <20230728211201.1108407-1-festevam@gmail.com>
References: <20230728211201.1108407-1-festevam@gmail.com>
Date:   Fri, 28 Jul 2023 23:17:39 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Fabio Estevam" <festevam@gmail.com>,
        "Helge Deller" <deller@gmx.de>
Cc:     linux-fbdev@vger.kernel.org, "Fabio Estevam" <festevam@denx.de>
Subject: Re: [PATCH] fbdev: mx3fb: Remove the driver
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Fri, Jul 28, 2023, at 23:12, Fabio Estevam wrote:
> From: Fabio Estevam <festevam@denx.de>
>
> The mx3fb driver does not support devicetree and i.MX has been converted
> to a DT-only platform since kernel 5.10.
>
> As there is no user for this driver anymore, just remove it.
>
> Signed-off-by: Fabio Estevam <festevam@denx.de>

Reviewed-by: Arnd Bergmann <arnd@arndb.de>
