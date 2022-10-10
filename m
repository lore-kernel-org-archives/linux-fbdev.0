Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84588C433FE
	for <linux-fbdev@archiver.kernel.org>; Mon, 10 Oct 2022 02:46:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230210AbiJJCqf (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Sun, 9 Oct 2022 22:46:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230027AbiJJCqf (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Sun, 9 Oct 2022 22:46:35 -0400
X-Greylist: delayed 939 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 09 Oct 2022 19:46:33 PDT
Received: from m1374.mail.163.com (m1374.mail.163.com [220.181.13.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E2A264B0F9
        for <linux-fbdev@vger.kernel.org>; Sun,  9 Oct 2022 19:46:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Date:From:Subject:MIME-Version:Message-ID; bh=2YhiT
        nPIQ4MDIZ3nx9WHggkgfBvqFh2UA8aSL+N9Vew=; b=a0jGYpuoyaHCPrGDV1HrX
        XOSK9y1T3ngLCUIhPFNeIDDTuQ1knhg3UgJlX0+KIlSMQiQ0YwJ4tmemlegUj9hh
        S00OPEKOjJ2he2EWu3o/p2sD3ZOlpe8NxuXpGG+jOeSQTbWV4unjc1Q91qkv3luh
        wu68sZ3GQL7GUtWvU6hscg=
Received: from 13667453960$163.com ( [111.48.58.12] ) by
 ajax-webmail-wmsvr74 (Coremail) ; Mon, 10 Oct 2022 10:30:36 +0800 (CST)
X-Originating-IP: [111.48.58.12]
Date:   Mon, 10 Oct 2022 10:30:36 +0800 (CST)
From:   "Yi Jiangshan" <13667453960@163.com>
To:     "Greg KH" <gregkh@linuxfoundation.org>
Cc:     sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com,
        linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        "Jiangshan Yi" <yijiangshan@kylinos.cn>,
        k2ci <kernel-bot@kylinos.cn>
Subject: Re:Re: [PATCH] staging: sm750fb: fix spelling typo in comment
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.13 build 20220113(9671e152)
 Copyright (c) 2002-2022 www.mailtech.cn 163com
In-Reply-To: <Y0MRcIyBtLlzjRzi@kroah.com>
References: <20221009094809.3171319-1-13667453960@163.com>
 <Y0MRcIyBtLlzjRzi@kroah.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
MIME-Version: 1.0
Message-ID: <f427e25.1615.183bfbad6a1.Coremail.13667453960@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: SsGowACnLW_Mg0NjhYxMAA--.59363W
X-CM-SenderInfo: bprtllyxuvjmiwq6il2tof0z/1tbivguV+1Zce8Xw2gACsH
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

CkF0IDIwMjItMTAtMTAgMDI6MjI6NDAsICJHcmVnIEtIIiA8Z3JlZ2toQGxpbnV4Zm91bmRhdGlv
bi5vcmc+IHdyb3RlOgo+T24gU3VuLCBPY3QgMDksIDIwMjIgYXQgMDU6NDg6MDlQTSArMDgwMCwg
SmlhbmdzaGFuIFlpIHdyb3RlOgo+PiBGcm9tOiBKaWFuZ3NoYW4gWWkgPHlpamlhbmdzaGFuQGt5
bGlub3MuY24+Cj4KPkFnYWluLCB3aHkgMTYzLmNvbT8KPgoKCgpUaGVyZSBpcyBhIHByb2JsZW0g
d2l0aCB0aGUgY29tcGFueSdzIG1haWxib3gsIGFuZCBzb21ldGltZXMgSSBjYW4ndCByZWNlaXZl
IGVtYWlscy4gU28gSSB0ZW1wb3JhcmlseSB1c2UgbXkgcGVyc29uYWwgZW1haWwgdG8gc2VuZCBw
YXRjaGVzLCBzbyB0aGF0IEkgY2FuIHJlY2VpdmUgZmVlZGJhY2sgZnJvbSB0aGUgY29tbXVuaXR5
IGluIGEgdGltZWx5IG1hbm5lci4KCgp0aGFua3OjrAoKCkppYW5nc2hhbiBZaQ==
