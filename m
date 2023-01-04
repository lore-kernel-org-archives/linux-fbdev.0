Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7763C46467
	for <linux-fbdev@archiver.kernel.org>; Wed,  4 Jan 2023 08:19:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233383AbjADITc (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 4 Jan 2023 03:19:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbjADITb (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Wed, 4 Jan 2023 03:19:31 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8EBD19297
        for <linux-fbdev@vger.kernel.org>; Wed,  4 Jan 2023 00:19:29 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 8B8DA38DBF;
        Wed,  4 Jan 2023 08:19:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1672820368; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wRCuw/FBpjLFmZlr4t9YLBU/akbtfRaeLolHpVMegfU=;
        b=moBOfYNAWpZteHiDRyBm+aaEvmldyGoq8rVcjvyhPu8gLP4XnyJV4kCECUSNZ6Kn7wPkK2
        ZtewzWdAV82NbjCDK9qT8+jqLApfJTypxUI/PshA87hIsdaNON9w90/IQFY/mtP7VC6fbR
        HXTlV5/thjdEk7IGQ7PWEp6c1AGRBP4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1672820368;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wRCuw/FBpjLFmZlr4t9YLBU/akbtfRaeLolHpVMegfU=;
        b=atsLXFjA7tc6VOT4qTxfuIQI3Deo60lP7ONaXldY0oGyV1jbfWmCZjfFIEOxPu8IjKyhpJ
        qdg7bdQ//YHdesAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6D7F5133D1;
        Wed,  4 Jan 2023 08:19:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ubXZGZA2tWPXFQAAMHmgww
        (envelope-from <tzimmermann@suse.de>); Wed, 04 Jan 2023 08:19:28 +0000
Message-ID: <db1458b3-d109-bcae-b136-d0e1567519e1@suse.de>
Date:   Wed, 4 Jan 2023 09:19:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: Why is mgag200 not used over matroxfb?
Content-Language: en-US
To:     Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     "Z. Liu" <liuzx@knownsec.com>, Helge Deller <deller@gmx.de>,
        linux-fbdev@vger.kernel.org, it+linux-fbdev@molgen.mpg.de
References: <5da53ec5-3a9c-ec87-da20-69f140aaaa6b@molgen.mpg.de>
 <972999d3-b75d-5680-fcef-6e6905c52ac5@suse.de>
 <7b85b832-e6fd-fe42-c6a1-93ebb591383c@molgen.mpg.de>
 <c11a7128-ec34-c497-e012-577a4928dc94@molgen.mpg.de>
From:   Thomas Zimmermann <tzimmermann@suse.de>
In-Reply-To: <c11a7128-ec34-c497-e012-577a4928dc94@molgen.mpg.de>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------sJksckRwE3cHuYz1sdmQt0He"
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------sJksckRwE3cHuYz1sdmQt0He
Content-Type: multipart/mixed; boundary="------------UCeGCWfvKj3rvM20hZkPsPPd";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann@suse.de>
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: "Z. Liu" <liuzx@knownsec.com>, Helge Deller <deller@gmx.de>,
 linux-fbdev@vger.kernel.org, it+linux-fbdev@molgen.mpg.de
Message-ID: <db1458b3-d109-bcae-b136-d0e1567519e1@suse.de>
Subject: Re: Why is mgag200 not used over matroxfb?
References: <5da53ec5-3a9c-ec87-da20-69f140aaaa6b@molgen.mpg.de>
 <972999d3-b75d-5680-fcef-6e6905c52ac5@suse.de>
 <7b85b832-e6fd-fe42-c6a1-93ebb591383c@molgen.mpg.de>
 <c11a7128-ec34-c497-e012-577a4928dc94@molgen.mpg.de>
In-Reply-To: <c11a7128-ec34-c497-e012-577a4928dc94@molgen.mpg.de>

--------------UCeGCWfvKj3rvM20hZkPsPPd
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGkNCg0KQW0gMDMuMDEuMjMgdW0gMTc6MjAgc2NocmllYiBQYXVsIE1lbnplbDoNCj4gRGVh
ciBUaG9tYXMsDQo+IA0KPiANCj4gSSBoYXZlIHRvIGNvcnJlY3QgbXlzZWxmLg0KPiANCj4g
DQo+IEFtIDE2LjEyLjIyIHVtIDE0OjE2IHNjaHJpZWIgUGF1bCBNZW56ZWw6DQo+IA0KPj4g
QW0gMTYuMTIuMjIgdW0gMTM6Mjcgc2NocmllYiBUaG9tYXMgWmltbWVybWFubjoNCj4+DQo+
Pj4gQW0gMTUuMTIuMjIgdW0gMTc6Mzkgc2NocmllYiBQYXVsIE1lbnplbDoNCj4+DQo+PiBb
4oCmXQ0KPj4NCj4+Pj4gQmV0d2VlbiBMaW51eCA1LjEwLjEwMyBhbmQgNS4xMC4xMTAvNS4x
NS43NywgbWF0cml4ZmIgZmFpbHMgdG8gbG9hZC4NCj4+Pg0KPj4+IE9mZi10b3BpYywgYnV0
IHJlbGF0ZWQuIG1hdHJveGZiIGlzIG9ic29sZXRlIGFuZCB0aGVyZSdzIGEgbWFpbnRhaW5l
ZCANCj4+PiBEUk0gcmVwbGFjZW1lbnQgKG1nYWcyMDApIGZvciB0aGlzIGhhcmR3YXJlLg0K
Pj4NCj4+IEkgYWxzbyByZW1lbWJlcmVkIHNvbWV0aGluZyBsaWtlIHRoaXMgaW4gdGhlIGJh
Y2sgb2YgbXkgaGVhZC4gVGhvdWdoIEkgDQo+PiB0aG91Z2h0IGFib3V0IHVzaW5nIHNpbXBs
ZWRybSAoYERSTV9TSU1QTEVEUk1gKSwgd2UgZG8gbm90IGJ1aWxkIHRob3VnaC4NCj4+DQo+
Pj4gSXMgdGhlcmUgYW55dGhpbmcgbWlzc2luZyBmcm9tIG1nYWcyMDAgdGhhdCBwcmV2ZW50
cyB5b3UgZnJvbSBzd2l0Y2hpbmc/DQo+PiBObywgaXQgbG9va3MgbGlrZSB0aGUgbWF0cm94
ZmIgbW9kdWxlcyB0YWtlIHByZWNlZGVuY2Ugb3ZlciB0aGUgDQo+PiBtZ2FnMjAwIG1vZHVs
ZToNCj4+DQo+PiDCoMKgwqDCoCAkIGdyZXAgLWUgRkJfTUFUUk9YIC1lIE1HQUcgL2Jvb3Qv
Y29uZmlnLTUuMTUuNzcubXg2NC40NDANCj4+IMKgwqDCoMKgIENPTkZJR19EUk1fTUdBRzIw
MD1tDQo+PiDCoMKgwqDCoCBDT05GSUdfRkJfTUFUUk9YPW0NCj4+IMKgwqDCoMKgIENPTkZJ
R19GQl9NQVRST1hfTUlMTEVOSVVNPXkNCj4+IMKgwqDCoMKgIENPTkZJR19GQl9NQVRST1hf
TVlTVElRVUU9eQ0KPj4gwqDCoMKgwqAgQ09ORklHX0ZCX01BVFJPWF9HPXkNCj4+IMKgwqDC
oMKgIENPTkZJR19GQl9NQVRST1hfSTJDPW0NCj4+IMKgwqDCoMKgICMgQ09ORklHX0ZCX01B
VFJPWF9NQVZFTiBpcyBub3Qgc2V0DQo+Pg0KPj4gwqDCoMKgwqAgJCBsc21vZCB8IGdyZXAg
bWF0cm94DQo+PiDCoMKgwqDCoCBtYXRyb3hmYl9iYXNlwqDCoMKgwqDCoMKgwqDCoMKgIDI4
NjcywqAgMA0KPj4gwqDCoMKgwqAgbWF0cm94ZmJfZzQ1MMKgwqDCoMKgwqDCoMKgwqDCoCAx
NjM4NMKgIDEgbWF0cm94ZmJfYmFzZQ0KPj4gwqDCoMKgwqAgbWF0cm94ZmJfVGkzMDI2wqDC
oMKgwqDCoMKgwqAgMTYzODTCoCAxIG1hdHJveGZiX2Jhc2UNCj4+IMKgwqDCoMKgIG1hdHJv
eGZiX2FjY2VswqDCoMKgwqDCoMKgwqDCoCAxNjM4NMKgIDEgbWF0cm94ZmJfYmFzZQ0KPj4g
wqDCoMKgwqAgbWF0cm94ZmJfREFDMTA2NMKgwqDCoMKgwqDCoCAyMDQ4MMKgIDEgbWF0cm94
ZmJfYmFzZQ0KPj4gwqDCoMKgwqAgZzQ1MF9wbGzCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIDE2Mzg0wqAgMiBtYXRyb3hmYl9nNDUwLG1hdHJveGZiX0RBQzEwNjQNCj4+IMKgwqDC
oMKgIG1hdHJveGZiX21pc2PCoMKgwqDCoMKgwqDCoMKgwqAgMjA0ODDCoCA1IA0KPj4gZzQ1
MF9wbGwsbWF0cm94ZmJfVGkzMDI2LG1hdHJveGZiX2Jhc2UsbWF0cm94ZmJfZzQ1MCxtYXRy
b3hmYl9EQUMxMDY0DQo+IA0KPiBUaGUgc2VhcmNoIHN0cmluZyB3YXMgaW5jb3JyZWN0LiBU
aGUgbW9kdWxlIG1nYWcyMDAsIGlzIGxvYWRlZDoNCj4gDQo+ICDCoMKgwqAgJCBsc21vZCB8
IGdyZXAgbWdhZzIwMA0KPiAgwqDCoMKgIG1nYWcyMDDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgMzY4NjTCoCAwDQo+ICDCoMKgwqAgZHJtX2ttc19oZWxwZXLCoMKgwqDCoMKg
wqDCoCAyNDE2NjTCoCAzIG1nYWcyMDANCj4gIMKgwqDCoCBkcm3CoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgNTI0Mjg4wqAgMyBkcm1fa21zX2hlbHBlcixtZ2FnMjAw
DQo+ICDCoMKgwqAgaTJjX2FsZ29fYml0wqDCoMKgwqDCoMKgwqDCoMKgwqAgMTYzODTCoCAx
IG1nYWcyMDANCj4gDQo+IGFuZCBpdCBpcyB1c2VkIGFjY29yZGluZyB0byBgbHNwY2lgOg0K
PiANCj4gIMKgwqDCoCAkIGxzcGNpIC1ubiAtayAtcyAwOTowMy4NCj4gIMKgwqDCoCAwOTow
My4wIFZHQSBjb21wYXRpYmxlIGNvbnRyb2xsZXIgWzAzMDBdOiBNYXRyb3ggRWxlY3Ryb25p
Y3MgDQo+IFN5c3RlbXMgTHRkLiBNR0EgRzIwMGVXIFdQQ000NTAgWzEwMmI6MDUzMl0gKHJl
diAwYSkNCj4gIMKgwqDCoMKgwqDCoMKgIERldmljZU5hbWU6IEVtYmVkZGVkIFZpZGVvDQo+
ICDCoMKgwqDCoMKgwqDCoCBTdWJzeXN0ZW06IERlbGwgTUdBIEcyMDBlVyBXUENNNDUwIFsx
MDI4OjAyZDNdDQo+ICDCoMKgwqDCoMKgwqDCoCBLZXJuZWwgZHJpdmVyIGluIHVzZTogbWdh
ZzIwMA0KPiAgwqDCoMKgwqDCoMKgwqAgS2VybmVsIG1vZHVsZXM6IG1hdHJveGZiX2Jhc2Us
IG1nYWcyMDANCj4gDQo+IFNvLCBpdCB3YXMgb25seSBhIGNvc21ldGljIGlzc3VlLg0KDQpU
aGFua3MgZm9yIGFsbCB0aGUgZmVlZGJhY2suIFRoZSBvdXRwdXQgc2hvd24gaW4geW91ciBv
cmlnaW5hbCBidWcgDQpyZXBvcnQgY2FtZSBmcm9tIG1hdHJveGZiLCBzbyBpdCBtdXN0IGhh
dmUgYmVlbiBsb2FkZWQgdGhlbi4gSSBkb24ndCANCmtub3cgd2hhdCB0aGUgcHJlZmVycmVk
IG9yZGVyIGlzIGlmIG11bHRpcGxlIG1vZHVsZXMgc2VydmUgdGhlIHNhbWUgDQpoYXJkd2Fy
ZS4gTWF5YmUgaXQncyByYW5kb20uDQoNCkJlc3QgcmVnYXJkcw0KVGhvbWFzDQoNCj4gDQo+
IA0KPiBLaW5kIHJlZ2FyZHMsDQo+IA0KPiBQYXVsDQoNCi0tIA0KVGhvbWFzIFppbW1lcm1h
bm4NCkdyYXBoaWNzIERyaXZlciBEZXZlbG9wZXINClNVU0UgU29mdHdhcmUgU29sdXRpb25z
IEdlcm1hbnkgR21iSA0KTWF4ZmVsZHN0ci4gNSwgOTA0MDkgTsO8cm5iZXJnLCBHZXJtYW55
DQooSFJCIDM2ODA5LCBBRyBOw7xybmJlcmcpDQpHZXNjaMOkZnRzZsO8aHJlcjogSXZvIFRv
dGV2DQo=

--------------UCeGCWfvKj3rvM20hZkPsPPd--

--------------sJksckRwE3cHuYz1sdmQt0He
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEExndm/fpuMUdwYFFolh/E3EQov+AFAmO1NpAFAwAAAAAACgkQlh/E3EQov+Bu
SRAArjiC601rJfC4f3wtoQiPu195JhfiVXsW7+F3Ag0Jv7fE96OuCBXcNinFPqzxk3xQ2PXiy8TM
OWKY88CjntZeJRRGKZcRYivuhxM/bnXCVKORZan6E4ZtXpa5efgCTCkLZr1MSzehfcRz4hnbEUtf
Ean1Vyv+GVyXwEYBJgptY9+kxKo4gzRYYai/bpgmNcgTiBWwovXxa95960SVmK9qYWpjESQLqVP6
wGTYQey6Op0DzQxt9s0FFmZxS+EqmSVUHSon2xMu9Y2iAjmLUa7TlerDttwYbbuHeRouTSxjQjiV
8vJKagmFoMU7b7YiVLcIaJfhLPYo+EqjYMBnmKjfs/0ILj1lW5MDY8zUeenEHqCukC6GxFvBt7TI
0c6GA6mdDx+A9qkZQYcvXAfuKNIbFPr4bvMBHmK1FKR0vHaIzlychcv3ZzGmJ+11VL7RO3X1GWOQ
tRBapskam+aiuArWCw6PpkvEb5PrOZVP+milONUsQYp+7PWM6hf1sy9+cySAn+aUPVhLPORUw1zK
Ls47e35w3IANDZIQ9p/rQY5ZzZ9bIcZFTR5Ci+yMBtNyYwthXBoJ8yzpQ5rJX1MCHzC3qiUDj1Jv
ap2rg2e1ak0Pv+qJbA0sGsBEQeiYpHxKAFyQFwu4ySk+L95gXNKNB6XMQyd9rbpIsgKhlDH0HbA6
iOY=
=sjxE
-----END PGP SIGNATURE-----

--------------sJksckRwE3cHuYz1sdmQt0He--
