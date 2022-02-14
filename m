Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14C94C433F5
	for <linux-fbdev@archiver.kernel.org>; Mon, 14 Feb 2022 13:29:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229818AbiBNN34 (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 14 Feb 2022 08:29:56 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234405AbiBNN34 (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Mon, 14 Feb 2022 08:29:56 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 714DA4F9F0
        for <linux-fbdev@vger.kernel.org>; Mon, 14 Feb 2022 05:29:48 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 2C13B1F38B;
        Mon, 14 Feb 2022 13:29:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1644845387; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dBYFKpfYPiq5qXDA4uSe9C+FEeYwTU0ApnNbJpDmu7U=;
        b=vQIcyFZlRqNCiymSeRHK0mN+ozEkatEkESJ/IetNRGz+C2v0OUShJX9uDFaYG3elKooT+r
        Go86x6ctYgsXc9Zd2ggVYd7N4qnuplPenbB8Yl2bocNm9pMiN2oAlHOa7s3UAXGM5JVxyF
        ANnr0HEjqPceC6mt42UDur7aIMjXvuM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1644845387;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dBYFKpfYPiq5qXDA4uSe9C+FEeYwTU0ApnNbJpDmu7U=;
        b=zglN0Cribnhsg7fGfo2i8rCHebd7Lyd0jg0YrAvprUZSrshrAlg3AItBKF+GVYp9/lHAKH
        GMV8doFWJDSGotDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E520913B2B;
        Mon, 14 Feb 2022 13:29:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id HclINkpZCmKcJwAAMHmgww
        (envelope-from <tzimmermann@suse.de>); Mon, 14 Feb 2022 13:29:46 +0000
Message-ID: <4a0697de-52db-97e7-d528-c7e2fe000e66@suse.de>
Date:   Mon, 14 Feb 2022 14:29:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 2/2] fbdev: Don't sort deferred-I/O pages by default
Content-Language: en-US
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     linux-fbdev@vger.kernel.org, deller@gmx.de,
        linux-staging@lists.linux.dev, bernie@plugable.com,
        dri-devel@lists.freedesktop.org, javierm@redhat.com,
        noralf@tronnes.org, andriy.shevchenko@linux.intel.com,
        jayalk@intworks.biz
References: <20220210141111.5231-1-tzimmermann@suse.de>
 <20220210141111.5231-3-tzimmermann@suse.de>
 <CAMuHMdVb1JjZkEo-PM6DTXOywcmJDRr0a=Ci94DJCj7dXbbihw@mail.gmail.com>
 <9b2e2649-1511-66a3-b346-60863de788fc@suse.de>
 <CAMuHMdWPw8UcTVown3Zghxn11-WuqSBNCWKpP3T5NUxxZmntcA@mail.gmail.com>
From:   Thomas Zimmermann <tzimmermann@suse.de>
In-Reply-To: <CAMuHMdWPw8UcTVown3Zghxn11-WuqSBNCWKpP3T5NUxxZmntcA@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------cY83eb3xDQ46xO4efc8b4xec"
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------cY83eb3xDQ46xO4efc8b4xec
Content-Type: multipart/mixed; boundary="------------7oyYbAfnymsn2oK8u0wDPWX0";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann@suse.de>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-fbdev@vger.kernel.org, deller@gmx.de,
 linux-staging@lists.linux.dev, bernie@plugable.com,
 dri-devel@lists.freedesktop.org, javierm@redhat.com, noralf@tronnes.org,
 andriy.shevchenko@linux.intel.com, jayalk@intworks.biz
Message-ID: <4a0697de-52db-97e7-d528-c7e2fe000e66@suse.de>
Subject: Re: [PATCH 2/2] fbdev: Don't sort deferred-I/O pages by default
References: <20220210141111.5231-1-tzimmermann@suse.de>
 <20220210141111.5231-3-tzimmermann@suse.de>
 <CAMuHMdVb1JjZkEo-PM6DTXOywcmJDRr0a=Ci94DJCj7dXbbihw@mail.gmail.com>
 <9b2e2649-1511-66a3-b346-60863de788fc@suse.de>
 <CAMuHMdWPw8UcTVown3Zghxn11-WuqSBNCWKpP3T5NUxxZmntcA@mail.gmail.com>
In-Reply-To: <CAMuHMdWPw8UcTVown3Zghxn11-WuqSBNCWKpP3T5NUxxZmntcA@mail.gmail.com>

--------------7oyYbAfnymsn2oK8u0wDPWX0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGkNCg0KQW0gMTQuMDIuMjIgdW0gMTA6MDUgc2NocmllYiBHZWVydCBVeXR0ZXJob2V2ZW46
DQo+IEhpIFRob21hcywNCj4gDQo+IE9uIE1vbiwgRmViIDE0LCAyMDIyIGF0IDk6MjggQU0g
VGhvbWFzIFppbW1lcm1hbm4gPHR6aW1tZXJtYW5uQHN1c2UuZGU+IHdyb3RlOg0KPj4gQW0g
MTQuMDIuMjIgdW0gMDk6MDUgc2NocmllYiBHZWVydCBVeXR0ZXJob2V2ZW46DQo+Pj4gT24g
VGh1LCBGZWIgMTAsIDIwMjIgYXQgNDoyNCBQTSBUaG9tYXMgWmltbWVybWFubiA8dHppbW1l
cm1hbm5Ac3VzZS5kZT4gd3JvdGU6DQo+Pj4+IEZiZGV2J3MgZGVmZXJyZWQgSS9PIHNvcnRz
IGFsbCBkaXJ0eSBwYWdlcyBieSBkZWZhdWx0LCB3aGljaCBpbmN1cnMgYQ0KPj4+PiBzaWdu
aWZpY2FudCBvdmVyaGVhZC4gTWFrZSB0aGUgc29ydGluZyBzdGVwIG9wdGlvbmFsIGFuZCB1
cGRhdGUgdGhlIGZldw0KPj4+PiBkcml2ZXJzIHRoYXQgcmVxdWlyZSBpdC4gVXNlIGEgRklG
TyBsaXN0IGJ5IGRlZmF1bHQuDQo+Pj4+DQo+Pj4+IFNvcnRpbmcgcGFnZXMgYnkgbWVtb3J5
IG9mZnNldCBmb3IgZGVmZXJyZWQgSS9PIHBlcmZvcm1zIGFuIGltcGxpY2l0DQo+Pj4+IGJ1
YmJsZS1zb3J0IHN0ZXAgb24gdGhlIGxpc3Qgb2YgZGlydHkgcGFnZXMuIFRoZSBhbGdvcml0
aG0gZ29lcyB0aHJvdWdoDQo+Pj4+IHRoZSBsaXN0IG9mIGRpcnR5IHBhZ2VzIGFuZCBpbnNl
cnRzIGVhY2ggbmV3IHBhZ2UgYWNjb3JkaW5nIHRvIGl0cw0KPj4+PiBpbmRleCBmaWVsZC4g
RXZlbiB3b3JzZSwgbGlzdCB0cmF2ZXJzYWwgYWx3YXlzIHN0YXJ0cyBhdCB0aGUgZmlyc3QN
Cj4+Pj4gZW50cnkuIEFzIHZpZGVvIG1lbW9yeSBpcyBtb3N0IGxpa2VseSB1cGRhdGVkIHNj
YW5saW5lIGJ5IHNjYW5saW5lLCB0aGUNCj4+Pj4gYWxnb3JpdGhtIHRyYXZlcnNlcyB0aHJv
dWdoIHRoZSBjb21wbGV0ZSBsaXN0IGZvciBlYWNoIHVwZGF0ZWQgcGFnZS4NCj4+Pj4NCj4+
Pj4gRm9yIGV4YW1wbGUsIHdpdGggMTAyNHg3Njh4MzJicHAgYSBwYWdlIGNvdmVycyBleGFj
dGx5IG9uZSBzY2FubGluZS4NCj4+Pj4gV3JpdGluZyBhIHNpbmdsZSBzY3JlZW4gdXBkYXRl
IGZyb20gdG9wIHRvIGJvdHRvbSByZXF1aXJlcyB1cGRhdGluZw0KPj4+PiA3NjggcGFnZXMu
IFdpdGggYW4gYXZlcmFnZSBsaXN0IGxlbmd0aCBvZiAzODQgZW50cmllcywgYSBzY3JlZW4g
dXBkYXRlDQo+Pj4+IGNyZWF0ZXMgKDc2OCAqIDM4NCA9KSAyOTQ5MTIgY29tcGFyZSBvcGVy
YXRpb24uDQo+Pj4NCj4+PiBXaGF0IGFib3V0IHVzaW5nIGZvbGlvcz8NCj4+PiBJZiBjb25z
ZWN1dGl2ZSBwYWdlcyBhcmUgbWVyZ2VkIGludG8gYSBzaW5nbGUgZW50cnksIHRoZXJlJ3Mg
bXVjaCBsZXNzDQo+Pj4gKG9yIG5vdGhpbmcgaW4gdGhlIGV4YW1wbGUgYWJvdmUpIHRvIHNv
cnQuDQo+Pg0KPj4gSG93IHdvdWxkIHRoZSBjb2RlIGtub3cgdGhhdD8gQ2FsbHMgdG8gcGFn
ZV9ta3dyaXRlIGhhcHBlbg0KPj4gcGFnZWZhdWx0LWJ5LXBhZ2VmYXVsdCBpbiBhbnkgb3Jk
ZXIgQUZBSUNULg0KPiANCj4gZmJfZGVmZXJyZWRfaW9fbWt3cml0ZSgpIHdvdWxkIHN0aWxs
IGJlIGNhbGxlZCBmb3IgYSBwYWdlLCBidXQgYW4NCj4gYWRqYWNlbnQgcGFnZSBjYW4gYmUg
bWVyZ2VkIHdpdGggYW4gZXhpc3RpbmcgZW50cnkgd2hpbGUgYWRkaW5nIGl0DQo+IHRvIHRo
ZSBsaXN0Lg0KDQpJIHN0aWxsIGRvbid0IHVuZGVyc3RhbmQgaG93IHdlJ2QgdXNlIGl0IHRv
IG91ciBhZHZhbnRhZ2UuIE1vc3QgZHJpdmVycyANCmRvbid0IG5lZWQgc29ydGVkIHBhZ2Vz
IGF0IGFsbC4gQSBmb2xpbyBoYXMgc3Ryb25nIGFsaWdubWVudCANCnJlcXVpcmVtZW50cyBm
b3Igc2l6ZSBhbmQgb2Zmc2V0IEFGQUlDVC4gV2UgbWlnaHQgZW5kIHVwIGZsdXNoaW5nIHdh
eSANCnRvbyBtdWNoIG9mIHRoZSBkaXNwbGF5IG1lbW9yeS4NCg0KQmVzdCByZWdhcmRzDQpU
aG9tYXMNCg0KPiANCj4gR3J7b2V0amUsZWV0aW5nfXMsDQo+IA0KPiAgICAgICAgICAgICAg
ICAgICAgICAgICAgR2VlcnQNCj4gDQo+IC0tDQo+IEdlZXJ0IFV5dHRlcmhvZXZlbiAtLSBU
aGVyZSdzIGxvdHMgb2YgTGludXggYmV5b25kIGlhMzIgLS0gZ2VlcnRAbGludXgtbTY4ay5v
cmcNCj4gDQo+IEluIHBlcnNvbmFsIGNvbnZlcnNhdGlvbnMgd2l0aCB0ZWNobmljYWwgcGVv
cGxlLCBJIGNhbGwgbXlzZWxmIGEgaGFja2VyLiBCdXQNCj4gd2hlbiBJJ20gdGFsa2luZyB0
byBqb3VybmFsaXN0cyBJIGp1c3Qgc2F5ICJwcm9ncmFtbWVyIiBvciBzb21ldGhpbmcgbGlr
ZSB0aGF0Lg0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAtLSBMaW51cyBU
b3J2YWxkcw0KDQotLSANClRob21hcyBaaW1tZXJtYW5uDQpHcmFwaGljcyBEcml2ZXIgRGV2
ZWxvcGVyDQpTVVNFIFNvZnR3YXJlIFNvbHV0aW9ucyBHZXJtYW55IEdtYkgNCk1heGZlbGRz
dHIuIDUsIDkwNDA5IE7DvHJuYmVyZywgR2VybWFueQ0KKEhSQiAzNjgwOSwgQUcgTsO8cm5i
ZXJnKQ0KR2VzY2jDpGZ0c2bDvGhyZXI6IEl2byBUb3Rldg0K

--------------7oyYbAfnymsn2oK8u0wDPWX0--

--------------cY83eb3xDQ46xO4efc8b4xec
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEExndm/fpuMUdwYFFolh/E3EQov+AFAmIKWUoFAwAAAAAACgkQlh/E3EQov+Cn
7g//VR4bJ50USTs3KzUagxwdNLJmbwe8qSF9xEomwcWVoxO3uiUsIJWcOCJ66IN4S1HD19dAyCtf
ic0+6vSkUtbtQ4M+Nzowv/yOng+nwoPQzUbK1GvNs8EyK5FHY+DwdvDeUPYssLXNcHVadJNjsrZ4
hYBfdV+IXPO85D8ZYTG5MSBlVoQxxTpC/X1eqvE5ZhUsRD8khn021DdIcaIxzNAkyraSFpE91zDD
Pys1ScZ1N1FYo6qv5u3T0zEdGHZMVTJ6ZL2VWoCSNOFMovWjtbzQfXyJ/7f0HtECNfrw5umY8MZC
tQFgFvl3wg5u3xAXvIU8nIQenaLZobj2xKFeVvFVhmAcJrRQ/beFQ5HzH6BPvazS9YuoMdE/Goi4
jct6jRA2Exx23aZhsfdZ19p7Wooj1f/vKHIEdoXIPBvzZK+r8DgDewYMqHgDmCdDL9Rc0+lPE8Wb
acfSOUco4r59dmYnMcrxm0J/3LKQGaaK7ZP8NWg/6mRUjVft7HUbJKIGIr8GuMz+8CqvUtCRUMfg
thbXvdEirLOd8htcoK4s/98rIHYsZ5fKHcAbPZsVniIKl8FVCEdZ/1Dit6CEnOGjOZjOHxQ4Lhvy
yi3dtSQZWlpRUZypPAorOvtgP48lspmnjmYMDV4rsmU/g13Y3RtTLH8420qQmV1k2r27AFZ9/zRN
YkQ=
=GcVp
-----END PGP SIGNATURE-----

--------------cY83eb3xDQ46xO4efc8b4xec--
