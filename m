Received: from canpmsgout09.his.huawei.com (canpmsgout09.his.huawei.com [113.46.200.224])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D03BE37C938;
	Wed,  4 Mar 2026 03:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.224
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772596034; cv=none; b=mWCSrnCdv50wXM/KA7xw49DiY5IhS3B3qixHjFa8eY4uHp1WsZlwIif3Knpt/wxCFjMgB1QYEwvaegN3lvAqjE0B2Bbo2pfC9dFMGHlCwSyoi/+nXzN4UwTH7P/9SG8q5R2cB9zeo29Ry67SuCHYPo69Ywnk/0YJMzVcqROMTAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772596034; c=relaxed/simple;
	bh=R7Y0Vhg0vbnCUOWov2QZL8yJJBQ0d8UD/2fGXSIsV/o=;
	h=From:To:CC:Subject:Date:Message-ID:References:Content-Type:
	 MIME-Version; b=bV6ePH84DmvPCn3CKXCHwjokr4qCdrEo6+H1OFPsDWIfy9hRnI6nrJ6DwTkwvAmHSy97vskGo/Q+i4Regsh9Q+KsjYuqIgQJWD5hACxEX9fUjjZPIp87jPR6tIbE9uLiJo9JUvdx2KIpqBnm9bIQ+v2jLyQKeC/eXqExwJLWIc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=reUD3SzR; arc=none smtp.client-ip=113.46.200.224
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="reUD3SzR"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=J7Mh7bqFG+UquGstqyTgDAuEz5QqjV3HrrBSgI2oVhg=;
	b=reUD3SzRtzllOXM6XH7tGTit+EaVqVpiizqK8scFaoysrHy89vV+IIfH4RM5rz1vJ5NjN16AR
	icEu85wSKZ7SXlma8aK0nTtTNor6Qdd3iyRoQK1g//mP0bYkkFR/C2aeRuziY4ZZaAVJGPGx0nz
	Frp7B0O7LHUaTs5szeiDt5E=
Received: from mail.maildlp.com (unknown [172.19.163.163])
	by canpmsgout09.his.huawei.com (SkyGuard) with ESMTPS id 4fQdlY4fn7z1cyPw;
	Wed,  4 Mar 2026 11:42:17 +0800 (CST)
Received: from dggpemf500011.china.huawei.com (unknown [7.185.36.131])
	by mail.maildlp.com (Postfix) with ESMTPS id 65E334048B;
	Wed,  4 Mar 2026 11:47:08 +0800 (CST)
Received: from dggpemf100008.china.huawei.com (7.185.36.138) by
 dggpemf500011.china.huawei.com (7.185.36.131) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 4 Mar 2026 11:47:08 +0800
Received: from dggpemf100008.china.huawei.com ([7.185.36.138]) by
 dggpemf100008.china.huawei.com ([7.185.36.138]) with mapi id 15.02.1544.011;
 Wed, 4 Mar 2026 11:47:08 +0800
From: "chenjun (AM)" <chenjun102@huawei.com>
To: Thomas Zimmermann <tzimmermann@suse.de>, "simona@ffwll.ch"
	<simona@ffwll.ch>, "deller@gmx.de" <deller@gmx.de>,
	"linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: "linruifeng (A)" <linruifeng4@huawei.com>
Subject: Re: [RFC PATCH] fbcon: Fix out-of-bounds memory in fbcon_putcs
Thread-Topic: [RFC PATCH] fbcon: Fix out-of-bounds memory in fbcon_putcs
Thread-Index: AQHcp/hkWokbZ7kj9E6ZoDdZSs/a8A==
Date: Wed, 4 Mar 2026 03:47:07 +0000
Message-ID: <ab91899d3fc34585ab119dc2b246c24a@huawei.com>
References: <20260227144358.101173-1-chenjun102@huawei.com>
 <1c078618-7236-4ccb-ae99-376276369f36@suse.de>
 <e8e3b8182e124ac08cc33700d45772ce@huawei.com>
 <8772d571-43a9-45ea-9bd7-63928e357ab0@suse.de>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

=1B$B:_=1B(B 2026/3/2 19:34, Thomas Zimmermann =1B$B<LF;=1B(B:=0A=
> Hi=0A=
> =0A=
> Am 02.03.26 um 12:24 schrieb chenjun (AM):=0A=
>> =1B$B:_=1B(B 2026/3/2 18:19, Thomas Zimmermann =1B$B<LF;=1B(B:=0A=
>>>=0A=
>>> Am 27.02.26 um 15:43 schrieb Chen Jun:=0A=
>>>> When a font is set on an invisible console, the screen will not update=
.=0A=
>>>> However, the fontbuffer is not updated to match the new font dimension=
s.=0A=
>>>>=0A=
>>>> This inconsistency leads to out-of-bounds memory access when writing t=
o=0A=
>>>> the tty bound to fbcon, as demonstrated by the following KASAN report:=
=0A=
>>>>=0A=
>>>> BUG: KASAN: slab-out-of-bounds in fb_pad_aligned_buffer+0xdf/0x140=0A=
>>>> Read of size 1 at addr ffff8881195a2280 by task a.out/971=0A=
>>>> Call Trace:=0A=
>>>>      <TASK>=0A=
>>>>      fb_pad_aligned_buffer+0xdf/0x140=0A=
>>>>      ud_putcs+0x88a/0xde0=0A=
>>>>      fbcon_putcs+0x319/0x430=0A=
>>>>      do_update_region+0x23c/0x3b0=0A=
>>>>      do_con_write+0x225c/0x67f0=0A=
>>>>      con_write+0xe/0x30=0A=
>>>>      n_tty_write+0x4b5/0xff0=0A=
>>>>      file_tty_write.isra.41+0x46c/0x880=0A=
>>>>      vfs_write+0x868/0xd60=0A=
>>>>      ksys_write+0xf2/0x1d0=0A=
>>>>      do_syscall_64+0xfa/0x570=0A=
>>>>=0A=
>>>> Fix this by calling fbcon_rotate_font() if vc is invisible in=0A=
>>>> fbcon_do_set_font().=0A=
>>>>=0A=
>>>> Signed-off-by: Chen Jun <chenjun102@huawei.com>=0A=
>>> Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>=0A=
>> Hi Thomas,=0A=
>>=0A=
>> Thanks for your review.=0A=
>>=0A=
>> I'm not familiar with the fbcon module. Is there a better way to fix thi=
s?=0A=
> =0A=
> Not really, I think. The whole module first needs a redesign to be=0A=
> easier to understand.=0A=
> =0A=
> Best regards=0A=
> Thomas=0A=
> =0A=
>>=0A=
>>>> ---=0A=
>>>>      drivers/video/fbdev/core/fbcon.c | 5 +++++=0A=
>>>>      1 file changed, 5 insertions(+)=0A=
>>>>=0A=
>>>> diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/co=
re/fbcon.c=0A=
>>>> index 666261ae59d8..d76100188bee 100644=0A=
>>>> --- a/drivers/video/fbdev/core/fbcon.c=0A=
>>>> +++ b/drivers/video/fbdev/core/fbcon.c=0A=
>>>> @@ -2444,6 +2444,11 @@ static int fbcon_do_set_font(struct vc_data *vc=
, int w, int h, int charcount,=0A=
>>>>      		rows =3D FBCON_SWAP(par->rotate, info->var.yres, info->var.xres=
);=0A=
>>>>      		cols /=3D w;=0A=
>>>>      		rows /=3D h;=0A=
>>>> +		if (!con_is_visible(vc)) {=0A=
>>>> +			ret =3D fbcon_rotate_font(info, vc);=0A=
>>>> +			if (ret)=0A=
>>>> +				goto err_out;=0A=
>>>> +		}=0A=
=0A=
Hi Thomas and Helge,=0A=
=0A=
I apologize, but after reviewing the code, I believe there is a problem.=0A=
The issue is that fbcon_do_set_font() updates members of =0A=
info->fbcon_par, and the info are shared with other vc instances.=0A=
=0A=
Best regards=0A=
Chen Jun=0A=
=0A=
>>>>      		ret =3D vc_resize(vc, cols, rows);=0A=
>>>>      		if (ret)=0A=
>>>>      			goto err_out;=0A=
>>=0A=
> =0A=
=0A=
