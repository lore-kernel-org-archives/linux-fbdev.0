Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D1134EA377;
	Tue,  3 Mar 2026 19:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772567340; cv=none; b=nQauVeOeyVfNP4kAnN5xu5LzaBzmN7xXw5pUeefMuYibZMX24HysZHuy6vKW8TVMOYtKHAE3nTMFwoBBrhy/1wbC5Qjwn34wkaWkQCCXJ6EyYpTxOMtlFOenRk+X50W9b8kok+BhCfr8kB4wuB0DJoc5qBwYzAaGFKqdlDHnP00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772567340; c=relaxed/simple;
	bh=wi9LWREveuwKFs2vcAzCGhS/3R10Dw/jcCnrEl/bAHs=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=VtAxzESk3K+nvYbDohBfUBPDiYWyOlM5pDCpBor2RVDCDb5X4Xt3D2wVdSW48rq6+aMCdL1L5KDGCL65++juBMw+DuHXFnZN8Xcnp8xBdGdBVev3hJuDsHI7c6bEr3xp3DGU/E/u/mfOt9tux9J342YAh8iS22P6DLC0vmI5v3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b=nc4lfpHR; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b="nc4lfpHR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1772567333; x=1773172133; i=deller@gmx.de;
	bh=UZsq+a1lyRe1B/+Wa5+G2cTiNkWubqgCj6VvGU94ors=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=nc4lfpHRXeO9BXZKAlTe+hgw6lnunh1yWJ6Gnj7p0kwdsfxCF6iqHfw85C7VgrBN
	 2D0hCMHy3QsbQ/PpKAL6h6zggcabWMzJyAfOnAbDPc9IlIFFKUkLU3oH024+HKenP
	 I7PDQBP6RjngKtfsLj7/Lh+sV0THhSiAYqYyIeaiyxZ95HH7BayPshhgFCBw1FVs+
	 DWJW721+IIuua2sediTmv8PxNOHrOSRF66iFuv+ACUIP0ATbZ8hO6Ed98ZHHVSALH
	 GBHh6+lgS1h/F5c9+VzzR/KaVF4ZOy4zCP329Ayglqck915tq4wKvbUTiZ8+9S4od
	 6orHrTuA05zvXLqcVg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MQMyf-1wJHka0tIP-00RqWa; Tue, 03
 Mar 2026 20:48:53 +0100
Message-ID: <9bdf0256-201e-454c-a491-96ec86959d3d@gmx.de>
Date: Tue, 3 Mar 2026 20:48:50 +0100
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] fbcon: Fix out-of-bounds memory in fbcon_putcs
From: Helge Deller <deller@gmx.de>
To: Chen Jun <chenjun102@huawei.com>, simona@ffwll.ch, tzimmermann@suse.de,
 linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: linruifeng4@huawei.com
References: <20260227144358.101173-1-chenjun102@huawei.com>
 <e85bd96c-031f-477e-b0ce-aa10161fbb97@gmx.de>
Content-Language: en-US
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <e85bd96c-031f-477e-b0ce-aa10161fbb97@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:s2Le2lPEFoEAWztV1YBwsjFPN1ApL/Wj76cmh6YOEbdDBOWSmmO
 zqkNxn8lkk4eztWqTknv0t1UHuEHVpU/jCB/beL3qedda4XnnL9BIdqpDh1N5ERzNDV08Ed
 B9/XMkg4CB5t14uol/MNd8lZElQIs00jUYWK+x+XrkEmJU8E+YYq7CXhABuy1hh+RUlMkbf
 bXEGUlGIWdGiE6SwwNAmg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:C+2Ciy+81Ds=;UQ5CMmPrki4bQF2EnBiMgE2KeWM
 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
 XYXHCf1o=

On 3/3/26 15:15, Helge Deller wrote:
> On 2/27/26 15:43, Chen Jun wrote:
>> When a font is set on an invisible console, the screen will not update.
>> However, the fontbuffer is not updated to match the new font dimensions=
.
>>
>> This inconsistency leads to out-of-bounds memory access when writing to
>> the tty bound to fbcon, as demonstrated by the following KASAN report:
>>
>> BUG: KASAN: slab-out-of-bounds in fb_pad_aligned_buffer+0xdf/0x140
>> Read of size 1 at addr ffff8881195a2280 by task a.out/971
>> Call Trace:
>> =C2=A0 <TASK>
>> =C2=A0 fb_pad_aligned_buffer+0xdf/0x140
>> =C2=A0 ud_putcs+0x88a/0xde0
>> =C2=A0 fbcon_putcs+0x319/0x430
>> =C2=A0 do_update_region+0x23c/0x3b0
>> =C2=A0 do_con_write+0x225c/0x67f0
>> =C2=A0 con_write+0xe/0x30
>> =C2=A0 n_tty_write+0x4b5/0xff0
>> =C2=A0 file_tty_write.isra.41+0x46c/0x880
>> =C2=A0 vfs_write+0x868/0xd60
>> =C2=A0 ksys_write+0xf2/0x1d0
>> =C2=A0 do_syscall_64+0xfa/0x570
>>
>> Fix this by calling fbcon_rotate_font() if vc is invisible in
>> fbcon_do_set_font().
>>
>> Signed-off-by: Chen Jun <chenjun102@huawei.com>
>> ---
>> =C2=A0 drivers/video/fbdev/core/fbcon.c | 5 +++++
>> =C2=A0 1 file changed, 5 insertions(+)
>=20
> applied to fbdev git tree.

I got a compile error:

hppa-linux-gnu-ld: drivers/video/fbdev/core/fbcon.o: in function `fbcon_do=
_set_font':
/home/cvs/parisc/git-kernel/linus-linux-2.6/drivers/video/fbdev/core/fbcon=
.c:2392:(.text+0x1e28): undefined reference to `fbcon_rotate_font'
make[3]: *** [/home/cvs/parisc/git-kernel/linus-linux-2.6/scripts/Makefile=
.vmlinux:72: vmlinux.unstripped] Error 1

I modified your patch like this:

diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/f=
bcon.c
index a58ce1fe320c..1fb28f353168 100644
=2D-- a/drivers/video/fbdev/core/fbcon.c
+++ b/drivers/video/fbdev/core/fbcon.c
@@ -2388,7 +2388,7 @@ static int fbcon_do_set_font(struct vc_data *vc, int=
 w, int h, int charcount,
                 rows =3D FBCON_SWAP(par->rotate, info->var.yres, info->va=
r.xres);
                 cols /=3D w;
                 rows /=3D h;
-               if (!con_is_visible(vc)) {
+               if (IS_ENABLED(CONFIG_FRAMEBUFFER_CONSOLE_ROTATION) && !co=
n_is_visible(vc)) {
                         ret =3D fbcon_rotate_font(info, vc);

Helge
