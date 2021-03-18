Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EC31C433E0
	for <linux-fbdev@archiver.kernel.org>; Thu, 18 Mar 2021 02:55:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C037764E2E
	for <linux-fbdev@archiver.kernel.org>; Thu, 18 Mar 2021 02:55:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229949AbhCRCzJ (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 17 Mar 2021 22:55:09 -0400
Received: from gateway21.websitewelcome.com ([192.185.45.210]:47876 "EHLO
        gateway21.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230507AbhCRCyv (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Wed, 17 Mar 2021 22:54:51 -0400
X-Greylist: delayed 806 seconds by postgrey-1.27 at vger.kernel.org; Wed, 17 Mar 2021 22:54:51 EDT
Received: from cm17.websitewelcome.com (cm17.websitewelcome.com [100.42.49.20])
        by gateway21.websitewelcome.com (Postfix) with ESMTP id 3E116400E5764
        for <linux-fbdev@vger.kernel.org>; Wed, 17 Mar 2021 21:54:51 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id MioFl3IhWMGeEMioFlrykw; Wed, 17 Mar 2021 21:54:51 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=kyaSur+AVF/eZzNQuGBhQHivPm6TStIKn+Qw+aned7E=; b=zGMj/6k3W3aDYn8aL7/lXpG97v
        MC7eBhhc2fBXe2lT/moJp6YmozGaXzd/RV2gqGJw37Eq5pZ7NE/g9T1qA8CSoGCCPl67l9EXsc6rw
        YysFu8SwpD3tqkJG+W5Auj2gXhk9ZqTqBFKZkdkafDSGLRjhMJPzTBhsEOr69oM0O50+AmN/uVmRP
        qOQa9WE0h/RZ/jrayy//uNqRNqZpvuM+TTtjC64O3dC9/KjaaO4cyjNl0AjRTCkdTIyqlQUv50sWf
        /JIp0ruRkXS8B0Jbhic3QbvOBVYuOsbgWc5Sa8wOSkmjHPmMXDVuOmNMT4yuE6vSwxBec6jm3klA8
        XFZ83OPQ==;
Received: from 187-162-31-110.static.axtel.net ([187.162.31.110]:40896 helo=[192.168.15.8])
        by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <gustavo@embeddedor.com>)
        id 1lMioE-004GQg-Tf; Wed, 17 Mar 2021 21:54:50 -0500
Subject: Re: [PATCH] drivers/video/fbdev:modify 0 to NULL
To:     Chunyou Tang <tangchunyou@163.com>
Cc:     gustavoars@kernel.org, sam@ravnborg.org,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, tangchunyou@yulong.com
References: <20210318023329.488-1-tangchunyou@163.com>
 <20f1664e-df4c-d085-cb25-1d05e8a793a3@embeddedor.com>
 <20210318104718.00005767@163.com>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Message-ID: <5202c72d-4246-1a4e-37fa-7caf2d9c1ce3@embeddedor.com>
Date:   Wed, 17 Mar 2021 20:54:41 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210318104718.00005767@163.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 187.162.31.110
X-Source-L: No
X-Exim-ID: 1lMioE-004GQg-Tf
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187-162-31-110.static.axtel.net ([192.168.15.8]) [187.162.31.110]:40896
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 12
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org



On 3/17/21 21:47, Chunyou Tang wrote:

> I think "if (info == NULL)" is more intuitive,and there have many
> compare likes "if (info == NULL)" in this file.

In that case, all those instances should be changed to if (!foo), instead.

--
Gustavo
