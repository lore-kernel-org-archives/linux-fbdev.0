Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE05AC433FE
	for <linux-fbdev@archiver.kernel.org>; Tue,  3 May 2022 07:16:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231774AbiECHUG (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Tue, 3 May 2022 03:20:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231795AbiECHTw (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Tue, 3 May 2022 03:19:52 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8889245A6
        for <linux-fbdev@vger.kernel.org>; Tue,  3 May 2022 00:16:18 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 840511F38D;
        Tue,  3 May 2022 07:16:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1651562177; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uyxDjtv2AmW304YlvPW8eM0qoCoUUzSSwsZjZH6UIhI=;
        b=zvFQFhUJZceSbsKKcFjUOxjpnq8+CynM4VzydBvHBVTassvp64K+tbH5SUpPUPOQfS/Lch
        nK93VvKVxPGFnO/ATpWX3d0+Y19L66CQYUgCleci3pFKT+NsylekY6etiJpvQQicVAveOd
        rNeP9buMXfu8SMeC7KcoZUARhxa3YYM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1651562177;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uyxDjtv2AmW304YlvPW8eM0qoCoUUzSSwsZjZH6UIhI=;
        b=v3aGIwPljUJ6sePxlDcW/zFOro7qyGWkws7wVj+0FeAmWTcyrwHkkjukFKZKYpVBW4Os4o
        u8Fgrbg8WKjvo7Aw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5969A13AA3;
        Tue,  3 May 2022 07:16:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id OGTKFMHWcGLCFwAAMHmgww
        (envelope-from <tzimmermann@suse.de>); Tue, 03 May 2022 07:16:17 +0000
Message-ID: <941d416c-63a4-aae1-0b9a-bda8211114f6@suse.de>
Date:   Tue, 3 May 2022 09:16:16 +0200
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
From:   Thomas Zimmermann <tzimmermann@suse.de>
In-Reply-To: <BN9PR11MB53709B93930F49194C0E5757ECC09@BN9PR11MB5370.namprd11.prod.outlook.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------gYNZwOFH3p0SUM83Z0va1aM3"
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------gYNZwOFH3p0SUM83Z0va1aM3
Content-Type: multipart/mixed; boundary="------------mrKb0cSzqUf9UJW0GG8tpDUN";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann@suse.de>
To: "Chang, Junxiao" <junxiao.chang@intel.com>,
 "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>
Cc: "lethal@linux-sh.org" <lethal@linux-sh.org>,
 "patchwork-bot@kernel.org" <patchwork-bot@kernel.org>,
 "deller@gmx.de" <deller@gmx.de>, "Li, Lili" <lili.li@intel.com>,
 Javier Martinez Canillas <javierm@redhat.com>
Message-ID: <941d416c-63a4-aae1-0b9a-bda8211114f6@suse.de>
Subject: Re: [PATCH] video: fbdev: don't remove firmware fb device if it is
 busy
References: <20220430025749.2320824-1-junxiao.chang@intel.com>
 <ab099144-2db2-caae-7a59-94211111a6cf@suse.de>
 <BN9PR11MB53709B93930F49194C0E5757ECC09@BN9PR11MB5370.namprd11.prod.outlook.com>
In-Reply-To: <BN9PR11MB53709B93930F49194C0E5757ECC09@BN9PR11MB5370.namprd11.prod.outlook.com>

--------------mrKb0cSzqUf9UJW0GG8tpDUN
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

KGNjJ2luZyBKYXZpZXIpDQoNCkhpDQoNCkFtIDAzLjA1LjIyIHVtIDAyOjM4IHNjaHJpZWIg
Q2hhbmcsIEp1bnhpYW86DQo+IEhpIFRob21hcywNCj4gDQo+IFdlIHJlcHJvZHVjZWQgdGhp
cyBpc3N1ZSB3aXRoIFlvY3RvIGltYWdlICsgNS4xOC1yYzMga2VybmVsLg0KPiBJZiB5b3Ug
Y291bGQgdHJ5IFlvY3RvIGltYWdlIGFuZCBlbmFibGUgcHNwbGFzaCwgdGhlIHByb2JsZW0g
Y291bGQgYmUgcmVwcm9kdWNlZCBhbG1vc3QgZXZlcnkgdGltZSBpZiBwc3BsYXNoIGlzIGxh
dW5jaGVkIGJlZm9yZSBJbnRlbCBpOTE1IHJlZ2lzdGVycyAybmQgZnJhbWVidWZmZXIuDQo+
IA0KPiBEdXJpbmcgWW9jdG8gYm9vdGluZyB1cCwgaXQgbGF1bmNoZXMgcHNwbGFzaCB3aGlj
aCBvcGVucyBFRkkgZmlybXdhcmUgZnJhbWVidWZmZXIgYW5kIHBsYXlzIGFuaW1hdGlvbi4g
V2hlbiBpdCBleGl0cywgZmJfcmVsZWFzZSBpbiBrZXJuZWwgbWlnaHQgYWNjZXNzIG1lbW9y
eSB3aGljaCBoYXMgYmVlbiByZWxlYXNlZC4NCj4gDQo+IE92ZXJhbGwgcHJvY2VzcyBsb29r
cyBsaWtlOg0KPiAxLiBFRkkgcmVnaXN0ZXJzIGZyYW1lYnVmZmVyIGluIGVmaWZiX3Byb2Jl
LCBmcmFtZWJ1ZmZlcl9hbGxvYyBpcyBjYWxsZWQgdG8gYWxsb2NhdGUgInN0cnVjdCBmYl9p
bmZvIiBtZW1vcnk7DQo+IDIuIEluIHVzZXJzcGFjZSwgcHNwbGFzaCBpcyBzdGFydGVkIHRv
IHBsYXkgYm9vdCBhbmltYXRpb24sIGl0IG9wZW5zIGZyYW1lYnVmZmVyIGRyaXZlci4gSW4g
ZmJfb3BlbiBmdW5jdGlvbiwgaXQgc2F2ZXMgZmJfaW5mbyBtZW1vcnkgdG8gZmlsZS0+cHJp
dmF0ZV9kYXRhOw0KPiAzLiBXaGVuIEludGVsIGk5MTUgZHJpdmVyIGlzIHByb2JlZCwgaXQg
cmVnaXN0ZXJzIDJuZCBmcmFtZWJ1ZmZlciwgYW5kIHdpbGwgcmVtb3ZlIGNvbmZsaWN0aW5n
IGZyYW1lYnVmZmVyOw0KPiA0LiBJbiBkb19yZW1vdmVfY29uZmxpY3RpbmdfZnJhbWVidWZm
ZXJzLCBpdCBjYWxscyAicGxhdGZvcm1fZGV2aWNlX3VucmVnaXN0ZXIiIHRvIHJlbW92ZSBF
RkkgcGxhdGZvcm0gZnJhbWVidWZmZXIgZGV2aWNlOw0KPiA1LiBJbiBFRkkgZnJhbWVidWZm
ZXIncyBlZmlmYl9yZW1vdmUgZnVuY3Rpb24sIGl0IGNhbGxzIGZyYW1lYnVmZmVyX3JlbGVh
c2UgdG8gcmVsZWFzZSAic3RydWN0IGZiX2luZm8iIG1lbW9yeSB3aGljaCBpcyBzdGlsbCB1
c2UgYW5kIHN0b3JlZCBpbiBmaWxlLT5wcml2YXRlX2RhdGE7DQo+IDYuIFdoZW4gcHNwbGFz
aCB1c2VyIHNwYWNlIGFwcGxpY2F0aW9uIGV4aXRzLCBpdCBjYWxscyBmYl9yZWxlYXNlIGZ1
bmN0aW9uLCBhbmQgYWNjZXNzZXMgdG8gZmJfaW5mbyBtZW1vcnksIGJ1dCBpdCBoYXMgYmVl
biByZWxlYXNlZCBpbiBzdGVwIDUuIEtlcm5lbCBwYW5pYyBoYXBwZW5zLg0KDQpUaGFua3Mg
Zm9yIHRoZSBpbmZvcm1hdGlvbi4gV2Ugb25seSBoYWQgYSBzaW1pbGFyIHJlcG9ydCBhYm91
dCBSUGkgDQpkZXZpY2VzLCBidXQgd2UgbmV2ZXIgZW5jb3VudGVyZWQgdGhpcyBwcm9ibGVt
IGJlZm9yZS4NCg0KPiANCj4gT3VyIHBhdGNoIGlzIHRvIGNoZWNrIHdoZXRoZXIgRUZJIGZy
YW1lYnVmZmVyIGlzIG9wZW5lZCBhdCB0aGF0IHRpbWUuIElmIGl0IGlzIGZyZWUocmVnaXN0
ZXJlZF9mYltpXS0+Y291bnQgPT0gMSksIGdvIGFoZWFkIHRvIHJlbW92ZSBFRkkgcGxhdGZv
cm0gZGV2aWNlLiBPciBlbHNlLCBqdXN0IHVucmVnaXN0ZXIgZnJhbWVidWZmZXIgdG8gYXZv
aWQga2VybmVsIHBhbmljLg0KDQpKYXZpZXIgcG9zdGVkIGEgcG9zc2libGUgZml4IGZvciB0
aGUgcm9vdCBjYXVzZSBvZiB0aGlzIHByb2JsZW0sIGJ1dCANCndlJ3JlIHN0aWxsIGxvb2tp
bmcgZm9yIHRlc3RlcnMuIElmIHlvdSBoYXZlIHRoZSBvcHBvcnR1bml0eSwgY291bGQgeW91
IA0KICBwbGVhc2UgdGVzdCB0aGUgcGF0Y2ggYXQgWzFdIGFuZCByZXBvcnQgYmFjayBvbiB0
aGUgcmVzdWx0cy4NCg0KQmVzdCByZWdhcmRzDQpUaG9tYXMNCg0KWzFdIA0KaHR0cHM6Ly9s
b3JlLmtlcm5lbC5vcmcvZHJpLWRldmVsLzIwMjIwNTAyMTM1MDE0LjM3Nzk0NS0xLWphdmll
cm1AcmVkaGF0LmNvbS9ULyN1DQoNCj4gDQo+IFRoYW5rcywNCj4gSnVueGlhbw0KPiANCj4g
LS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogVGhvbWFzIFppbW1lcm1hbm4g
PHR6aW1tZXJtYW5uQHN1c2UuZGU+DQo+IFNlbnQ6IE1vbmRheSwgTWF5IDIsIDIwMjIgMzoy
NCBQTQ0KPiBUbzogQ2hhbmcsIEp1bnhpYW8gPGp1bnhpYW8uY2hhbmdAaW50ZWwuY29tPjsg
bGludXgtZmJkZXZAdmdlci5rZXJuZWwub3JnDQo+IENjOiBsZXRoYWxAbGludXgtc2gub3Jn
OyBwYXRjaHdvcmstYm90QGtlcm5lbC5vcmc7IGRlbGxlckBnbXguZGU7IExpLCBMaWxpIDxs
aWxpLmxpQGludGVsLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSF0gdmlkZW86IGZiZGV2
OiBkb24ndCByZW1vdmUgZmlybXdhcmUgZmIgZGV2aWNlIGlmIGl0IGlzIGJ1c3kNCj4gDQo+
IEhpDQo+IA0KPiBBbSAzMC4wNC4yMiB1bSAwNDo1NyBzY2hyaWViIEp1bnhpYW8gQ2hhbmc6
DQo+PiBXaGVuIGZpcm13YXJlIGZyYW1lYnVmZmVyIGlzIGluIHVzZSwgZG9uJ3QgcmVtb3Zl
IGl0cyBwbGF0Zm9ybSBkZXZpY2UuDQo+PiBPciBlbHNlIGl0cyBmYl9pbmZvIGJ1ZmZlciBp
cyByZWxlYXNlZCBieSBwbGF0Zm9ybSByZW1vdmUgaG9vayB3aGlsZQ0KPj4gZGV2aWNlIGlz
IHN0aWxsIG9wZW5lZC4gVGhpcyBpbnRyb2R1Y2VzIHVzZSBhZnRlciBmcmVlIGlzc3VlLg0K
PiANCj4gV2hlbiBleGFjdGx5IGRvZXMgdGhpcyBoYXBwZW4/IERvIHlvdSBoYXZlIGEgcmVs
aWFibGUgd2F5IG9mIHJlcHJvZHVjaW5nIGl0Pw0KPiANCj4gQmVzdCByZWdhcmRzDQo+IFRo
b21hcw0KPiANCj4+DQo+PiBBIGtlcm5lbCBwYW5pYyBleGFtcGxlOg0KPj4gQ1BVOiAyIFBJ
RDogMzQyNSBDb21tOiBwc3BsYXNoIFRhaW50ZWQ6IEcgICAgIFUgIFcgICAgIDUuMTguMC1y
YzMNCj4+IEhhcmR3YXJlIG5hbWU6IEludGVsIENsaWVudCBQbGF0Zm9ybS9BRFAtUyBERFI1
IFVESU1NIENSQg0KPj4gUklQOiAwMDEwOm5hdGl2ZV9xdWV1ZWRfc3Bpbl9sb2NrX3Nsb3dw
YXRoKzB4MWM3LzB4MjEwDQo+PiBSU1A6IDAwMTg6ZmZmZmIzYTBjMGMyZmRiMCBFRkxBR1M6
IDAwMDEwMjA2DQo+PiBSQVg6IDAwMmRjMDc0ZmY1YzA5ODggUkJYOiBmZmZmOTJlOTg3YTVk
ODE4IFJDWDogZmZmZjkyZTk4OWJhOWY0MA0KPj4gUkRYOiAwMDAwMDAwMDAwMDAyMDY3IFJT
STogZmZmZmZmZmY4NjQzNDRmMSBSREk6IGZmZmZmZmZmODY0NDE4M2MNCj4+IFJCUDogZmZm
ZjkyZjEwZjRhYmQ0MCBSMDg6IDAwMDAwMDAwMDAwMDAwMDEgUjA5OiBmZmZmOTJlOTg2ZGMy
MTg4IC4uLg0KPj4gQ2FsbCBUcmFjZToNCj4+ICAgIDxUQVNLPg0KPj4gICAgX3Jhd19zcGlu
X2xvY2srMHgyYy8weDMwDQo+PiAgICBfX211dGV4X2xvY2suY29uc3Rwcm9wLjArMHgxNzUv
MHg0ZjANCj4+ICAgID8gX3Jhd19zcGluX3VubG9jaysweDE1LzB4MzANCj4+ICAgID8gbGlz
dF9scnVfYWRkKzB4MTI0LzB4MTYwDQo+PiAgICBmYl9yZWxlYXNlKzB4MWIvMHg2MA0KPj4g
ICAgX19mcHV0KzB4ODkvMHgyNDANCj4+ICAgIHRhc2tfd29ya19ydW4rMHg1OS8weDkwDQo+
PiAgICBkb19leGl0KzB4MzQzLzB4YWYwDQo+PiAgICBkb19ncm91cF9leGl0KzB4MmQvMHg5
MA0KPj4gICAgX194NjRfc3lzX2V4aXRfZ3JvdXArMHgxNC8weDIwDQo+PiAgICBkb19zeXNj
YWxsXzY0KzB4NDAvMHg5MA0KPj4gICAgZW50cnlfU1lTQ0FMTF82NF9hZnRlcl9od2ZyYW1l
KzB4NDQvMHhhZQ0KPj4NCj4+IEZpeGVzOiAyNzU5OWFhY2JhZWYgKCJmYmRldjogSG90LXVu
cGx1ZyBmaXJtd2FyZSBmYiBkZXZpY2VzIG9uIGZvcmNlZA0KPj4gcmVtb3ZhbCIpDQo+PiBT
aWduZWQtb2ZmLWJ5OiBKdW54aWFvIENoYW5nIDxqdW54aWFvLmNoYW5nQGludGVsLmNvbT4N
Cj4+IFNpZ25lZC1vZmYtYnk6IExpbGkgTGkgPGxpbGkubGlAaW50ZWwuY29tPg0KPj4gLS0t
DQo+PiAgICBkcml2ZXJzL3ZpZGVvL2ZiZGV2L2NvcmUvZmJtZW0uYyB8IDQgKysrLQ0KPj4g
ICAgMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPj4N
Cj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3ZpZGVvL2ZiZGV2L2NvcmUvZmJtZW0uYw0KPj4g
Yi9kcml2ZXJzL3ZpZGVvL2ZiZGV2L2NvcmUvZmJtZW0uYw0KPj4gaW5kZXggYTZiYjBlNDM4
MjE2Li5mZjliOTgzMGIzOTggMTAwNjQ0DQo+PiAtLS0gYS9kcml2ZXJzL3ZpZGVvL2ZiZGV2
L2NvcmUvZmJtZW0uYw0KPj4gKysrIGIvZHJpdmVycy92aWRlby9mYmRldi9jb3JlL2ZibWVt
LmMNCj4+IEBAIC0xNTg2LDcgKzE1ODYsOSBAQCBzdGF0aWMgdm9pZCBkb19yZW1vdmVfY29u
ZmxpY3RpbmdfZnJhbWVidWZmZXJzKHN0cnVjdCBhcGVydHVyZXNfc3RydWN0ICphLA0KPj4g
ICAgCQkJCSAqIGZyYW1lYnVmZmVyIGFzIGJlZm9yZSB3aXRob3V0IHdhcm5pbmcuDQo+PiAg
ICAJCQkJICovDQo+PiAgICAJCQkJZG9fdW5yZWdpc3Rlcl9mcmFtZWJ1ZmZlcihyZWdpc3Rl
cmVkX2ZiW2ldKTsNCj4+IC0JCQl9IGVsc2UgaWYgKGRldl9pc19wbGF0Zm9ybShkZXZpY2Up
KSB7DQo+PiArCQkJfSBlbHNlIGlmIChkZXZfaXNfcGxhdGZvcm0oZGV2aWNlKSAmJg0KPj4g
KwkJCQkJcmVmY291bnRfcmVhZCgmcmVnaXN0ZXJlZF9mYltpXS0+Y291bnQpID09IDEpIHsN
Cj4+ICsJCQkJLyogUmVtb3ZlIHBsYXRmb3JtIGRldmljZSBpZiBpdCBpcyBub3QgaW4gdXNl
LiAqLw0KPj4gICAgCQkJCXJlZ2lzdGVyZWRfZmJbaV0tPmZvcmNlZF9vdXQgPSB0cnVlOw0K
Pj4gICAgCQkJCXBsYXRmb3JtX2RldmljZV91bnJlZ2lzdGVyKHRvX3BsYXRmb3JtX2Rldmlj
ZShkZXZpY2UpKTsNCj4+ICAgIAkJCX0gZWxzZSB7DQo+IA0KPiAtLQ0KPiBUaG9tYXMgWmlt
bWVybWFubg0KPiBHcmFwaGljcyBEcml2ZXIgRGV2ZWxvcGVyDQo+IFNVU0UgU29mdHdhcmUg
U29sdXRpb25zIEdlcm1hbnkgR21iSA0KPiBNYXhmZWxkc3RyLiA1LCA5MDQwOSBOw7xybmJl
cmcsIEdlcm1hbnkNCj4gKEhSQiAzNjgwOSwgQUcgTsO8cm5iZXJnKQ0KPiBHZXNjaMOkZnRz
ZsO8aHJlcjogSXZvIFRvdGV2DQoNCi0tIA0KVGhvbWFzIFppbW1lcm1hbm4NCkdyYXBoaWNz
IERyaXZlciBEZXZlbG9wZXINClNVU0UgU29mdHdhcmUgU29sdXRpb25zIEdlcm1hbnkgR21i
SA0KTWF4ZmVsZHN0ci4gNSwgOTA0MDkgTsO8cm5iZXJnLCBHZXJtYW55DQooSFJCIDM2ODA5
LCBBRyBOw7xybmJlcmcpDQpHZXNjaMOkZnRzZsO8aHJlcjogSXZvIFRvdGV2DQo=

--------------mrKb0cSzqUf9UJW0GG8tpDUN--

--------------gYNZwOFH3p0SUM83Z0va1aM3
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEExndm/fpuMUdwYFFolh/E3EQov+AFAmJw1sAFAwAAAAAACgkQlh/E3EQov+AH
xhAAuByFz7FKki/Ke31++mxDjfuj2MzuCF1KaNYMY7LPZ7RRN4yOHdlcTH+uQA+Z3CTVupASwLgu
vKvkrOgkgQ2/KY+KdnkG11a/rpfZUDjEkBubIbBd6YKnZv6R4JGJRQ7/ajl6UNWXMWhG/yuFdzPe
YbsldsONPXTgho1Mkk0oqbTbg4VmpeD+MhJkRAi+qGf4QtFZRfWB2pqM/B4oV5+AGuc+1PZUjq9t
1AJl/q7Ss3iDfsjG+OOKECujd6cIiidoXUgyugf8fPWkCHPX+fO4iHrqsrp5eg4ANJhHH/Yef03i
HQ/LHAVPE6Uc4hYrr4zQfwF+/1vj+R+MwVGKfYjAZL95yK996RFG4bYbqYeyVjHuxSk5/4S/mFqi
rCBBrc0L7w+vn8iGX9dbDh6dhTcldbGgW4hDZNBH53aSuHs6jQWSm7OiJH30di3+HJmKHvsd/HaA
AZPlJMYlb6Nb8vu59MJoP564wtPA5euDt53FoN4/+sirvYyw/XgM5nV3sIqZYTTnloUS9C8uj3Lw
B+f9yHJDKYMRKLCTjMXbSCp/PtKpcXT4zAGAwtx0/Ye72R7C9Mv5tEi62FCKQF8DrRxTVA9cnMMO
n+J7ATNKbB1SYVWZD/yO5hgv2JXEr4jWFM0KwhLnNHr2eXo6bN0YhpyS+JfVfjhz0RsvAr55tGi4
teY=
=909y
-----END PGP SIGNATURE-----

--------------gYNZwOFH3p0SUM83Z0va1aM3--
