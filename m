Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64538C4338F
	for <linux-fbdev@archiver.kernel.org>; Tue, 27 Jul 2021 02:01:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4394960C41
	for <linux-fbdev@archiver.kernel.org>; Tue, 27 Jul 2021 02:01:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234271AbhG0BUb (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 26 Jul 2021 21:20:31 -0400
Received: from mail4.tencent.com ([183.57.53.109]:35243 "EHLO
        mail4.tencent.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233249AbhG0BUb (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Mon, 26 Jul 2021 21:20:31 -0400
X-Greylist: delayed 462 seconds by postgrey-1.27 at vger.kernel.org; Mon, 26 Jul 2021 21:20:29 EDT
Received: from EX-SZ018.tencent.com (unknown [10.28.6.39])
        by mail4.tencent.com (Postfix) with ESMTP id CB61E722F8;
        Tue, 27 Jul 2021 09:53:13 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tencent.com;
        s=s202002; t=1627350793;
        bh=8Cbopqcu32jcnUOGgyQG+1EQ4NBoRxltQXtssLYctGE=;
        h=From:To:CC:Subject:Date:References:In-Reply-To;
        b=TB5FK46xaroIBoP/Qb1ajWe00eI1+hD/EFx33mgYm4sN8CJquVjdrfvnCMRLrgN0e
         jWzWV5i9+xTImNQSwsg0naXccxfHu0a/LAHlgQfovG3FlHkrHg2YLC45TaBzgeBUFW
         6CRBepZO89IH+26rzNCar+aDfAdwKmB0rhLtFtlo=
Received: from EX-SZ031.tencent.com (10.28.6.107) by EX-SZ018.tencent.com
 (10.28.6.39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Tue, 27 Jul
 2021 09:53:13 +0800
Received: from EX-SZ030.tencent.com (10.28.6.105) by EX-SZ031.tencent.com
 (10.28.6.107) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Tue, 27 Jul
 2021 09:53:13 +0800
Received: from EX-SZ030.tencent.com ([fe80::cd97:7a16:11e6:d0c8]) by
 EX-SZ030.tencent.com ([fe80::cd97:7a16:11e6:d0c8%5]) with mapi id
 15.01.2242.008; Tue, 27 Jul 2021 09:53:13 +0800
From:   =?utf-8?B?dGNzX2tlcm5lbCjohb7orq/kupHlhoXmoLjlvIDlj5HogIUp?= 
        <tcs_kernel@tencent.com>
To:     Sam Ravnborg <sam@ravnborg.org>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "daniel.vetter@ffwll.ch" <daniel.vetter@ffwll.ch>,
        "yepeilin.cs@gmail.com" <yepeilin.cs@gmail.com>,
        "penguin-kernel@I-love.SAKURA.ne.jp" 
        <penguin-kernel@i-love.sakura.ne.jp>,
        "tzimmermann@suse.de" <tzimmermann@suse.de>,
        "george.kennedy@oracle.com" <george.kennedy@oracle.com>,
        "ducheng2@gmail.com" <ducheng2@gmail.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [Internet]Re: [PATCH] fbcon: Out-Of-Bounds write in
 sys_imageblit, add range check
Thread-Topic: [Internet]Re: [PATCH] fbcon: Out-Of-Bounds write in
 sys_imageblit, add range check
Thread-Index: AQHXghHvrDWkYfnua06MBXDuWeAYa6tUvrSAgAFReAA=
Date:   Tue, 27 Jul 2021 01:53:13 +0000
Message-ID: <28F2D8E8-B519-40F6-B6CD-98A0FAD67CD7@tencent.com>
References: <D5DF8A1C-5FA2-426B-AAB4-3199AEA0A02E@tencent.com>
 <YP68cQ4WVVusCv0N@ravnborg.org>
In-Reply-To: <YP68cQ4WVVusCv0N@ravnborg.org>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.28.2.14]
Content-Type: text/plain; charset="utf-8"
Content-ID: <885012B3419FBE45BBC5BA3CE990EBB8@tencent.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

eXJlcyBhbmQgdnlyZXMgY2FuIGJlIGNvbnRyb2xsZWQgYnkgdXNlciBtb2RlIHBhcmFtYXRlcnMs
IGFuZCBjYXVzZSBwLT52cm93cyB0byBiZWNvbWUgYSBuZWdhdGl2ZSB2YWx1ZS4gV2hpbGUgdGhp
cyB2YWx1ZSBiZSBwYXNzZWQgdG8gcmVhbF95IGZ1bmN0aW9uLCB0aGUgeXBvcyB3aWxsIGJlIG91
dCBvZiBzY3JlZW4gcmFuZ2UuDQpUaGlzIGlzIGFuIG91dC1vZi1ib3VuZHMgd3JpdGUgYnVnLg0K
SSB0aGluayB1cGRhdGVzY3JvbGxtb2RlIGlzIHRoZSByaWdodCBwbGFjZSB0byB2YWxpZGF0ZSB2
YWx1ZXMgc3VwcGxpZWQgYnkgYSB1c2VyIGlvY3RsLCBiZWNhdXNlIG9ubHkgaGVyZSBtYWtlcyAt
LW9wZXJhdGlvbixhbmQgMCBpcyBhIGxlZ2FsIHZhbHVlIGJlZm9yZSB0aGF0Lg0KDQpTaWduZWQt
b2ZmLWJ5OiBUZW5jZW50IENsb3VkIFN5c3RlbSB0Y3Nfa2VybmVsQHRlbmNlbnQuY29tDQoNCmRp
ZmYgLS1naXQgYS9kcml2ZXJzL3ZpZGVvL2ZiZGV2L2NvcmUvZmJjb24uYyBiL2RyaXZlcnMvdmlk
ZW8vZmJkZXYvY29yZS9mYmNvbi5jDQppbmRleCAyMmJiMzg5MmY2YmQuLjA5NzBkZTQ2NzgyZiAx
MDA2NDQNCi0tLSBhL2RyaXZlcnMvdmlkZW8vZmJkZXYvY29yZS9mYmNvbi5jDQorKysgYi9kcml2
ZXJzL3ZpZGVvL2ZiZGV2L2NvcmUvZmJjb24uYw0KQEAgLTE5NTYsMTEgKzE5NTYsMTIgQEAgc3Rh
dGljIHZvaWQgdXBkYXRlc2Nyb2xsbW9kZShzdHJ1Y3QgZmJjb25fZGlzcGxheSAqcCwNCiAgICAg
ICAgaW50IHlyZXMgPSBGQkNPTl9TV0FQKG9wcy0+cm90YXRlLCBpbmZvLT52YXIueXJlcywgaW5m
by0+dmFyLnhyZXMpOw0KICAgICAgICBpbnQgdnlyZXMgPSBGQkNPTl9TV0FQKG9wcy0+cm90YXRl
LCBpbmZvLT52YXIueXJlc192aXJ0dWFsLA0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICBpbmZvLT52YXIueHJlc192aXJ0dWFsKTsNCisgICAgICAgaW50IHJvd3MgPSB2Yy0+dmNf
cm93czsNCiANCiAgICAgICAgcC0+dnJvd3MgPSB2eXJlcy9maDsNCi0gICAgICAgaWYgKHlyZXMg
PiAoZmggKiAodmMtPnZjX3Jvd3MgKyAxKSkpDQotICAgICAgICAgICAgICAgcC0+dnJvd3MgLT0g
KHlyZXMgLSAoZmggKiB2Yy0+dmNfcm93cykpIC8gZmg7DQotICAgICAgIGlmICgoeXJlcyAlIGZo
KSAmJiAodnlyZXMgJSBmaCA8IHlyZXMgJSBmaCkpDQorICAgICAgIGlmICgoeXJlcyA+IChmaCAq
IChyb3dzICsgMSkpKSAmJiAodnlyZXMgPj0gKHlyZXMgLSAoZmggKiByb3dzKSkpICYmIHAtPnZy
b3dzKQ0KKyAgICAgICAgICAgICAgIHAtPnZyb3dzIC09ICh5cmVzIC0gKGZoICogcm93cykpIC8g
Zmg7DQorICAgICAgIGlmICgoeXJlcyAlIGZoKSAmJiAodnlyZXMgJSBmaCA8IHlyZXMgJSBmaCkg
JiYgcC0+dnJvd3MpDQogICAgICAgICAgICAgICAgcC0+dnJvd3MtLTsNCiB9DQoNCu+7v+WcqCAy
MDIxLzcvMjYgMjE6NDXvvIzigJxTYW0gUmF2bmJvcmfigJ08c2FtQHJhdm5ib3JnLm9yZz4g5YaZ
5YWlOg0KDQogICAgSGksDQogICAgT24gTW9uLCBKdWwgMjYsIDIwMjEgYXQgMTE6MzI6MzdBTSAr
MDAwMCwgdGNzX2tlcm5lbCjohb7orq/kupHlhoXmoLjlvIDlj5HogIUpIHdyb3RlOg0KICAgID4g
eXJlcyBhbmQgdnlyZXMgY2FuIGJlIGNvbnRyb2xsZWQgYnkgdXNlciBtb2RlIHBhcmFtYXRlcnMs
IGFuZCBjYXVzZSBwLT52cm93cyB0byBiZWNvbWUgYSBuZWdhdGl2ZSB2YWx1ZS4gV2hpbGUgdGhp
cyB2YWx1ZSBiZSBwYXNzZWQgdG8gcmVhbF95IGZ1bmN0aW9uLCB0aGUgeXBvcyB3aWxsIGJlIG91
dCBvZiBzY3JlZW4gcmFuZ2UuDQogICAgPiBUaGlzIGlzIGFuIG91dC1vZi1ib3VuZHMgd3JpdGUg
YnVnLg0KDQogICAgUGxlYXNlIGludmVzdGlnYXRlIGlmIHlvdSBjYW4gdmFsaWRhdGUgdGhlIHVz
ZXItc3VwcGxpZWQgdmFsdWVzIGZvciB5cmVzDQogICAgYW5kIHZ5cmVzIGVhcmxpZXIgc28gdGhl
IGNvZGUgbmV2ZXIgcmVhY2hlcyB0aGUgYmVsb3cgc3RhdGVtZW50cy4NCiAgICBUaGlzIHdvdWxk
IGFsc28gbWFrZSBpdCBtdWNoIG1vcmUgZXhwbGljaXQgd2hhdCBpcyBnb2luZyBvbi4NCg0KICAg
IAlTYW0NCg0KICAgID4gDQogICAgPiANCiAgICA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3ZpZGVv
L2ZiZGV2L2NvcmUvZmJjb24uYyBiL2RyaXZlcnMvdmlkZW8vZmJkZXYvY29yZS9mYmNvbi5jDQog
ICAgPiBpbmRleCAyMmJiMzg5MmY2YmQuLjA5NzBkZTQ2NzgyZiAxMDA2NDQNCiAgICA+IC0tLSBh
L2RyaXZlcnMvdmlkZW8vZmJkZXYvY29yZS9mYmNvbi5jDQogICAgPiArKysgYi9kcml2ZXJzL3Zp
ZGVvL2ZiZGV2L2NvcmUvZmJjb24uYw0KICAgID4gQEAgLTE5NTYsMTEgKzE5NTYsMTIgQEAgc3Rh
dGljIHZvaWQgdXBkYXRlc2Nyb2xsbW9kZShzdHJ1Y3QgZmJjb25fZGlzcGxheSAqcCwNCiAgICA+
ICAgICAgICAgaW50IHlyZXMgPSBGQkNPTl9TV0FQKG9wcy0+cm90YXRlLCBpbmZvLT52YXIueXJl
cywgaW5mby0+dmFyLnhyZXMpOw0KICAgID4gICAgICAgICBpbnQgdnlyZXMgPSBGQkNPTl9TV0FQ
KG9wcy0+cm90YXRlLCBpbmZvLT52YXIueXJlc192aXJ0dWFsLA0KICAgID4gICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICBpbmZvLT52YXIueHJlc192aXJ0dWFsKTsNCiAgICA+ICsg
ICAgICAgaW50IHJvd3MgPSB2Yy0+dmNfcm93czsNCiAgICA+ICANCiAgICA+ICAgICAgICAgcC0+
dnJvd3MgPSB2eXJlcy9maDsNCiAgICA+IC0gICAgICAgaWYgKHlyZXMgPiAoZmggKiAodmMtPnZj
X3Jvd3MgKyAxKSkpDQogICAgPiAtICAgICAgICAgICAgICAgcC0+dnJvd3MgLT0gKHlyZXMgLSAo
ZmggKiB2Yy0+dmNfcm93cykpIC8gZmg7DQogICAgPiAtICAgICAgIGlmICgoeXJlcyAlIGZoKSAm
JiAodnlyZXMgJSBmaCA8IHlyZXMgJSBmaCkpDQogICAgPiArICAgICAgIGlmICgoeXJlcyA+IChm
aCAqIChyb3dzICsgMSkpKSAmJiAodnlyZXMgPj0gKHlyZXMgLSAoZmggKiByb3dzKSkpICYmIHAt
PnZyb3dzKQ0KICAgID4gKyAgICAgICAgICAgICAgIHAtPnZyb3dzIC09ICh5cmVzIC0gKGZoICog
cm93cykpIC8gZmg7DQogICAgPiArICAgICAgIGlmICgoeXJlcyAlIGZoKSAmJiAodnlyZXMgJSBm
aCA8IHlyZXMgJSBmaCkgJiYgcC0+dnJvd3MpDQogICAgPiAgICAgICAgICAgICAgICAgcC0+dnJv
d3MtLTsNCiAgICA+ICB9DQogICAgPiANCg0KDQo=
