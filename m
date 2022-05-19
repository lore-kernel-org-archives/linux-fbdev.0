Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CB89C433F5
	for <linux-fbdev@archiver.kernel.org>; Thu, 19 May 2022 07:28:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229741AbiESH2i (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Thu, 19 May 2022 03:28:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230184AbiESH14 (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Thu, 19 May 2022 03:27:56 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2728E87202
        for <linux-fbdev@vger.kernel.org>; Thu, 19 May 2022 00:27:55 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id C543921C00;
        Thu, 19 May 2022 07:27:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1652945273; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nXI7yzPNPnzOjOuZs/6VSTJImcFeRc6CqE6DQhBe4HQ=;
        b=l5fICcoTbiSH8XptsNdnLm+Qewud3PjRemNCodqNXNzeDboRhb0rijsRpXpWzChBBARPe9
        0m/s/TiBWw8GSE8ZyRJvFO2LrkkmwITz7CHxak+V0H7Uv3XwojBi7o9yiRkDlBuaY5lXWK
        NwXQUBuXbQSwv9YVvgjK9sOLHqZE9Ww=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1652945273;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nXI7yzPNPnzOjOuZs/6VSTJImcFeRc6CqE6DQhBe4HQ=;
        b=+xTN5Cyizl0Pt0HgX3UYUfSxkQbRZqyDn/EbBdssziaw6TxmVRACu3Rh/urHZIqJOITBr/
        r+nZuPKURo6bCiAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7977013B1E;
        Thu, 19 May 2022 07:27:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id jQCeHHnxhWKKHAAAMHmgww
        (envelope-from <tzimmermann@suse.de>); Thu, 19 May 2022 07:27:53 +0000
Message-ID: <29a8201d-3c0c-eeed-81af-92b351880702@suse.de>
Date:   Thu, 19 May 2022 09:27:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH 2/2] drm/tiny: Add ofdrm for Open Firmware framebuffers
Content-Language: en-US
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        =?UTF-8?Q?Michal_Such=c3=a1nek?= <msuchanek@suse.de>
Cc:     Javier Martinez Canillas <javierm@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Helge Deller <deller@gmx.de>,
        Maxime Ripard <maxime@cerno.tech>,
        Sam Ravnborg <sam@ravnborg.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
References: <20220518183006.14548-1-tzimmermann@suse.de>
 <20220518183006.14548-3-tzimmermann@suse.de>
 <20220518185156.GJ163591@kunlun.suse.cz>
 <CAMuHMdUws2eJ4pHng4GD0PjuvMj5Hef_y_YyM4fUJV9xdUVuEQ@mail.gmail.com>
From:   Thomas Zimmermann <tzimmermann@suse.de>
In-Reply-To: <CAMuHMdUws2eJ4pHng4GD0PjuvMj5Hef_y_YyM4fUJV9xdUVuEQ@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------5dmllPELt0GXPjcxnqG0e0cu"
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------5dmllPELt0GXPjcxnqG0e0cu
Content-Type: multipart/mixed; boundary="------------0ijXJBb6W00VkW8KF1l4qRcR";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann@suse.de>
To: Geert Uytterhoeven <geert@linux-m68k.org>,
 =?UTF-8?Q?Michal_Such=c3=a1nek?= <msuchanek@suse.de>
Cc: Javier Martinez Canillas <javierm@redhat.com>,
 David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
 Helge Deller <deller@gmx.de>, Maxime Ripard <maxime@cerno.tech>,
 Sam Ravnborg <sam@ravnborg.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 DRI Development <dri-devel@lists.freedesktop.org>,
 Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Message-ID: <29a8201d-3c0c-eeed-81af-92b351880702@suse.de>
Subject: Re: [PATCH 2/2] drm/tiny: Add ofdrm for Open Firmware framebuffers
References: <20220518183006.14548-1-tzimmermann@suse.de>
 <20220518183006.14548-3-tzimmermann@suse.de>
 <20220518185156.GJ163591@kunlun.suse.cz>
 <CAMuHMdUws2eJ4pHng4GD0PjuvMj5Hef_y_YyM4fUJV9xdUVuEQ@mail.gmail.com>
In-Reply-To: <CAMuHMdUws2eJ4pHng4GD0PjuvMj5Hef_y_YyM4fUJV9xdUVuEQ@mail.gmail.com>

--------------0ijXJBb6W00VkW8KF1l4qRcR
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGkNCg0KQW0gMTkuMDUuMjIgdW0gMDk6MTEgc2NocmllYiBHZWVydCBVeXR0ZXJob2V2ZW46
DQo+IEhpIE1pY2hhbCwNCj4gDQo+IE9uIFdlZCwgTWF5IDE4LCAyMDIyIGF0IDg6NTQgUE0g
TWljaGFsIFN1Y2jDoW5layA8bXN1Y2hhbmVrQHN1c2UuZGU+IHdyb3RlOg0KPj4gT24gV2Vk
LCBNYXkgMTgsIDIwMjIgYXQgMDg6MzA6MDZQTSArMDIwMCwgVGhvbWFzIFppbW1lcm1hbm4g
d3JvdGU6DQo+Pj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL3RpbnkvS2NvbmZpZw0KPj4+ICsr
KyBiL2RyaXZlcnMvZ3B1L2RybS90aW55L0tjb25maWcNCj4+PiBAQCAtNTEsNiArNTEsMTgg
QEAgY29uZmlnIERSTV9HTTEyVTMyMA0KPj4+ICAgICAgICAgVGhpcyBpcyBhIEtNUyBkcml2
ZXIgZm9yIHByb2plY3RvcnMgd2hpY2ggdXNlIHRoZSBHTTEyVTMyMCBjaGlwc2V0DQo+Pj4g
ICAgICAgICBmb3IgdmlkZW8gdHJhbnNmZXIgb3ZlciBVU0IyLzMsIHN1Y2ggYXMgdGhlIEFj
ZXIgQzEyMCBtaW5pIHByb2plY3Rvci4NCj4+Pg0KPj4+ICtjb25maWcgRFJNX09GRFJNDQo+
Pj4gKyAgICAgdHJpc3RhdGUgIk9wZW4gRmlybXdhcmUgZGlzcGxheSBkcml2ZXIiDQo+Pj4g
KyAgICAgZGVwZW5kcyBvbiBEUk0gJiYgTU1VICYmIFBQQw0KPj4NCj4+IERvZXMgdGhpcyBi
dWlsZCB3aXRoICFQQ0k/DQo+Pg0KPj4gVGhlIGRyaXZlciB1c2VzIHNvbWUgUENJIGZ1bmN0
aW9ucywgc28gaXQgbWlnaHQgcG9zc2libHkgYnJlYWsgd2l0aA0KPj4gcmFuZGNvbmZpZy4g
SSBkb24ndCB0aGluayB0aGVyZSBhcmUgcHJhY3RpY2FsICFQQ0kgUFBDIGNvbmZpZ3VyYXRp
b25zLg0KPiANCj4gSUlSQywgdGhlIGZpcnN0IFBvd2VyTWFjcyBkaWRuJ3QgaGF2ZSBQQ0ku
DQoNCkknbGwgdHJ5IHRvIGJ1aWxkIHdpdGhvdXQgUENJIHRvIHNlZSB3aGF0IGhhcHBlbnMu
DQoNClRob3NlIG9sZCBNYWNzIHVzZSBCb290WCwgcmlnaHQ/IEJvb3RYIGlzIG5vdCBzdXBw
b3J0ZWQgQVRNLCBhcyBJIGRvbid0IA0KaGF2ZSB0aGUgSFcgdG8gdGVzdC4gSXMgdGhlcmUg
YW4gZW11bGF0b3IgZm9yIGl0Pw0KDQpJZiBhbnlvbmUgd2hhdCdzIHRvIG1ha2UgcGF0Y2hl
cyBmb3IgQm9vdFgsIEknZCBiZSBoYXBweSB0byBhZGQgdGhlbS4gDQpUaGUgb2ZmYiBkcml2
ZXIgYWxzbyBzdXBwb3J0cyBhIG51bWJlciBvZiBzcGVjaWFsIGNhc2VzIGZvciBwYWxldHRl
IA0KaGFuZGxpbmcuIFRoYXQgbWlnaHQgYmUgbmVjZXNzYXJ5IGZvciBvZmRybSBhcyB3ZWxs
Lg0KDQpCZXN0IHJlZ2FyZHMNClRob21hcw0KDQo+IA0KPiBHcntvZXRqZSxlZXRpbmd9cywN
Cj4gDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICBHZWVydA0KPiANCj4gLS0NCj4gR2Vl
cnQgVXl0dGVyaG9ldmVuIC0tIFRoZXJlJ3MgbG90cyBvZiBMaW51eCBiZXlvbmQgaWEzMiAt
LSBnZWVydEBsaW51eC1tNjhrLm9yZw0KPiANCj4gSW4gcGVyc29uYWwgY29udmVyc2F0aW9u
cyB3aXRoIHRlY2huaWNhbCBwZW9wbGUsIEkgY2FsbCBteXNlbGYgYSBoYWNrZXIuIEJ1dA0K
PiB3aGVuIEknbSB0YWxraW5nIHRvIGpvdXJuYWxpc3RzIEkganVzdCBzYXkgInByb2dyYW1t
ZXIiIG9yIHNvbWV0aGluZyBsaWtlIHRoYXQuDQo+ICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIC0tIExpbnVzIFRvcnZhbGRzDQoNCi0tIA0KVGhvbWFzIFppbW1lcm1hbm4N
CkdyYXBoaWNzIERyaXZlciBEZXZlbG9wZXINClNVU0UgU29mdHdhcmUgU29sdXRpb25zIEdl
cm1hbnkgR21iSA0KTWF4ZmVsZHN0ci4gNSwgOTA0MDkgTsO8cm5iZXJnLCBHZXJtYW55DQoo
SFJCIDM2ODA5LCBBRyBOw7xybmJlcmcpDQpHZXNjaMOkZnRzZsO8aHJlcjogSXZvIFRvdGV2
DQo=

--------------0ijXJBb6W00VkW8KF1l4qRcR--

--------------5dmllPELt0GXPjcxnqG0e0cu
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEExndm/fpuMUdwYFFolh/E3EQov+AFAmKF8XkFAwAAAAAACgkQlh/E3EQov+Bw
qA//b+WhxjuVqw5fF88PrCclvvjaIg96oxQuhY7CfII1Roq/mmFFQzZVopt/SpPFLKBZJeA0q+VI
rycm+DjiLt6a+RFAJbjlqwlKvSTeoK1xsYD6GUdVxcIe+oCjHCHnVFZ4aVcDRdqKQPDaGmvY/qEY
6/A8KO7SO7PVEOe0y9yjl3vwINRJrkV+nfA8+CF56j4MJD9mtHxdPYVpnyrhnO2o5iWNhL9KGaa1
iMuIpiW5cbRpm6nJ99lqe2zxtaoz4bNNPiyOik+Ei0CpLl5y7KaN10Hx5ULyUkRd0TsKqBXI6sej
vUwiMnNl5NM54dB6TMA6O+zB7eniVxa/ITJmaxoY9O55h58Vx4OEw0mxNXb8n2MJZIQ+e8qTH8vW
CxmplADM/j1xXQ+c6ze+ERlri6LFb4umSjvF9VP4adaEZQuEJDHu8HhYyCjEa3qx2B2Jnf1Tiikk
h1WWS/60QPJsKrw+CRyql+QAokEoZxFYVGzVv73ohgQpWmuzrNUdU3v3utubqvBZAHwgLr/z71YQ
AIlQIK4ghYI57ADtz6HMWqV63SiK54LkaFnZtrmudUIuD5AvDlmAmQHGuPEBDjKHnhvAjeZ2TXHE
jA70jCwg9iIIRiaF8+OEO/bWUuzcGgirxd5FhcCX5HhZksJsgenXw2DSqpLOqdjxUI3FKShaT9as
/e0=
=ww3S
-----END PGP SIGNATURE-----

--------------5dmllPELt0GXPjcxnqG0e0cu--
