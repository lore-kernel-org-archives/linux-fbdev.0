Received: from bg-bec.cloudflare-smtp.org (bg-bec.cloudflare-smtp.org [104.30.16.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6524E41D231
	for <linux-fbdev@vger.kernel.org>; Thu, 27 Aug 2026 12:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.30.16.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787834616; cv=none; b=cYHAZlSM+5dn9HeRFpBIKuqH6Wum83q1OwKWrFLEVi9eaU6N0vWlgm7G5B6wXauadeQa5TsLGZes3J/WxcZxa52XMGBLvYPFZ3GkQhsNKNj6j2C+qT5ykUXGRLF0H3FjcSadQEGW2A5jHuir/xdN9QqXpDa46+EEPYZo0GhGGOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787834616; c=relaxed/simple;
	bh=q8JUi+sBLEsD3aAuLeK4+q4xd/6RpI0p5FTkaClmncs=;
	h=From:Message-ID:Date:Subject:To:MIME-Version:Content-Type; b=cU8IGhL4Be3IMZFkIJKzt7bythTQXo0x9P1zUt+uADjh9mKyNz8AuQdQQP0gmGIAW34dbLOe0Bc6+eeiwy7azF5JK+tAI4lQEuBOlYPuPQFGQP0cEI75j1JOOOutzENbq0XghunOsOLrPh8aUZoHJqsiEVtWKXmcffhVx6pA1ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bugs.sh; spf=pass smtp.mailfrom=cf-bounce.bugs.sh; dkim=pass (2048-bit key) header.d=cloudflare-smtp.org header.i=@cloudflare-smtp.org header.b=JvbWdbaT; dkim=pass (2048-bit key) header.d=bugs.sh header.i=@bugs.sh header.b=gWettobn; arc=none smtp.client-ip=104.30.16.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bugs.sh
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cf-bounce.bugs.sh
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare-smtp.org header.i=@cloudflare-smtp.org header.b="JvbWdbaT";
	dkim=pass (2048-bit key) header.d=bugs.sh header.i=@bugs.sh header.b="gWettobn"
DKIM-Signature: v=1; a=rsa-sha256; s=cf2024-1; d=cloudflare-smtp.org; c=relaxed/relaxed;
	h=To:Subject:Date:From:Feedback-ID:from:reply-to:cc:resent-date
	:resent-from:resent-to:resent-cc:in-reply-to:references:list-id:list-help
	:list-unsubscribe:list-unsubscribe-post:list-subscribe:list-post
	:list-owner:list-archive; t=1787834612; x=1788439412; bh=/SyfQl9CLBwpujeN1/
	3FRGnSEmpv2gLnAd/W66Uu8KE=; b=JvbWdbaTzivFYPSs6u437zroZSh3NItJYhR/rljuOu2lT
	ncVHGtsxwCa0KO0GW80RS5ymnwoR7k1vZ3QPOJ/cwm9bfyIbxl4bZjFeafZS44tiKblQ1qJdvXZ
	7LgvOMGkR7ly94lZqmTMK6vrH8sljraIP3AW2Qwx7Pq+4M3dwLfOfhSFwWDfVMjqfcAjNdXfc1B
	iJeFXqvJa59xZNUoVkXbXuwUMi6H0/+3EwS4hnu0J0cg1gCJiCu7uHV6shThwR3uTTmMwcmVg0w
	eqJq/6/6+3Q2MISwiHYrCriQBpzbwGa4THe94nsxkSmin6fQ0ZD7fOeLfq5A8lFaz9hWz9fA==;
DKIM-Signature: v=1; a=rsa-sha256; s=cf-bounce; d=bugs.sh; c=relaxed/relaxed;
	h=To:Subject:Date:From:Feedback-ID:from:reply-to:cc:resent-date
	:resent-from:resent-to:resent-cc:in-reply-to:references:list-id:list-help
	:list-unsubscribe:list-unsubscribe-post:list-subscribe:list-post
	:list-owner:list-archive; t=1787834612; x=1788439412; bh=/SyfQl9CLBwpujeN1/
	3FRGnSEmpv2gLnAd/W66Uu8KE=; b=gWettobngGjLSU8VEBV+aJ6ShVcfeuQVfZWfQpG1msIMh
	pQXbdvUwznHkbj9BesIg6lLWao0omEsMtGVgdTPWnQ5a1NK+rp6Aa/htdlgaoq/yOAE9MtdhYzO
	EkdEkBRVplb4MBkvMvOmJu1tth8R7pym2HuqUKaisjBlyiAW1wpebgyX0UvBbbD3ELX/KIwvfQs
	VACA8Ac1dRaeGBwM3M2fDxaCMYuPLwGnR6Qfhmzxa5SfASOQ1Gu2DUfJYtDbVSr55m2JKWBO1xv
	VFh/LE9uQCD6g22pwF7Hw1nr87G7JBH+uhcyETTwVDQ3sUjGZJ08gg7FW/ua8oTiIiGIvNNg==;
Feedback-ID: bugs.sh:5:6:Cloudflare
From: co <co+c25629c98ba36ebe@bugs.sh>
Message-ID: <f2Kf9GYn1lKR5S1dbvGVtykMxK1RlgP5z8sW@bugs.sh>
Date: Thu, 27 Aug 2026 12:43:25 +0000
Subject: [BUG] drivers/video: use-after-free in _copy_to_user()
To: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, "Simona
 Vetter" <simona@ffwll.ch>, "Helge Deller" <deller@gmx.de>, "Petr Mladek" <pmladek@suse.com>, "Thomas
 Zimmermann" <tzimmermann@suse.de>, "Geert Uytterhoeven" <geert+renesas@glider.be>, "Song
 Liu" <song@kernel.org>, "Biju Das" <biju.das.jz@bp.renesas.com>, "Oleg
 Nesterov" <oleg@redhat.com>, "Andrea Righi" <righi.andrea@gmail.com>, "Andrew
 Morton" <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

We found a bug reachable in:

    path    drivers/video/fbdev/core/fb_chrdev.c`, `drivers/video/fbdev/core
    crash   use-after-free in _copy_to_user()
    commit  843bc34db94b

Config, environment, the sanitizer report and a C reproducer follow.

=3D=3D Notes =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
    If you patch the bug based on our artifacts, a tag would be
    appreciated:

Reported-by: co+c25629c98ba36ebe@bugs.sh

    Everything in this mail is validated by the reproducer below.

    We also hold an LLM-generated root-cause analysis and a candidate
    patch. The patch passes an A/B test: the same reproducer panics the
    unpatched kernel and runs clean on the patched one. Neither has had
    human review, so both still require validation before you send or
    apply them. Available on:

        patch.diff  https://bugs.sh/b/c25629c98ba36ebe/patch.diff
        report.md   https://bugs.sh/b/c25629c98ba36ebe/report.md

    This is an open science project. The code and the full set of PoCs
    are not public at this moment, as we intend to disclose our findings
    in an ethical way.

    Happy to test patches. Complaints and suggestions about our work
    are welcome at:

        cedalion@bugs.sh

=3D=3D Environment =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
    Reproduced on  843bc34db94b
    VM setup       https://bugs.sh/b/c25629c98ba36ebe/run.sh
    config         https://bugs.sh/b/c25629c98ba36ebe/config.gz
    poc            https://bugs.sh/b/c25629c98ba36ebe/repro.c

=3D=3D Sanitizer Report =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
BUG: KASAN: slab-use-after-free in _copy_to_user (include/linux/instrumente=
d.h:129 include/linux/uaccess.h:201 lib/usercopy.c:24)
Read of size 512 at addr ffff88800dd12800 by task exploit/147
CPU: 1 UID: 0 PID: 147 Comm: exploit Tainted: G        W           7.2.0-rc=
2+ #6 PREEMPTLAZY
Call Trace:
dump_stack_lvl (lib/dump_stack.c:94 lib/dump_stack.c:120)
print_report (mm/kasan/report.c:378 mm/kasan/report.c:482)
kasan_report (mm/kasan/report.c:595)
kasan_check_range (mm/kasan/generic.c:186 mm/kasan/generic.c:200)
_copy_to_user (include/linux/instrumented.h:129 include/linux/uaccess.h:201=
 lib/usercopy.c:24)
fb_cmap_to_user (include/linux/uaccess.h:230 drivers/video/fbdev/core/fbcma=
p.c:211)
do_fb_ioctl (drivers/video/fbdev/core/fb_chrdev.c:114)
__x64_sys_ioctl (fs/ioctl.c:51 fs/ioctl.c:597 fs/ioctl.c:583 fs/ioctl.c:583)
do_syscall_64 (arch/x86/entry/syscall_64.c:63 arch/x86/entry/syscall_64.c:9=
4)
entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:121)
Allocated by task 1:
kasan_save_stack (mm/kasan/common.c:57)
kasan_save_track (mm/kasan/common.c:78)
__kasan_kmalloc (mm/kasan/common.c:398 mm/kasan/common.c:415)
__kmalloc_noprof (include/linux/kasan.h:263 mm/slub.c:5362 mm/slub.c:5387)
fb_alloc_cmap_gfp (include/linux/slab.h:973 include/linux/slab.h:1290 drive=
rs/video/fbdev/core/fbcmap.c:108)
vfb_probe (drivers/video/fbdev/vfb.c:459)
platform_probe (drivers/base/platform.c:1439)
really_probe (drivers/base/dd.c:628 drivers/base/dd.c:706)
__driver_probe_device (drivers/base/dd.c:868)
driver_probe_device (drivers/base/dd.c:898)
__device_attach_driver (drivers/base/dd.c:1026)
bus_for_each_drv (drivers/base/bus.c:500)
__device_attach (drivers/base/dd.c:1098)
device_initial_probe (drivers/base/dd.c:1153)
bus_probe_device (drivers/base/bus.c:620)
device_add (drivers/base/core.c:3772)
platform_device_add (drivers/base/platform.c:762)
vfb_init (drivers/video/fbdev/vfb.c:525)
do_one_initcall (init/main.c:1347)
kernel_init_freeable (init/main.c:1409 (discriminator 1) init/main.c:1425 (=
discriminator 1) init/main.c:1445 (discriminator 1) init/main.c:1658 (discr=
iminator 1))
kernel_init (init/main.c:1548)
ret_from_fork (arch/x86/kernel/process.c:158)
ret_from_fork_asm (arch/x86/entry/entry_64.S:245)
Freed by task 144:
kasan_save_stack (mm/kasan/common.c:57)
kasan_save_track (mm/kasan/common.c:78)
kasan_save_free_info (mm/kasan/generic.c:584)
__kasan_slab_free (mm/kasan/common.c:253 mm/kasan/common.c:285)
kfree (include/linux/kasan.h:235 mm/slub.c:2705 mm/slub.c:6405 mm/slub.c:67=
20)
fb_dealloc_cmap (drivers/video/fbdev/core/fbcmap.c:151)
vfb_remove (drivers/video/fbdev/vfb.c:489)
device_release_driver_internal (drivers/base/dd.c:1349 drivers/base/dd.c:13=
72)
unbind_store (drivers/base/bus.c:244)
kernfs_fop_write_iter (fs/kernfs/file.c:345)
vfs_write (fs/read_write.c:595 fs/read_write.c:687)
ksys_write (fs/read_write.c:739)
do_syscall_64 (arch/x86/entry/syscall_64.c:63 arch/x86/entry/syscall_64.c:9=
4)
entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:121)
The buggy address belongs to the object at ffff88800dd12800
which belongs to the cache kmalloc-512 of size 512
The buggy address is located 0 bytes inside of
freed 512-byte region [ffff88800dd12800, ffff88800dd12a00)
The buggy address belongs to the physical page:
page dumped because: kasan: bad access detected
Memory state around the buggy address:
ffff88800dd12700: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
ffff88800dd12780: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff88800dd12800: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
^
ffff88800dd12880: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
ffff88800dd12900: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb


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


