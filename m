Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B775C433EF
	for <linux-fbdev@archiver.kernel.org>; Mon,  6 Dec 2021 15:24:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348550AbhLFP2W (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 6 Dec 2021 10:28:22 -0500
Received: from vern.gendns.com ([98.142.107.122]:44204 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1358707AbhLFPXa (ORCPT <rfc822;linux-fbdev@vger.kernel.org>);
        Mon, 6 Dec 2021 10:23:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=lechnology.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=AF2/R1hXPB3sA1ReHfqnoIHtZukG2PWVyQc/kMCx1Cw=; b=CZmtGEXm7YJUfxTRKJ33Z6yUVI
        mJ1G0Mc5J4eWoXtaH+RTMI5tYnkjr5e0IOQ/c+OGEIfsNgHSXvrDsvwqMqOcaVKfjSlTBEbq/mNCi
        S8qOgwGfdjpINXbGYbAZsUg5JxnPjFlZWhkVV1mzP1QnGhal2mrHIgFbyPcZkqJlO7kqV5k9+g/Z3
        pReAx3lms6dZlfE8n/wgkgePTQlRVPNReEsoSNhZctchjnYXKJ5huEBYnFfozmDQf5MvY80szbpQo
        6x31bCekD327vaQxnIR8eF51rc/Duwh+ZJV0jXf69wO6MJ1QtMs8HnChA+6+EwvPx305jR6f7RElL
        1ryzLqaw==;
Received: from 108-198-5-147.lightspeed.okcbok.sbcglobal.net ([108.198.5.147]:49496 helo=[192.168.0.134])
        by vern.gendns.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <david@lechnology.com>)
        id 1muFmW-0006Y1-5E; Mon, 06 Dec 2021 10:19:58 -0500
Subject: Re: [PATCH 3/6] dt-bindings: display: sitronix,st7735r: Remove
 spi-max-frequency limit
To:     =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>,
        robh+dt@kernel.org
Cc:     devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
        dave.stevenson@raspberrypi.com, maxime@cerno.tech
References: <20211124150757.17929-1-noralf@tronnes.org>
 <20211124150757.17929-4-noralf@tronnes.org>
From:   David Lechner <david@lechnology.com>
Message-ID: <1a094ddf-2190-3586-16b9-8c610e406bc2@lechnology.com>
Date:   Mon, 6 Dec 2021 09:19:58 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211124150757.17929-4-noralf@tronnes.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - vern.gendns.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lechnology.com
X-Get-Message-Sender-Via: vern.gendns.com: authenticated_id: davidmain+lechnology.com/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: vern.gendns.com: davidmain@lechnology.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On 11/24/21 9:07 AM, Noralf Trønnes wrote:
> The datasheet lists the minimum Serial clock cycle (Write) as 66ns which is

Is this supposed to say "maximum" rather than "minimum"?

> 15MHz. Mostly it can do much better than that and is in fact often run at
> 32MHz. With a clever driver that runs configuration commands at a low speed
> and only the pixel data at the maximum speed the configuration can't be
> messed up by transfer errors and the speed is only limited by the amount of
> pixel glitches that one is able to tolerate.
> 
> Signed-off-by: Noralf Trønnes <noralf@tronnes.org>
> ---
Acked-by: David Lechner <david@lechnology.com>
