Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A18AC4332F
	for <linux-fbdev@archiver.kernel.org>; Mon,  6 Dec 2021 15:21:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358666AbhLFPYr (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 6 Dec 2021 10:24:47 -0500
Received: from vern.gendns.com ([98.142.107.122]:44130 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1356651AbhLFPW2 (ORCPT <rfc822;linux-fbdev@vger.kernel.org>);
        Mon, 6 Dec 2021 10:22:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=lechnology.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=MrbM5JtmZOetU8qvnRkuIkHmVZsc/GIsXd2sH8CDHoA=; b=OEB2lfKo8p9fZe7AUfNPMTQgo6
        ECpUIwc9urNBvNZxFhOUjtFhYdeW0Obx+c/Ltvms0aEYp/yIXhn9AYZToADVtVSIiPSj5ywEn3aEP
        DSdPWFI3KI7ClUQ9AIxQZkarG5Ky0gUlf1uaF+3CD4af07XbKc+er3WVMSazc9i8Z55atphjyl+Z5
        WFTfvpdqo6AQUgjrUxbqZSwoHruqB1VG0JCDhVPHyr1G6Z36jkH9MglaxaiBpqc1mCIXDZgLwW4Ub
        1G6TLAAhoBJ8zDuQpst50BQMsRvieb/Fp4Un5CFMSfM7D40u9gL6cKgfyRbCGUG2xD/YsXCzGDruJ
        OnSiY5/A==;
Received: from 108-198-5-147.lightspeed.okcbok.sbcglobal.net ([108.198.5.147]:49494 helo=[192.168.0.134])
        by vern.gendns.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <david@lechnology.com>)
        id 1muFlX-0006OW-3G; Mon, 06 Dec 2021 10:18:57 -0500
Subject: Re: [PATCH 2/6] dt-bindings: display: sitronix,st7735r: Make
 reset-gpios optional
To:     =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>,
        robh+dt@kernel.org
Cc:     devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
        dave.stevenson@raspberrypi.com, maxime@cerno.tech
References: <20211124150757.17929-1-noralf@tronnes.org>
 <20211124150757.17929-3-noralf@tronnes.org>
From:   David Lechner <david@lechnology.com>
Message-ID: <7c93e00f-7ea4-818d-75dc-a0d9a6145363@lechnology.com>
Date:   Mon, 6 Dec 2021 09:18:56 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211124150757.17929-3-noralf@tronnes.org>
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
> There are other ways than using a gpio to reset the controller so make
> this property optional.
> 
> Signed-off-by: Noralf Trønnes <noralf@tronnes.org>
> ---
Acked-by: David Lechner <david@lechnology.com>
