Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D648F2C324D
	for <linux-fbdev@vger.kernel.org>; Fri, 24 Apr 2026 08:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777020275; cv=none; b=kXOTjtdywWRkzuDZbdkZuXF/MTNGQ6kYwRtZk2L7I1iPQXP9v2BzgFyRGHIqyBLTdrHbkeShkek41p03GKFThhG9fUQ+ZshxnhE4Z4VH1Y6ROVMvgpqeyp2qagc8pVO+8g0JmZmt8kzZnNeSv3fjdUNX/MNvix/xJu+9wN3S+Rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777020275; c=relaxed/simple;
	bh=7ISYR8F3K2sFaIG27uwE9ScnE0QQmJa2992ne+W9AoI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=UGtRdbneU8S/dzn2P/18ZGoijng3Q0ctuLV4vmQiMnOsthkw25i/jMt9dGVKe5P8JBtVFxPJBrnjuVpdRJxbvN+AOgOHLPPKUVsRvTg0656w+WTRUMlahAMYXjMSVFJ4KU7O5hjS8irAmFT6b9cBv6kum158CJRJlC0dOx/fv4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b=PXU9w0kN; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b="PXU9w0kN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1777020272; x=1777625072; i=deller@gmx.de;
	bh=7ISYR8F3K2sFaIG27uwE9ScnE0QQmJa2992ne+W9AoI=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=PXU9w0kNiayXanrjB3b0nwi2ppNZGUIRdNnSngEfwegFBfZouNWP4EfGF+dYoAqC
	 edmpQNbdm7yfXO010DPh3neKeWJpW49nNiXsoPKw/VS9s1GTvUmm81ny8b8wTbjMv
	 VX0Sq/kkgtNFMKUmgqT03GJeGMHnFaEpp3ibO7/TI0kYHYSs3iNBWz5ujW+dRY4dE
	 qjzbEl7MinhdcES1M3dlO44gIdR+L9dGKI3+LfUtoMmozpmZLp7hLQbyWsTlDbK0V
	 +eTfkUdnAA1AOFPiZwwvDFhERI3vHfI0rhpizEUxkjpyDHwAXxyv5a2ozYzVMifs/
	 1dWJyxvobuwl7vxNzg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mi2Nv-1vlHEB1dSr-00nnMd; Fri, 24
 Apr 2026 10:39:22 +0200
Message-ID: <5ccb6ea6-37e5-48c9-a6cf-f794edf7a7fd@gmx.de>
Date: Fri, 24 Apr 2026 10:39:21 +0200
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/todo: Drop todo item to request memory regions in all
 fbdev drivers
To: Thomas Zimmermann <tzimmermann@suse.de>, linux-fbdev@vger.kernel.org,
 dri-devel@lists.freedesktop.org
References: <20260423205531.49971-1-deller@gmx.de>
 <3fe83b69-b868-45a8-9862-50c6f0fdeb95@suse.de>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <3fe83b69-b868-45a8-9862-50c6f0fdeb95@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:iBDlGTwRJDq3wZdw9a9/XrY9Tjl8FWC9nbgyag3Cee370KZNAnY
 bwLrB2D4gFYwzqpMcx9QKpDtlHXhwOJmDE48zPaLLcslHlxWpN5fI5biehPv7DIHgWQy76q
 hD6Q8aYB8C72LF8BnVZm2BoTgeCQT1IN6IpxbToHwMcT90djjRkbSKjW87i1/jMXyvNSM6Z
 wAVUku0Tme77UlJrFUNiQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:5vMQneQi4n8=;xR5V9+f6CmaoBDRP5JWw1fmZOM8
 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
 XwCttWdOF9rvxGIm4hGqymKk/1dD6eTeXpEU=

On 4/24/26 08:57, Thomas Zimmermann wrote:
> Hi
>=20
> Am 23.04.26 um 22:55 schrieb Helge Deller:
>> This item is tagged for beginners, so often people not familiar with
>> the fbdev drivers think this is an easy task, start up their AI tools
>> and blindly send in the generated code as patches.
>>
>> The problem:
>> - Those patches often introduce bugs, so
>> - ideally want the code tested, since ressource misconfigurations
>> =C2=A0=C2=A0 often lead to failing drivers
>> - The patches are often unnecessary, since in the old machines with the
>> =C2=A0=C2=A0 old graphic cards resource conflicts usually don't happen =
as only one
>> =C2=A0=C2=A0 graphic card can be used at a time anyway.
>> - and today most relevant drivers have necessary patches already
>> =C2=A0=C2=A0 implemented.
>>
>> So, let's get rid of this todo item and silence the steady stream of
>> stupid patches.
>=20
> I see that AI patches can be problematic, but reserving these
> regions is still the correct thing to do. Removing the TODO item
> will not change that.

Sure.
 =20
> Some background on why this item exists: we currently use aperture
> helpers [1] to manage ownership of the framebuffer memory during
> boot up. This is necessary to switch from the system-framebuffer
> driver (i..e, simplefb, simpledrm, etc) to the hardware's native
> driver. But this is all ad-hoc because Linux' resource management
> doesn't do this for us. Before we can integrate any such
> functionality, we have to fix all drivers to reserve their resources
> correctly.
>=20
> If we remove the TODO item, we'd likely still want to move forward
> with improving resource management. If that breaks unfixed fbdev
> drivers, users would then also send bug reports.

Ok for me.

Helge

> And the other point is (again) that if there are no means of testing a d=
river and no information whether a driver is actually in used by anyone, i=
t's maybe time to remove the driver.
>=20
> [1] https://elixir.bootlin.com/linux/v7.0.1/source/drivers/video/apertur=
e.c#L17
>=20
> Best regards
> Thomas
>=20
>=20
>>
>> Signed-off-by: Helge Deller <deller@gmx.de>
>> ---
>> =C2=A0 Documentation/gpu/todo.rst | 16 ----------------
>> =C2=A0 1 file changed, 16 deletions(-)
>>
>> diff --git a/Documentation/gpu/todo.rst b/Documentation/gpu/todo.rst
>> index bc9f14c8a2ec..b4dd64a8cc06 100644
>> --- a/Documentation/gpu/todo.rst
>> +++ b/Documentation/gpu/todo.rst
>> @@ -448,22 +448,6 @@ Contact: Thomas Zimmermann <tzimmermann@suse.de>
>> =C2=A0 Level: Intermediate
>> -Request memory regions in all fbdev drivers
>> ---------------------------------------------
>> -
>> -Old/ancient fbdev drivers do not request their memory properly.
>> -Go through these drivers and add code to request the memory regions
>> -that the driver uses. This requires adding calls to request_mem_region=
(),
>> -pci_request_region() or similar functions. Use helpers for managed cle=
anup
>> -where possible. Problematic areas include hardware that has exclusive =
ranges
>> -like VGA. VGA16fb does not request the range as it is expected.
>> -Drivers are pretty bad at doing this and there used to be conflicts am=
ong
>> -DRM and fbdev drivers. Still, it's the correct thing to do.
>> -
>> -Contact: Thomas Zimmermann <tzimmermann@suse.de>
>> -
>> -Level: Starter
>> -
>> =C2=A0 Remove driver dependencies on FB_DEVICE
>> =C2=A0 ---------------------------------------
>=20

