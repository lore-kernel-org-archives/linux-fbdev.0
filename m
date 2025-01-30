Received: from c64.rulez.org (c64.rulez.org [79.139.58.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71C381946C8
	for <linux-fbdev@vger.kernel.org>; Thu, 30 Jan 2025 19:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.139.58.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738263980; cv=none; b=ZBwEeOnxyidYHojB5piXYgLQ3l/s314LThd4WthpmwMrBxft3YDhFQomlPerVhhutGMTh3aycRIQ5BPth49bkMphHwgpFC0EIB2SGHojY8bbYvAIs48eSwrITXDCxzI0p/CQa1ctfGabLIOZrG+SQlTnd/DHLBxw89yZkmQ6gp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738263980; c=relaxed/simple;
	bh=e1orZ5Aek2xKjOjAENO3gZz7vY7P6IkfGu6YX9CuNpI=;
	h=Message-ID:Date:MIME-Version:To:References:From:Subject:
	 In-Reply-To:Content-Type; b=qvz3Z0N3DbkUyB0FyGak5Zu+jr+c1kFeqhu/KgCeSBSbE/BJvIPPVIrYXX4vN6dw7NWYZkvSO8BlBVarYMF4/W+FI+8D38mRf0gfn0I0EbayVjkQ/PophoJlv5FdMKNkvx2Detf+5PS7fkpF3rtBSl5IhHQNUkA4/kk886xpXUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c64.rulez.org; spf=pass smtp.mailfrom=c64.rulez.org; arc=none smtp.client-ip=79.139.58.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c64.rulez.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=c64.rulez.org
Received: from [192.168.0.122] (unknown [89.134.11.179])
	by c64.rulez.org (Postfix) with ESMTPSA id 1E67A100F6
	for <linux-fbdev@vger.kernel.org>; Thu, 30 Jan 2025 19:58:55 +0100 (CET)
Message-ID: <573bc0d9-b19a-5433-cd6f-6949cb70b9eb@c64.rulez.org>
Date: Thu, 30 Jan 2025 19:58:54 +0100
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Content-Language: en-GB
To: linux-fbdev@vger.kernel.org
References: <cover.1736809898.git.lorenzo.stoakes@oracle.com>
 <936a79ef-3328-490c-8a98-e1f99232cef3@lucifer.local>
From: =?UTF-8?Q?Kajt=c3=a1r_Zsolt?= <soci@c64.rulez.org>
Subject: Re: [RFC PATCH v2 0/3] expose mapping wrprotect, fix fb_defio use
In-Reply-To: <936a79ef-3328-490c-8a98-e1f99232cef3@lucifer.local>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------nVU9OmgYBNOGfKq3nswQa5Ze"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------nVU9OmgYBNOGfKq3nswQa5Ze
Content-Type: multipart/mixed; boundary="------------0S0qxsHBW0T0ZZpSCCUk14Me";
 protected-headers="v1"
From: =?UTF-8?Q?Kajt=c3=a1r_Zsolt?= <soci@c64.rulez.org>
To: linux-fbdev@vger.kernel.org
Message-ID: <573bc0d9-b19a-5433-cd6f-6949cb70b9eb@c64.rulez.org>
Subject: Re: [RFC PATCH v2 0/3] expose mapping wrprotect, fix fb_defio use
References: <cover.1736809898.git.lorenzo.stoakes@oracle.com>
 <936a79ef-3328-490c-8a98-e1f99232cef3@lucifer.local>
In-Reply-To: <936a79ef-3328-490c-8a98-e1f99232cef3@lucifer.local>

--------------0S0qxsHBW0T0ZZpSCCUk14Me
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable


Hello Lorenzo!

I tried the patches below yesterday with the latest mm tree from git at t=
he
time. I have some work in progress code which uses defio, and hardware wh=
ich
needs that for shuffling bytes around to get the right picture.

There was no obvious difference in operation, it looked the same with and=

without the patches. I've skipped the card's memory initialization so it =

contained garbage while the system memory behind was clean. That garbage
remained and was only cleaned or overwritten where the system memory was
updated by the application. Fbcon wasn't assigned and the app mapped the
memory of course. Left it running at configured to HZ/50 for a while with=

1/3 of the screen updated at ~50 FPS by the test app, nothing interesting=

happened. Same tearing both ways.

I can't comment on performance as the CPU is moving the bytes in the defi=
o
callback and that code is too heavy at the moment to notice a difference.=

Test was performed on a dual core x86-64 (E3400).

So defio seems to still work after these changes for me.

Tested-by: Zsolt Kajtar <soci@c64.rulez.org>

> On Mon, Jan 13, 2025 at 11:15:45PM +0000, Lorenzo Stoakes wrote:
>> Right now the only means by which we can write-protect a range using t=
he
>> reverse mapping is via folio_mkclean().
>>
>> However this is not always the appropriate means of doing so, specific=
ally
>> in the case of the framebuffer deferred I/O logic (fb_defio enabled by=

>> CONFIG_FB_DEFERRED_IO). There, kernel pages are mapped read-only and
>> write-protect faults used to batch up I/O operations.
>>
>> Each time the deferred work is done, folio_mkclean() is used to mark t=
he
>> framebuffer page as having had I/O performed on it. However doing so
>> requires the kernel page (perhaps allocated via vmalloc()) to have its=

>> page->mapping, index fields set so the rmap can find everything that m=
aps
>> it in order to write-protect.
>>
>> This is problematic as firstly, these fields should not be set for
>> kernel-allocated memory, and secondly these are not folios (it's not u=
ser
>> memory) and page->index, mapping fields are now deprecated and soon to=
 be
>> removed.
>>
>> The implementers cannot be blamed for having used this however, as the=
re is
>> simply no other way of performing this operation correctly.
>>
>> This series fixes this - we provide the mapping_wrprotect_page() funct=
ion
>> to allow the reverse mapping to be used to look up mappings from the p=
age
>> cache object (i.e. its address_space pointer) at a specific offset.
>>
>> The fb_defio logic already stores this offset, and can simply be expan=
ded
>> to keep track of the page cache object, so the change then becomes
>> straight-forward.
>>
>> This series should have no functional change.
>>
>> *** REVIEWERS NOTES: ***
>>
>> I do not have any hardware that uses fb_defio, so I'm asking for help =
with
>> testing this series from those who do :) I have tested the mm side of =
this,
>> and done a quick compile smoke test of the fb_defio side but this _ver=
y
>> much_ requires testing on actual hardware to ensure everything behaves=
 as
>> expected.
>>
>> This is based on Andrew's tree [0] in the mm-unstable branch - I was
>> thinking it'd be best to go through the mm tree (with fb_defio maintai=
ner
>> approval, of course!) as it relies upon the mm changes to work correct=
ly.
>>
>> [0]: https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git/
>>
>> RFC v2:
>> * Updated Jaya Kumar's email on cc - the MAINTAINERS section is appare=
ntly incorrect.
>> * Corrected rmap_walk_file() comment to refer to folios as per Matthew=
=2E
>> * Reference folio->mapping rather than folio_mapping(folio) in rmap_wa=
lk_file()
>>   as per Matthew.
>> * Reference folio->index rather than folio_pgoff(folio) in rmap_walk_f=
ile() as
>>   per Matthew.
>> * Renamed rmap_wrprotect_file_page() to mapping_wrprotect_page() as pe=
r Matthew.
>> * Fixed kerneldoc and moved to implementation as per Matthew.
>> * Updated mapping_wrprotect_page() to take a struct page pointer as pe=
r David.
>> * Removed folio lock when invoking mapping_wrprotect_page() in
>>   fb_deferred_io_work() as per Matthew.
>> * Removed compound_nr() in fb_deferred_io_work() as per Matthew.
>>
>> RFC v1:
>> https://lore.kernel.org/all/1e452b5b65f15a9a5d0c2ed3f5f812fdd1367603.1=
736352361.git.lorenzo.stoakes@oracle.com/
>>
>> Lorenzo Stoakes (3):
>>   mm: refactor rmap_walk_file() to separate out traversal logic
>>   mm: provide mapping_wrprotect_page() function
>>   fb_defio: do not use deprecated page->mapping, index fields
>>
>>  drivers/video/fbdev/core/fb_defio.c |  38 ++-----
>>  include/linux/fb.h                  |   1 +
>>  include/linux/rmap.h                |   3 +
>>  mm/rmap.c                           | 152 +++++++++++++++++++++++----=
-
>>  4 files changed, 141 insertions(+), 53 deletions(-)
>>
>> --
>> 2.48.0

--=20
						    -soci-

--------------0S0qxsHBW0T0ZZpSCCUk14Me--

--------------nVU9OmgYBNOGfKq3nswQa5Ze
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEE8WlaH4v4aHNT2Bn0WOeEu4KftGsFAmeby+4FAwAAAAAACgkQWOeEu4KftGsw
Cgf/epz4AcATmcz3ijb2k6mLnoCHfqoWXB2SBvOFAEYZtZC36iEC0gxNcKuKzNFCoo0zlz+cnk+2
zRPLRz8Y+/YHOfceTpdkGnba7rJ2dPI909uonD38rBaz5JVONVSbuhTYU4j9hjreTs+wgr/vc9e0
tSL6538biOqADNAhVIh44CZr026wVe4dkUQaTyOHNTAWg6rvSZusuTWtcIHuBIBfzdwV3/mUFPf4
g6NSe3ejhapVbYoUnGkqaBeU1JLW4NTWBH9unM7ICy1l+7/kBJcn9ZDLnTlzYYJ6HOHJ8M1VhATi
XevJYWEURSNIKQqTu9f0AIKRttQJhoawdHub7dbOqQ==
=Wc13
-----END PGP SIGNATURE-----

--------------nVU9OmgYBNOGfKq3nswQa5Ze--
