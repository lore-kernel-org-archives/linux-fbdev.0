Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FE953E3DA8;
	Tue,  3 Mar 2026 14:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772547342; cv=none; b=Ccp9sDjiT8mZ8qoLmIr/14EvT/xe1i6RmqHzNy3e1py6mZDL1BjDodp4IwXjeHtCwSuQLiFz70s+nYYibLgjdmy3hiJpAmoyr6BrFgx+ikiFCcXsQp48DZoaTU1KZFqvQ5EG85qwvEtolt+eGnolnhiSIe3HKcodeof3lOhhqhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772547342; c=relaxed/simple;
	bh=hlIVq29G0MhxDL7QF0ZkFaJHx2nj0UMj4lHltTKKjE4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B5buz+QiOD4rhHYGQCAmnpq44L6bKO2qG/PrcuM5LcfCJhL42NtkRGfNq2zk9Me680XwLlaltqCD8wf39aZge8N7VVvRmiw0dgWV2PcayC/bo1fKngbp+kNVwUIAz82xmJEUzI7WMF++YzaG945YKUzn3cBxShyb/UW05yyEJ2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b=KpG08Lj+; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b="KpG08Lj+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1772547323; x=1773152123; i=deller@gmx.de;
	bh=157y93KS9310mSI3POa0npdwTaPBYvR9QOHiDWz63yc=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=KpG08Lj+UmB6W2sHC2PEn7LjjbUlWxWPCKl/t8qKoJoCwMPweiK8xDq8YpApBILB
	 DXaP9wkgLl6LMVtm4VvdssJ/NPTJGGCe9U6ozGvkBwMcyw+ulDzba73vjZq5/W+cR
	 KNYe9tH3ld9nhgvkU90n7NXXSeHEmYZCUoMUOIfvhEwIplIMwFckcvmaJ+oi63mx0
	 3DEFIOULGgCZOJb7AnqAAK19vNngmrvAG4qQD+MTxrkvRitB5wlKSNKaEELhiDtjE
	 UpCD1D9AuaSC6NZ5Jcump714/fb9tyVVzWCn5FuDtWT5AOiHg7PnxDI13+nG8Gahv
	 ROI61rkNZa29NQ50Mg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MsYux-1vhXZR2tKd-018MKa; Tue, 03
 Mar 2026 15:15:22 +0100
Message-ID: <e85bd96c-031f-477e-b0ce-aa10161fbb97@gmx.de>
Date: Tue, 3 Mar 2026 15:15:21 +0100
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] fbcon: Fix out-of-bounds memory in fbcon_putcs
To: Chen Jun <chenjun102@huawei.com>, simona@ffwll.ch, tzimmermann@suse.de,
 linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: linruifeng4@huawei.com
References: <20260227144358.101173-1-chenjun102@huawei.com>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20260227144358.101173-1-chenjun102@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:8AQFQVeUQl2Vcbj57AMTmFFvVvSvxllfkqMZqO3oUATT0kFsl7/
 M9XlnCjsFKpp5ShLXl4jeq8yz//cn1L2AwwMkd+Fn6oP6XYfvHjHXZIHtyPF2+G/opihp0v
 2x05bHFihAU/+el6WGfppyCH1qSmy1EWnL1j15abSyWQdvnmHgVJJBplNVJ+BU45w+KaWm+
 n/JPnO3sYf8CspYCVLbHw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:tulqI3WylFo=;SVzuoF0/MVtOQLWHbmmV+IEx4hv
 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

On 2/27/26 15:43, Chen Jun wrote:
> When a font is set on an invisible console, the screen will not update.
> However, the fontbuffer is not updated to match the new font dimensions.
>=20
> This inconsistency leads to out-of-bounds memory access when writing to
> the tty bound to fbcon, as demonstrated by the following KASAN report:
>=20
> BUG: KASAN: slab-out-of-bounds in fb_pad_aligned_buffer+0xdf/0x140
> Read of size 1 at addr ffff8881195a2280 by task a.out/971
> Call Trace:
>   <TASK>
>   fb_pad_aligned_buffer+0xdf/0x140
>   ud_putcs+0x88a/0xde0
>   fbcon_putcs+0x319/0x430
>   do_update_region+0x23c/0x3b0
>   do_con_write+0x225c/0x67f0
>   con_write+0xe/0x30
>   n_tty_write+0x4b5/0xff0
>   file_tty_write.isra.41+0x46c/0x880
>   vfs_write+0x868/0xd60
>   ksys_write+0xf2/0x1d0
>   do_syscall_64+0xfa/0x570
>=20
> Fix this by calling fbcon_rotate_font() if vc is invisible in
> fbcon_do_set_font().
>=20
> Signed-off-by: Chen Jun <chenjun102@huawei.com>
> ---
>   drivers/video/fbdev/core/fbcon.c | 5 +++++
>   1 file changed, 5 insertions(+)

applied to fbdev git tree.

Thanks!
Helge
