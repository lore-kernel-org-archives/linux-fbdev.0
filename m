Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4272E3033FF;
	Sat, 28 Feb 2026 01:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772243630; cv=none; b=mVQ43WJKgI87eWKSm9oBrgZkzHWJDpRgj4di5qzCAxgjHxnxQoyFVy6K+NWxVk8RT1xPpSbQVEDBjQVOT4umYZ4bb8kSEeJ8Ej2QqyYJbrqgPGTm8U7dc6WFluEcTU0Tw0JqOkHLA+ADNfmvRQdzrjCkjBEsxIONGavWI4xJZsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772243630; c=relaxed/simple;
	bh=S+ilTV+vNMEsN7eYt/O6IIr3m29qfzUMEvysBrjiQcM=;
	h=From:To:CC:Subject:Date:Message-ID:References:Content-Type:
	 MIME-Version; b=PxgRfLoqKqHP3QCNe5KlQKMthfTS04Jh6YNJE0saqIwanh3L6AqQdUnVMnVULe9bj30IHVfJAZ23sa0o6fFa9dH3N6lWwnQVTydq22CWPwpCigBo2YtMyHvCKI49SprUAX5SEVYVTDANhAOEbj0x5Mgdw4/HesWw79ksBDvsJMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=tCXfa4FH; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=tCXfa4FH; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="tCXfa4FH";
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="tCXfa4FH"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=YgqhHcoNHz2fkv2FDernGNnKMhXqgo0CBDYIFanP39U=;
	b=tCXfa4FHZfMiOwevzr04qAlRb3ezqzJP9fmMj3jxFG++hhplMEZIxXA9ua/j19wK2oo0ljhOq
	HTbBsWQRi9rUqgXXFidD8F8IZuOjrhENmtZt+dGJEFS6oVTDjSgT5AJ+IvUV7Qeahc12wQvdRue
	UkFjUijHoefHEkSaWBptnpU=
Received: from canpmsgout01.his.huawei.com (unknown [172.19.92.178])
	by szxga01-in.huawei.com (SkyGuard) with ESMTPS id 4fN7Wk036jz1BFMt;
	Sat, 28 Feb 2026 09:53:22 +0800 (CST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=YgqhHcoNHz2fkv2FDernGNnKMhXqgo0CBDYIFanP39U=;
	b=tCXfa4FHZfMiOwevzr04qAlRb3ezqzJP9fmMj3jxFG++hhplMEZIxXA9ua/j19wK2oo0ljhOq
	HTbBsWQRi9rUqgXXFidD8F8IZuOjrhENmtZt+dGJEFS6oVTDjSgT5AJ+IvUV7Qeahc12wQvdRue
	UkFjUijHoefHEkSaWBptnpU=
Received: from mail.maildlp.com (unknown [172.19.162.144])
	by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4fN7QN0zhrz1T4G5;
	Sat, 28 Feb 2026 09:48:44 +0800 (CST)
Received: from dggpemf500012.china.huawei.com (unknown [7.185.36.8])
	by mail.maildlp.com (Postfix) with ESMTPS id B697540538;
	Sat, 28 Feb 2026 09:53:39 +0800 (CST)
Received: from dggpemf100008.china.huawei.com (7.185.36.138) by
 dggpemf500012.china.huawei.com (7.185.36.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Sat, 28 Feb 2026 09:53:39 +0800
Received: from dggpemf100008.china.huawei.com ([7.185.36.138]) by
 dggpemf100008.china.huawei.com ([7.185.36.138]) with mapi id 15.02.1544.011;
 Sat, 28 Feb 2026 09:53:39 +0800
From: "chenjun (AM)" <chenjun102@huawei.com>
To: Thomas Zimmermann <tzimmermann@suse.de>, "simona@ffwll.ch"
	<simona@ffwll.ch>, "deller@gmx.de" <deller@gmx.de>,
	"linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: "linruifeng (A)" <linruifeng4@huawei.com>
Subject: Re: [RFC PATCH] fbcon: Fix out-of-bounds memory in fbcon_putcs
Thread-Topic: [RFC PATCH] fbcon: Fix out-of-bounds memory in fbcon_putcs
Thread-Index: AQHcp/hkWokbZ7kj9E6ZoDdZSs/a8A==
Date: Sat, 28 Feb 2026 01:53:39 +0000
Message-ID: <031a9e0b2f5346bbb6875c985fac149b@huawei.com>
References: <20260227144358.101173-1-chenjun102@huawei.com>
 <bc9a37ac-43d2-451b-81b7-e0b23827006f@suse.de>
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

=1B$B:_=1B(B 2026/2/27 23:56, Thomas Zimmermann =1B$B<LF;=1B(B:=0A=
> Hi,=0A=
> =0A=
> thanks for the patch.=0A=
> =0A=
> Am 27.02.26 um 15:43 schrieb Chen Jun:=0A=
>> When a font is set on an invisible console, the screen will not update.=
=0A=
>> However, the fontbuffer is not updated to match the new font dimensions.=
=0A=
> =0A=
> I looked through vc_resize() but cannot quite find the logic that calls=
=0A=
> fbcon_rotate_font(). Can you please point to correct place?=0A=
> =0A=
> Best regards=0A=
> Thomas=0A=
> =0A=
=0A=
Hi, fbcon_rouate_font is called in fbcon_switch=0A=
=0A=
[   64.669554] CPU: 3 UID: 0 PID: 978 Comm: a.out Not tainted =0A=
7.0.0-rc1-00021-gd9d32e5bd5a4-dirty #10 PREEMPT(lazy)=0A=
[   64.669576] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), =0A=
BIOS rel-1.13.0-0-gf21b5a4aeb02-prebuilt.qemu.org 04/4=0A=
[   64.669584] Call Trace: =0A=
=0A=
[   64.669589]  <TASK> =0A=
=0A=
[   64.669595]  dump_stack_lvl+0x53/0x70 =0A=
=0A=
[   64.669615]  fbcon_rotate_font+0x2d6/0xe90 =0A=
=0A=
[   64.669636]  ? kfree+0x159/0x3b0 =0A=
=0A=
[   64.669650]  ? ud_cursor+0x830/0x1d80 =0A=
=0A=
[   64.669661]  ? __kmalloc_noprof+0x198/0x4a0 =0A=
=0A=
[   64.669674]  fbcon_switch+0x67b/0x10f0 =0A=
=0A=
[   64.669689]  ? __pfx_fbcon_switch+0x10/0x10 =0A=
=0A=
[   64.669708]  ? con_is_visible+0xb0/0x130 =0A=
=0A=
[   64.669723]  redraw_screen+0x258/0x690 =0A=
=0A=
[   64.669736]  ? mutex_unlock+0x7d/0xd0 =0A=
=0A=
[   64.669751]  ? __pfx_redraw_screen+0x10/0x10 =0A=
=0A=
[   64.669764]  ? tty_get_pgrp+0x73/0xb0 =0A=
=0A=
[   64.669784]  vc_do_resize+0x9a5/0xec0 =0A=
=0A=
[   64.669803]  ? __pfx_vc_do_resize+0x10/0x10 =0A=
=0A=
[   64.669815]  ? kernel_fpu_begin_mask+0x1c5/0x210 =0A=
=0A=
[   64.669832]  ? __pfx_kernel_fpu_begin_mask+0x10/0x10 =0A=
=0A=
[   64.669843]  ? fbcon_set_font+0x2cb/0x8c0 =0A=
=0A=
[   64.669853]  ? __kasan_kmalloc_large+0x81/0xa0 =0A=
=0A=
[   64.669863]  ? __kmalloc_large_node_noprof+0x18/0xb0 =0A=
=0A=
[   64.669874]  fbcon_do_set_font+0x390/0xa70 =0A=
=0A=
[   64.669890]  ? __pfx_fbcon_set_font+0x10/0x10 =0A=
=0A=
[   64.669900]  con_font_op+0x7d5/0xc30 =0A=
=0A=
[   64.669910]  ? arch_stack_walk+0x9f/0xf0 =0A=
=0A=
[   64.669924]  ? __pfx_con_font_op+0x10/0x10 =0A=
=0A=
[   64.669940]  vt_ioctl+0x8ee/0x2480 =0A=
=0A=
[   64.669953]  ? __pfx_vt_ioctl+0x10/0x10 =0A=
=0A=
[   64.669964]  ? __x64_sys_open+0x79/0xc0 =0A=
=0A=
[   64.669976]  ? do_syscall_64+0xfa/0x570 =0A=
=0A=
[   64.669986]  ? entry_SYSCALL_64_after_hwframe+0x77/0x7f =0A=
=0A=
[   64.669996]  ? __pfx_path_openat+0x10/0x10 =0A=
=0A=
[   64.670006]  ? __pfx_avc_has_extended_perms+0x10/0x10 =0A=
=0A=
[   64.670022]  ? _raw_spin_lock+0x7f/0xd0 =0A=
=0A=
[   64.670040]  ? do_file_open+0x22f/0x2b0 =0A=
=0A=
[   64.670048]  ? pte_offset_map_lock+0xe2/0x1e0 =0A=
=0A=
[   64.670070]  ? __pfx_do_file_open+0x10/0x10 =0A=
=0A=
[   64.670082]  tty_ioctl+0x3e7/0x1190 =0A=
=0A=
[   64.670098]  ? __pfx_tty_ioctl+0x10/0x10 =0A=
=0A=
[   64.670109]  ? __pfx_do_vfs_ioctl+0x10/0x10 =0A=
=0A=
[   64.670124]  ? ioctl_has_perm.constprop.74+0x2e1/0x4f0 =0A=
=0A=
[   64.670137]  ? __pfx_ioctl_has_perm.constprop.74+0x10/0x10 =0A=
=0A=
[   64.670148]  ? __pfx_do_sys_openat2+0x10/0x10 =0A=
=0A=
[   64.670191]  __x64_sys_ioctl+0x130/0x1a0 =0A=
=0A=
[   64.670204]  do_syscall_64+0xfa/0x570 =0A=
=0A=
[   64.670214]  entry_SYSCALL_64_after_hwframe+0x77/0x7f =0A=
=0A=
[   64.670223] RIP: 0033:0x7ff56cb0c577 =0A=
=0A=
[   64.670233] Code: b3 66 90 48 8b 05 11 89 2c 00 64 c7 00 26 00 00 00 =0A=
48 c7 c0 ff ff ff ff c3 66 2e 0f 1f 84 00 00 00 00 8=0A=
[   64.670242] RSP: 002b:00007fff94ab6a48 EFLAGS: 00000206 ORIG_RAX: =0A=
0000000000000010=0A=
[   64.670256] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: =0A=
00007ff56cb0c577=0A=
[   64.670263] RDX: 00007fff94ab6a60 RSI: 0000000000004b72 RDI: =0A=
0000000000000003=0A=
[   64.670269] RBP: 00007fff94ab6af0 R08: 000055bf68e008d0 R09: =0A=
00007ff56cdec090=0A=
[   64.670275] R10: 0000000000000000 R11: 0000000000000206 R12: =0A=
000055bf68e00630=0A=
[   64.670281] R13: 00007fff94ab6be0 R14: 0000000000000000 R15: =0A=
0000000000000000=0A=
[   64.670293]  </TASK> =0A=
=0A=
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
