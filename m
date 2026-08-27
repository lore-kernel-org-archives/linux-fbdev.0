Received: from bg-bec.cloudflare-smtp.org (bg-bec.cloudflare-smtp.org [104.30.16.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AF06327BEC
	for <linux-fbdev@vger.kernel.org>; Thu, 27 Aug 2026 12:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.30.16.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787834588; cv=none; b=m90AyYnEa1J9h3lH5syD2UAUEtYYKObHpBisLH06LXdCsJ+5/RNn1OtF/d1+s8HEiZsBrkNDKAk6DIMQmDuvyWqQXYxoS0yz0kO1qRExPxPCqMQm9tLYfJZhZcGaLriqA8FKPRGOo50610Y9ikDOYejdJlsd2PgVwB9azLoAczo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787834588; c=relaxed/simple;
	bh=2fpFu6mZtLWfZe5MnWYvuIIDcrPX6zCr75vNXRAyuiQ=;
	h=From:Message-ID:Date:Subject:To:MIME-Version:Content-Type; b=ls301Zm5rWkaMVpb26MlKZcr+CK+hGPzDJXW/gkkbmxdSDpN+JxW0YuOgAqzVDL/PusVopeMeuMp3y71aZC1EE00JWgagDJVl0POQI+SbXM3QzSCYkIpkw5AexEevENAuO2HnkQ3qX1hNvizLIqnw4Ex4o178XHlkixVGr3UNo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bugs.sh; spf=pass smtp.mailfrom=cf-bounce.bugs.sh; dkim=pass (2048-bit key) header.d=cloudflare-smtp.org header.i=@cloudflare-smtp.org header.b=PBoWqLK1; dkim=pass (2048-bit key) header.d=bugs.sh header.i=@bugs.sh header.b=F1gemMzl; arc=none smtp.client-ip=104.30.16.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bugs.sh
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cf-bounce.bugs.sh
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare-smtp.org header.i=@cloudflare-smtp.org header.b="PBoWqLK1";
	dkim=pass (2048-bit key) header.d=bugs.sh header.i=@bugs.sh header.b="F1gemMzl"
DKIM-Signature: v=1; a=rsa-sha256; s=cf2024-1; d=cloudflare-smtp.org; c=relaxed/relaxed;
	h=To:Subject:Date:From:Feedback-ID:from:reply-to:cc:resent-date
	:resent-from:resent-to:resent-cc:in-reply-to:references:list-id:list-help
	:list-unsubscribe:list-unsubscribe-post:list-subscribe:list-post
	:list-owner:list-archive; t=1787834577; x=1788439377; bh=vFpdbsdJZfeFKcTVUZ
	5ghk7Kj1Khv5U+q9Ot+oG5kFQ=; b=PBoWqLK15tYP1PbuWZCyBoUl6bfoY3uMY1f6rF6On8iRW
	g91ZW9UpyUgNWj7xh/Y/VU3ME8hSsaEoLWihvRNMdKlMQNWGkqGwsLLpOGFmkuorzmkvktsbKRj
	1QNJvB3X6nOC8GSt4skQfp9r1MZHCGHiaEBG7WvbWDRT8GkV0YIfoapiwzeTGvDa2YwdpauggSv
	0a+FggucC8bKj2nVtr9XzuuYRwt6ssItl18TedGoX1vt0gJaZNianj3vdhcDjJXstaamS7Fl9NG
	XS/gTKQAPQebLjGPI6j4qpXWeiMxg7rPxH44jOR63ypZ0olxFeNq+8RO+ERBHSLzQ/zIE+gg==;
DKIM-Signature: v=1; a=rsa-sha256; s=cf-bounce; d=bugs.sh; c=relaxed/relaxed;
	h=To:Subject:Date:From:Feedback-ID:from:reply-to:cc:resent-date
	:resent-from:resent-to:resent-cc:in-reply-to:references:list-id:list-help
	:list-unsubscribe:list-unsubscribe-post:list-subscribe:list-post
	:list-owner:list-archive; t=1787834577; x=1788439377; bh=vFpdbsdJZfeFKcTVUZ
	5ghk7Kj1Khv5U+q9Ot+oG5kFQ=; b=F1gemMzlQYjOowWEUqGu7m3JI/OE+eYiPjtzD6T8bDaqL
	aqicTiY6rBLU4EK75nKvlg+i+vbYU0yKpDxS2a9dmq3c4bGRjepY2/ppA0i6/g0FDGdlo8z+NU2
	U8drcG70nHjnQwdX2WVv+SIk0X/2UsgXcal/izx9fU9mRivqzpDDKAF5IqEKdkzDbPuqHe6GB4Z
	rUIq4gZ0zr1cITR6mT0czHAum1yrIbCzy9eiKfFa0LdqVBd6TP6E9DGd8FfLVGDVQ4aghIbJ5Z9
	Xw7eEcwXjfTiQKBdqM8Hz7JCwfsNZ/G1dzxMPpDG5FhKwkGDtQC6+ZM03PVW66TjV9AzKVGg==;
Feedback-ID: bugs.sh:5:6:Cloudflare
From: co <co+ed9902f2e44184d9@bugs.sh>
Message-ID: <1jSCSNaDKmuUG7h40rTsSl1rMaSwdlJef4rp@bugs.sh>
Date: Thu, 27 Aug 2026 12:42:49 +0000
Subject: [BUG] drivers/video: use-after-free in fb_videomode_to_var()
To: dri-devel@lists.freedesktop.org, "Helge Deller" <deller@gmx.de>, "Bernie
 Thompson" <bernie@plugable.com>, "Greg Kroah-Hartman" <gregkh@suse.de>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

We found a bug reachable in:

    path    drivers/video/fbdev
    crash   use-after-free in fb_videomode_to_var()
    commit  3cd8b194bf34 ("Merge tag 'v7.1-rc-part1-smbdirect-fixes' of git=
://git.samba.org/ksmbd")

Config, environment, the sanitizer report and a C reproducer follow.

=3D=3D Notes =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
    If you patch the bug based on our artifacts, a tag would be
    appreciated:

Reported-by: co+ed9902f2e44184d9@bugs.sh

    Everything in this mail is validated by the reproducer below.

    We also hold an LLM-generated root-cause analysis and a candidate
    patch. The patch passes an A/B test: the same reproducer panics the
    unpatched kernel and runs clean on the patched one. Neither has had
    human review, so both still require validation before you send or
    apply them. Available on:

        patch.diff  https://bugs.sh/b/ed9902f2e44184d9/patch.diff
        report.md   https://bugs.sh/b/ed9902f2e44184d9/report.md

    This is an open science project. The code and the full set of PoCs
    are not public at this moment, as we intend to disclose our findings
    in an ethical way.

    Happy to test patches. Complaints and suggestions about our work
    are welcome at:

        cedalion@bugs.sh

=3D=3D Environment =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
    Reproduced on  3cd8b194bf34 ("Merge tag 'v7.1-rc-part1-smbdirect-fixes'=
 of git://git.samba.org/ksmbd")
    VM setup       https://bugs.sh/b/ed9902f2e44184d9/run.sh
    config         https://bugs.sh/b/ed9902f2e44184d9/config.gz
    poc            https://bugs.sh/b/ed9902f2e44184d9/repro.c

=3D=3D Sanitizer Report =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
BUG: KASAN: slab-use-after-free in fb_videomode_to_var (drivers/video/fbdev=
/core/modedb.c:906)
Read of size 4 at addr ffff88801057471c by task kworker/1:2/113
CPU: 1 UID: 0 PID: 113 Comm: kworker/1:2 Not tainted 7.0.0+ #1 PREEMPT(lazy)
Workqueue: events console_callback
Call Trace:
dump_stack_lvl (lib/dump_stack.c:123)
print_report (mm/kasan/report.c:379 mm/kasan/report.c:482)
kasan_report (mm/kasan/report.c:597)
fb_videomode_to_var (drivers/video/fbdev/core/modedb.c:906)
display_to_var (drivers/video/fbdev/core/fbcon.c:1000)
fbcon_switch (drivers/video/fbdev/core/fbcon.c:2190)
redraw_screen (drivers/tty/vt/vt.c:995)
complete_change_console (drivers/tty/vt/vt_ioctl.c:1149)
change_console (drivers/tty/vt/vt_ioctl.c:1263)
console_callback (drivers/tty/vt/vt.c:3320)
process_one_work (kernel/workqueue.c:3307)
worker_thread (kernel/workqueue.c:3379 (discriminator 2) kernel/workqueue.c=
:3466 (discriminator 2))
kthread (kernel/kthread.c:436)
ret_from_fork (arch/x86/kernel/process.c:164)
ret_from_fork_asm (arch/x86/entry/entry_64.S:255)
Allocated by task 12:
kasan_save_stack (mm/kasan/common.c:58)
kasan_save_track (mm/kasan/common.c:70 (discriminator 1) mm/kasan/common.c:=
79 (discriminator 1))
__kasan_kmalloc (mm/kasan/common.c:398 mm/kasan/common.c:415)
fb_add_videomode (./include/linux/slab.h:950 drivers/video/fbdev/core/moded=
b.c:1073)
dlfb_setup_modes (drivers/video/fbdev/udlfb.c:1316 (discriminator 2))
dlfb_usb_probe (drivers/video/fbdev/udlfb.c:1685)
usb_probe_interface (drivers/usb/core/driver.c:397)
really_probe (drivers/base/dd.c:631 drivers/base/dd.c:709)
__driver_probe_device (drivers/base/dd.c:851)
driver_probe_device (drivers/base/dd.c:882)
__device_attach_driver (drivers/base/dd.c:1010)
bus_for_each_drv (drivers/base/bus.c:500)
__device_attach (drivers/base/dd.c:1083)
device_initial_probe (drivers/base/dd.c:1136)
bus_probe_device (drivers/base/bus.c:615)
device_add (drivers/base/core.c:3698)
usb_new_device (drivers/usb/core/hub.c:2696)
hub_event (drivers/usb/core/hub.c:5568 drivers/usb/core/hub.c:5707 drivers/=
usb/core/hub.c:5871 drivers/usb/core/hub.c:5953)
process_one_work (kernel/workqueue.c:3307)
worker_thread (kernel/workqueue.c:3379 (discriminator 2) kernel/workqueue.c=
:3466 (discriminator 2))
kthread (kernel/kthread.c:436)
ret_from_fork (arch/x86/kernel/process.c:164)
ret_from_fork_asm (arch/x86/entry/entry_64.S:255)
Freed by task 173:
kasan_save_stack (mm/kasan/common.c:58)
kasan_save_track (mm/kasan/common.c:70 (discriminator 1) mm/kasan/common.c:=
79 (discriminator 1))
kasan_save_free_info (mm/kasan/generic.c:587 (discriminator 1))
__kasan_slab_free (mm/kasan/common.c:287)
kfree (mm/slub.c:6246 (discriminator 3) mm/slub.c:6561 (discriminator 3))
fb_destroy_modelist (drivers/video/fbdev/core/modedb.c:1116 (discriminator =
3))
dlfb_setup_modes (drivers/video/fbdev/udlfb.c:1268)
edid_store (drivers/video/fbdev/udlfb.c:1456)
sysfs_kf_bin_write (fs/sysfs/file.c:164)
kernfs_fop_write_iter (fs/kernfs/file.c:88 fs/kernfs/file.c:356)
vfs_write (fs/read_write.c:596 (discriminator 1) fs/read_write.c:688 (discr=
iminator 1))
ksys_write (fs/read_write.c:741)
do_syscall_64 (arch/x86/entry/syscall_64.c:63 (discriminator 1) arch/x86/en=
try/syscall_64.c:94 (discriminator 1))
entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130)
The buggy address belongs to the object at ffff888010574700
which belongs to the cache kmalloc-96 of size 96
The buggy address is located 28 bytes inside of


---
The report format is based on syzbot bug report.

This report is generated by a bot. It may contain errors.
See https://github.com/n132/cedalion for more information.

For any issue with this report, reach out to cedalion@bugs.sh

If the report is already addressed, let us know by replying with:
#co fix: <commit hash>

If the report is a duplicate of another one, reply with:
#co dup: <lore link>

If you want to undo deduplication, reply with:
#co undup


