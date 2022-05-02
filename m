Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 437E1C433FE
	for <linux-fbdev@archiver.kernel.org>; Mon,  2 May 2022 07:24:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344735AbiEBH1j (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 2 May 2022 03:27:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358534AbiEBH1i (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Mon, 2 May 2022 03:27:38 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C72E17A94
        for <linux-fbdev@vger.kernel.org>; Mon,  2 May 2022 00:24:10 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 03B731F894;
        Mon,  2 May 2022 07:24:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1651476249; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ixVtmWvWzkh6HsgOWGjDXJ6bi1x5u28xrHg6exGXCOA=;
        b=pMvT2NvzWIjTSHdK0W4L1NMw2jJEB+qWUrys6FfrodnsGY1D0Ckq/DmBp9z0I7+32d4pSq
        N49bW/ky/5oDCB9K5gMvMQnzmhUJc6erHLink1AcsH3hT3aOCoyV953ESRxW8L4DwS9b0T
        xIbi9jVnMZpuHb/tR9kwOYYwdBGuSKY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1651476249;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ixVtmWvWzkh6HsgOWGjDXJ6bi1x5u28xrHg6exGXCOA=;
        b=zO2U1gnNmrVaPBGzXKWTT+ecX4iXCAzmU9Ua+UdhPW2V7+KuASab+kq0g560A2uqyZEXq4
        DlKB3jbJ1dLEvzCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D4FA613491;
        Mon,  2 May 2022 07:24:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Nb0VMxiHb2KLcwAAMHmgww
        (envelope-from <tzimmermann@suse.de>); Mon, 02 May 2022 07:24:08 +0000
Message-ID: <ab099144-2db2-caae-7a59-94211111a6cf@suse.de>
Date:   Mon, 2 May 2022 09:24:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH] video: fbdev: don't remove firmware fb device if it is
 busy
Content-Language: en-US
To:     Junxiao Chang <junxiao.chang@intel.com>,
        linux-fbdev@vger.kernel.org
Cc:     lethal@linux-sh.org, patchwork-bot@kernel.org, deller@gmx.de,
        lili.li@intel.com
References: <20220430025749.2320824-1-junxiao.chang@intel.com>
From:   Thomas Zimmermann <tzimmermann@suse.de>
In-Reply-To: <20220430025749.2320824-1-junxiao.chang@intel.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------BvbCRMcmfN947UPFJ0CqdOMI"
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------BvbCRMcmfN947UPFJ0CqdOMI
Content-Type: multipart/mixed; boundary="------------ynmIa3qwJYwEYRK0Qprjv7Gx";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann@suse.de>
To: Junxiao Chang <junxiao.chang@intel.com>, linux-fbdev@vger.kernel.org
Cc: lethal@linux-sh.org, patchwork-bot@kernel.org, deller@gmx.de,
 lili.li@intel.com
Message-ID: <ab099144-2db2-caae-7a59-94211111a6cf@suse.de>
Subject: Re: [PATCH] video: fbdev: don't remove firmware fb device if it is
 busy
References: <20220430025749.2320824-1-junxiao.chang@intel.com>
In-Reply-To: <20220430025749.2320824-1-junxiao.chang@intel.com>

--------------ynmIa3qwJYwEYRK0Qprjv7Gx
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGkNCg0KQW0gMzAuMDQuMjIgdW0gMDQ6NTcgc2NocmllYiBKdW54aWFvIENoYW5nOg0KPiBX
aGVuIGZpcm13YXJlIGZyYW1lYnVmZmVyIGlzIGluIHVzZSwgZG9uJ3QgcmVtb3ZlIGl0cyBw
bGF0Zm9ybQ0KPiBkZXZpY2UuIE9yIGVsc2UgaXRzIGZiX2luZm8gYnVmZmVyIGlzIHJlbGVh
c2VkIGJ5IHBsYXRmb3JtIHJlbW92ZQ0KPiBob29rIHdoaWxlIGRldmljZSBpcyBzdGlsbCBv
cGVuZWQuIFRoaXMgaW50cm9kdWNlcyB1c2UgYWZ0ZXIgZnJlZQ0KPiBpc3N1ZS4NCg0KV2hl
biBleGFjdGx5IGRvZXMgdGhpcyBoYXBwZW4/IERvIHlvdSBoYXZlIGEgcmVsaWFibGUgd2F5
IG9mIHJlcHJvZHVjaW5nIGl0Pw0KDQpCZXN0IHJlZ2FyZHMNClRob21hcw0KDQo+IA0KPiBB
IGtlcm5lbCBwYW5pYyBleGFtcGxlOg0KPiBDUFU6IDIgUElEOiAzNDI1IENvbW06IHBzcGxh
c2ggVGFpbnRlZDogRyAgICAgVSAgVyAgICAgNS4xOC4wLXJjMw0KPiBIYXJkd2FyZSBuYW1l
OiBJbnRlbCBDbGllbnQgUGxhdGZvcm0vQURQLVMgRERSNSBVRElNTSBDUkINCj4gUklQOiAw
MDEwOm5hdGl2ZV9xdWV1ZWRfc3Bpbl9sb2NrX3Nsb3dwYXRoKzB4MWM3LzB4MjEwDQo+IFJT
UDogMDAxODpmZmZmYjNhMGMwYzJmZGIwIEVGTEFHUzogMDAwMTAyMDYNCj4gUkFYOiAwMDJk
YzA3NGZmNWMwOTg4IFJCWDogZmZmZjkyZTk4N2E1ZDgxOCBSQ1g6IGZmZmY5MmU5ODliYTlm
NDANCj4gUkRYOiAwMDAwMDAwMDAwMDAyMDY3IFJTSTogZmZmZmZmZmY4NjQzNDRmMSBSREk6
IGZmZmZmZmZmODY0NDE4M2MNCj4gUkJQOiBmZmZmOTJmMTBmNGFiZDQwIFIwODogMDAwMDAw
MDAwMDAwMDAwMSBSMDk6IGZmZmY5MmU5ODZkYzIxODgNCj4gLi4uDQo+IENhbGwgVHJhY2U6
DQo+ICAgPFRBU0s+DQo+ICAgX3Jhd19zcGluX2xvY2srMHgyYy8weDMwDQo+ICAgX19tdXRl
eF9sb2NrLmNvbnN0cHJvcC4wKzB4MTc1LzB4NGYwDQo+ICAgPyBfcmF3X3NwaW5fdW5sb2Nr
KzB4MTUvMHgzMA0KPiAgID8gbGlzdF9scnVfYWRkKzB4MTI0LzB4MTYwDQo+ICAgZmJfcmVs
ZWFzZSsweDFiLzB4NjANCj4gICBfX2ZwdXQrMHg4OS8weDI0MA0KPiAgIHRhc2tfd29ya19y
dW4rMHg1OS8weDkwDQo+ICAgZG9fZXhpdCsweDM0My8weGFmMA0KPiAgIGRvX2dyb3VwX2V4
aXQrMHgyZC8weDkwDQo+ICAgX194NjRfc3lzX2V4aXRfZ3JvdXArMHgxNC8weDIwDQo+ICAg
ZG9fc3lzY2FsbF82NCsweDQwLzB4OTANCj4gICBlbnRyeV9TWVNDQUxMXzY0X2FmdGVyX2h3
ZnJhbWUrMHg0NC8weGFlDQo+IA0KPiBGaXhlczogMjc1OTlhYWNiYWVmICgiZmJkZXY6IEhv
dC11bnBsdWcgZmlybXdhcmUgZmIgZGV2aWNlcyBvbiBmb3JjZWQgcmVtb3ZhbCIpDQo+IFNp
Z25lZC1vZmYtYnk6IEp1bnhpYW8gQ2hhbmcgPGp1bnhpYW8uY2hhbmdAaW50ZWwuY29tPg0K
PiBTaWduZWQtb2ZmLWJ5OiBMaWxpIExpIDxsaWxpLmxpQGludGVsLmNvbT4NCj4gLS0tDQo+
ICAgZHJpdmVycy92aWRlby9mYmRldi9jb3JlL2ZibWVtLmMgfCA0ICsrKy0NCj4gICAxIGZp
bGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+IA0KPiBkaWZm
IC0tZ2l0IGEvZHJpdmVycy92aWRlby9mYmRldi9jb3JlL2ZibWVtLmMgYi9kcml2ZXJzL3Zp
ZGVvL2ZiZGV2L2NvcmUvZmJtZW0uYw0KPiBpbmRleCBhNmJiMGU0MzgyMTYuLmZmOWI5ODMw
YjM5OCAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy92aWRlby9mYmRldi9jb3JlL2ZibWVtLmMN
Cj4gKysrIGIvZHJpdmVycy92aWRlby9mYmRldi9jb3JlL2ZibWVtLmMNCj4gQEAgLTE1ODYs
NyArMTU4Niw5IEBAIHN0YXRpYyB2b2lkIGRvX3JlbW92ZV9jb25mbGljdGluZ19mcmFtZWJ1
ZmZlcnMoc3RydWN0IGFwZXJ0dXJlc19zdHJ1Y3QgKmEsDQo+ICAgCQkJCSAqIGZyYW1lYnVm
ZmVyIGFzIGJlZm9yZSB3aXRob3V0IHdhcm5pbmcuDQo+ICAgCQkJCSAqLw0KPiAgIAkJCQlk
b191bnJlZ2lzdGVyX2ZyYW1lYnVmZmVyKHJlZ2lzdGVyZWRfZmJbaV0pOw0KPiAtCQkJfSBl
bHNlIGlmIChkZXZfaXNfcGxhdGZvcm0oZGV2aWNlKSkgew0KPiArCQkJfSBlbHNlIGlmIChk
ZXZfaXNfcGxhdGZvcm0oZGV2aWNlKSAmJg0KPiArCQkJCQlyZWZjb3VudF9yZWFkKCZyZWdp
c3RlcmVkX2ZiW2ldLT5jb3VudCkgPT0gMSkgew0KPiArCQkJCS8qIFJlbW92ZSBwbGF0Zm9y
bSBkZXZpY2UgaWYgaXQgaXMgbm90IGluIHVzZS4gKi8NCj4gICAJCQkJcmVnaXN0ZXJlZF9m
YltpXS0+Zm9yY2VkX291dCA9IHRydWU7DQo+ICAgCQkJCXBsYXRmb3JtX2RldmljZV91bnJl
Z2lzdGVyKHRvX3BsYXRmb3JtX2RldmljZShkZXZpY2UpKTsNCj4gICAJCQl9IGVsc2Ugew0K
DQotLSANClRob21hcyBaaW1tZXJtYW5uDQpHcmFwaGljcyBEcml2ZXIgRGV2ZWxvcGVyDQpT
VVNFIFNvZnR3YXJlIFNvbHV0aW9ucyBHZXJtYW55IEdtYkgNCk1heGZlbGRzdHIuIDUsIDkw
NDA5IE7DvHJuYmVyZywgR2VybWFueQ0KKEhSQiAzNjgwOSwgQUcgTsO8cm5iZXJnKQ0KR2Vz
Y2jDpGZ0c2bDvGhyZXI6IEl2byBUb3Rldg0K

--------------ynmIa3qwJYwEYRK0Qprjv7Gx--

--------------BvbCRMcmfN947UPFJ0CqdOMI
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEExndm/fpuMUdwYFFolh/E3EQov+AFAmJvhxcFAwAAAAAACgkQlh/E3EQov+AP
shAAzAIui0ZhnXkAi8+cd/g7JJxOpdakwAQ4TSJgGFpLZUt1A7wk31dBaFThWjoTw7X6e1nWpBQO
8/WkY/Qfnl94WXlIQQJ/psrK52UAvr+8MPo0mTcosE6m4NlWsFqBtJIIE15TS6NDm+rXujsIEtr1
hTI4s7x79IDLOh3+cX3cgbezJ9HhdSaxXkYxOT5wXXnukJA8mw+S5+hs+6BffnB5RGlfJRe1fcaX
dLI0+2HDbii+Bcu562I31fgVJHAbgNDDlYXP/7WwSEjo+WGiGfE1KDclLDNO3CrjflgOSDSKt1hJ
Askpwz2EN7eyJY2VP511syPcj0UvtFNTGMCwrocBWbCQusP7arFJjEDOZEicCEfQo76Eyh86m1DE
v28Z8SGldE/BaxaJ89F/8CA2klQ33dbKtgeh9Il4yt227SBUi/iJ+xJcwtukPS3fKjY3/JFw9714
xX1bx8Vy4HSvEcB8zbDtItsbksp2kU5/7LegmlZR/OaxOOTeS2WqVhVcuLmPDzTkIbEAv3GrS0GO
V3lCh2/joDLpoBE3IedR9g63ertlWmEfadxvJNxK4Ruc9unkF1Bk7hzjEp14CInRr8GGU47TBMzC
aI7lryxY//qJEycqgSPKm7X4At1n2UDfZbP7k0TJUHPNhlMKn+g1QJjq26v2vgFAj5OAa4TEFYOj
rp0=
=XZil
-----END PGP SIGNATURE-----

--------------BvbCRMcmfN947UPFJ0CqdOMI--
