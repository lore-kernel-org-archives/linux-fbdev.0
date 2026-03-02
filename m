Received: from canpmsgout01.his.huawei.com (canpmsgout01.his.huawei.com [113.46.200.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25C7E331A41;
	Mon,  2 Mar 2026 11:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772450647; cv=none; b=S6nmVFVMYAbcciQcFyZj8aX2VcJYOw/4uI5GxlNOoKl9Te/ajykyeN+W09dN08AU2tC6cp8Q3SMfa4BRsFBuFs/DEHwBdb4ZNNwSGD01Ugp0ow+qcSpsiozVR/TX/hfzjaaCanpDYeN5ec+XQ2sDHU0xBmOXTCQwlHRWYIbZ+6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772450647; c=relaxed/simple;
	bh=nJG3uv0DRbLHlAN2sg47noIL9znJRp1j+EmiYfUAwe8=;
	h=From:To:CC:Subject:Date:Message-ID:References:Content-Type:
	 MIME-Version; b=GAT/z1dln9AMD7k2UMQNBgt9bNFW0uRONZWeYiXvKwHjz1ptCo3LsUby5KgSgfj1usbIhGvs8C1f+cBC2p0oJ3BXreBhtXP7K8bt99Dhv04gCfptCOL2lvVfy8psCuzDdSqy0kiHa25egp+NdkZZRJ/zis+xF+XPdqEHgMwcLF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=CUlc1P/g; arc=none smtp.client-ip=113.46.200.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="CUlc1P/g"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=I2UZm9FgJ4ujM2J35wKIVyC3lCXrj+SWcquGkOnO66w=;
	b=CUlc1P/g9bUg2LO3HGtKQCBuUTVYYC2H5IhsIajxe1b4TPbOaJm21I7/x7062nKokGF3dEH0R
	bi8keMnfeDTj3R94Efq5LWtEYCnKbuEbR2hbPK6Y1t+m6w5x1RtSQp/2kZOEIZmJ/Hp2u8lpmN5
	lSz2lW+dRjTS+rVfa+ONUas=
Received: from mail.maildlp.com (unknown [172.19.163.0])
	by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4fPbzT6b9yz1T4Fq;
	Mon,  2 Mar 2026 19:19:01 +0800 (CST)
Received: from dggpemf200010.china.huawei.com (unknown [7.185.36.144])
	by mail.maildlp.com (Postfix) with ESMTPS id D94A440561;
	Mon,  2 Mar 2026 19:24:00 +0800 (CST)
Received: from dggpemf100008.china.huawei.com (7.185.36.138) by
 dggpemf200010.china.huawei.com (7.185.36.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 2 Mar 2026 19:24:00 +0800
Received: from dggpemf100008.china.huawei.com ([7.185.36.138]) by
 dggpemf100008.china.huawei.com ([7.185.36.138]) with mapi id 15.02.1544.011;
 Mon, 2 Mar 2026 19:24:00 +0800
From: "chenjun (AM)" <chenjun102@huawei.com>
To: Thomas Zimmermann <tzimmermann@suse.de>, "simona@ffwll.ch"
	<simona@ffwll.ch>, "deller@gmx.de" <deller@gmx.de>,
	"linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: "linruifeng (A)" <linruifeng4@huawei.com>
Subject: Re: [RFC PATCH] fbcon: Fix out-of-bounds memory in fbcon_putcs
Thread-Topic: [RFC PATCH] fbcon: Fix out-of-bounds memory in fbcon_putcs
Thread-Index: AQHcp/hkWokbZ7kj9E6ZoDdZSs/a8A==
Date: Mon, 2 Mar 2026 11:24:00 +0000
Message-ID: <e8e3b8182e124ac08cc33700d45772ce@huawei.com>
References: <20260227144358.101173-1-chenjun102@huawei.com>
 <1c078618-7236-4ccb-ae99-376276369f36@suse.de>
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

=1B$B:_=1B(B 2026/3/2 18:19, Thomas Zimmermann =1B$B<LF;=1B(B:=0A=
> =0A=
> =0A=
> Am 27.02.26 um 15:43 schrieb Chen Jun:=0A=
>> When a font is set on an invisible console, the screen will not update.=
=0A=
>> However, the fontbuffer is not updated to match the new font dimensions.=
=0A=
>>=0A=
>> This inconsistency leads to out-of-bounds memory access when writing to=
=0A=
>> the tty bound to fbcon, as demonstrated by the following KASAN report:=
=0A=
>>=0A=
>> BUG: KASAN: slab-out-of-bounds in fb_pad_aligned_buffer+0xdf/0x140=0A=
>> Read of size 1 at addr ffff8881195a2280 by task a.out/971=0A=
>> Call Trace:=0A=
>>    <TASK>=0A=
>>    fb_pad_aligned_buffer+0xdf/0x140=0A=
>>    ud_putcs+0x88a/0xde0=0A=
>>    fbcon_putcs+0x319/0x430=0A=
>>    do_update_region+0x23c/0x3b0=0A=
>>    do_con_write+0x225c/0x67f0=0A=
>>    con_write+0xe/0x30=0A=
>>    n_tty_write+0x4b5/0xff0=0A=
>>    file_tty_write.isra.41+0x46c/0x880=0A=
>>    vfs_write+0x868/0xd60=0A=
>>    ksys_write+0xf2/0x1d0=0A=
>>    do_syscall_64+0xfa/0x570=0A=
>>=0A=
>> Fix this by calling fbcon_rotate_font() if vc is invisible in=0A=
>> fbcon_do_set_font().=0A=
>>=0A=
>> Signed-off-by: Chen Jun <chenjun102@huawei.com>=0A=
> =0A=
> Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>=0A=
=0A=
Hi Thomas,=0A=
=0A=
Thanks for your review.=0A=
=0A=
I'm not familiar with the fbcon module. Is there a better way to fix this?=
=0A=
=0A=
>> ---=0A=
>>    drivers/video/fbdev/core/fbcon.c | 5 +++++=0A=
>>    1 file changed, 5 insertions(+)=0A=
>>=0A=
>> diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core=
/fbcon.c=0A=
>> index 666261ae59d8..d76100188bee 100644=0A=
>> --- a/drivers/video/fbdev/core/fbcon.c=0A=
>> +++ b/drivers/video/fbdev/core/fbcon.c=0A=
>> @@ -2444,6 +2444,11 @@ static int fbcon_do_set_font(struct vc_data *vc, =
int w, int h, int charcount,=0A=
>>    		rows =3D FBCON_SWAP(par->rotate, info->var.yres, info->var.xres);=
=0A=
>>    		cols /=3D w;=0A=
>>    		rows /=3D h;=0A=
>> +		if (!con_is_visible(vc)) {=0A=
>> +			ret =3D fbcon_rotate_font(info, vc);=0A=
>> +			if (ret)=0A=
>> +				goto err_out;=0A=
>> +		}=0A=
>>    		ret =3D vc_resize(vc, cols, rows);=0A=
>>    		if (ret)=0A=
>>    			goto err_out;=0A=
> =0A=
=0A=
=0A=
