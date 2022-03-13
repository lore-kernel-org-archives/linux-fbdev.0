Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F7DFC433EF
	for <linux-fbdev@archiver.kernel.org>; Sun, 13 Mar 2022 19:23:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229518AbiCMTY4 (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Sun, 13 Mar 2022 15:24:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230155AbiCMTYz (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Sun, 13 Mar 2022 15:24:55 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1707F193CD
        for <linux-fbdev@vger.kernel.org>; Sun, 13 Mar 2022 12:23:46 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 5470C1F37B;
        Sun, 13 Mar 2022 19:23:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1647199424; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Nkkj12+tv1AnRM+Or9b6CddObiLNZasVqwdYNffCuqk=;
        b=Cn0SuAjZAzXk1h5NoUcgd3nsrH90I4QC10Ee0l/ax+cIaOy+5ysYRH5ZnwlfNG0lY6Cbgh
        UvI40W08o7BG2KJBf+DHmFjJGk34SRn5D0s5pOV4rwdqj3RdHEwEvg+ztgdfuWBLCsG9/e
        0h6N3LJP76SLapySbbW9InsBcC692J4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1647199424;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Nkkj12+tv1AnRM+Or9b6CddObiLNZasVqwdYNffCuqk=;
        b=QI47LzpRKe2LhU3R/TOtERrGycJoEPFyyb72SATZcbE5MFAbmqb51ecs4Ta65dEUteZUMU
        wi5Fywcho9H33uCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1898913AFE;
        Sun, 13 Mar 2022 19:23:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id sYA3BMBELmLzEwAAMHmgww
        (envelope-from <tzimmermann@suse.de>); Sun, 13 Mar 2022 19:23:44 +0000
Message-ID: <ffcb6d57-1804-2112-ed4a-a67a4cd35663@suse.de>
Date:   Sun, 13 Mar 2022 20:23:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [v3,4/5] fbdev: Improve performance of cfb_imageblit()
Content-Language: en-US
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Daniel Vetter <daniel@ffwll.ch>, Helge Deller <deller@gmx.de>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Pekka Paalanen <ppaalanen@gmail.com>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>
References: <20220223193804.18636-5-tzimmermann@suse.de>
 <CGME20220308225225eucas1p12fcdd6e5dc83308b19d51ad7b2a13141@eucas1p1.samsung.com>
 <21110de8-d52a-e55e-8853-1f073c4ab969@samsung.com>
 <a7c8ee6c-185e-916c-c92a-d3b3f4fd9135@suse.de>
 <f318d57d-ef9e-295a-6865-eb0377a9bd07@samsung.com>
 <CAMuHMdU4w-68-V2QXqbJqorL3iQFyBSRkGTrz5ePFRRUC8mRzw@mail.gmail.com>
 <d8726a6e-d0a9-1471-c113-a7bf567aa994@suse.de>
 <CAMuHMdVO0-q8CU7CAf-5O1CQ3e-8eeg73KgbS8uDAVY+vnd6nw@mail.gmail.com>
From:   Thomas Zimmermann <tzimmermann@suse.de>
In-Reply-To: <CAMuHMdVO0-q8CU7CAf-5O1CQ3e-8eeg73KgbS8uDAVY+vnd6nw@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------Cdng91sFzWXT67fXrtzX0RX5"
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------Cdng91sFzWXT67fXrtzX0RX5
Content-Type: multipart/mixed; boundary="------------aDeuT8Y9NbbF05ul4K0q3PDe";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann@suse.de>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>,
 Daniel Vetter <daniel@ffwll.ch>, Helge Deller <deller@gmx.de>,
 Javier Martinez Canillas <javierm@redhat.com>,
 Sam Ravnborg <sam@ravnborg.org>, Gerd Hoffmann <kraxel@redhat.com>,
 Pekka Paalanen <ppaalanen@gmail.com>,
 Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
 DRI Development <dri-devel@lists.freedesktop.org>
Message-ID: <ffcb6d57-1804-2112-ed4a-a67a4cd35663@suse.de>
Subject: Re: [v3,4/5] fbdev: Improve performance of cfb_imageblit()
References: <20220223193804.18636-5-tzimmermann@suse.de>
 <CGME20220308225225eucas1p12fcdd6e5dc83308b19d51ad7b2a13141@eucas1p1.samsung.com>
 <21110de8-d52a-e55e-8853-1f073c4ab969@samsung.com>
 <a7c8ee6c-185e-916c-c92a-d3b3f4fd9135@suse.de>
 <f318d57d-ef9e-295a-6865-eb0377a9bd07@samsung.com>
 <CAMuHMdU4w-68-V2QXqbJqorL3iQFyBSRkGTrz5ePFRRUC8mRzw@mail.gmail.com>
 <d8726a6e-d0a9-1471-c113-a7bf567aa994@suse.de>
 <CAMuHMdVO0-q8CU7CAf-5O1CQ3e-8eeg73KgbS8uDAVY+vnd6nw@mail.gmail.com>
In-Reply-To: <CAMuHMdVO0-q8CU7CAf-5O1CQ3e-8eeg73KgbS8uDAVY+vnd6nw@mail.gmail.com>

--------------aDeuT8Y9NbbF05ul4K0q3PDe
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGkgR2VlcnQNCg0KQW0gMTAuMDMuMjIgdW0gMjA6MjMgc2NocmllYiBHZWVydCBVeXR0ZXJo
b2V2ZW46DQpbLi4uXQ0KPj4NCj4+IEhvdyBkbyBJIGFjdGl2YXRlIHRoZSA3eDE0IGZvbnQ/
IEl0J3MgY29tcGlsZWQgaW50byB0aGUga2VybmVsIGFscmVhZHkNCj4+IChDT05GSUdfRk9O
VF83eDE0PXkpLg0KPiANCj4gRG9jdW1lbnRhdGlvbi9mYi9mYmNvbi5yc3Q6MS4gZmJjb249
Zm9udDo8bmFtZT4NCj4gDQo+IE9yIGp1c3QgZGlzYWJsZSBhbGwgb3RoZXIgZm9udHMuDQoN
ClRoYW5rcy4gSSd2ZSBiZWVuIGFibGUgdG8gcmVwcm9kdWNlIHRoZSBwcm9ibGVtIGFuZCB3
aWxsIHNlbmQgYSBwYXRjaCBzb29uLg0KDQpCZXN0IHJlZ2FyZHMNClRob21hcw0KDQo+IA0K
PiBHcntvZXRqZSxlZXRpbmd9cywNCj4gDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICBH
ZWVydA0KPiANCj4gLS0NCj4gR2VlcnQgVXl0dGVyaG9ldmVuIC0tIFRoZXJlJ3MgbG90cyBv
ZiBMaW51eCBiZXlvbmQgaWEzMiAtLSBnZWVydEBsaW51eC1tNjhrLm9yZw0KPiANCj4gSW4g
cGVyc29uYWwgY29udmVyc2F0aW9ucyB3aXRoIHRlY2huaWNhbCBwZW9wbGUsIEkgY2FsbCBt
eXNlbGYgYSBoYWNrZXIuIEJ1dA0KPiB3aGVuIEknbSB0YWxraW5nIHRvIGpvdXJuYWxpc3Rz
IEkganVzdCBzYXkgInByb2dyYW1tZXIiIG9yIHNvbWV0aGluZyBsaWtlIHRoYXQuDQo+ICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIC0tIExpbnVzIFRvcnZhbGRzDQoNCi0t
IA0KVGhvbWFzIFppbW1lcm1hbm4NCkdyYXBoaWNzIERyaXZlciBEZXZlbG9wZXINClNVU0Ug
U29mdHdhcmUgU29sdXRpb25zIEdlcm1hbnkgR21iSA0KTWF4ZmVsZHN0ci4gNSwgOTA0MDkg
TsO8cm5iZXJnLCBHZXJtYW55DQooSFJCIDM2ODA5LCBBRyBOw7xybmJlcmcpDQpHZXNjaMOk
ZnRzZsO8aHJlcjogSXZvIFRvdGV2DQo=

--------------aDeuT8Y9NbbF05ul4K0q3PDe--

--------------Cdng91sFzWXT67fXrtzX0RX5
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEExndm/fpuMUdwYFFolh/E3EQov+AFAmIuRL8FAwAAAAAACgkQlh/E3EQov+DN
uA/8CBjG7W/uFGU2Uw8ANoQxlxnKeb6Q+KrDDEoxYD1m0EpbuH0S6MdgevjYcWfmGE6eqLMtf4o5
KDYg9xGbl1XLSOLx9bkxObHDeKsh13X41rteHIoa0kOwgDggXxIubT/6uauueIv0MFDW9M6E2UUs
xVTKTkVtX+LWYOyfoTceIfXZLUwSYqJzcLsbjGPYCS7ck1BT5Z/hZQvLtpkHb0wdYP9QeKxIG8QD
rBiwEAgdFj8X9v9H4HnB4tJ37ZunF6p35ybG9hml1Cg66mVVCWZ/GrpCyQ6S3wk80upSzCqZH9uN
cGBa/AdR8m5Z/5+k0VG081Gfr4CWOUOeBxR227GXu2rD1CYYL4b56CXL2j1+D7K1qurM/PV7L9Cd
1x0tbqN7UageGqGx5KWwOHOS4GeYMIyk7vLr1A5obOYPt7lQ7ljGS/DNtqarDZJnZReuAiXiv2ky
wvOSHLmfh6+7ZRhVNZ1WyMUucHBTaO7etaKrEhQZak8HfCVwmIgUQjJy4JwfMu9ToHizd/qbHMtm
On2U9sIhN0pi4pT/M8mfOwpYj/6Ra48D8AkqvhvJnjcQgrqqBnw5+fGEE1nzEj+QyWhGvuO0l0t3
GnubN/dAtiaPVnP5Txcb/X4cBSE8EaOydlYNz8AcjU5yZnAe7nrI0fWwPc7T1lzXDSK3vmV1YBpt
flg=
=rYy3
-----END PGP SIGNATURE-----

--------------Cdng91sFzWXT67fXrtzX0RX5--
