Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4892C433DB
	for <linux-fbdev@archiver.kernel.org>; Thu, 18 Mar 2021 03:06:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 615F264E89
	for <linux-fbdev@archiver.kernel.org>; Thu, 18 Mar 2021 03:06:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229702AbhCRDGF (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 17 Mar 2021 23:06:05 -0400
Received: from gateway21.websitewelcome.com ([192.185.45.210]:21854 "EHLO
        gateway21.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230221AbhCRDF5 (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Wed, 17 Mar 2021 23:05:57 -0400
Received: from cm16.websitewelcome.com (cm16.websitewelcome.com [100.42.49.19])
        by gateway21.websitewelcome.com (Postfix) with ESMTP id 20116400C645F
        for <linux-fbdev@vger.kernel.org>; Wed, 17 Mar 2021 21:41:25 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id MibFlLufPb8LyMibFlqHz5; Wed, 17 Mar 2021 21:41:25 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=077KSEAS2xb5VEhFS9pC9E/z/1ME0eQIQJD6xAHitCY=; b=o+/dtnZL6jjO+1rqjpinf20z/A
        22q7XfWAPSuEA1TpkG3W/NLwY9TOsQzX7xmKXKRlIOWCEi+Qck0nsHlJ8DsuKIVei+GApsp2dctYF
        Cp7ZvTzu7IOt8saAGTB9TgNM/4nYYujpZt30YU9TNCG+S8Z7J98M7mw2/ilFdI8Xg+xqU7bq9S58B
        N5MgVBPWwFPJwXsM113o2KviMw7t2V9Z3fsPUAzcdOkOHUDA8hB4taH0JBfoHipstsntrkS3ZCZ1P
        BXIIMj86XW79raARuPJzXOqhzk94w8vaanrKXPA5nPzBDfs5IECwrxVzziiJZ8mZzNSZBgrpJgO5V
        JTXtFDbg==;
Received: from 187-162-31-110.static.axtel.net ([187.162.31.110]:40396 helo=[192.168.15.8])
        by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <gustavo@embeddedor.com>)
        id 1lMibE-00475T-P0; Wed, 17 Mar 2021 21:41:24 -0500
Subject: Re: [PATCH] drivers/video/fbdev:modify 0 to NULL
To:     ChunyouTang <tangchunyou@163.com>, gustavoars@kernel.org,
        sam@ravnborg.org
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, tangchunyou@yulong.com
References: <20210318023329.488-1-tangchunyou@163.com>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Message-ID: <20f1664e-df4c-d085-cb25-1d05e8a793a3@embeddedor.com>
Date:   Wed, 17 Mar 2021 20:41:15 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210318023329.488-1-tangchunyou@163.com>
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
X-Exim-ID: 1lMibE-00475T-P0
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187-162-31-110.static.axtel.net ([192.168.15.8]) [187.162.31.110]:40396
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 5
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org



On 3/17/21 21:33, ChunyouTang wrote:
> From: tangchunyou <tangchunyou@yulong.com>
> 
> modify 0 to NULL,info is a pointer,it should be
> 
> compared with NULL,not 0
> 
> Signed-off-by: tangchunyou <tangchunyou@yulong.com>
> ---
>  drivers/video/fbdev/offb.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/video/fbdev/offb.c b/drivers/video/fbdev/offb.c
> index 4501e84..cd1042f 100644
> --- a/drivers/video/fbdev/offb.c
> +++ b/drivers/video/fbdev/offb.c
> @@ -412,7 +412,7 @@ static void __init offb_init_fb(const char *name,
>  
>  	info = framebuffer_alloc(sizeof(u32) * 16, NULL);
>  
> -	if (info == 0) {
> +	if (info == NULL) {

if (!info) is better.

--
Gustavo

>  		release_mem_region(res_start, res_size);
>  		return;
>  	}
> 
