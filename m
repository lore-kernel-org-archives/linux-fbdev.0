Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8A39C433FE
	for <linux-fbdev@archiver.kernel.org>; Wed, 16 Nov 2022 08:47:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233263AbiKPIrG (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 16 Nov 2022 03:47:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231259AbiKPIrD (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Wed, 16 Nov 2022 03:47:03 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85904193EF
        for <linux-fbdev@vger.kernel.org>; Wed, 16 Nov 2022 00:47:01 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id C5FAE1F917;
        Wed, 16 Nov 2022 08:46:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1668588419; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=f8xsodB29M0YHl5cgmPZ4kptVwsvYgCqWImnEyfEags=;
        b=rF90pqrQimfw/MuQWTIYOq4Yw7e2lXoBvGwaiECFfkZ6TNfHvMUJCiBtNNKCkqj2XmkCD5
        l2Kb01cXk4jbFc/VaB8dXkWC64mpIHR59pg6vdWrOtsCBbny12wrcrtdnqLmroXEwAi+wT
        qb9tdn9DeqxjYIfx6Lcc5k8FbLuTips=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1668588419;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=f8xsodB29M0YHl5cgmPZ4kptVwsvYgCqWImnEyfEags=;
        b=r7NL0Ie0gTOTjs2jfYRjtZ4tv21JW5Jf+dmwb4lku1DsWzmVGOwp2HbTs8kmV8Ty1rxxXF
        6o+6f1XsPqiX2dDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id AE19513480;
        Wed, 16 Nov 2022 08:46:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id GKoLKYOjdGPzIgAAMHmgww
        (envelope-from <tzimmermann@suse.de>); Wed, 16 Nov 2022 08:46:59 +0000
Message-ID: <ab379da4-f137-c820-277f-5432ea80cdee@suse.de>
Date:   Wed, 16 Nov 2022 09:46:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] Add framebuffer device driver for gamecube/wii,
 incorporating Farter's work.
To:     Zopolis0 <creatorsmithmdt@gmail.com>, Helge Deller <deller@gmx.de>
Cc:     linux-fbdev@vger.kernel.org
References: <CAEYL+X9qahvtsi71thrOzzqdtq_mpdTyV1ZCqc-TvMH--7HqdQ@mail.gmail.com>
 <09b7b91c-4bae-0bba-7701-cb1f8c58c00b@gmx.de>
 <CAEYL+X9mM_m9HvdW-dMWDNWkyaY=Y7Y0TeZP3w3K7RA066RNJA@mail.gmail.com>
Content-Language: en-US
From:   Thomas Zimmermann <tzimmermann@suse.de>
In-Reply-To: <CAEYL+X9mM_m9HvdW-dMWDNWkyaY=Y7Y0TeZP3w3K7RA066RNJA@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------0ybUxSqEs206Ju7Utty0M1Uu"
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------0ybUxSqEs206Ju7Utty0M1Uu
Content-Type: multipart/mixed; boundary="------------cvgmOQY3Q0sr93qozh0JBJsQ";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann@suse.de>
To: Zopolis0 <creatorsmithmdt@gmail.com>, Helge Deller <deller@gmx.de>
Cc: linux-fbdev@vger.kernel.org
Message-ID: <ab379da4-f137-c820-277f-5432ea80cdee@suse.de>
Subject: Re: [PATCH] Add framebuffer device driver for gamecube/wii,
 incorporating Farter's work.
References: <CAEYL+X9qahvtsi71thrOzzqdtq_mpdTyV1ZCqc-TvMH--7HqdQ@mail.gmail.com>
 <09b7b91c-4bae-0bba-7701-cb1f8c58c00b@gmx.de>
 <CAEYL+X9mM_m9HvdW-dMWDNWkyaY=Y7Y0TeZP3w3K7RA066RNJA@mail.gmail.com>
In-Reply-To: <CAEYL+X9mM_m9HvdW-dMWDNWkyaY=Y7Y0TeZP3w3K7RA066RNJA@mail.gmail.com>

--------------cvgmOQY3Q0sr93qozh0JBJsQ
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGkNCg0KQW0gMTUuMTEuMjIgdW0gMjM6Mzggc2NocmllYiBab3BvbGlzMDoNCj4gSSdtIG5v
dCB0b28gZmFtaWxpYXIgd2l0aCBEUk0sIHVuZm9ydHVuYXRlbHksIHNvIEkgY2FuJ3QgZ2l2
ZSB5b3UgYQ0KPiBncmVhdCBhbnN3ZXIuDQo+IA0KPiBNeSBjdXJyZW50IGFpbSBpcyBqdXN0
IHRvIGdldCB0aGlzIGFuZCB0aGUgb3RoZXIgZ2MtbGludXggcGF0Y2hlcyBpbnRvDQo+IHVw
c3RyZWFtIGJlZm9yZSB0aGV5IGJlZ2luIHRvIHJvdC4NCj4gDQo+IEJ1dCwgSSdkIGJlIGhh
cHB5IHRvIGxvb2sgaW50byBwb3J0aW5nIHRoaXMgdG8gRFJNIGFmdGVyIGl0J3MgbWVyZ2Vk
IHRob3VnaC4NCg0KV2UgZ2VuZXJhbGx5IGRvbid0IGFjY2VwdCBuZXcgZHJpdmVycyBpbnRv
IGZiZGV2Lg0KDQpCZXN0IHJlZ2FyZHMNClRob21hcw0KDQo+IA0KPiBPbiBXZWQsIE5vdiAx
NiwgMjAyMiBhdCA0OjA1IEFNIEhlbGdlIERlbGxlciA8ZGVsbGVyQGdteC5kZT4gd3JvdGU6
DQo+Pg0KPj4gT24gMTEvMTUvMjIgMTE6MDUsIFpvcG9saXMwIHdyb3RlOg0KPj4+IEp1c3Qg
dXBzdHJlYW1pbmcgdGhlIGdjL3dpaSBmcmFtZWJ1ZmZlciBkcml2ZXIgZnJvbSBnYy1saW51
eCwgYW5kDQo+Pj4gaW5jb3Jwb3JhdGVzIEZhcnRlcidzIHBhdGNoIHRvIHNvbHZlIHRoZSBj
b2xvciBpc3N1ZS4gU2VlDQo+Pj4gaHR0cHM6Ly9mYXJ0ZXJzb2Z0LmNvbS9ibG9nLzIwMTEv
MDYvMjIvaGFja2luZy11cC1hbi1yZ2ItZnJhbWVidWZmZXItZHJpdmVyLWZvci13aWktbGlu
dXgvDQo+Pj4gYW5kIGh0dHBzOi8vZmFydGVyc29mdC5jb20vYmxvZy8yMDExLzA3LzMxL2hh
Y2tpbmctdXAtYW4tcmdiLWZyYW1lYnVmZmVyLWRyaXZlci1mb3Itd2lpLWxpbnV4LXRha2Ut
dHdvLy4NCj4+DQo+PiBKdXN0IGZvciB0aGUgcmVjb3JkOg0KPj4gSXMgdGhlcmUgYSByZWFz
b24gd2h5IGl0IHdhc24ndCAob3IgY2FuJ3QgYmUpIHBvcnRlZCB0byBEUk0gPw0KPj4gTG9v
a2luZyBhdCB0aGUgcGF0Y2ggKGFuZCB0aGUgaGFyZHdhcmUgYmVoaW5kIGl0KSBJIGRvIHNl
ZSB2YXJpb3VzIHJlYXNvbnMsDQo+PiBidXQgSSdkIGxpa2UgdG8gaGVhciBpdCBmcm9tIHlv
dS4uLg0KPj4NCj4+IEhlbGdlDQoNCi0tIA0KVGhvbWFzIFppbW1lcm1hbm4NCkdyYXBoaWNz
IERyaXZlciBEZXZlbG9wZXINClNVU0UgU29mdHdhcmUgU29sdXRpb25zIEdlcm1hbnkgR21i
SA0KTWF4ZmVsZHN0ci4gNSwgOTA0MDkgTsO8cm5iZXJnLCBHZXJtYW55DQooSFJCIDM2ODA5
LCBBRyBOw7xybmJlcmcpDQpHZXNjaMOkZnRzZsO8aHJlcjogSXZvIFRvdGV2DQo=

--------------cvgmOQY3Q0sr93qozh0JBJsQ--

--------------0ybUxSqEs206Ju7Utty0M1Uu
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEExndm/fpuMUdwYFFolh/E3EQov+AFAmN0o4IFAwAAAAAACgkQlh/E3EQov+BD
IQ//SJOtyV9p+uYb/mKbkXgWgMkjQ2noJmB6HJwznL1cpJSjCK0GZ2d/hTrncxz6M+2l6fIDXIxO
g+Dusmr/RynwRLjX241Wx2yFZ9hCBHZyx0omLig4bZP/iqoNUwk73ttXGPRZkqCPjd34CNmPFIpC
4FJ+N6b/rbSjxGOGn4bK0jWSX/GLPzK3FKo6lsZn0S0Xpx2Ba9lTa2/rD34m1d60XAeXDP3qxZoW
TNu6/UtcqxtVXwP0+35w76udADhguufKq6M8dvTlznFUVngBc3wCyNjZavqnCIfY81/oHFE4zxXQ
Pkap/A8ZYSMgNhgm9BzUnYxGRuvwSDn8C016d52b35ZMhFyv8q9vC32YlCajH6r2LiQ5toEViCvO
grqE8ocI5twkUf4ZDT0NO75F21/JfOUDZ8Nsu+zarv1rrapuKNBdmYis0z+QN5L6JzrTaRfpfEGW
dOWxr+bKLwxpZoidj8LMm1oYD3neP2sD311JcmxEJl92KlLs4i/VKje2d+Fx965PEpYti+gpOmyy
g/ZPa4U5Q9M3CdHAhjX5VWTl+7bBTpfQn5hVFYoFb5buY0X6loctOcOk6ZBf4YbKJdyYxNyKIMaQ
VbtlXXY1cdzx3YB7Id6Jny78LCOakzs0U4DAoTUbQQwiKWJ6O1uKniES9kLoH8zdRnHHYBUPe55Y
S1M=
=ekjU
-----END PGP SIGNATURE-----

--------------0ybUxSqEs206Ju7Utty0M1Uu--
