Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFA05223DD6
	for <linux-fbdev@vger.kernel.org>; Wed,  4 Mar 2026 13:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772630379; cv=none; b=ILi60jjmoC8oq837NfUfYMJ/IOSVsUDhlC2RBE/uHCCPTHpjnD7G/d0pJHmmbDDcqQFdZ9hEc/EOYYuRBs7mNRDzB0snA6kGS0nrT+FhYkidTad9QOryGlltWpXHbWaTH+SpzpD83317UNKMTrbnEf9cM5mUWrEmbCqvhq5fkaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772630379; c=relaxed/simple;
	bh=zJAyQn3go9nxFaacMJdEJ/WQX+r7j53d9XJkFqbCVKA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ibSU6egpd7zc0AtfwmLoZmWKeg3H7olnE3RaIETFTIo4+Ebvm2be+ZZRQSu0MAr8jhkPc6+y9W8CRNv1ML40IX52ZsIgusOKo8aUd4euzcCEnePOl7i08MeNBgbQ/FGM0h1MU3WNS0vWVgpV24zCcbdQGmOOUhE298b7gfcQR6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b=gHRkKMcX; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b="gHRkKMcX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1772630372; x=1773235172; i=deller@gmx.de;
	bh=zJAyQn3go9nxFaacMJdEJ/WQX+r7j53d9XJkFqbCVKA=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=gHRkKMcXKFgoUeRHoCpfJ/OB35e5feG7vSGKQIeeRdVDKqpx6LuavzgIFO46tQnd
	 CeCO1HoLNNkWq1ZzVzC8RZxXHrMAt8XnwVOmOwvs+r4w13tPT1JdJlclS/obOPn4u
	 OATgPaK9lWeuk1OxhuEAPT2cYrotHJYHexOr1dsz/rNB94dz+jFOj+Jqjzs3L+PXN
	 pZP3mOpK8oeKIj/+K1kQoJLUPUhAtagzUzTZVFVMXVUayCCE72LDpyuCoT8peS1a6
	 rkFnv6RkwhBebhyvTRKac1KoMxMGCp0tfe45vwXBHG9dup1T3Y5QknDqGtWVYMnXE
	 1uakIWxf1/iV6cVmbQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MulqN-1vhD1M40ep-0169dv; Wed, 04
 Mar 2026 14:19:32 +0100
Message-ID: <b919babb-a287-4d2d-9808-0fe91adadcbc@gmx.de>
Date: Wed, 4 Mar 2026 14:19:30 +0100
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] fbcon: Fix out-of-bounds memory in fbcon_putcs
To: Thomas Zimmermann <tzimmermann@suse.de>,
 "chenjun (AM)" <chenjun102@huawei.com>, "simona@ffwll.ch" <simona@ffwll.ch>,
 "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>
Cc: "linruifeng (A)" <linruifeng4@huawei.com>
References: <20260227144358.101173-1-chenjun102@huawei.com>
 <1c078618-7236-4ccb-ae99-376276369f36@suse.de>
 <e8e3b8182e124ac08cc33700d45772ce@huawei.com>
 <8772d571-43a9-45ea-9bd7-63928e357ab0@suse.de>
 <ab91899d3fc34585ab119dc2b246c24a@huawei.com>
 <33bab812-163b-4cf1-88bc-19e6949cc038@suse.de>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <33bab812-163b-4cf1-88bc-19e6949cc038@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Ggs4FJH89dkWifvuZnHaTtWSBIePXEoHBepV1j0d2sJ56G+NM9r
 AvjAnVJy+rM054HQ9h4rQmNMULNvuEVLfSCADcZQv52rg4i/kGhDuWARIk4D6tJYAwkZufj
 SSP3qDJR9BRBpeAenLxFIJ5QlXtqxDPtldQUWmoQTogf3M6dRXnGoWhC69Qpjz0KjIEJ3e0
 0KLuwEisvrSQ/RmYNHuaA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Aw2/hKpwxiQ=;Q4Alf5I9/OFMHZoJLgzIm8O1pbn
 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

On 3/4/26 10:57, Thomas Zimmermann wrote:
> Hi
>=20
> Am 04.03.26 um 04:47 schrieb chenjun (AM):
>> =E5=9C=A8 2026/3/2 19:34, Thomas Zimmermann =E5=86=99=E9=81=93:
>>> Hi
>>>
>>> Am 02.03.26 um 12:24 schrieb chenjun (AM):
>>>> =E5=9C=A8 2026/3/2 18:19, Thomas Zimmermann =E5=86=99=E9=81=93:
>>>>> Am 27.02.26 um 15:43 schrieb Chen Jun:
>>>>>> When a font is set on an invisible console, the screen will not upd=
ate.
>>>>>> However, the fontbuffer is not updated to match the new font dimens=
ions.
>>>>>>
>>>>>> This inconsistency leads to out-of-bounds memory access when writin=
g to
>>>>>> the tty bound to fbcon, as demonstrated by the following KASAN repo=
rt:
>>>>>>
>>>>>> BUG: KASAN: slab-out-of-bounds in fb_pad_aligned_buffer+0xdf/0x140
>>>>>> Read of size 1 at addr ffff8881195a2280 by task a.out/971
>>>>>> Call Trace:
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 <TASK>
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fb_pad_aligned_buffer+0xdf/0x140
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ud_putcs+0x88a/0xde0
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fbcon_putcs+0x319/0x430
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 do_update_region+0x23c/0x3b0
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 do_con_write+0x225c/0x67f0
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 con_write+0xe/0x30
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 n_tty_write+0x4b5/0xff0
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 file_tty_write.isra.41+0x46c/0x880
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 vfs_write+0x868/0xd60
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ksys_write+0xf2/0x1d0
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 do_syscall_64+0xfa/0x570
>>>>>>
>>>>>> Fix this by calling fbcon_rotate_font() if vc is invisible in
>>>>>> fbcon_do_set_font().
>>>>>>
>>>>>> Signed-off-by: Chen Jun <chenjun102@huawei.com>
>>>>> Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
>>>> Hi Thomas,
>>>>
>>>> Thanks for your review.
>>>>
>>>> I'm not familiar with the fbcon module. Is there a better way to fix =
this?
>>> Not really, I think. The whole module first needs a redesign to be
>>> easier to understand.
>>>
>>> Best regards
>>> Thomas
>>>
>>>>>> ---
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 drivers/video/fbdev/core/fbcon.c | 5=
 +++++
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1 file changed, 5 insertions(+)
>>>>>>
>>>>>> diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev=
/core/fbcon.c
>>>>>> index 666261ae59d8..d76100188bee 100644
>>>>>> --- a/drivers/video/fbdev/core/fbcon.c
>>>>>> +++ b/drivers/video/fbdev/core/fbcon.c
>>>>>> @@ -2444,6 +2444,11 @@ static int fbcon_do_set_font(struct vc_data =
*vc, int w, int h, int charcount,
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 rows =3D FBCON_SWAP(par->rotate, info->var.yres, info->var.xr=
es);
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 cols /=3D w;
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 rows /=3D h;
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!con_is_visible(vc)=
) {
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 ret =3D fbcon_rotate_font(info, vc);
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 if (ret)
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 goto err_out;
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> Hi Thomas and Helge,
>>
>> I apologize, but after reviewing the code, I believe there is a problem=
.
>> The issue is that fbcon_do_set_font() updates members of
>> info->fbcon_par, and the info are shared with other vc instances.
>=20
> Than let's drop the patch for now.

Patch is now dropped from fbdev git tree.

Helge
