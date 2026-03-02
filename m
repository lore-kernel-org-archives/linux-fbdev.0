Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD49139E6C6
	for <linux-fbdev@vger.kernel.org>; Mon,  2 Mar 2026 10:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772446739; cv=none; b=itbrSYY6GHJeo+TxZNA/VMSalFc/Bg+oxa4esw9xvivGd1H6eSxv+jjZPVxcQ+2Ec3ZMQxnU9GZ1MgLCG+qFePu4mFhFH+BWnhfVQp/PWD3fdZ84OsfwHrz2br8mWsjqqkJ9pxlORiJo1YGI6yR1XvKID2Uu69vQSX9X0ujYjcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772446739; c=relaxed/simple;
	bh=y2WTf6W13hkV2mQMrULMQ58yrSCoUGNwsVXOZaqbYLE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uJcXVekIhsAWOQdanGhTLLoL2OpHvFIoSZVPctgVrPA87kT9pMZy1ByqohzrXhcsMEnbSDqyrWd5Xp1UiSH7nuBsGatIHuDR+w680T9jSsSIGOI4XRZK/wwmU+kHHzJgJ8p0WJlvG67sFXmcTE1CQddY9GziaRwM411z2FlUtBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=XOiBdfMN; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ry4ClynC; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=J8JFvTu/; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=zNkNC0mn; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="XOiBdfMN";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ry4ClynC";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="J8JFvTu/";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="zNkNC0mn"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D97893FA56;
	Mon,  2 Mar 2026 10:18:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1772446730; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=PeOZdxnKhL7CfVppH+fdCeQwqgTDKc8tOBj2H9V3Spg=;
	b=XOiBdfMN0Z7Q84sPmymOifjJJzhx7q8iUFw5XDgY0iw/L9X2fy9bt+yw+jn0pin2whOTXT
	QJ/3kl0/bcC7IuYnT1KFft4IbGnn3fkH+zlnqTNodN2f1JnpNk2/80F0rKigxXecOlA/ia
	2xutaKSUNawo1kDs1Rtog5hZvke1Ano=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1772446730;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=PeOZdxnKhL7CfVppH+fdCeQwqgTDKc8tOBj2H9V3Spg=;
	b=ry4ClynC8ZZjPcmZTj+yRPvVo7FcPvCvzKSjwPx8jZf0hYilB7dhUSCtpMNt2j06jYHmtD
	tNYyOZXl1E4vjxDQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="J8JFvTu/";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=zNkNC0mn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1772446729; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=PeOZdxnKhL7CfVppH+fdCeQwqgTDKc8tOBj2H9V3Spg=;
	b=J8JFvTu/AkjPxib4VOjqremmXlK9iVV/655hKPkOD4/drEEvtH1RL64q6zezMb32HiokpR
	WyrJAH0qXuxR8pWgdFNb9ZbIesFD2hFxrSSFKjhKbs8L/dInCfMpB7U4+v2f46/5jttBZh
	9Rt1pQyAbwdKY/vUDh0tvW1pHVgb5eQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1772446729;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=PeOZdxnKhL7CfVppH+fdCeQwqgTDKc8tOBj2H9V3Spg=;
	b=zNkNC0mn855R/21cRtP+lizgyyYO5R3V6c5usfLyecaoIODZPmodplr3IqYbY9jhu5L/wY
	1NDSVPomFBi7LQAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AB90D3EA69;
	Mon,  2 Mar 2026 10:18:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id gIO5KAlkpWnvKAAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Mon, 02 Mar 2026 10:18:49 +0000
Message-ID: <e0ad87cc-ab67-492b-8754-d67a310217d9@suse.de>
Date: Mon, 2 Mar 2026 11:18:49 +0100
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] fbcon: Fix out-of-bounds memory in fbcon_putcs
To: "chenjun (AM)" <chenjun102@huawei.com>, "simona@ffwll.ch"
 <simona@ffwll.ch>, "deller@gmx.de" <deller@gmx.de>,
 "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: "linruifeng (A)" <linruifeng4@huawei.com>
References: <20260227144358.101173-1-chenjun102@huawei.com>
 <bc9a37ac-43d2-451b-81b7-e0b23827006f@suse.de>
 <031a9e0b2f5346bbb6875c985fac149b@huawei.com>
Content-Language: en-US
From: Thomas Zimmermann <tzimmermann@suse.de>
Autocrypt: addr=tzimmermann@suse.de; keydata=
 xsBNBFs50uABCADEHPidWt974CaxBVbrIBwqcq/WURinJ3+2WlIrKWspiP83vfZKaXhFYsdg
 XH47fDVbPPj+d6tQrw5lPQCyqjwrCPYnq3WlIBnGPJ4/jreTL6V+qfKRDlGLWFjZcsrPJGE0
 BeB5BbqP5erN1qylK9i3gPoQjXGhpBpQYwRrEyQyjuvk+Ev0K1Jc5tVDeJAuau3TGNgah4Yc
 hdHm3bkPjz9EErV85RwvImQ1dptvx6s7xzwXTgGAsaYZsL8WCwDaTuqFa1d1jjlaxg6+tZsB
 9GluwvIhSezPgnEmimZDkGnZRRSFiGP8yjqTjjWuf0bSj5rUnTGiyLyRZRNGcXmu6hjlABEB
 AAHNJ1Rob21hcyBaaW1tZXJtYW5uIDx0emltbWVybWFubkBzdXNlLmRlPsLAjgQTAQgAOAIb
 AwULCQgHAgYVCgkICwIEFgIDAQIeAQIXgBYhBHIX+6yM6c9jRKFo5WgNwR1TC3ojBQJftODH
 AAoJEGgNwR1TC3ojx1wH/0hKGWugiqDgLNXLRD/4TfHBEKmxIrmfu9Z5t7vwUKfwhFL6hqvo
 lXPJJKQpQ2z8+X2vZm/slsLn7J1yjrOsoJhKABDi+3QWWSGkaGwRJAdPVVyJMfJRNNNIKwVb
 U6B1BkX2XDKDGffF4TxlOpSQzdtNI/9gleOoUA8+jy8knnDYzjBNOZqLG2FuTdicBXblz0Mf
 vg41gd9kCwYXDnD91rJU8tzylXv03E75NCaTxTM+FBXPmsAVYQ4GYhhgFt8S2UWMoaaABLDe
 7l5FdnLdDEcbmd8uLU2CaG4W2cLrUaI4jz2XbkcPQkqTQ3EB67hYkjiEE6Zy3ggOitiQGcqp
 j//OwE0EWznS4AEIAMYmP4M/V+T5RY5at/g7rUdNsLhWv1APYrh9RQefODYHrNRHUE9eosYb
 T6XMryR9hT8XlGOYRwKWwiQBoWSDiTMo/Xi29jUnn4BXfI2px2DTXwc22LKtLAgTRjP+qbU6
 3Y0xnQN29UGDbYgyyK51DW3H0If2a3JNsheAAK+Xc9baj0LGIc8T9uiEWHBnCH+RdhgATnWW
 GKdDegUR5BkDfDg5O/FISymJBHx2Dyoklv5g4BzkgqTqwmaYzsl8UxZKvbaxq0zbehDda8lv
 hFXodNFMAgTLJlLuDYOGLK2AwbrS3Sp0AEbkpdJBb44qVlGm5bApZouHeJ/+n+7r12+lqdsA
 EQEAAcLAdgQYAQgAIAIbDBYhBHIX+6yM6c9jRKFo5WgNwR1TC3ojBQJftOH6AAoJEGgNwR1T
 C3ojVSkIALpAPkIJPQoURPb1VWjh34l0HlglmYHvZszJWTXYwavHR8+k6Baa6H7ufXNQtThR
 yIxJrQLW6rV5lm7TjhffEhxVCn37+cg0zZ3j7zIsSS0rx/aMwi6VhFJA5hfn3T0TtrijKP4A
 SAQO9xD1Zk9/61JWk8OysuIh7MXkl0fxbRKWE93XeQBhIJHQfnc+YBLprdnxR446Sh8Wn/2D
 Ya8cavuWf2zrB6cZurs048xe0UbSW5AOSo4V9M0jzYI4nZqTmPxYyXbm30Kvmz0rYVRaitYJ
 4kyYYMhuULvrJDMjZRvaNe52tkKAvMevcGdt38H4KSVXAylqyQOW5zvPc4/sq9c=
In-Reply-To: <031a9e0b2f5346bbb6875c985fac149b@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FREEMAIL_TO(0.00)[huawei.com,ffwll.ch,gmx.de,vger.kernel.org];
	ARC_NA(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmx.de];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	URIBL_BLOCKED(0.00)[suse.de:dkim,suse.de:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:url,huawei.com:email,qemu.org:url];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,huawei.com:email,suse.com:url,suse.de:dkim,suse.de:mid]
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -4.51
X-Spam-Level: 
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: D97893FA56

Hi

Am 28.02.26 um 02:53 schrieb chenjun (AM):
> 在 2026/2/27 23:56, Thomas Zimmermann 写道:
>> Hi,
>>
>> thanks for the patch.
>>
>> Am 27.02.26 um 15:43 schrieb Chen Jun:
>>> When a font is set on an invisible console, the screen will not update.
>>> However, the fontbuffer is not updated to match the new font dimensions.
>> I looked through vc_resize() but cannot quite find the logic that calls
>> fbcon_rotate_font(). Can you please point to correct place?
>>
>> Best regards
>> Thomas
>>
> Hi, fbcon_rouate_font is called in fbcon_switch
>
> [   64.669554] CPU: 3 UID: 0 PID: 978 Comm: a.out Not tainted
> 7.0.0-rc1-00021-gd9d32e5bd5a4-dirty #10 PREEMPT(lazy)
> [   64.669576] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
> BIOS rel-1.13.0-0-gf21b5a4aeb02-prebuilt.qemu.org 04/4
> [   64.669584] Call Trace:
>
> [   64.669589]  <TASK>
>
> [   64.669595]  dump_stack_lvl+0x53/0x70
>
> [   64.669615]  fbcon_rotate_font+0x2d6/0xe90
>
> [   64.669636]  ? kfree+0x159/0x3b0
>
> [   64.669650]  ? ud_cursor+0x830/0x1d80
>
> [   64.669661]  ? __kmalloc_noprof+0x198/0x4a0
>
> [   64.669674]  fbcon_switch+0x67b/0x10f0
>
> [   64.669689]  ? __pfx_fbcon_switch+0x10/0x10
>
> [   64.669708]  ? con_is_visible+0xb0/0x130
>
> [   64.669723]  redraw_screen+0x258/0x690

Thanks. Somehow I made a wrong turn in redraw_screen()

Best regards
Thomas

>
> [   64.669736]  ? mutex_unlock+0x7d/0xd0
>
> [   64.669751]  ? __pfx_redraw_screen+0x10/0x10
>
> [   64.669764]  ? tty_get_pgrp+0x73/0xb0
>
> [   64.669784]  vc_do_resize+0x9a5/0xec0
>
> [   64.669803]  ? __pfx_vc_do_resize+0x10/0x10
>
> [   64.669815]  ? kernel_fpu_begin_mask+0x1c5/0x210
>
> [   64.669832]  ? __pfx_kernel_fpu_begin_mask+0x10/0x10
>
> [   64.669843]  ? fbcon_set_font+0x2cb/0x8c0
>
> [   64.669853]  ? __kasan_kmalloc_large+0x81/0xa0
>
> [   64.669863]  ? __kmalloc_large_node_noprof+0x18/0xb0
>
> [   64.669874]  fbcon_do_set_font+0x390/0xa70
>
> [   64.669890]  ? __pfx_fbcon_set_font+0x10/0x10
>
> [   64.669900]  con_font_op+0x7d5/0xc30
>
> [   64.669910]  ? arch_stack_walk+0x9f/0xf0
>
> [   64.669924]  ? __pfx_con_font_op+0x10/0x10
>
> [   64.669940]  vt_ioctl+0x8ee/0x2480
>
> [   64.669953]  ? __pfx_vt_ioctl+0x10/0x10
>
> [   64.669964]  ? __x64_sys_open+0x79/0xc0
>
> [   64.669976]  ? do_syscall_64+0xfa/0x570
>
> [   64.669986]  ? entry_SYSCALL_64_after_hwframe+0x77/0x7f
>
> [   64.669996]  ? __pfx_path_openat+0x10/0x10
>
> [   64.670006]  ? __pfx_avc_has_extended_perms+0x10/0x10
>
> [   64.670022]  ? _raw_spin_lock+0x7f/0xd0
>
> [   64.670040]  ? do_file_open+0x22f/0x2b0
>
> [   64.670048]  ? pte_offset_map_lock+0xe2/0x1e0
>
> [   64.670070]  ? __pfx_do_file_open+0x10/0x10
>
> [   64.670082]  tty_ioctl+0x3e7/0x1190
>
> [   64.670098]  ? __pfx_tty_ioctl+0x10/0x10
>
> [   64.670109]  ? __pfx_do_vfs_ioctl+0x10/0x10
>
> [   64.670124]  ? ioctl_has_perm.constprop.74+0x2e1/0x4f0
>
> [   64.670137]  ? __pfx_ioctl_has_perm.constprop.74+0x10/0x10
>
> [   64.670148]  ? __pfx_do_sys_openat2+0x10/0x10
>
> [   64.670191]  __x64_sys_ioctl+0x130/0x1a0
>
> [   64.670204]  do_syscall_64+0xfa/0x570
>
> [   64.670214]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
>
> [   64.670223] RIP: 0033:0x7ff56cb0c577
>
> [   64.670233] Code: b3 66 90 48 8b 05 11 89 2c 00 64 c7 00 26 00 00 00
> 48 c7 c0 ff ff ff ff c3 66 2e 0f 1f 84 00 00 00 00 8
> [   64.670242] RSP: 002b:00007fff94ab6a48 EFLAGS: 00000206 ORIG_RAX:
> 0000000000000010
> [   64.670256] RAX: ffffffffffffffda RBX: 0000000000000000 RCX:
> 00007ff56cb0c577
> [   64.670263] RDX: 00007fff94ab6a60 RSI: 0000000000004b72 RDI:
> 0000000000000003
> [   64.670269] RBP: 00007fff94ab6af0 R08: 000055bf68e008d0 R09:
> 00007ff56cdec090
> [   64.670275] R10: 0000000000000000 R11: 0000000000000206 R12:
> 000055bf68e00630
> [   64.670281] R13: 00007fff94ab6be0 R14: 0000000000000000 R15:
> 0000000000000000
> [   64.670293]  </TASK>
>
>
>>> This inconsistency leads to out-of-bounds memory access when writing to
>>> the tty bound to fbcon, as demonstrated by the following KASAN report:
>>>
>>> BUG: KASAN: slab-out-of-bounds in fb_pad_aligned_buffer+0xdf/0x140
>>> Read of size 1 at addr ffff8881195a2280 by task a.out/971
>>> Call Trace:
>>>     <TASK>
>>>     fb_pad_aligned_buffer+0xdf/0x140
>>>     ud_putcs+0x88a/0xde0
>>>     fbcon_putcs+0x319/0x430
>>>     do_update_region+0x23c/0x3b0
>>>     do_con_write+0x225c/0x67f0
>>>     con_write+0xe/0x30
>>>     n_tty_write+0x4b5/0xff0
>>>     file_tty_write.isra.41+0x46c/0x880
>>>     vfs_write+0x868/0xd60
>>>     ksys_write+0xf2/0x1d0
>>>     do_syscall_64+0xfa/0x570
>>>
>>> Fix this by calling fbcon_rotate_font() if vc is invisible in
>>> fbcon_do_set_font().
>>>
>>> Signed-off-by: Chen Jun <chenjun102@huawei.com>
>>> ---
>>>     drivers/video/fbdev/core/fbcon.c | 5 +++++
>>>     1 file changed, 5 insertions(+)
>>>
>>> diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
>>> index 666261ae59d8..d76100188bee 100644
>>> --- a/drivers/video/fbdev/core/fbcon.c
>>> +++ b/drivers/video/fbdev/core/fbcon.c
>>> @@ -2444,6 +2444,11 @@ static int fbcon_do_set_font(struct vc_data *vc, int w, int h, int charcount,
>>>     		rows = FBCON_SWAP(par->rotate, info->var.yres, info->var.xres);
>>>     		cols /= w;
>>>     		rows /= h;
>>> +		if (!con_is_visible(vc)) {
>>> +			ret = fbcon_rotate_font(info, vc);
>>> +			if (ret)
>>> +				goto err_out;
>>> +		}
>>>     		ret = vc_resize(vc, cols, rows);
>>>     		if (ret)
>>>     			goto err_out;
>

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Jochen Jaser, Andrew McDonald, Werner Knoblich, (HRB 36809, AG Nürnberg)


