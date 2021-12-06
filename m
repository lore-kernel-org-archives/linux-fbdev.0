Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E93FC433EF
	for <linux-fbdev@archiver.kernel.org>; Mon,  6 Dec 2021 16:13:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386364AbhLFQRA (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 6 Dec 2021 11:17:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359046AbhLFQQ1 (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Mon, 6 Dec 2021 11:16:27 -0500
Received: from smtp.domeneshop.no (smtp.domeneshop.no [IPv6:2a01:5b40:0:3005::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9C4DC02B766;
        Mon,  6 Dec 2021 08:02:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=tronnes.org
        ; s=ds202012; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=GQst4t/4LdWSVVcCrm8SH8Vn8HARUfxxGSM3TziIqtg=; b=TlbdtDbZXaqHvM5WwxDFaOJnMe
        bum/P9yHE+wMNvtWFA0vau3/uepcq6HBt5JPOESm0MIkFSvegyZQtzAPyyuRyOW6kHDf9Az7Ekuqa
        FVhvq7/lBDhcRV8BIlz9lDjTvlAXMPsiV0RfruSDiH9TXdDJxcELBf+306+OlNR5gvgp756kgkr/z
        KBbc26G+M0O5S7FGDqJas/PNYylxKOySRSygWkbteDR5XD8qJ/yt6G93pNPK/las7bTQNPerU+jAd
        HkOrEv20TiH4PYJSsrPtaHzDZI2Db7nID95jWsLUqfw/hsvXV8i6F47f9D6d+II4gxaz2knXzjK7+
        Whk8igMw==;
Received: from 211.81-166-168.customer.lyse.net ([81.166.168.211]:64292 helo=[192.168.10.61])
        by smtp.domeneshop.no with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <noralf@tronnes.org>)
        id 1muGRV-0007xK-E9; Mon, 06 Dec 2021 17:02:17 +0100
Message-ID: <6add71c8-3685-38dd-08a7-dd95c149d2be@tronnes.org>
Date:   Mon, 6 Dec 2021 17:02:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH 3/6] dt-bindings: display: sitronix,st7735r: Remove
 spi-max-frequency limit
To:     David Lechner <david@lechnology.com>, robh+dt@kernel.org
Cc:     devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
        dave.stevenson@raspberrypi.com, maxime@cerno.tech
References: <20211124150757.17929-1-noralf@tronnes.org>
 <20211124150757.17929-4-noralf@tronnes.org>
 <1a094ddf-2190-3586-16b9-8c610e406bc2@lechnology.com>
From:   =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>
In-Reply-To: <1a094ddf-2190-3586-16b9-8c610e406bc2@lechnology.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org



Den 06.12.2021 16.19, skrev David Lechner:
> On 11/24/21 9:07 AM, Noralf Trønnes wrote:
>> The datasheet lists the minimum Serial clock cycle (Write) as 66ns
>> which is
> 
> Is this supposed to say "maximum" rather than "minimum"?
> 

Minimum cycle time == maximum frequency.

Noralf.

>> 15MHz. Mostly it can do much better than that and is in fact often run at
>> 32MHz. With a clever driver that runs configuration commands at a low
>> speed
>> and only the pixel data at the maximum speed the configuration can't be
>> messed up by transfer errors and the speed is only limited by the
>> amount of
>> pixel glitches that one is able to tolerate.
>>
>> Signed-off-by: Noralf Trønnes <noralf@tronnes.org>
>> ---
> Acked-by: David Lechner <david@lechnology.com>
