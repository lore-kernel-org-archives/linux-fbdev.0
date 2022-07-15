Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2EBAC433EF
	for <linux-fbdev@archiver.kernel.org>; Fri, 15 Jul 2022 11:58:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230102AbiGOL6O (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Fri, 15 Jul 2022 07:58:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbiGOL6N (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Fri, 15 Jul 2022 07:58:13 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90B6F89EB7
        for <linux-fbdev@vger.kernel.org>; Fri, 15 Jul 2022 04:58:12 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 4C3FC34D6E;
        Fri, 15 Jul 2022 11:58:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1657886291; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=a8JmdST4Lo7mEf36LoInF0FvbOYTCpy5tGRrFXUHQx0=;
        b=PEZhJoL+pjSAbIUAHK5olaZRrj+ggKT0FTKtURHx3en576qTmrvzyt09UBWfC173dnw0DN
        CIu5WwWmp+aZgAj7lIF4OiYi7DUMqGTN485Y32a6d36tGDGBoNwy2uyxNgUuwebrW6Byn+
        dCvMLD4yF/Tigpg0RhMHrk60q12T9Ok=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1657886291;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=a8JmdST4Lo7mEf36LoInF0FvbOYTCpy5tGRrFXUHQx0=;
        b=mSlnC6iM3TWK9MrqkCXS/2bQ2O6TOgSsjk5liAkKoepQLZ0jp91ur9D6icYxRyuCbHa3TQ
        172Gz9C9IzFmJrBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 21BEC13754;
        Fri, 15 Jul 2022 11:58:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id xRtDB1NW0WIHAgAAMHmgww
        (envelope-from <tzimmermann@suse.de>); Fri, 15 Jul 2022 11:58:11 +0000
Message-ID: <e06202b3-5350-56e7-26c6-ba9ae1ae7a36@suse.de>
Date:   Fri, 15 Jul 2022 13:58:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 10/11] fbdev: Acquire framebuffer apertures for firmware
 devices
Content-Language: en-US
To:     Javier Martinez Canillas <javierm@redhat.com>, deller@gmx.de,
        daniel@ffwll.ch, sam@ravnborg.org, maxime@cerno.tech
Cc:     linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
        dri-devel@lists.freedesktop.org
References: <20220707153952.32264-1-tzimmermann@suse.de>
 <20220707153952.32264-11-tzimmermann@suse.de>
 <3f22174e-e1ee-1c1e-c643-37d437af7578@redhat.com>
From:   Thomas Zimmermann <tzimmermann@suse.de>
In-Reply-To: <3f22174e-e1ee-1c1e-c643-37d437af7578@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------6GH0j04Z2LMK0kXsXJ0ksBoK"
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------6GH0j04Z2LMK0kXsXJ0ksBoK
Content-Type: multipart/mixed; boundary="------------kiCGlvrWslyBzQRMKoFVl0MK";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann@suse.de>
To: Javier Martinez Canillas <javierm@redhat.com>, deller@gmx.de,
 daniel@ffwll.ch, sam@ravnborg.org, maxime@cerno.tech
Cc: linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
 dri-devel@lists.freedesktop.org
Message-ID: <e06202b3-5350-56e7-26c6-ba9ae1ae7a36@suse.de>
Subject: Re: [PATCH 10/11] fbdev: Acquire framebuffer apertures for firmware
 devices
References: <20220707153952.32264-1-tzimmermann@suse.de>
 <20220707153952.32264-11-tzimmermann@suse.de>
 <3f22174e-e1ee-1c1e-c643-37d437af7578@redhat.com>
In-Reply-To: <3f22174e-e1ee-1c1e-c643-37d437af7578@redhat.com>

--------------kiCGlvrWslyBzQRMKoFVl0MK
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGkNCg0KQW0gMTEuMDcuMjIgdW0gMTM6Mjkgc2NocmllYiBKYXZpZXIgTWFydGluZXogQ2Fu
aWxsYXM6DQo+IE9uIDcvNy8yMiAxNzozOSwgVGhvbWFzIFppbW1lcm1hbm4gd3JvdGU6DQo+
PiBXaGVuIHJlZ2lzdGVyaW5nIGEgZ2VuZXJpYyBmcmFtZWJ1ZmZlciwgYXV0b21hdGljYWxs
eSBhY3F1aXJlIG93bmVyc2hpcA0KPj4gb2YgdGhlIGZyYW1lYnVmZmVyJ3MgSS9PIHJhbmdl
LiBUaGUgZGV2aWNlIHdpbGwgbm93IGJlIGhhbmRsZWQgYnkgdGhlDQo+PiBhcGVydHVyZSBo
ZWxwZXJzLiBGYmRldi1iYXNlZCBjb25mbGljdCBoYW5kbGluZyBpcyBubyBsb25nZXIgcmVx
dWlyZWQuDQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogVGhvbWFzIFppbW1lcm1hbm4gPHR6aW1t
ZXJtYW5uQHN1c2UuZGU+DQo+PiAtLS0NCj4+ICAgZHJpdmVycy92aWRlby9mYmRldi9jb3Jl
L2ZibWVtLmMgfCAzMyArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKw0KPj4gICAx
IGZpbGUgY2hhbmdlZCwgMzMgaW5zZXJ0aW9ucygrKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9k
cml2ZXJzL3ZpZGVvL2ZiZGV2L2NvcmUvZmJtZW0uYyBiL2RyaXZlcnMvdmlkZW8vZmJkZXYv
Y29yZS9mYm1lbS5jDQo+PiBpbmRleCAyMjM3MDQ5MzI3ZGIuLmU1NTZhZDY5ZjQ4ZiAxMDA2
NDQNCj4+IC0tLSBhL2RyaXZlcnMvdmlkZW8vZmJkZXYvY29yZS9mYm1lbS5jDQo+PiArKysg
Yi9kcml2ZXJzL3ZpZGVvL2ZiZGV2L2NvcmUvZmJtZW0uYw0KPj4gQEAgLTEzLDYgKzEzLDcg
QEANCj4+ICAgDQo+PiAgICNpbmNsdWRlIDxsaW51eC9tb2R1bGUuaD4NCj4+ICAgDQo+PiAr
I2luY2x1ZGUgPGxpbnV4L2FwZXJ0dXJlLmg+DQo+PiAgICNpbmNsdWRlIDxsaW51eC9jb21w
YXQuaD4NCj4+ICAgI2luY2x1ZGUgPGxpbnV4L3R5cGVzLmg+DQo+PiAgICNpbmNsdWRlIDxs
aW51eC9lcnJuby5oPg0KPj4gQEAgLTE3MzksNiArMTc0MCwzMiBAQCBzdGF0aWMgdm9pZCBk
b191bnJlZ2lzdGVyX2ZyYW1lYnVmZmVyKHN0cnVjdCBmYl9pbmZvICpmYl9pbmZvKQ0KPj4g
ICAJcHV0X2ZiX2luZm8oZmJfaW5mbyk7DQo+PiAgIH0NCj4+ICAgDQo+PiArc3RhdGljIGlu
dCBmYm1fYXBlcnR1cmVfYWNxdWlyZV9mb3JfcGxhdGZvcm1fZGV2aWNlKHN0cnVjdCBmYl9p
bmZvICpmYl9pbmZvKQ0KPj4gK3sNCj4gDQo+IFdoYXQncyB0aGUgbWVhbmluZyBvZiAnbScg
aGVyZSA/IE1pc2MsIG1lbW9yeSA/IEkgd291bGQganVzdCBjYWxsIGl0ICdmYl8nLg0KDQon
bWFuYWdlZCcgYXMgaW4gZHJtbV8gQnV0IHVzaW5nIGZiXyBpcyBhbHNvIGdvb2QuIEkgYWN0
dWFsbHkgd2Fzbid0IHN1cmUgDQphYm91dCB0aGlzIG5hbWluZy4NCg0KQmVzdCByZWdhcmRz
DQpUaG9tYXMNCg0KPiANCj4gUmV2aWV3ZWQtYnk6IEphdmllciBNYXJ0aW5leiBDYW5pbGxh
cyA8amF2aWVybUByZWRoYXQuY29tPg0KPiANCg0KLS0gDQpUaG9tYXMgWmltbWVybWFubg0K
R3JhcGhpY3MgRHJpdmVyIERldmVsb3Blcg0KU1VTRSBTb2Z0d2FyZSBTb2x1dGlvbnMgR2Vy
bWFueSBHbWJIDQpNYXhmZWxkc3RyLiA1LCA5MDQwOSBOw7xybmJlcmcsIEdlcm1hbnkNCihI
UkIgMzY4MDksIEFHIE7DvHJuYmVyZykNCkdlc2Now6RmdHNmw7xocmVyOiBJdm8gVG90ZXYN
Cg==

--------------kiCGlvrWslyBzQRMKoFVl0MK--

--------------6GH0j04Z2LMK0kXsXJ0ksBoK
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEExndm/fpuMUdwYFFolh/E3EQov+AFAmLRVlIFAwAAAAAACgkQlh/E3EQov+Db
mA//QOtVRDcENxdwcK73Yvd/iP6FGVicDdmaLMFYFrB6JJKpj+UZZlWIlV8iRSLDjTnnO+3O+oUC
htEJ0WOZ3kv14fpQrQ/eOwTep2e3B5KT7oGXKQ9BbtLTl3dxuEZnk/Jw+qHNrOnP7Wc+ksyfV79I
HJY9hckvCT0Ujz9gPD7YB/6hFL8Y3kUXf2egHDMwyRHy3Ln6X2q72V14jP0cMKL9VPJtrZxAyujO
HQ+4PpxOu+S+NhenNVnh8k3OOrzu/xUZ4gj2ZS5V8J1vtaaa7AjX0I1ZdMuNoWLYjYys0cN7jFUb
UgWTKXI6uz4QpisBXobYVt6vsdekcilFc93hgiUdmtRtesWxA+IVd1txqbly8OEVgqIawLZgqmT5
KazrP3+FXsCdx6VGxPPn5GUk8D00lqpieuCZ1vqaeVwHiIhtZrOLQebDvCd1Xv7+lah1FWLMwj70
bZN7MdB6XhYgjYjZ+9mVzKjUs1M0DvSsnkzUVpMfLjqDIqsymE3LE698n+yQVk8tbqy8Bi7AOeAv
2N+AQOgPhUGoHF0NAqoSyvhrvH4sQrYytLSYCyyttx213q6/MJqp5USfxlDlHOv8qZIDeNvnUaPV
Mvg9x64NlEDbnQLQlX/oLWQEATnVcxhLXb30ucP2qleNDzVdslBimqs4eM+Z+dEdyxTEfoHnfvCZ
kks=
=e49S
-----END PGP SIGNATURE-----

--------------6GH0j04Z2LMK0kXsXJ0ksBoK--
