Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D5AEC4332F
	for <linux-fbdev@archiver.kernel.org>; Fri, 16 Dec 2022 12:27:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230174AbiLPM1p (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Fri, 16 Dec 2022 07:27:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbiLPM1n (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Fri, 16 Dec 2022 07:27:43 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47EEAE012
        for <linux-fbdev@vger.kernel.org>; Fri, 16 Dec 2022 04:27:42 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 038393404F;
        Fri, 16 Dec 2022 12:27:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1671193661; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7bZzBmiu1RgFG2TbPgHZCLoahMeulMJ19F8KSyjseJE=;
        b=NxFpWYV9BrHG3OIsx6n+qtkGScgZDRVGeYA/jlcu5ZvpDTvuh8t68xep7aDNCCeTeoDEA8
        usbte5ha2Saog1tbJa3JUUiwNn8o+23eBJyJM3vkfnZd1d3Ji/uJCC3SKTH0t/FR9AYZMN
        4Eb1aQBT1Vf9xl4n3y28XxHoK2oiquA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1671193661;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7bZzBmiu1RgFG2TbPgHZCLoahMeulMJ19F8KSyjseJE=;
        b=jEkX+sxAHzvT9h7C6DIgCUtn1wgXQey/BLnMUZS0RIGptwGxfcyW4Qi7kkAnQ3+cfAFSM1
        QkHBmYcTdTwv3rBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DA003138FD;
        Fri, 16 Dec 2022 12:27:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id TOQCNDxknGPOKwAAMHmgww
        (envelope-from <tzimmermann@suse.de>); Fri, 16 Dec 2022 12:27:40 +0000
Message-ID: <972999d3-b75d-5680-fcef-6e6905c52ac5@suse.de>
Date:   Fri, 16 Dec 2022 13:27:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: matroxfb: cannot determine memory size
To:     Paul Menzel <pmenzel@molgen.mpg.de>, linux-fbdev@vger.kernel.org
Cc:     "Z. Liu" <liuzx@knownsec.com>, Helge Deller <deller@gmx.de>,
        it+linux-fbdev@molgen.mpg.de
References: <5da53ec5-3a9c-ec87-da20-69f140aaaa6b@molgen.mpg.de>
Content-Language: en-US
From:   Thomas Zimmermann <tzimmermann@suse.de>
In-Reply-To: <5da53ec5-3a9c-ec87-da20-69f140aaaa6b@molgen.mpg.de>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------tofzjITEdE9UjXVF0EcRYvI7"
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------tofzjITEdE9UjXVF0EcRYvI7
Content-Type: multipart/mixed; boundary="------------GCLJkxPJ62ZRNF3bkFl6Bpq1";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann@suse.de>
To: Paul Menzel <pmenzel@molgen.mpg.de>, linux-fbdev@vger.kernel.org
Cc: "Z. Liu" <liuzx@knownsec.com>, Helge Deller <deller@gmx.de>,
 it+linux-fbdev@molgen.mpg.de
Message-ID: <972999d3-b75d-5680-fcef-6e6905c52ac5@suse.de>
Subject: Re: matroxfb: cannot determine memory size
References: <5da53ec5-3a9c-ec87-da20-69f140aaaa6b@molgen.mpg.de>
In-Reply-To: <5da53ec5-3a9c-ec87-da20-69f140aaaa6b@molgen.mpg.de>

--------------GCLJkxPJ62ZRNF3bkFl6Bpq1
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGkNCg0KQW0gMTUuMTIuMjIgdW0gMTc6Mzkgc2NocmllYiBQYXVsIE1lbnplbDoNCj4gRGVh
ciBMaW51eCBmb2xrcywNCj4gDQo+IA0KPiBCZXR3ZWVuIExpbnV4IDUuMTAuMTAzIGFuZCA1
LjEwLjExMC81LjE1Ljc3LCBtYXRyaXhmYiBmYWlscyB0byBsb2FkLg0KDQpPZmYtdG9waWMs
IGJ1dCByZWxhdGVkLiBtYXRyb3hmYiBpcyBvYnNvbGV0ZSBhbmQgdGhlcmUncyBhIG1haW50
YWluZWQgDQpEUk0gcmVwbGFjZW1lbnQgKG1nYWcyMDApIGZvciB0aGlzIGhhcmR3YXJlLiBJ
cyB0aGVyZSBhbnl0aGluZyBtaXNzaW5nIA0KZnJvbSBtZ2FnMjAwIHRoYXQgcHJldmVudHMg
eW91IGZyb20gc3dpdGNoaW5nPw0KDQpCZXN0IHJlZ2FyZHMNClRob21hcw0KDQo+IA0KPiAj
IyBXb3JraW5nOg0KPiANCj4gIMKgwqDCoCBbwqDCoMKgIDAuMDAwMDAwXSBMaW51eCB2ZXJz
aW9uIDUuMTAuMTAzLm14NjQuNDI5IA0KPiAocm9vdEB0aGVpbnRlcm5ldC5tb2xnZW4ubXBn
LmRlKSAoZ2NjIChHQ0MpIDcuNS4wLCBHTlUgbGQgKEdOVSBCaW51dGlscykgDQo+IDIuMzcp
ICMxIFNNUCBNb24gTWFyIDcgMTY6NDE6NTggQ0VUIDIwMjINCj4gIMKgwqDCoCBbwqDCoMKg
IDAuMDAwMDAwXSBDb21tYW5kIGxpbmU6IA0KPiBCT09UX0lNQUdFPS9ib290L2J6SW1hZ2Ut
NS4xMC4xMDMubXg2NC40Mjkgcm9vdD1MQUJFTD1yb290IHJvIA0KPiBjcmFzaGtlcm5lbD02
NEctOjI1Nk0gY29uc29sZT10dHlTMCwxMTUyMDBuOCBjb25zb2xlPXR0eTAgDQo+IGluaXQ9
L2Jpbi9zeXN0ZW1kIGF1ZGl0PTAgcmFuZG9tLnRydXN0X2NwdT1vbiANCj4gc3lzdGVtZC51
bmlmaWVkX2Nncm91cF9oaWVyYXJjaHkNCj4gIMKgwqDCoCBb4oCmXQ0KPiAgwqDCoMKgIFvC
oMKgwqAgMC4wMDAwMDBdIERNSTogRGVsbCBJbmMuIFBvd2VyRWRnZSBSOTEwLzBLWUQzRCwg
QklPUyAyLjEwLjAgDQo+IDA4LzI5LzIwMTMNCj4gIMKgwqDCoCBb4oCmXQ0KPiAgwqDCoMKg
IFvCoMKgIDQ4LjA0NTUzMF0gbWF0cm94ZmI6IE1hdHJveCBNR0EtRzIwMGVXIChQQ0kpIGRl
dGVjdGVkDQo+ICDCoMKgwqAgW8KgwqAgNDguMDU0Njc1XSBtYXRyb3hmYjogNjQweDQ4MHg4
YnBwICh2aXJ0dWFsOiA2NDB4MTMxMDcpDQo+ICDCoMKgwqAgW8KgwqAgNDguMDU5OTY2XSBt
YXRyb3hmYjogZnJhbWVidWZmZXIgYXQgMHhDNTAwMDAwMCwgbWFwcGVkIHRvIA0KPiAweDAw
MDAwMDAwY2E3MjM4ZmEsIHNpemUgODM4ODYwOA0KPiANCj4gIyMgTm9uLXdvcmtpbmc6DQo+
IA0KPiAjIyMgNS4xMC4xMTANCj4gDQo+ICDCoMKgwqAgW8KgwqDCoCAwLjAwMDAwMF0gTGlu
dXggdmVyc2lvbiA1LjEwLjExMC5teDY0LjQzMyANCj4gKHJvb3RAdGhlaW50ZXJuZXQubW9s
Z2VuLm1wZy5kZSkgKGdjYyAoR0NDKSA3LjUuMCwgR05VIGxkIChHTlUgQmludXRpbHMpIA0K
PiAyLjM3KSAjMSBTTVAgVGh1IEFwciAxNCAxNToyODo1MyBDRVNUIDIwMjINCj4gIMKgwqDC
oCBbwqDCoMKgIDAuMDAwMDAwXSBDb21tYW5kIGxpbmU6IHJvb3Q9TEFCRUw9cm9vdCBybyAN
Cj4gY3Jhc2hrZXJuZWw9NjRHLToyNTZNIGNvbnNvbGU9dHR5UzAsMTE1MjAwbjggY29uc29s
ZT10dHkwIA0KPiBpbml0PS9iaW4vc3lzdGVtZCBhdWRpdD0wIHJhbmRvbS50cnVzdF9jcHU9
b24gDQo+IHN5c3RlbWQudW5pZmllZF9jZ3JvdXBfaGllcmFyY2h5DQo+ICDCoMKgwqAgW+KA
pl0NCj4gIMKgwqDCoCBbwqDCoMKgIDAuMDAwMDAwXSBETUk6IERlbGwgSW5jLiBQb3dlckVk
Z2UgUjkxMC8wS1lEM0QsIEJJT1MgMi4xMC4wIA0KPiAwOC8yOS8yMDEzDQo+ICDCoMKgwqAg
W+KApl0NCj4gIMKgwqDCoCBbwqDCoCAzNS4yMjU5ODddIG1hdHJveGZiOiBNYXRyb3ggTUdB
LUcyMDBlVyAoUENJKSBkZXRlY3RlZA0KPiAgwqDCoMKgIFvCoMKgIDM1LjIzNDA4OF0gbWF0
cm94ZmI6IGNhbm5vdCBkZXRlcm1pbmUgbWVtb3J5IHNpemUNCj4gIMKgwqDCoCBbwqDCoCAz
NS4yMzg5MzFdIG1hdHJveGZiOiBwcm9iZSBvZiAwMDAwOjA5OjAzLjAgZmFpbGVkIHdpdGgg
ZXJyb3IgLTENCj4gDQo+ICMjIyA1LjE1Ljc3DQo+IA0KPiAgwqDCoMKgIFvCoMKgwqAgMC4w
MDAwMDBdIExpbnV4IHZlcnNpb24gNS4xNS43Ny5teDY0LjQ0MCANCj4gKHJvb3RAdGhlaW50
ZXJuZXQubW9sZ2VuLm1wZy5kZSkgKGdjYyAoR0NDKSAxMC40LjAsIEdOVSBsZCAoR05VIA0K
PiBCaW51dGlscykgMi4zNykgIzEgU01QIFR1ZSBOb3YgOCAxNTo0MjozMyBDRVQgMjAyMg0K
PiAgwqDCoMKgIFvCoMKgwqAgMC4wMDAwMDBdIENvbW1hbmQgbGluZTogcm9vdD1MQUJFTD1y
b290IHJvIA0KPiBjcmFzaGtlcm5lbD02NEctOjI1Nk0gY29uc29sZT10dHlTMCwxMTUyMDBu
OCBjb25zb2xlPXR0eTAgDQo+IGluaXQ9L2Jpbi9zeXN0ZW1kIGF1ZGl0PTAgcmFuZG9tLnRy
dXN0X2NwdT1vbiANCj4gc3lzdGVtZC51bmlmaWVkX2Nncm91cF9oaWVyYXJjaHkNCj4gDQo+
ICDCoMKgwqAgW+KApl0NCj4gIMKgwqDCoCBbwqDCoMKgIDAuMDAwMDAwXSBETUk6IERlbGwg
SW5jLiBQb3dlckVkZ2UgUjcxNS8wRzJEUDMsIEJJT1MgMS41LjIgDQo+IDA0LzE5LzIwMTEN
Cj4gIMKgwqDCoCBb4oCmXQ0KPiAgwqDCoMKgIFvCoMKgwqAgOS40MzY0MjBdIG1hdHJveGZi
OiBNYXRyb3ggTUdBLUcyMDBlVyAoUENJKSBkZXRlY3RlZA0KPiAgwqDCoMKgIFvCoMKgwqAg
OS40NDQ1MDJdIG1hdHJveGZiOiBjYW5ub3QgZGV0ZXJtaW5lIG1lbW9yeSBzaXplDQo+ICDC
oMKgwqAgW8KgwqDCoCA5LjQ0OTMxNl0gbWF0cm94ZmI6IHByb2JlIG9mIDAwMDA6MGE6MDMu
MCBmYWlsZWQgd2l0aCBlcnJvciAtMQ0KPiANCj4gV2Ugc2VlIGl0IG9uIHNldmVyYWwgc3lz
dGVtczoNCj4gDQo+ICDCoMKgwqAgJCBsc3BjaSAtbm4gLXMgMGE6MDMuMCAjIERlbGwgUG93
ZXJFZGdlIFI3MTUNCj4gIMKgwqDCoCAwYTowMy4wIFZHQSBjb21wYXRpYmxlIGNvbnRyb2xs
ZXIgWzAzMDBdOiBNYXRyb3ggRWxlY3Ryb25pY3MgDQo+IFN5c3RlbXMgTHRkLiBNR0EgRzIw
MGVXIFdQQ000NTAgWzEwMmI6MDUzMl0gKHJldiAwYSkNCj4gDQo+ICDCoMKgwqAgJCBsc3Bj
aSAtbm4gLXMgMDk6MDMuMCAjIERlbGwgUG93ZXJFZGdlIFI5MTANCj4gIMKgwqDCoCAwOTow
My4wIFZHQSBjb21wYXRpYmxlIGNvbnRyb2xsZXIgWzAzMDBdOiBNYXRyb3ggRWxlY3Ryb25p
Y3MgDQo+IFN5c3RlbXMgTHRkLiBNR0EgRzIwMGVXIFdQQ000NTAgWzEwMmI6MDUzMl0gKHJl
diAwYSkNCj4gDQo+IEkgZm91bmQgc29tZSBvbGQgbG9nIGZyb20gQXByaWwgMjAyMiwgd2hl
cmUgSSBib290ZWQgNS4xMC4xMDksIGFuZCB0aGUgDQo+IGVycm9yIGlzIG5vdCB0aGVyZSwg
cG9pbnRpbmcgdG93YXJkIHRoZSByZWdyZXNzaW9uIHRvIGJlIGludHJvZHVjZWQgDQo+IGJl
dHdlZW4gNS4xMC4xMDkgYW5kIDUuMTAuMTEwLg0KPiANCj4gYGBgDQo+ICQgZ2l0IGxvZyAt
LW9uZWxpbmUgdjUuMTAuMTA5Li52NS4xMC4xMTAgLS1ncmVwIGZiZGV2DQo+IGIxYzI4NTc3
NTI5YyB2aWRlbzogZmJkZXY6IHNtNzEyZmI6IEZpeCBjcmFzaCBpbiBzbXRjZmJfd3JpdGUo
KQ0KPiA2ODFhMzE3MDM0YjIgdmlkZW86IGZiZGV2OiB1ZGxmYjogcmVwbGFjZSBzbnByaW50
ZiBpbiBzaG93IGZ1bmN0aW9ucyANCj4gd2l0aCBzeXNmc19lbWl0DQo+IGE3YzYyNGFiZjY5
NCB2aWRlbzogZmJkZXY6IG9tYXBmYjogcGFuZWwtdHBvLXRkMDQzbXRlYTE6IFVzZSANCj4g
c3lzZnNfZW1pdCgpIGluc3RlYWQgb2Ygc25wcmludGYoKQ0KPiA1NDNkYWUwYTQ2YjAgdmlk
ZW86IGZiZGV2OiBvbWFwZmI6IHBhbmVsLWRzaS1jbTogVXNlIHN5c2ZzX2VtaXQoKSANCj4g
aW5zdGVhZCBvZiBzbnByaW50ZigpDQo+IGRhMjEwYjFiNTUxYyB2aWRlbzogZmJkZXY6IG9t
YXBmYjogYWN4NTY1YWttOiByZXBsYWNlIHNucHJpbnRmIHdpdGggDQo+IHN5c2ZzX2VtaXQN
Cj4gOGM3ZTIxNDFmYjg5IHZpZGVvOiBmYmRldjogY2lycnVzZmI6IGNoZWNrIHBpeGNsb2Nr
IHRvIGF2b2lkIGRpdmlkZSBieSB6ZXJvDQo+IDFlMzNmMTk3NDY4ZiB2aWRlbzogZmJkZXY6
IHcxMDBmYjogUmVzZXQgZ2xvYmFsIHN0YXRlDQo+IDA4ZGZmNDgyMDEyNyB2aWRlbzogZmJk
ZXY6IG52aWRpYWZiOiBVc2Ugc3Ryc2NweSgpIHRvIHByZXZlbnQgYnVmZmVyIA0KPiBvdmVy
Zmxvdw0KPiAwNjZkOWI0OGY5NDkgdmlkZW86IGZiZGV2OiBvbWFwZmI6IEFkZCBtaXNzaW5n
IG9mX25vZGVfcHV0KCkgaW4gDQo+IGR2aWNfcHJvYmVfb2YNCj4gYmY0YmFkMTExNGEzIHZp
ZGVvOiBmYmRldjogZmJjdnQuYzogZml4IHByaW50aW5nIGluIGZiX2N2dF9wcmludF9uYW1l
KCkNCj4gNmRlNmE2NGYyM2E2IHZpZGVvOiBmYmRldjogYXRtZWxfbGNkZmI6IGZpeCBhbiBl
cnJvciBjb2RlIGluIA0KPiBhdG1lbF9sY2RmYl9wcm9iZSgpDQo+IDY0ZWMzZTY3OGQ3NiB2
aWRlbzogZmJkZXY6IHNtc2N1Zng6IEZpeCBudWxsLXB0ci1kZXJlZiBpbiB1ZnhfdXNiX3By
b2JlKCkNCj4gMGRmZjg2YWViMTkxIHZpZGVvOiBmYmRldjogY29udHJvbGZiOiBGaXggQ09N
UElMRV9URVNUIGJ1aWxkDQo+IGVjMWMyMGIwMmFlMCB2aWRlbzogZmJkZXY6IGNvbnRyb2xm
YjogRml4IHNldCBidXQgbm90IHVzZWQgd2FybmluZ3MNCj4gZjhiZjE5ZjdmMzExIHZpZGVv
OiBmYmRldjogbWF0cm94ZmI6IHNldCBtYXh2cmFtIG9mIHZiRzIwMGVXIHRvIHRoZSBzYW1l
IA0KPiBhcyB2YkcyMDAgdG8gYXZvaWQgYmxhY2sgc2NyZWVuDQo+IDJjYTJhNTU1MmE4MyB2
aWRlbzogZmJkZXY6IGF0YXJpOiBBdGFyaSAyIGJwcCAoU1RlKSBwYWxldHRlIGJ1Z2ZpeA0K
PiA3MmFmODgxMDkyMmUgdmlkZW86IGZiZGV2OiBzbTcxMmZiOiBGaXggY3Jhc2ggaW4gc210
Y2ZiX3JlYWQoKQ0KPiBgYGANCj4gDQo+IElzIGl0IHdvcnRod2hpbGUgdG8gdGVzdCBjb21t
aXQgZjhiZjE5ZjdmMzExICh2aWRlbzogZmJkZXY6IG1hdHJveGZiOiANCj4gc2V0IG1heHZy
YW0gb2YgdmJHMjAwZVcgdG8gdGhlIHNhbWUgYXMgdmJHMjAwIHRvIGF2b2lkIGJsYWNrIHNj
cmVlbik/DQo+IA0KPiBUaGUgbWFzdGVyIGNvbW1pdCA2MmQ4OWE3ZDQ5YSB3YXMgYWRkZWQg
dG8gdjUuMTgtcmMxLCBhbmQgd2FzIGFsc28gDQo+IGJhY2twb3J0ZWQgdG8gdGhlIExpbnV4
IDUuMTUgc2VyaWVzIGluIDUuMTUuMzMuDQo+IA0KPiANCj4gS2luZCByZWdhcmRzLA0KPiAN
Cj4gUGF1bA0KDQotLSANClRob21hcyBaaW1tZXJtYW5uDQpHcmFwaGljcyBEcml2ZXIgRGV2
ZWxvcGVyDQpTVVNFIFNvZnR3YXJlIFNvbHV0aW9ucyBHZXJtYW55IEdtYkgNCk1heGZlbGRz
dHIuIDUsIDkwNDA5IE7DvHJuYmVyZywgR2VybWFueQ0KKEhSQiAzNjgwOSwgQUcgTsO8cm5i
ZXJnKQ0KR2VzY2jDpGZ0c2bDvGhyZXI6IEl2byBUb3Rldg0K

--------------GCLJkxPJ62ZRNF3bkFl6Bpq1--

--------------tofzjITEdE9UjXVF0EcRYvI7
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEExndm/fpuMUdwYFFolh/E3EQov+AFAmOcZDoFAwAAAAAACgkQlh/E3EQov+D8
KQ//VvSkhgDNqo5Z/3wdXJY/YP1g5Mk43WRSyXeZJusST9PtUUNA3vKpEuFS+auGu3GU4DgPnDsQ
yhELLxSWJtubsGOfetUFhjwRa+/03OQbCwtwGcHvKKt4kPa94QLI9rGdbVOr8uKrc3GUfpkv58GB
+zjlz8lftPQzzgoxaXXb2B4cGN9lra+sZW6HsPQE3c4rdWF+ZyCXbgppBtl14Coxkjpri50fr4rt
ksrWfAsXsJWCUszfMJZhQswVPMSvZ4BAO+bEhh9S4m4ZMrc/70wxrvBhBZRMBdbBk3yKDuC+0xBR
/QuBCWY5OIyX7BZilWFsMYEcCZEoXHLlUZNiuWq5XFHcHKSx4pI5UhvV3sefoonxZSLWI2SrwO+q
e637bICSr1tFCbGL3nM7eo1vQciHJIIUvSGdOzDdtd51bK7SlHjHQmzX4hiwhGuN8GtYLTyAJPbJ
CialFQ4oPdrok/kqfKc2XTC14E9UJzcAysgiZBZxC5cfaTi4GvdVvbVyNwgbg5crLBZo4s222GQC
hZrq2lhHnmO3soJwHMaxWTEmHgsGL7fazB012GwbQFcGKFLLZDOi/CcNkNfA96j6d+j7JZRuzzze
JaA/VaazP/O5BacaTJCF8nUtn5DXEnsHPbZoyhLTW6PyYpLhm1my6yvyRiWsyYSL8/rdIOQIzQBP
GcI=
=qX6e
-----END PGP SIGNATURE-----

--------------tofzjITEdE9UjXVF0EcRYvI7--
