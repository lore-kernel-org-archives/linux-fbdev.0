Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73DAFC433FE
	for <linux-fbdev@archiver.kernel.org>; Fri, 18 Nov 2022 13:08:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234724AbiKRNIL (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Fri, 18 Nov 2022 08:08:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbiKRNIK (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Fri, 18 Nov 2022 08:08:10 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F95F78186
        for <linux-fbdev@vger.kernel.org>; Fri, 18 Nov 2022 05:08:09 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 185922274D;
        Fri, 18 Nov 2022 13:08:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1668776888; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oOUual5mmEkBsHqyTxTawhKQoaX+Y0DScBsOQnNSvVc=;
        b=yI1U2AfhHf4jNabfejsIpG6GSo5ouGO5mBaaBLGHj2cnFMCXvN33e7VrYGotCboRZnYOXG
        qiL1JA3aBcYQUAAbk1cE+pVBwfcATFCa3k+3pRRAzN0SDiEwkutM/IpFWwB3xdLm/L2ZSR
        QpyjxOYX4lDOGg0XIiJ7nfjTyz3cBB4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1668776888;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oOUual5mmEkBsHqyTxTawhKQoaX+Y0DScBsOQnNSvVc=;
        b=w6O1xAdGu/KPRKMRhE4Ol5QexPX9nxmyMm87vE9rZCFOXRudkAeDiKladK9Q22huOXlXOF
        m9uE9/33iQQ02/DQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id F41E013A66;
        Fri, 18 Nov 2022 13:08:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 7teXOreDd2MUHgAAMHmgww
        (envelope-from <tzimmermann@suse.de>); Fri, 18 Nov 2022 13:08:07 +0000
Message-ID: <80ade2db-6a6c-f4c9-3b53-3d3f71896bfe@suse.de>
Date:   Fri, 18 Nov 2022 14:08:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] Add framebuffer device driver for gamecube/wii,
 incorporating Farter's work.
Content-Language: en-US
To:     Helge Deller <deller@gmx.de>, Zopolis0 <creatorsmithmdt@gmail.com>
Cc:     linux-fbdev@vger.kernel.org
References: <CAEYL+X9qahvtsi71thrOzzqdtq_mpdTyV1ZCqc-TvMH--7HqdQ@mail.gmail.com>
 <09b7b91c-4bae-0bba-7701-cb1f8c58c00b@gmx.de>
 <CAEYL+X-GSKCP9j0fz6m_VQ0tBH+adEkChWMxpOkeQ8TXC8tguw@mail.gmail.com>
 <0084795e-a13b-eb14-034a-c70ec66baa79@gmx.de>
From:   Thomas Zimmermann <tzimmermann@suse.de>
In-Reply-To: <0084795e-a13b-eb14-034a-c70ec66baa79@gmx.de>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------nxY5isnYynZ6IKHpyKFmMytH"
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------nxY5isnYynZ6IKHpyKFmMytH
Content-Type: multipart/mixed; boundary="------------y3YbOtSaMc9l8ZW1Z19Pgkju";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann@suse.de>
To: Helge Deller <deller@gmx.de>, Zopolis0 <creatorsmithmdt@gmail.com>
Cc: linux-fbdev@vger.kernel.org
Message-ID: <80ade2db-6a6c-f4c9-3b53-3d3f71896bfe@suse.de>
Subject: Re: [PATCH] Add framebuffer device driver for gamecube/wii,
 incorporating Farter's work.
References: <CAEYL+X9qahvtsi71thrOzzqdtq_mpdTyV1ZCqc-TvMH--7HqdQ@mail.gmail.com>
 <09b7b91c-4bae-0bba-7701-cb1f8c58c00b@gmx.de>
 <CAEYL+X-GSKCP9j0fz6m_VQ0tBH+adEkChWMxpOkeQ8TXC8tguw@mail.gmail.com>
 <0084795e-a13b-eb14-034a-c70ec66baa79@gmx.de>
In-Reply-To: <0084795e-a13b-eb14-034a-c70ec66baa79@gmx.de>

--------------y3YbOtSaMc9l8ZW1Z19Pgkju
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGkNCg0KQW0gMTguMTEuMjIgdW0gMDk6NTcgc2NocmllYiBIZWxnZSBEZWxsZXI6DQo+IEhl
bGxvIE1heGltaWxpYW4sDQo+IA0KPiBPbiAxMS8xNS8yMiAyMzowNSwgWm9wb2xpczAgd3Jv
dGU6DQo+PiBJJ20gbm90IHRvbyBmYW1pbGlhciB3aXRoIERSTSwgdW5mb3J0dW5hdGVseSwg
c28gSSBjYW4ndCBnaXZlIHlvdSBhIA0KPj4gZ3JlYXQgYW5zd2VyLg0KPj4NCj4+IE15IGN1
cnJlbnQgYWltIGlzIGp1c3QgdG8gZ2V0IHRoaXMgYW5kIHRoZSBvdGhlciBnYy1saW51eCBw
YXRjaGVzIGludG8gDQo+PiB1cHN0cmVhbSBiZWZvcmUgdGhleSBiZWdpbiB0byByb3QuDQo+
Pg0KPj4gQnV0LCBJJ2QgYmUgaGFwcHkgdG8gbG9vayBpbnRvIHBvcnRpbmcgdGhpcyB0byBE
Uk0gYWZ0ZXIgaXQncyBtZXJnZWQgDQo+PiB0aG91Z2guDQo+IA0KPiBZb3VyIGFpbSB0byB1
cHN0cmVhbSB0aGUgcGF0Y2hlcyBpcyBvaywgYnV0IGdlbmVyYWxseSBEUk0gaXMgdGhlIHdh
eSANCj4gZm9yd2FyZA0KPiBmb3IgTGludXggZ3JhcGhpY3MuDQo+IA0KPiBJJ3ZlIGJyaWVm
bHkgbG9va2VkIGF0IHRoZSBkcml2ZXIgYW5kIGl0IHNlZW1zIHRoYXQgaXQgaW5pdGlhbGx5
IHNldHMgdXAgDQo+IHRoZQ0KPiBncmFwaGljcyBtb2RlLCBhbmQgdGhhdCBjaGFuZ2VzIHRv
IHRoZSBzY3JlZW4gYXJlIHRoZW4gcmVuZGVyZWQgaW50byBhIA0KPiBtZW1vcnkNCj4gYnVm
ZmVyIGZyb20gd2hlcmUgYSBkYW1hZ2UgZGV0ZWN0aW9uIGlzIHRoZW4gcnVuIHdoaWNoIHVw
ZGF0ZXMgdGhlIHNjcmVlbi4NCj4gQXMgZmFyIGFzIEkgdW5kZXJzdGFuZCBEUk0sIHRoaXMg
aXMgaG93IGl0J3MgZG9uZSBpbiBEUk0gZm9yIHZhcmlvdXMNCj4gZ3JhcGhpY3MgZHJpdmVy
cyAoVGhvbWFzLCBwbGVhc2UgY29ycmVjdCBtZSBpZiBJJ20gd3JvbmchKS4NCg0KWW91J3Jl
IHJpZ2h0LiBXZSBkbyB0aGlzIGZvciBtb3N0IHNpbXBsZSBoYXJkd2FyZSB0aGF0IGhhcyBs
aW1pdGVkIA0Kb3B0aW9ucyBmb3IgY29sb3IgZm9ybWF0cyBhbmQvb3IgZGlzcGxheSBtZW1v
cnkuDQoNCj4gQWRkaXRpb25hbGx5IHRoZSBkcml2ZXIgaW5jbHVkZXMgdHdvIElPQ1RMcyBm
b3IgRkJJT1dBSVRSRVRSQUNFICh3YWl0IA0KPiBmb3IgcmV0cmFjZSkNCj4gYW5kIEZCSU9G
TElQSEFDSyAod2FpdCB1bnRpbCBhIHNwZWNpZmljIHZpZGVvIHBhZ2UgaXMgdmlzaWJsZSBv
ciBub3QgDQo+IHZpc2libGUpLg0KPiBJIGFzc3VtZSBsaWJzZGwgaXMgdXNpbmcgdGhvc2U/
IEFyZSB0aGV5IHN0aWxsIHJlcXVpcmVkIG5vd2FkYXlzPw0KPiBJIGRvbid0IGtub3cgaWYg
c3VjaCBpb2N0bHMgYXJlIGRvYWJsZSBpbiBEUk0gb3IgaWYgRFJNIGhhcyBvdGhlcg0KPiBw
b3NzaWJpbGl0aWVzIC0gdGhpcyB3b3VsZCBiZSBpbnRlcmVzdGluZyBhcyBpdCB3b3VsZCBo
ZWxwIHRvIGRlY2lkZQ0KPiBpZiBwb3J0aW5nIHRvIERSTSBpcyBwb3NzaWJsZSAmIHVzZWZ1
bC4NCg0KVGhlcmUncyB0aGUgRFJNX0lPQ1RMX1dBSVRfVkJMQU5LIGlvY3RsLCB3aGljaCBh
cHBlYXJzIHRvIGRvIHRoZSBzYW1lIGFzIA0KRkJJT1dBSVRSRVRSQUNFLiBJREsgdGhlIG1l
YW5pbmcgb2YgRkJJT0ZMSVBIQUNLLCBidXQgaWYgaXQncyBqdXN0IGZvciANCnZzeW5jLWlu
ZyBkaXNwbGF5IHVwZGF0ZXMgdGhlbiBEUk0gZG9lcyB0aGlzIGF1dG9tYXRpY2FsbHkgYXMg
cGFydCBvZiANCnRoZSBwYWdlZmxpcC4NCg0KPiANCj4gVXN1YWxseSB3ZSBhbHNvIGV4cGVj
dCB0aGUgcGF0Y2hlcyB0byBiZSBzZW50IHdpdGggcHJvcGVyIGNvbW1pdCBtZXNzYWdlcw0K
PiBpbiBwbGFpbiB0ZXh0IHRvIHRoZSBtYWlsaW5nIGxpc3RzLiBTaW5jZSB5b3UgaGFkIHBy
b2JsZW1zIHdpdGggdGhpcywgSSd2ZQ0KPiBzdG9yZWQgeW91ciBwYXRjaCBpbiB0aGUgZmJk
ZXYtd2lpIGJyYW5jaCBvZiBteSBnaXQgcmVwbywgc28gdGhhdCBpdCdzIA0KPiBlYXNpZXIN
Cj4gZm9yIG1lIHRvIHRha2UgYSBsb29rIGF0IHRoZSBwYXRjaC4gRm9yIHBlb3BsZSB3aG8g
YXJlIGludGVyZXN0ZWQgYXMgd2VsbCwNCj4gaXQncyBhcmNoaWV2ZWQgaGVyZSBub3c6DQo+
IGh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L2RlbGxl
ci9saW51eC1mYmRldi5naXQvY29tbWl0Lz9oPWZiZGV2LXdpaSZpZD04MDJiYjBhYTFhZjE0
OWVjODI5OWVhN2RmZWJmM2ZjMTBkYzljM2RmDQo+IA0KPiBUaGF0IHNhaWQsIEkgd2lzaCB5
b3UgbXVjaCBzdWNjZXNzIHdpdGggcHVzaGluZyB0aGUgb3RoZXIgZ2MtcGF0Y2hlcyANCj4g
dXBzdHJlYW0uDQo+IEJ1dCBmb3Igbm93IEkgd29uJ3QgbWVyZ2UgdGhpcyBwYXRjaCB1bmxl
c3MgdGhlIHBvc3NpYmlsaXR5IHRvIGNvbnZlcnQgDQo+IHRvIERSTQ0KPiBoYXMgYmVlbiBm
dWxseSBjbGFyaWZpZWQuDQoNClRoZSBiZXN0IHdlIGNhbiBkbyBtaWdodCBiZSBkcml2ZXJz
L3N0YWdpbmcuIEJ1dCBzdGFnaW5nIHdvdWxkIG9ubHkgbWFrZSANCml0IGVhc2llciB0byB0
cmFjayBEUk0gZHVyaW5nIHRoZSBwb3J0Lg0KDQpXaXRoIERSTSwgeW91J2QgaW5pdGlhbGx5
IGhhdmUgdG8gcHV0IHNvbWUgZWZmb3J0IGludG8gdGhlIHBvcnQuIEFuZCBEUk0gDQppcyBk
aWZmZXJlbnQgZW5vdWdoIGZyb20gZmJkZXYgdGhhdCBpdCByZWFsbHkgaXMgd29yay4gIEJ1
dCBvbmNlIHBvcnRlZCwgDQpEUk0gb2ZmZXJzIGEgd2VsbC1tYWludGFpbmVkIHNldCBvZiBo
ZWxwZXJzIGFuZCBmZWF0dXJlcy4gQW5kIG1vc3Qgb2YgDQphbGwsIHlvdSdkIGdldCBzdXBw
b3J0IGZvciBtb2Rlcm4gdXNlcnNwYWNlLiAgRmJkZXYgc3VwcG9ydCBpbiB1c2Vyc3BhY2Ug
DQppcyBkeWluZyBhbmQgb25seSB0aGUgdGV4dCBjb25zb2xlIGlzIHJlbGlhYmx5IGF2YWls
YWJsZS5eMQ0KDQpCZXN0IHJlZ2FyZHMNClRob21hcw0KDQpeMTogVGhlcmUgYXJlIGlkZWFz
IG9mIG1vdmluZyBhd2F5IGZyb20gZmJkZXYtYmFzZWQgY29uc29sZXMuDQoNCj4gDQo+IEhl
bGdlDQo+IA0KPj4gT24gV2VkLCAxNiBOb3YgMjAyMiBhdCAwNDowNSwgSGVsZ2UgRGVsbGVy
IDxkZWxsZXJAZ214LmRlIA0KPj4gPG1haWx0bzpkZWxsZXJAZ214LmRlPj4gd3JvdGU6DQo+
Pg0KPj4gwqDCoMKgIE9uIDExLzE1LzIyIDExOjA1LCBab3BvbGlzMCB3cm90ZToNCj4+IMKg
wqDCoMKgID4gSnVzdCB1cHN0cmVhbWluZyB0aGUgZ2Mvd2lpIGZyYW1lYnVmZmVyIGRyaXZl
ciBmcm9tIGdjLWxpbnV4LCBhbmQNCj4+IMKgwqDCoMKgID4gaW5jb3Jwb3JhdGVzIEZhcnRl
cidzIHBhdGNoIHRvIHNvbHZlIHRoZSBjb2xvciBpc3N1ZS4gU2VlDQo+PiDCoMKgwqDCoCA+
IA0KPj4gaHR0cHM6Ly9mYXJ0ZXJzb2Z0LmNvbS9ibG9nLzIwMTEvMDYvMjIvaGFja2luZy11
cC1hbi1yZ2ItZnJhbWVidWZmZXItZHJpdmVyLWZvci13aWktbGludXgvIDxodHRwczovL2Zh
cnRlcnNvZnQuY29tL2Jsb2cvMjAxMS8wNi8yMi9oYWNraW5nLXVwLWFuLXJnYi1mcmFtZWJ1
ZmZlci1kcml2ZXItZm9yLXdpaS1saW51eC8+DQo+PiDCoMKgwqDCoCA+IGFuZCANCj4+IGh0
dHBzOi8vZmFydGVyc29mdC5jb20vYmxvZy8yMDExLzA3LzMxL2hhY2tpbmctdXAtYW4tcmdi
LWZyYW1lYnVmZmVyLWRyaXZlci1mb3Itd2lpLWxpbnV4LXRha2UtdHdvLyA8aHR0cHM6Ly9m
YXJ0ZXJzb2Z0LmNvbS9ibG9nLzIwMTEvMDcvMzEvaGFja2luZy11cC1hbi1yZ2ItZnJhbWVi
dWZmZXItZHJpdmVyLWZvci13aWktbGludXgtdGFrZS10d28vPi4NCj4+DQo+PiDCoMKgwqAg
SnVzdCBmb3IgdGhlIHJlY29yZDoNCj4+IMKgwqDCoCBJcyB0aGVyZSBhIHJlYXNvbiB3aHkg
aXQgd2Fzbid0IChvciBjYW4ndCBiZSkgcG9ydGVkIHRvIERSTSA/DQo+PiDCoMKgwqAgTG9v
a2luZyBhdCB0aGUgcGF0Y2ggKGFuZCB0aGUgaGFyZHdhcmUgYmVoaW5kIGl0KSBJIGRvIHNl
ZSB2YXJpb3VzIA0KPj4gcmVhc29ucywNCj4+IMKgwqDCoCBidXQgSSdkIGxpa2UgdG8gaGVh
ciBpdCBmcm9tIHlvdS4uLg0KPj4NCj4+IMKgwqDCoCBIZWxnZQ0KPj4NCj4gDQoNCi0tIA0K
VGhvbWFzIFppbW1lcm1hbm4NCkdyYXBoaWNzIERyaXZlciBEZXZlbG9wZXINClNVU0UgU29m
dHdhcmUgU29sdXRpb25zIEdlcm1hbnkgR21iSA0KTWF4ZmVsZHN0ci4gNSwgOTA0MDkgTsO8
cm5iZXJnLCBHZXJtYW55DQooSFJCIDM2ODA5LCBBRyBOw7xybmJlcmcpDQpHZXNjaMOkZnRz
ZsO8aHJlcjogSXZvIFRvdGV2DQo=

--------------y3YbOtSaMc9l8ZW1Z19Pgkju--

--------------nxY5isnYynZ6IKHpyKFmMytH
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEExndm/fpuMUdwYFFolh/E3EQov+AFAmN3g7cFAwAAAAAACgkQlh/E3EQov+CD
LBAAwbdeG5EkVqzCb0lDDN5VlxnsRCqwBEXH67a8IkJmjW5wxmjoTPgX9r1sq83oPKo/Gx99RED9
5CXtlPJeFjc7Co1yiGaPOC3ifSr2rTaZGHtGtq1rt4e44ShI0enC2SkFMeHMUTcmIRAIcep2wNxf
0ikXRwaLUvBS4pe5xo6SVELpBXyhp9mTWQMzf5OZGiN3aPQ3X3uF8kxbprLNrzOzTdnMLROLIuQk
VTv2J+C20V3wOmOvzI4C7ARAzQBRCXr80yMHxz2MIe3Gu7t3yo9uPHwvBk1fUZiz/iN0Z6REnkty
V32praDT7ebnjs2ehq0pDiiC7ZytcFij/wosma4XhCxghvgQsMsFm+lo54rrMz/TbFFU8wymGljC
3k/EsFtPtFrIpZBNWyiyaLxqnMs06DKhYNCANeNjWXjFjXTDk96OaA6sBQk9ZLEL2evwjU/Dp5jq
sWgBaoqHR1nZhebKyCSbqbhfg+w0iXdICxK03lh4DCLO/9xxoHnBUyMJWujYpMBGMU8uxgjQn+YG
rTp1JkepxjG65GzE0iMxTC8rXT2h6HUlbP88psdE09e1kRcdijhPCxfX1qf3xSSwEpbL///rBMDO
RuaKvl9iVTUAXzILs+x4HZUFmHcfGgaEam4iJVrU5gSZT7mmT4E+HS3r5mXAkikBjQL0Tn9pv+I5
+NI=
=MkYy
-----END PGP SIGNATURE-----

--------------nxY5isnYynZ6IKHpyKFmMytH--
