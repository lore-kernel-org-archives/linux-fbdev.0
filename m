Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACE9C4A18
	for <linux-fbdev@vger.kernel.org>; Sun, 27 Apr 2025 15:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745768102; cv=none; b=ryNMKJ3KRXZJXNcsya+kBITyro9DLJcioiuOhtYAebnTzQgMdYYOWf8nDE9sb2m7Oa3IteZER65nhZN83lehXeTRQXPWH8caQcaXjYmmtw20ecxYpielpC3XbqsXUYZTVMKE4gTKg4lKyFW0hdz3ZzdG8wuvcc/ah6ag4HtnAKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745768102; c=relaxed/simple;
	bh=y3+Qa9p87SYULlPxd0eMpx2wC+SuoI0FPubfYsSTO6I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AqnGiyyOJu/lbIZrd59SCzMEXiaMkIrUnf6/nINx46LwRq3XEd7iZalzYKUKCk1hu0KWtCkbIp5QaiGrJHMUj3JxO/3NZaU9Z1NAKYx3zDj7pBsQ+cfZ5JaENooql87VLcH8NdY1Kzeb9jX3AKTtVn2n5SE9DDmSniNWH7VRpIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b=SFFYeKSf; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b="SFFYeKSf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1745768092; x=1746372892; i=deller@gmx.de;
	bh=gNbaoxMjFYtSKZPcgvvh6KuT8yz7sRsoQzC3v5c4nd0=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=SFFYeKSfG+25ldYjFnfTu08k6uSDEzbzh703vM4/GexndQj3k9hO89tIqiAozlaN
	 XICwxpuBeLzHlyoHWUiIVkPKPauA1k6B6Wj+fEMxHPHfNwY18wjW6IOszuPHIW6PF
	 IXjyOyIndBrQr9mLil4LvEpYkhTRrYOZ9elOpt0J62oCIIJp0Qrkv86a95temafyT
	 OA29YLkjq7MJMK0+A+IvWog0SWQY30SeDZYCEs8eE+xDr6VMJxgUtWpge0xdI1t5U
	 iTaoxUmQrTkMGUuoNzrBnP7pmYf/O4ssXUnYVDNpbWrqNPMehyDcqy3uGjAh4eF53
	 2Wh8xMEwzc0dVLs6wQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.173] ([109.250.63.181]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M5wLT-1uAzpY3NSF-003rIQ; Sun, 27
 Apr 2025 17:34:51 +0200
Message-ID: <bd358b87-8bca-4c45-9ee2-43d8d106969f@gmx.de>
Date: Sun, 27 Apr 2025 17:34:47 +0200
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 1/1] vgacon: Add check for vc_origin address range in
 vgacon_scroll()
To: GONG Ruiqi <gongruiqi1@huawei.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>, linux-fbdev@vger.kernel.org
Cc: security@kernel.org, Kees Cook <kees@kernel.org>,
 Yi Yang <yiyang13@huawei.com>, Lu Jialin <lujialin4@huawei.com>,
 Xiu Jianfeng <xiujianfeng@huawei.com>
References: <20250427025303.888320-1-gongruiqi1@huawei.com>
 <20250427025303.888320-2-gongruiqi1@huawei.com>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20250427025303.888320-2-gongruiqi1@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:wvS/saP8zAXALcsNixiOcMVP4WZZjAKe8ba859aeUm0B6B9VZrt
 0KMdioO+J8J8zs6CpiAemKRZYKHOH6Hecdna4jc0EOJw7AYKyxbI4nFsEdNuYMe2WSgimel
 o9nnrmcIYVWHB9xgM6VwkTU7FFFiLhSSb0zcxkIoCanPA85b8jFGJa2iQ0tdSw8mBtW7LqW
 NbA4TodFpHghTLTehSiEQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:G1LyeMecriU=;Eu21SemYsJbN+JhuBseYIJo/OGB
 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

On 4/27/25 04:53, GONG Ruiqi wrote:
> Our in-house Syzkaller reported the following BUG (twice), which we
> believed was the same issue with [1]:
>=20
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> BUG: KASAN: slab-out-of-bounds in vcs_scr_readw+0xc2/0xd0 drivers/tty/vt=
/vt.c:4740
> Read of size 2 at addr ffff88800f5bef60 by task syz.7.2620/12393
> ...
> Call Trace:
>   <TASK>
>   __dump_stack lib/dump_stack.c:88 [inline]
>   dump_stack_lvl+0x72/0xa0 lib/dump_stack.c:106
>   print_address_description.constprop.0+0x6b/0x3d0 mm/kasan/report.c:364
>   print_report+0xba/0x280 mm/kasan/report.c:475
>   kasan_report+0xa9/0xe0 mm/kasan/report.c:588
>   vcs_scr_readw+0xc2/0xd0 drivers/tty/vt/vt.c:4740
>   vcs_write_buf_noattr drivers/tty/vt/vc_screen.c:493 [inline]
>   vcs_write+0x586/0x840 drivers/tty/vt/vc_screen.c:690
>   vfs_write+0x219/0x960 fs/read_write.c:584
>   ksys_write+0x12e/0x260 fs/read_write.c:639
>   do_syscall_x64 arch/x86/entry/common.c:51 [inline]
>   do_syscall_64+0x59/0x110 arch/x86/entry/common.c:81
>   entry_SYSCALL_64_after_hwframe+0x78/0xe2
>   ...
>   </TASK>
>=20
> Allocated by task 5614:
>   kasan_save_stack+0x20/0x40 mm/kasan/common.c:45
>   kasan_set_track+0x25/0x30 mm/kasan/common.c:52
>   ____kasan_kmalloc mm/kasan/common.c:374 [inline]
>   __kasan_kmalloc+0x8f/0xa0 mm/kasan/common.c:383
>   kasan_kmalloc include/linux/kasan.h:201 [inline]
>   __do_kmalloc_node mm/slab_common.c:1007 [inline]
>   __kmalloc+0x62/0x140 mm/slab_common.c:1020
>   kmalloc include/linux/slab.h:604 [inline]
>   kzalloc include/linux/slab.h:721 [inline]
>   vc_do_resize+0x235/0xf40 drivers/tty/vt/vt.c:1193
>   vgacon_adjust_height+0x2d4/0x350 drivers/video/console/vgacon.c:1007
>   vgacon_font_set+0x1f7/0x240 drivers/video/console/vgacon.c:1031
>   con_font_set drivers/tty/vt/vt.c:4628 [inline]
>   con_font_op+0x4da/0xa20 drivers/tty/vt/vt.c:4675
>   vt_k_ioctl+0xa10/0xb30 drivers/tty/vt/vt_ioctl.c:474
>   vt_ioctl+0x14c/0x1870 drivers/tty/vt/vt_ioctl.c:752
>   tty_ioctl+0x655/0x1510 drivers/tty/tty_io.c:2779
>   vfs_ioctl fs/ioctl.c:51 [inline]
>   __do_sys_ioctl fs/ioctl.c:871 [inline]
>   __se_sys_ioctl+0x12d/0x190 fs/ioctl.c:857
>   do_syscall_x64 arch/x86/entry/common.c:51 [inline]
>   do_syscall_64+0x59/0x110 arch/x86/entry/common.c:81
>   entry_SYSCALL_64_after_hwframe+0x78/0xe2
>=20
> Last potentially related work creation:
>   kasan_save_stack+0x20/0x40 mm/kasan/common.c:45
>   __kasan_record_aux_stack+0x94/0xa0 mm/kasan/generic.c:492
>   __call_rcu_common.constprop.0+0xc3/0xa10 kernel/rcu/tree.c:2713
>   netlink_release+0x620/0xc20 net/netlink/af_netlink.c:802
>   __sock_release+0xb5/0x270 net/socket.c:663
>   sock_close+0x1e/0x30 net/socket.c:1425
>   __fput+0x408/0xab0 fs/file_table.c:384
>   __fput_sync+0x4c/0x60 fs/file_table.c:465
>   __do_sys_close fs/open.c:1580 [inline]
>   __se_sys_close+0x68/0xd0 fs/open.c:1565
>   do_syscall_x64 arch/x86/entry/common.c:51 [inline]
>   do_syscall_64+0x59/0x110 arch/x86/entry/common.c:81
>   entry_SYSCALL_64_after_hwframe+0x78/0xe2
>=20
> Second to last potentially related work creation:
>   kasan_save_stack+0x20/0x40 mm/kasan/common.c:45
>   __kasan_record_aux_stack+0x94/0xa0 mm/kasan/generic.c:492
>   __call_rcu_common.constprop.0+0xc3/0xa10 kernel/rcu/tree.c:2713
>   netlink_release+0x620/0xc20 net/netlink/af_netlink.c:802
>   __sock_release+0xb5/0x270 net/socket.c:663
>   sock_close+0x1e/0x30 net/socket.c:1425
>   __fput+0x408/0xab0 fs/file_table.c:384
>   task_work_run+0x154/0x240 kernel/task_work.c:239
>   exit_task_work include/linux/task_work.h:45 [inline]
>   do_exit+0x8e5/0x1320 kernel/exit.c:874
>   do_group_exit+0xcd/0x280 kernel/exit.c:1023
>   get_signal+0x1675/0x1850 kernel/signal.c:2905
>   arch_do_signal_or_restart+0x80/0x3b0 arch/x86/kernel/signal.c:310
>   exit_to_user_mode_loop kernel/entry/common.c:111 [inline]
>   exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
>   __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
>   syscall_exit_to_user_mode+0x1b3/0x1e0 kernel/entry/common.c:218
>   do_syscall_64+0x66/0x110 arch/x86/entry/common.c:87
>   entry_SYSCALL_64_after_hwframe+0x78/0xe2
>=20
> The buggy address belongs to the object at ffff88800f5be000
>   which belongs to the cache kmalloc-2k of size 2048
> The buggy address is located 2656 bytes to the right of
>   allocated 1280-byte region [ffff88800f5be000, ffff88800f5be500)
>=20
> ...
>=20
> Memory state around the buggy address:
>   ffff88800f5bee00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>   ffff88800f5bee80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>> ffff88800f5bef00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>                                                         ^
>   ffff88800f5bef80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>   ffff88800f5bf000: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> By analyzing the vmcore, we found that vc->vc_origin was somehow placed
> one line prior to vc->vc_screenbuf when vc was in KD_TEXT mode, and
> further writings to /dev/vcs caused out-of-bounds reads (and writes
> right after) in vcs_write_buf_noattr().
>=20
> Our further experiments show that in most cases, vc->vc_origin equals to
> vga_vram_base when the console is in KD_TEXT mode, and it's around
> vc->vc_screenbuf for the KD_GRAPHICS mode. But via triggerring a
> TIOCL_SETVESABLANK ioctl beforehand, we can make vc->vc_origin be around
> vc->vc_screenbuf while the console is in KD_TEXT mode, and then by
> writing the special 'ESC M' control sequence to the tty certain times
> (depends on the value of `vc->state.y - vc->vc_top`), we can eventually
> move vc->vc_origin prior to vc->vc_screenbuf. Here's the PoC, tested on
> QEMU:
>=20
> ```
> int main() {
> 	const int RI_NUM =3D 10; // should be greater than `vc->state.y - vc->v=
c_top`
> 	int tty_fd, vcs_fd;
> 	const char *tty_path =3D "/dev/tty0";
> 	const char *vcs_path =3D "/dev/vcs";
> 	const char escape_seq[] =3D "\x1bM";  // ESC + M
> 	const char trigger_seq[] =3D "Let's trigger an OOB write.";
> 	struct vt_sizes vt_size =3D { 70, 2 };
> 	int blank =3D TIOCL_BLANKSCREEN;
>=20
> 	tty_fd =3D open(tty_path, O_RDWR);
>=20
> 	char vesa_mode[] =3D { TIOCL_SETVESABLANK, 1 };
> 	ioctl(tty_fd, TIOCLINUX, vesa_mode);
>=20
> 	ioctl(tty_fd, TIOCLINUX, &blank);
> 	ioctl(tty_fd, VT_RESIZE, &vt_size);
>=20
> 	for (int i =3D 0; i < RI_NUM; ++i)
> 		write(tty_fd, escape_seq, sizeof(escape_seq) - 1);
>=20
> 	vcs_fd =3D open(vcs_path, O_RDWR);
> 	write(vcs_fd, trigger_seq, sizeof(trigger_seq));
>=20
> 	close(vcs_fd);
> 	close(tty_fd);
> 	return 0;
> }
> ```
>=20
> To solve this problem, add an address range validation check in
> vgacon_scroll(), ensuring vc->vc_origin never precedes vc_screenbuf.
>=20
> Reported-by: syzbot+9c09fda97a1a65ea859b@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3D9c09fda97a1a65ea859b [=
1]
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc: stable@vger.kernel.org
> Co-developed-by: Yi Yang <yiyang13@huawei.com>
> Signed-off-by: Yi Yang <yiyang13@huawei.com>
> Signed-off-by: GONG Ruiqi <gongruiqi1@huawei.com>
> ---
>   drivers/video/console/vgacon.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/video/console/vgacon.c b/drivers/video/console/vgac=
on.c
> index 37bd18730fe0..f9cdbf8c53e3 100644
> --- a/drivers/video/console/vgacon.c
> +++ b/drivers/video/console/vgacon.c
> @@ -1168,7 +1168,7 @@ static bool vgacon_scroll(struct vc_data *c, unsig=
ned int t, unsigned int b,
>   				     c->vc_screenbuf_size - delta);
>   			c->vc_origin =3D vga_vram_end - c->vc_screenbuf_size;
>   			vga_rolled_over =3D 0;
> -		} else
> +		} else if (oldo - delta >=3D (unsigned long)c->vc_screenbuf)
>   			c->vc_origin -=3D delta;
>   		c->vc_scr_end =3D c->vc_origin + c->vc_screenbuf_size;
>   		scr_memsetw((u16 *) (c->vc_origin), c->vc_video_erase_char,


The patch is not wrong, but I'm not yet sure if it hides another issue.
I've applied it to the fbdev tree for now (unless Greg wants to handle it)=
.

Thanks!
Helge
