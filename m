Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30C29C433EF
	for <linux-fbdev@archiver.kernel.org>; Tue,  3 May 2022 13:06:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233661AbiECNJi (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Tue, 3 May 2022 09:09:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235976AbiECNJd (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Tue, 3 May 2022 09:09:33 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81ED818B2C
        for <linux-fbdev@vger.kernel.org>; Tue,  3 May 2022 06:05:50 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 98C1421877;
        Tue,  3 May 2022 13:05:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1651583148; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nRfo66+Nk8CBuM+DdLsuVMR34G2Utwqf9JqbUfoMxMw=;
        b=lSMj7xyK0VDaq3W3fDTNufiHEYJ3/dxHc4JL4Iynj45M6VQ7ZqcxymcrCzL8vgfkuSIZ6F
        fEvMu7AbR4eIOqchMRyDN9PjVEyoRzxH9RBvFLj7O/snpTp99cAHFuc7aoxhc/P2dlVb2K
        Nl8dlgZ43XCanSxeNjHrcoqE3blSmgE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1651583148;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nRfo66+Nk8CBuM+DdLsuVMR34G2Utwqf9JqbUfoMxMw=;
        b=ORueIBbTx6zjoBza4Nguq1YRgamqYtlsF4VPUeuwYqTPQ3qSQ9zA75rYwuG1uAbNEx9dlg
        nFOakJno+P9YXSCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6901E13ABE;
        Tue,  3 May 2022 13:05:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id JmUKGKwocWKjPwAAMHmgww
        (envelope-from <tzimmermann@suse.de>); Tue, 03 May 2022 13:05:48 +0000
Message-ID: <25a52e76-b689-8990-2d12-1fc75a8a9459@suse.de>
Date:   Tue, 3 May 2022 15:05:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH] video: fbdev: don't remove firmware fb device if it is
 busy
Content-Language: en-US
To:     "Chang, Junxiao" <junxiao.chang@intel.com>,
        "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>
Cc:     "lethal@linux-sh.org" <lethal@linux-sh.org>,
        "patchwork-bot@kernel.org" <patchwork-bot@kernel.org>,
        "deller@gmx.de" <deller@gmx.de>, "Li, Lili" <lili.li@intel.com>,
        Javier Martinez Canillas <javierm@redhat.com>
References: <20220430025749.2320824-1-junxiao.chang@intel.com>
 <ab099144-2db2-caae-7a59-94211111a6cf@suse.de>
 <BN9PR11MB53709B93930F49194C0E5757ECC09@BN9PR11MB5370.namprd11.prod.outlook.com>
 <941d416c-63a4-aae1-0b9a-bda8211114f6@suse.de>
 <BN9PR11MB537070E36D25158B265C8490ECC09@BN9PR11MB5370.namprd11.prod.outlook.com>
From:   Thomas Zimmermann <tzimmermann@suse.de>
In-Reply-To: <BN9PR11MB537070E36D25158B265C8490ECC09@BN9PR11MB5370.namprd11.prod.outlook.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------N1DYaa1HMzn6KKUG9TMZuQnv"
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------N1DYaa1HMzn6KKUG9TMZuQnv
Content-Type: multipart/mixed; boundary="------------msQOBBp1I0Ed6dEfJUAam1VV";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann@suse.de>
To: "Chang, Junxiao" <junxiao.chang@intel.com>,
 "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>
Cc: "lethal@linux-sh.org" <lethal@linux-sh.org>,
 "patchwork-bot@kernel.org" <patchwork-bot@kernel.org>,
 "deller@gmx.de" <deller@gmx.de>, "Li, Lili" <lili.li@intel.com>,
 Javier Martinez Canillas <javierm@redhat.com>
Message-ID: <25a52e76-b689-8990-2d12-1fc75a8a9459@suse.de>
Subject: Re: [PATCH] video: fbdev: don't remove firmware fb device if it is
 busy
References: <20220430025749.2320824-1-junxiao.chang@intel.com>
 <ab099144-2db2-caae-7a59-94211111a6cf@suse.de>
 <BN9PR11MB53709B93930F49194C0E5757ECC09@BN9PR11MB5370.namprd11.prod.outlook.com>
 <941d416c-63a4-aae1-0b9a-bda8211114f6@suse.de>
 <BN9PR11MB537070E36D25158B265C8490ECC09@BN9PR11MB5370.namprd11.prod.outlook.com>
In-Reply-To: <BN9PR11MB537070E36D25158B265C8490ECC09@BN9PR11MB5370.namprd11.prod.outlook.com>

--------------msQOBBp1I0Ed6dEfJUAam1VV
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGkNCg0KQW0gMDMuMDUuMjIgdW0gMTQ6Mjkgc2NocmllYiBDaGFuZywgSnVueGlhbzoNCj4g
V2UgdGVzdGVkIEphdmllcidzIGZpeCwgaXNzdWUgY291bGRuJ3QgYmUgcmVwcm9kdWNlZCBh
bnltb3JlLg0KPiBodHRwczovL2xvcmUua2VybmVsLm9yZy9kcmktZGV2ZWwvMjAyMjA1MDIx
MzUwMTQuMzc3OTQ1LTEtamF2aWVybUByZWRoYXQuY29tL1QvI3UNCg0KVGhhbmsgeW91IHNv
IG11Y2guDQoNCkJlc3QgcmVnYXJkcw0KVGhvbWFzDQoNCj4gDQo+IEJ1dCB0aGlzIGZpeCBk
b2Vzbid0IGNvdmVyIGFsbCBGQiBkcml2ZXIncyBpbnRlcmZhY2U6DQo+IA0KPiAJLmdldF91
bm1hcHBlZF9hcmVhID0gZ2V0X2ZiX3VubWFwcGVkX2FyZWEsDQo+IAkuZnN5bmMgPQlmYl9k
ZWZlcnJlZF9pb19mc3luYywNCj4gDQo+IGZpbGVfZmJfaW5mbyhmaWxlKSBOVUxMIGNoZWNr
aW5nIHNob3VsZCBiZSBhZGRlZCBpbiB0aGVzZSB0d28gaW50ZXJmYWNlIGZ1bmN0aW9ucyhn
ZXRfZmJfdW5tYXBwZWRfYXJlYSBhbmQgZmJfZGVmZXJyZWRfaW9fZnN5bmMpIGFzIHdlbGw/
DQo+IA0KPiBSZWdhcmRzLA0KPiBKdW54aWFvDQo+IA0KPiAtLS0tLU9yaWdpbmFsIE1lc3Nh
Z2UtLS0tLQ0KPiBGcm9tOiBUaG9tYXMgWmltbWVybWFubiA8dHppbW1lcm1hbm5Ac3VzZS5k
ZT4NCj4gU2VudDogVHVlc2RheSwgTWF5IDMsIDIwMjIgMzoxNiBQTQ0KPiBUbzogQ2hhbmcs
IEp1bnhpYW8gPGp1bnhpYW8uY2hhbmdAaW50ZWwuY29tPjsgbGludXgtZmJkZXZAdmdlci5r
ZXJuZWwub3JnDQo+IENjOiBsZXRoYWxAbGludXgtc2gub3JnOyBwYXRjaHdvcmstYm90QGtl
cm5lbC5vcmc7IGRlbGxlckBnbXguZGU7IExpLCBMaWxpIDxsaWxpLmxpQGludGVsLmNvbT47
IEphdmllciBNYXJ0aW5leiBDYW5pbGxhcyA8amF2aWVybUByZWRoYXQuY29tPg0KPiBTdWJq
ZWN0OiBSZTogW1BBVENIXSB2aWRlbzogZmJkZXY6IGRvbid0IHJlbW92ZSBmaXJtd2FyZSBm
YiBkZXZpY2UgaWYgaXQgaXMgYnVzeQ0KPiANCj4gKGNjJ2luZyBKYXZpZXIpDQo+IA0KPiBI
aQ0KPiANCj4gQW0gMDMuMDUuMjIgdW0gMDI6Mzggc2NocmllYiBDaGFuZywgSnVueGlhbzoN
Cj4+IEhpIFRob21hcywNCj4+DQo+PiBXZSByZXByb2R1Y2VkIHRoaXMgaXNzdWUgd2l0aCBZ
b2N0byBpbWFnZSArIDUuMTgtcmMzIGtlcm5lbC4NCj4+IElmIHlvdSBjb3VsZCB0cnkgWW9j
dG8gaW1hZ2UgYW5kIGVuYWJsZSBwc3BsYXNoLCB0aGUgcHJvYmxlbSBjb3VsZCBiZSByZXBy
b2R1Y2VkIGFsbW9zdCBldmVyeSB0aW1lIGlmIHBzcGxhc2ggaXMgbGF1bmNoZWQgYmVmb3Jl
IEludGVsIGk5MTUgcmVnaXN0ZXJzIDJuZCBmcmFtZWJ1ZmZlci4NCj4+DQo+PiBEdXJpbmcg
WW9jdG8gYm9vdGluZyB1cCwgaXQgbGF1bmNoZXMgcHNwbGFzaCB3aGljaCBvcGVucyBFRkkg
ZmlybXdhcmUgZnJhbWVidWZmZXIgYW5kIHBsYXlzIGFuaW1hdGlvbi4gV2hlbiBpdCBleGl0
cywgZmJfcmVsZWFzZSBpbiBrZXJuZWwgbWlnaHQgYWNjZXNzIG1lbW9yeSB3aGljaCBoYXMg
YmVlbiByZWxlYXNlZC4NCj4+DQo+PiBPdmVyYWxsIHByb2Nlc3MgbG9va3MgbGlrZToNCj4+
IDEuIEVGSSByZWdpc3RlcnMgZnJhbWVidWZmZXIgaW4gZWZpZmJfcHJvYmUsIGZyYW1lYnVm
ZmVyX2FsbG9jIGlzDQo+PiBjYWxsZWQgdG8gYWxsb2NhdGUgInN0cnVjdCBmYl9pbmZvIiBt
ZW1vcnk7IDIuIEluIHVzZXJzcGFjZSwgcHNwbGFzaA0KPj4gaXMgc3RhcnRlZCB0byBwbGF5
IGJvb3QgYW5pbWF0aW9uLCBpdCBvcGVucyBmcmFtZWJ1ZmZlciBkcml2ZXIuIEluDQo+PiBm
Yl9vcGVuIGZ1bmN0aW9uLCBpdCBzYXZlcyBmYl9pbmZvIG1lbW9yeSB0byBmaWxlLT5wcml2
YXRlX2RhdGE7IDMuDQo+PiBXaGVuIEludGVsIGk5MTUgZHJpdmVyIGlzIHByb2JlZCwgaXQg
cmVnaXN0ZXJzIDJuZCBmcmFtZWJ1ZmZlciwgYW5kDQo+PiB3aWxsIHJlbW92ZSBjb25mbGlj
dGluZyBmcmFtZWJ1ZmZlcjsgNC4gSW4gZG9fcmVtb3ZlX2NvbmZsaWN0aW5nX2ZyYW1lYnVm
ZmVycywgaXQgY2FsbHMgInBsYXRmb3JtX2RldmljZV91bnJlZ2lzdGVyIiB0byByZW1vdmUg
RUZJIHBsYXRmb3JtIGZyYW1lYnVmZmVyIGRldmljZTsgNS4gSW4gRUZJIGZyYW1lYnVmZmVy
J3MgZWZpZmJfcmVtb3ZlIGZ1bmN0aW9uLCBpdCBjYWxscyBmcmFtZWJ1ZmZlcl9yZWxlYXNl
IHRvIHJlbGVhc2UgInN0cnVjdCBmYl9pbmZvIiBtZW1vcnkgd2hpY2ggaXMgc3RpbGwgdXNl
IGFuZCBzdG9yZWQgaW4gZmlsZS0+cHJpdmF0ZV9kYXRhOyA2LiBXaGVuIHBzcGxhc2ggdXNl
ciBzcGFjZSBhcHBsaWNhdGlvbiBleGl0cywgaXQgY2FsbHMgZmJfcmVsZWFzZSBmdW5jdGlv
biwgYW5kIGFjY2Vzc2VzIHRvIGZiX2luZm8gbWVtb3J5LCBidXQgaXQgaGFzIGJlZW4gcmVs
ZWFzZWQgaW4gc3RlcCA1LiBLZXJuZWwgcGFuaWMgaGFwcGVucy4NCj4gDQo+IFRoYW5rcyBm
b3IgdGhlIGluZm9ybWF0aW9uLiBXZSBvbmx5IGhhZCBhIHNpbWlsYXIgcmVwb3J0IGFib3V0
IFJQaSBkZXZpY2VzLCBidXQgd2UgbmV2ZXIgZW5jb3VudGVyZWQgdGhpcyBwcm9ibGVtIGJl
Zm9yZS4NCj4gDQo+Pg0KPj4gT3VyIHBhdGNoIGlzIHRvIGNoZWNrIHdoZXRoZXIgRUZJIGZy
YW1lYnVmZmVyIGlzIG9wZW5lZCBhdCB0aGF0IHRpbWUuIElmIGl0IGlzIGZyZWUocmVnaXN0
ZXJlZF9mYltpXS0+Y291bnQgPT0gMSksIGdvIGFoZWFkIHRvIHJlbW92ZSBFRkkgcGxhdGZv
cm0gZGV2aWNlLiBPciBlbHNlLCBqdXN0IHVucmVnaXN0ZXIgZnJhbWVidWZmZXIgdG8gYXZv
aWQga2VybmVsIHBhbmljLg0KPiANCj4gSmF2aWVyIHBvc3RlZCBhIHBvc3NpYmxlIGZpeCBm
b3IgdGhlIHJvb3QgY2F1c2Ugb2YgdGhpcyBwcm9ibGVtLCBidXQgd2UncmUgc3RpbGwgbG9v
a2luZyBmb3IgdGVzdGVycy4gSWYgeW91IGhhdmUgdGhlIG9wcG9ydHVuaXR5LCBjb3VsZCB5
b3UNCj4gICAgcGxlYXNlIHRlc3QgdGhlIHBhdGNoIGF0IFsxXSBhbmQgcmVwb3J0IGJhY2sg
b24gdGhlIHJlc3VsdHMuDQo+IA0KPiBCZXN0IHJlZ2FyZHMNCj4gVGhvbWFzDQo+IA0KPiBb
MV0NCj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvZHJpLWRldmVsLzIwMjIwNTAyMTM1MDE0
LjM3Nzk0NS0xLWphdmllcm1AcmVkaGF0LmNvbS9ULyN1DQo+IA0KPj4NCj4+IFRoYW5rcywN
Cj4+IEp1bnhpYW8NCj4+DQo+PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPj4gRnJv
bTogVGhvbWFzIFppbW1lcm1hbm4gPHR6aW1tZXJtYW5uQHN1c2UuZGU+DQo+PiBTZW50OiBN
b25kYXksIE1heSAyLCAyMDIyIDM6MjQgUE0NCj4+IFRvOiBDaGFuZywgSnVueGlhbyA8anVu
eGlhby5jaGFuZ0BpbnRlbC5jb20+Ow0KPj4gbGludXgtZmJkZXZAdmdlci5rZXJuZWwub3Jn
DQo+PiBDYzogbGV0aGFsQGxpbnV4LXNoLm9yZzsgcGF0Y2h3b3JrLWJvdEBrZXJuZWwub3Jn
OyBkZWxsZXJAZ214LmRlOyBMaSwNCj4+IExpbGkgPGxpbGkubGlAaW50ZWwuY29tPg0KPj4g
U3ViamVjdDogUmU6IFtQQVRDSF0gdmlkZW86IGZiZGV2OiBkb24ndCByZW1vdmUgZmlybXdh
cmUgZmIgZGV2aWNlIGlmDQo+PiBpdCBpcyBidXN5DQo+Pg0KPj4gSGkNCj4+DQo+PiBBbSAz
MC4wNC4yMiB1bSAwNDo1NyBzY2hyaWViIEp1bnhpYW8gQ2hhbmc6DQo+Pj4gV2hlbiBmaXJt
d2FyZSBmcmFtZWJ1ZmZlciBpcyBpbiB1c2UsIGRvbid0IHJlbW92ZSBpdHMgcGxhdGZvcm0g
ZGV2aWNlLg0KPj4+IE9yIGVsc2UgaXRzIGZiX2luZm8gYnVmZmVyIGlzIHJlbGVhc2VkIGJ5
IHBsYXRmb3JtIHJlbW92ZSBob29rIHdoaWxlDQo+Pj4gZGV2aWNlIGlzIHN0aWxsIG9wZW5l
ZC4gVGhpcyBpbnRyb2R1Y2VzIHVzZSBhZnRlciBmcmVlIGlzc3VlLg0KPj4NCj4+IFdoZW4g
ZXhhY3RseSBkb2VzIHRoaXMgaGFwcGVuPyBEbyB5b3UgaGF2ZSBhIHJlbGlhYmxlIHdheSBv
ZiByZXByb2R1Y2luZyBpdD8NCj4+DQo+PiBCZXN0IHJlZ2FyZHMNCj4+IFRob21hcw0KPj4N
Cj4+Pg0KPj4+IEEga2VybmVsIHBhbmljIGV4YW1wbGU6DQo+Pj4gQ1BVOiAyIFBJRDogMzQy
NSBDb21tOiBwc3BsYXNoIFRhaW50ZWQ6IEcgICAgIFUgIFcgICAgIDUuMTguMC1yYzMNCj4+
PiBIYXJkd2FyZSBuYW1lOiBJbnRlbCBDbGllbnQgUGxhdGZvcm0vQURQLVMgRERSNSBVRElN
TSBDUkINCj4+PiBSSVA6IDAwMTA6bmF0aXZlX3F1ZXVlZF9zcGluX2xvY2tfc2xvd3BhdGgr
MHgxYzcvMHgyMTANCj4+PiBSU1A6IDAwMTg6ZmZmZmIzYTBjMGMyZmRiMCBFRkxBR1M6IDAw
MDEwMjA2DQo+Pj4gUkFYOiAwMDJkYzA3NGZmNWMwOTg4IFJCWDogZmZmZjkyZTk4N2E1ZDgx
OCBSQ1g6IGZmZmY5MmU5ODliYTlmNDANCj4+PiBSRFg6IDAwMDAwMDAwMDAwMDIwNjcgUlNJ
OiBmZmZmZmZmZjg2NDM0NGYxIFJESTogZmZmZmZmZmY4NjQ0MTgzYw0KPj4+IFJCUDogZmZm
ZjkyZjEwZjRhYmQ0MCBSMDg6IDAwMDAwMDAwMDAwMDAwMDEgUjA5OiBmZmZmOTJlOTg2ZGMy
MTg4IC4uLg0KPj4+IENhbGwgVHJhY2U6DQo+Pj4gICAgIDxUQVNLPg0KPj4+ICAgICBfcmF3
X3NwaW5fbG9jaysweDJjLzB4MzANCj4+PiAgICAgX19tdXRleF9sb2NrLmNvbnN0cHJvcC4w
KzB4MTc1LzB4NGYwDQo+Pj4gICAgID8gX3Jhd19zcGluX3VubG9jaysweDE1LzB4MzANCj4+
PiAgICAgPyBsaXN0X2xydV9hZGQrMHgxMjQvMHgxNjANCj4+PiAgICAgZmJfcmVsZWFzZSsw
eDFiLzB4NjANCj4+PiAgICAgX19mcHV0KzB4ODkvMHgyNDANCj4+PiAgICAgdGFza193b3Jr
X3J1bisweDU5LzB4OTANCj4+PiAgICAgZG9fZXhpdCsweDM0My8weGFmMA0KPj4+ICAgICBk
b19ncm91cF9leGl0KzB4MmQvMHg5MA0KPj4+ICAgICBfX3g2NF9zeXNfZXhpdF9ncm91cCsw
eDE0LzB4MjANCj4+PiAgICAgZG9fc3lzY2FsbF82NCsweDQwLzB4OTANCj4+PiAgICAgZW50
cnlfU1lTQ0FMTF82NF9hZnRlcl9od2ZyYW1lKzB4NDQvMHhhZQ0KPj4+DQo+Pj4gRml4ZXM6
IDI3NTk5YWFjYmFlZiAoImZiZGV2OiBIb3QtdW5wbHVnIGZpcm13YXJlIGZiIGRldmljZXMg
b24gZm9yY2VkDQo+Pj4gcmVtb3ZhbCIpDQo+Pj4gU2lnbmVkLW9mZi1ieTogSnVueGlhbyBD
aGFuZyA8anVueGlhby5jaGFuZ0BpbnRlbC5jb20+DQo+Pj4gU2lnbmVkLW9mZi1ieTogTGls
aSBMaSA8bGlsaS5saUBpbnRlbC5jb20+DQo+Pj4gLS0tDQo+Pj4gICAgIGRyaXZlcnMvdmlk
ZW8vZmJkZXYvY29yZS9mYm1lbS5jIHwgNCArKystDQo+Pj4gICAgIDEgZmlsZSBjaGFuZ2Vk
LCAzIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4+Pg0KPj4+IGRpZmYgLS1naXQg
YS9kcml2ZXJzL3ZpZGVvL2ZiZGV2L2NvcmUvZmJtZW0uYw0KPj4+IGIvZHJpdmVycy92aWRl
by9mYmRldi9jb3JlL2ZibWVtLmMNCj4+PiBpbmRleCBhNmJiMGU0MzgyMTYuLmZmOWI5ODMw
YjM5OCAxMDA2NDQNCj4+PiAtLS0gYS9kcml2ZXJzL3ZpZGVvL2ZiZGV2L2NvcmUvZmJtZW0u
Yw0KPj4+ICsrKyBiL2RyaXZlcnMvdmlkZW8vZmJkZXYvY29yZS9mYm1lbS5jDQo+Pj4gQEAg
LTE1ODYsNyArMTU4Niw5IEBAIHN0YXRpYyB2b2lkIGRvX3JlbW92ZV9jb25mbGljdGluZ19m
cmFtZWJ1ZmZlcnMoc3RydWN0IGFwZXJ0dXJlc19zdHJ1Y3QgKmEsDQo+Pj4gICAgIAkJCQkg
KiBmcmFtZWJ1ZmZlciBhcyBiZWZvcmUgd2l0aG91dCB3YXJuaW5nLg0KPj4+ICAgICAJCQkJ
ICovDQo+Pj4gICAgIAkJCQlkb191bnJlZ2lzdGVyX2ZyYW1lYnVmZmVyKHJlZ2lzdGVyZWRf
ZmJbaV0pOw0KPj4+IC0JCQl9IGVsc2UgaWYgKGRldl9pc19wbGF0Zm9ybShkZXZpY2UpKSB7
DQo+Pj4gKwkJCX0gZWxzZSBpZiAoZGV2X2lzX3BsYXRmb3JtKGRldmljZSkgJiYNCj4+PiAr
CQkJCQlyZWZjb3VudF9yZWFkKCZyZWdpc3RlcmVkX2ZiW2ldLT5jb3VudCkgPT0gMSkgew0K
Pj4+ICsJCQkJLyogUmVtb3ZlIHBsYXRmb3JtIGRldmljZSBpZiBpdCBpcyBub3QgaW4gdXNl
LiAqLw0KPj4+ICAgICAJCQkJcmVnaXN0ZXJlZF9mYltpXS0+Zm9yY2VkX291dCA9IHRydWU7
DQo+Pj4gICAgIAkJCQlwbGF0Zm9ybV9kZXZpY2VfdW5yZWdpc3Rlcih0b19wbGF0Zm9ybV9k
ZXZpY2UoZGV2aWNlKSk7DQo+Pj4gICAgIAkJCX0gZWxzZSB7DQo+Pg0KPj4gLS0NCj4+IFRo
b21hcyBaaW1tZXJtYW5uDQo+PiBHcmFwaGljcyBEcml2ZXIgRGV2ZWxvcGVyDQo+PiBTVVNF
IFNvZnR3YXJlIFNvbHV0aW9ucyBHZXJtYW55IEdtYkgNCj4+IE1heGZlbGRzdHIuIDUsIDkw
NDA5IE7DvHJuYmVyZywgR2VybWFueSAoSFJCIDM2ODA5LCBBRyBOw7xybmJlcmcpDQo+PiBH
ZXNjaMOkZnRzZsO8aHJlcjogSXZvIFRvdGV2DQo+IA0KPiAtLQ0KPiBUaG9tYXMgWmltbWVy
bWFubg0KPiBHcmFwaGljcyBEcml2ZXIgRGV2ZWxvcGVyDQo+IFNVU0UgU29mdHdhcmUgU29s
dXRpb25zIEdlcm1hbnkgR21iSA0KPiBNYXhmZWxkc3RyLiA1LCA5MDQwOSBOw7xybmJlcmcs
IEdlcm1hbnkNCj4gKEhSQiAzNjgwOSwgQUcgTsO8cm5iZXJnKQ0KPiBHZXNjaMOkZnRzZsO8
aHJlcjogSXZvIFRvdGV2DQoNCi0tIA0KVGhvbWFzIFppbW1lcm1hbm4NCkdyYXBoaWNzIERy
aXZlciBEZXZlbG9wZXINClNVU0UgU29mdHdhcmUgU29sdXRpb25zIEdlcm1hbnkgR21iSA0K
TWF4ZmVsZHN0ci4gNSwgOTA0MDkgTsO8cm5iZXJnLCBHZXJtYW55DQooSFJCIDM2ODA5LCBB
RyBOw7xybmJlcmcpDQpHZXNjaMOkZnRzZsO8aHJlcjogSXZvIFRvdGV2DQo=

--------------msQOBBp1I0Ed6dEfJUAam1VV--

--------------N1DYaa1HMzn6KKUG9TMZuQnv
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEExndm/fpuMUdwYFFolh/E3EQov+AFAmJxKKsFAwAAAAAACgkQlh/E3EQov+Bs
/BAAlxGHYyNxmclYs/q6/Q4Qo/WhqHMNgTS8vuZo3msw4PrUyPYVGLVOEIob8ezRX26uv/LPzFrA
sZ6CuK5KIJWmo4GI4dli8vkPu99TpB6+erveHxfb8PxmMBvyd3UnwAs2B4rPFWI9v3s9UcXpxhOa
IJVx4EOO80j1jY/MINam+zvFdPT8+/SpWpIEQ/qKy9zCNkgNH57EnxkS5ArKC2EciOtEuhKRFhhR
XDcob+gZoHFALhzfl0McsgiGeVf17grx7f/HxtDzP7QRRm0bD0F5pprPO3vtAg5as0iqq6YYbBD3
D4Jo9EN7Pgj/+qpRtNSAVSRLRyeTTFrG0zJrBB6SjV/3TC8m6wVSRJbnA7ZkmzMjMXDkhslYq1I9
Dki3QCVQwAa9zgBDndHui+QyQYBjfqBd6WAyZA3iqCm2Z98s+39heQ4FkQjThYfRUKW1yZRkXOZg
9S8TMhc8SpH0fnYt1IKIRVEONM4aNywYJnqjY1mwo2TKyn4OjztqfthnQbG+pIDQ5EfV0NVLrvzz
ePgjZFI/ougXLYWsMG15PVqPZBqfcoKcRiIgI952nKxFyex60DeYPJCBL/5sC4GF+nrUY6QxelQa
jzU3ihqJbiX90aFkT6A/475Q0UEwhAAbvtoz8IQWZswy9Usw9SbY0WDCmLplaIzDFU3X/ojJUfsE
AfY=
=web1
-----END PGP SIGNATURE-----

--------------N1DYaa1HMzn6KKUG9TMZuQnv--
