Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D14D94908A9;
	Sat, 25 Jul 2026 15:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784993877; cv=none; b=B0pE31oeon6NaePAuZ31PnNgG8PBGEjYZtOLO01YDRvFWvR4U2lmpjakHPHOWbweWGnejf24Y6zOyuTqZv3f3vXrqobpnfQRYU/KGmSqe3mGcB0OS2TOvVHjD8wdNgYh2Coc2kKAUofoiBXOEIvE+Mz3AHfRCun8OsqjQ5pkVVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784993877; c=relaxed/simple;
	bh=iiKm1QSlyliTLmTdOzFCLqMgefQ7Be6WTr0lT1ml9uM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FPoEhFpKtCbDjtTaxqNa4oX3UTrsoSGUiyKgPWD61oRMUsIrUYJw7nVFmQicg2J5LOP5pSibLRJYQ6HVUy+A6N1rvqY0An2IPvlDWwEVN2c4uQA/PUzHX0756v02jUxNrnvfsoOkH19pQH0EDIP6Wb3zgh7B/FWDMLPqG40QFTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b=pu12xz8E; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b="pu12xz8E"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1784993838; x=1785598638; i=deller@gmx.de;
	bh=IN0g1ar0S1Fg/x0rGIU8Wo3TQa6LM7zjlaYWzMNjNHY=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=pu12xz8EZmcQr67qTKI6URydO7O3LP9VcqBYqPqZKU3O6BIDerfDiTCmakcslo1a
	 00TQa98Z8LYdi4g1VgC+aHNmHSTqjkczOeV1BMeTLScPC6W7xEPjhAqhogW+YcImA
	 YTbsmbRKzgSAz8sM+O57UraB3TjN0wzFac8sM0dUeFnPGMiT0G+ePg1XTK2i2t1Yq
	 Lu6m9I0qK4RXKIcrhETCy+tK7DaGoWFFs4OgfOlgMAaZ1MbDkJBglEmFI4B1vIKI7
	 5ZPBrs/aampNEXIxiYhrHgQCU6GROTCsXS5qVCZINNx6t+rngaAks1/d8NWMFN6MP
	 TJAuS6f6kRsYHH7SLA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MDhhN-1wecPZ26fn-004gWf; Sat, 25
 Jul 2026 17:37:18 +0200
Message-ID: <125aed01-4a98-4424-9276-c105c839fb7f@gmx.de>
Date: Sat, 25 Jul 2026 17:37:10 +0200
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2] fbdev: Fix out-of-bounds access when rotating console
 after font resize
To: Zizhi Wo <wozizhi@huaweicloud.com>, simona@ffwll.ch, tzimmermann@suse.de,
 sam@ravnborg.org, ville.syrjala@linux.intel.com
Cc: linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
 dri-devel@lists.freedesktop.org, yangerkun@huawei.com,
 chengzhihao1@huawei.com, wozizhi@huawei.com
References: <20260722062216.2574546-1-wozizhi@huaweicloud.com>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20260722062216.2574546-1-wozizhi@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:zA3lhcdiiF/5wOUPHKj8yFegvGCjT9/snltpHihDtnBatLGT/as
 uC8jUP93nvZRpweOxazvXV+B2bxh+6ydV4qIxED6P3cwJnQiobtAobhMiOMZ+Vrf7uo8Akr
 dE9RadrJfTWH906iUaqBbIzxNIFVhNPkNwY5FYtCFuU8EnuHhVdzrHQFC1LcB+o5L9Tf0Ys
 57HkkDX14M0dSaJm0vGPw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:ci9ryCvwlog=;u6AWYAf/iXLW+PViPXs1aYvH7kb
 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
 q+B48+mNphbbNSGN84YGWXuykMDMr9FIyg==

On 7/22/26 08:22, Zizhi Wo wrote:
> From: Zizhi Wo <wozizhi@huawei.com>
>=20
> [BUG]
> Recently, we encountered a KASAN warning as follows:
>=20
> BUG: KASAN: slab-out-of-bounds in ccw_putcs+0x8bd/0xa80
> Read of size 1 at addr ff11000110067100 by task bash/1209
> CPU: 10 UID: 0 PID: 1209 Comm: bash Not tainted 7.2.0-rc3 #69 PREEMPT(fu=
ll)
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.17.0-4.fc4=
1 04/01/2014
>   Call Trace:
>    <TASK>
>    ...
>    kasan_report+0xf0/0x120
>    ? ccw_putcs+0x8bd/0xa80
>    ccw_putcs+0x8bd/0xa80
>    ? __pfx_ccw_putcs+0x10/0x10
>    fbcon_putcs+0x338/0x410
>    ? __pfx_ccw_putcs+0x10/0x10
>    do_update_region+0x21d/0x450
>    invert_screen+0x29d/0x5e0
>    ? __kmalloc_noprof+0x493/0x640
>    ? vc_do_resize+0x17c/0xe50
>    clear_selection+0x4c/0x60
>    vc_do_resize+0xaee/0xe50
>    fbcon_modechanged+0x2bd/0x640
>    rotate_all_store+0x298/0x380
>    ...
>=20
> reproduce:
> 1) issue two ioctls: first a KDFONTOP ioctl with op.op =3D KD_FONT_OP_SE=
T,
> op.width =3D 1 and op.height =3D 1, then a TIOCL_SETSEL ioctl
> 2) echo 2 > /sys/devices/virtual/graphics/fbcon/rotate_all
> 3) issue two ioctls: first a KDFONTOP ioctl with op.op =3D KD_FONT_OP_SE=
T,
> op.width =3D 8 and op.height =3D 1, then a TIOCL_SETSEL ioctl
> 4) echo 3 > /sys/devices/virtual/graphics/fbcon/rotate_all
>=20
> [CAUSE]
> The root cause is that fbcon_modechanged() first sets the current rotate=
's
> corresponding ops. Subsequently, during vc_resize(), it may trigger
> clear_selection(), and in fbcon_putcs->ccw_putcs[rotate=3D3], this can r=
esult
> in an out-of-bounds access to "src". This happens because par->rotated.b=
uf
> is reallocated in fbcon_rotate_font():
> 1) When rotate=3D2, its size is (width + 7) / 8 * height
> 2) When rotate=3D3, its size is (height + 7) / 8 * width
>=20
> And the call to fbcon_rotate_font() occurs after clear_selection(). In
> other words, the fontbuffer is allocated using the size calculated from =
the
> previous rotation 2, but before reallocating it with the new size,
> con_putcs is already using the new rotation 3:
>=20
> rotate_all_store
>   fbcon_rotate_all
>    fbcon_set_all_vcs
>     fbcon_modechanged
>      set_blitting_type
>      ...
>       par->bitops =3D &ccw_fbcon_bitops
>      vc_resize
>      ...
>       clear_selection
>        highlight
>        ...
>         do_update_region
> 	fbcon_putcs
> 	...
> 	 image.dy =3D vyres - ((xx + count) * vc->vc_font.width) [1]  // overfl=
ow!
> 	 ccw_putcs_aligned
> 	  // old buf size is still being used during the read!
> 	  src =3D par->rotated.buf + (scr_readw(s--) & charmask) * cellsize
> 	  fb_pad_aligned_buffer----[src KASAN!!!]	[2]
> 	  info->fbops->fb_imageblit(info, image)
> 	   sys_imageblit
> 	    fb_imageblit
> 	     fb_address_forward
> 	      // offset: image->dy * bits_per_line + image->dx * bpp
> 	      unsigned int bits =3D (unsigned int)adr->bits + offset
> 	      adr->address +=3D (bits & ~(BITS_PER_LONG - 1u)) / BITS_PER_BYTE	=
[3]
> 	     fb_bitmap_imageblit
> 	     ...
> 	      fb_read_offset	// page fault!	[4]
>      update_screen
>       redraw_screen
>       ...
>        ccw_cursor
>         soft_cursor
>          memcpy(src, image->data, dsize)----[src KASAN again!!!]	[5]
>       fbcon_switch
>        fbcon_rotate_font
>         font_data_rotate
> 	dst =3D kmalloc_array(charcount, d_cellsize, GFP_KERNEL)
>         // the new size is allocated only here!
>         par->rotated.buf =3D buf	[6]
>=20
> [FIX]
> A fairly obvious approach is to follow fbcon_switch(): in
> fbcon_modechanged(), call rotate_font() before vc_resize() so that a
> correctly sized buffer is allocated in time, as done in [6]. This fix is
> necessary, but it is not sufficient on its own.
>=20
> In [1] it causes an image.dy overflow (ccw_putcs: vyres =3D 768,
> image.dy =3D 4294967040), because vc_cols has not been updated in time a=
t
> this point (it is likewise only updated after clear_selection()). This
> allows (xx + count) * width to exceed vyres, causing image.dy to overflo=
w.
> Subsequently, address in [3] is incremented by an even larger amount, wh=
ich
> triggers a page fault at [4].
>=20
> Therefore, a second fix is required in combination with the first: move
> clear_selection() earlier, before set_blitting_type() in
> fbcon_set_all_vcs(), to prevent the out-of-bounds access. fbcon_rotate()
> has a similar problem, so add the same clear there. Since vc_is_sel() is
> not exported, the fbdev side is currently forced to call clear_selection=
()
> unconditionally, causing the global selection to be cleared prematurely.
> And this will not cause any other significant impact.
>=20
> Signed-off-by: Zizhi Wo <wozizhi@huawei.com>
> ---
> v2:
> Fixed the issue by calling clear_selection() earlier, and updated the
> related description in the commit message.
>=20
> v1: https://lore.kernel.org/all/20250905024340.337521-1-wozizhi@huaweicl=
oud.com/
> ---
>   drivers/video/fbdev/core/fbcon.c | 9 +++++++++
>   1 file changed, 9 insertions(+)
>=20
> diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core=
/fbcon.c
> index 9f5c4c101581..3361479d139d 100644
> --- a/drivers/video/fbdev/core/fbcon.c
> +++ b/drivers/video/fbdev/core/fbcon.c
> @@ -2639,13 +2639,20 @@ static void fbcon_modechanged(struct fb_info *in=
fo)
>   	vc =3D vc_cons[par->currcon].d;
>   	if (vc->vc_mode !=3D KD_TEXT ||
>   	    fbcon_info_from_console(par->currcon) !=3D info)
>   		return;
>  =20
> +	clear_selection();
> +
>   	p =3D &fb_display[vc->vc_num];
>   	set_blitting_type(vc, info);
>  =20
> +	if (par->bitops->rotate_font && par->bitops->rotate_font(info, vc)) {

Do you mind adding some comments before this rotate_font(), so that people
may understand why you rotate the font here?

Same for the two added clear_selection() calls.... A short comment which e=
xplains
why the selection is cleared.

Thank you!
Helge

