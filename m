Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01E23C4338F
	for <linux-fbdev@archiver.kernel.org>; Mon, 26 Jul 2021 11:41:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D24C560C51
	for <linux-fbdev@archiver.kernel.org>; Mon, 26 Jul 2021 11:41:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233475AbhGZLBX (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 26 Jul 2021 07:01:23 -0400
Received: from mail12.tencent.com ([61.241.47.121]:49195 "EHLO
        mail4.tencent.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S233534AbhGZLBX (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Mon, 26 Jul 2021 07:01:23 -0400
X-Greylist: delayed 552 seconds by postgrey-1.27 at vger.kernel.org; Mon, 26 Jul 2021 07:01:22 EDT
Received: from EX-SZ021.tencent.com (unknown [10.28.6.73])
        by mail4.tencent.com (Postfix) with ESMTP id 8A41E64112;
        Mon, 26 Jul 2021 19:32:37 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tencent.com;
        s=s202002; t=1627299157;
        bh=evDPUslxUaLukH5pVeeVe4ET0nWliHTCs40Ts/OkTRs=;
        h=From:To:CC:Subject:Date;
        b=jGzGwnIiKN7HjDJ+AtlLPh5vXGE6W+42s2exAzhNRpBA6oVd1kvPgBNyLchZdBOSZ
         CYdS1uzgt6r8Sde4KZouTKIMmOTWXPru5KQ/B9se3BIodg7Ib+3cT5nF4fSbHXoZcQ
         +jfg4ay2BH9CS5wHhACTJiwbMdTUAGbfxi5oypgw=
Received: from EX-SZ037.tencent.com (10.28.6.119) by EX-SZ021.tencent.com
 (10.28.6.73) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Mon, 26 Jul
 2021 19:32:37 +0800
Received: from EX-SZ030.tencent.com (10.28.6.105) by EX-SZ037.tencent.com
 (10.28.6.119) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Mon, 26 Jul
 2021 19:32:37 +0800
Received: from EX-SZ030.tencent.com ([fe80::cd97:7a16:11e6:d0c8]) by
 EX-SZ030.tencent.com ([fe80::cd97:7a16:11e6:d0c8%5]) with mapi id
 15.01.2242.008; Mon, 26 Jul 2021 19:32:37 +0800
From:   =?utf-8?B?dGNzX2tlcm5lbCjohb7orq/kupHlhoXmoLjlvIDlj5HogIUp?= 
        <tcs_kernel@tencent.com>
To:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "daniel.vetter@ffwll.ch" <daniel.vetter@ffwll.ch>,
        "yepeilin.cs@gmail.com" <yepeilin.cs@gmail.com>,
        "penguin-kernel@I-love.SAKURA.ne.jp" 
        <penguin-kernel@I-love.SAKURA.ne.jp>,
        "tzimmermann@suse.de" <tzimmermann@suse.de>,
        "george.kennedy@oracle.com" <george.kennedy@oracle.com>,
        "ducheng2@gmail.com" <ducheng2@gmail.com>,
        "sam@ravnborg.org" <sam@ravnborg.org>
CC:     "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH] fbcon: Out-Of-Bounds write in sys_imageblit, add range check
Thread-Topic: [PATCH] fbcon: Out-Of-Bounds write in sys_imageblit, add range
 check
Thread-Index: AQHXghHvrDWkYfnua06MBXDuWeAYaw==
Date:   Mon, 26 Jul 2021 11:32:37 +0000
Message-ID: <D5DF8A1C-5FA2-426B-AAB4-3199AEA0A02E@tencent.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.28.2.15]
Content-Type: text/plain; charset="utf-8"
Content-ID: <F26A0D29A1DFB646BB35537219DFF289@tencent.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

eXJlcyBhbmQgdnlyZXMgY2FuIGJlIGNvbnRyb2xsZWQgYnkgdXNlciBtb2RlIHBhcmFtYXRlcnMs
IGFuZCBjYXVzZSBwLT52cm93cyB0byBiZWNvbWUgYSBuZWdhdGl2ZSB2YWx1ZS4gV2hpbGUgdGhp
cyB2YWx1ZSBiZSBwYXNzZWQgdG8gcmVhbF95IGZ1bmN0aW9uLCB0aGUgeXBvcyB3aWxsIGJlIG91
dCBvZiBzY3JlZW4gcmFuZ2UuDQpUaGlzIGlzIGFuIG91dC1vZi1ib3VuZHMgd3JpdGUgYnVnLg0K
DQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL3ZpZGVvL2ZiZGV2L2NvcmUvZmJjb24uYyBiL2RyaXZl
cnMvdmlkZW8vZmJkZXYvY29yZS9mYmNvbi5jDQppbmRleCAyMmJiMzg5MmY2YmQuLjA5NzBkZTQ2
NzgyZiAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvdmlkZW8vZmJkZXYvY29yZS9mYmNvbi5jDQorKysg
Yi9kcml2ZXJzL3ZpZGVvL2ZiZGV2L2NvcmUvZmJjb24uYw0KQEAgLTE5NTYsMTEgKzE5NTYsMTIg
QEAgc3RhdGljIHZvaWQgdXBkYXRlc2Nyb2xsbW9kZShzdHJ1Y3QgZmJjb25fZGlzcGxheSAqcCwN
CiAgICAgICAgaW50IHlyZXMgPSBGQkNPTl9TV0FQKG9wcy0+cm90YXRlLCBpbmZvLT52YXIueXJl
cywgaW5mby0+dmFyLnhyZXMpOw0KICAgICAgICBpbnQgdnlyZXMgPSBGQkNPTl9TV0FQKG9wcy0+
cm90YXRlLCBpbmZvLT52YXIueXJlc192aXJ0dWFsLA0KICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICBpbmZvLT52YXIueHJlc192aXJ0dWFsKTsNCisgICAgICAgaW50IHJvd3MgPSB2
Yy0+dmNfcm93czsNCiANCiAgICAgICAgcC0+dnJvd3MgPSB2eXJlcy9maDsNCi0gICAgICAgaWYg
KHlyZXMgPiAoZmggKiAodmMtPnZjX3Jvd3MgKyAxKSkpDQotICAgICAgICAgICAgICAgcC0+dnJv
d3MgLT0gKHlyZXMgLSAoZmggKiB2Yy0+dmNfcm93cykpIC8gZmg7DQotICAgICAgIGlmICgoeXJl
cyAlIGZoKSAmJiAodnlyZXMgJSBmaCA8IHlyZXMgJSBmaCkpDQorICAgICAgIGlmICgoeXJlcyA+
IChmaCAqIChyb3dzICsgMSkpKSAmJiAodnlyZXMgPj0gKHlyZXMgLSAoZmggKiByb3dzKSkpICYm
IHAtPnZyb3dzKQ0KKyAgICAgICAgICAgICAgIHAtPnZyb3dzIC09ICh5cmVzIC0gKGZoICogcm93
cykpIC8gZmg7DQorICAgICAgIGlmICgoeXJlcyAlIGZoKSAmJiAodnlyZXMgJSBmaCA8IHlyZXMg
JSBmaCkgJiYgcC0+dnJvd3MpDQogICAgICAgICAgICAgICAgcC0+dnJvd3MtLTsNCiB9DQoNCg==
