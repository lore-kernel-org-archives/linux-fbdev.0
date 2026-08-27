Received: from bg-bec.cloudflare-smtp.org (bg-bec.cloudflare-smtp.org [104.30.16.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C130A403B13
	for <linux-fbdev@vger.kernel.org>; Thu, 27 Aug 2026 12:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.30.16.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787834630; cv=none; b=MvYRqFcmtVvp66zSd2xlINmtaVcQ3fDn4o5Gz8qMIuLMKoR+jmh9beqREyGdZop3/Igm4QZxdvqER/Qp51j8UgvDG+i6jWpQyu8kHYCmL6dSAl3CmAdLNQM0uj06BQSXpXFoe4Ul+2FElYz8dIPDS8PVpMhCZ55nJR30NSyj7Es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787834630; c=relaxed/simple;
	bh=f8e0Fnj0VJy3IlG1lJqRKPLxR1n5C5Pnk8GZEKpjirM=;
	h=From:Message-ID:Date:Subject:To:MIME-Version:Content-Type; b=MI4A2OH1cNvt9MKhxRgMYXpdDUlAAEqj0UWQPeRDG1wm9LyfSe9Rv4OQ1KCY4HdZaZS78wB+ZNdnTUOjjBrgTxaUK5P+9jtbmoY9VGnhJ16Pvp+/kIuehugPcGo9waoNr+4iTk7j2ePd0D/J7CxacREbZ8+LQDTe3khgLPz3tUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bugs.sh; spf=pass smtp.mailfrom=cf-bounce.bugs.sh; dkim=pass (2048-bit key) header.d=cloudflare-smtp.org header.i=@cloudflare-smtp.org header.b=G4ZVOuTR; dkim=pass (2048-bit key) header.d=bugs.sh header.i=@bugs.sh header.b=PTvsH+hF; arc=none smtp.client-ip=104.30.16.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bugs.sh
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cf-bounce.bugs.sh
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare-smtp.org header.i=@cloudflare-smtp.org header.b="G4ZVOuTR";
	dkim=pass (2048-bit key) header.d=bugs.sh header.i=@bugs.sh header.b="PTvsH+hF"
DKIM-Signature: v=1; a=rsa-sha256; s=cf2024-1; d=cloudflare-smtp.org; c=relaxed/relaxed;
	h=To:Subject:Date:From:Feedback-ID:from:reply-to:cc:resent-date
	:resent-from:resent-to:resent-cc:in-reply-to:references:list-id:list-help
	:list-unsubscribe:list-unsubscribe-post:list-subscribe:list-post
	:list-owner:list-archive; t=1787834620; x=1788439420; bh=ybdv1l55cYdaAZRHPa
	yzjZTPrUKjnSWWBRLovv9blPg=; b=G4ZVOuTR4bdOdfHaohkF23azJMQniHCIQpVlENEyKL45q
	k72F5gKTGmEzz5ZL//u0cG9IC9yKvs2xkcd5Qge1zcYcI6Er64xTdMrTicd5dPLNajKzPHspODm
	rbwsvVgcdFRaWgSHw5+PT3E7dcas9bToDSa1AoZzcAwtibVEaIaL1bbXRAAgFdmTQoyrx9Aoe36
	WgZJCA29UUqjdrSyWDKWi48UlRDjbdvsrWsUJH1fZH/HcekJ1QSGo3NviM3NxMu14IYwO+Vcpwy
	MTvtJv2ttoZqvSUaQ5/lu0ifOzAYY6Wezpe/4N7MBWvfgLRNcZQBPMKFOapSidEf+sQ7t6cQ==;
DKIM-Signature: v=1; a=rsa-sha256; s=cf-bounce; d=bugs.sh; c=relaxed/relaxed;
	h=To:Subject:Date:From:Feedback-ID:from:reply-to:cc:resent-date
	:resent-from:resent-to:resent-cc:in-reply-to:references:list-id:list-help
	:list-unsubscribe:list-unsubscribe-post:list-subscribe:list-post
	:list-owner:list-archive; t=1787834620; x=1788439420; bh=ybdv1l55cYdaAZRHPa
	yzjZTPrUKjnSWWBRLovv9blPg=; b=PTvsH+hFKrQcy4cwRxfzkRBq0Z7hc/g9X2F546rQwfdLj
	7C7Lm8jpkiGGj2Dx2btaEcP7EtyKu7P3cDPHMve/7rBq+NXwISs8iX7d8y+xtIE0Gz/1es3DnbS
	H5sUvni6UWPqt7ABnqhCADNZDXg/bYb+IHGb0UMOSR48tyteh2ADZZcaAJJ5b3TY+JFekRAhaqF
	x8rFRLN/lILhCWtrUUFAr5KOUWnnwz2RX6p2qUkPMsygsic69qOEKOzuSj5HhxP33syjfmoTrQx
	pYaSkNipYasqYhTg9/Y6L8xloIHWbFcnOi1GpQkkSzWoJXixYI/697ZCe8+HKyYjaTn2oUug==;
Feedback-ID: bugs.sh:5:6:Cloudflare
From: co <co+1875dd47169bd757@bugs.sh>
Message-ID: <eI5CjpXt3iSkALGbLLgJa6Pj4lq2BbU7Fmjj@bugs.sh>
Date: Thu, 27 Aug 2026 12:43:33 +0000
Subject: [BUG] drivers/video: out-of-bounds in tile_putcs()
To: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, "Helge
 Deller" <deller@gmx.de>, "Thomas Zimmermann" <tzimmermann@suse.de>, "Simona
 Vetter" <simona@ffwll.ch>, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

We found a bug reachable in:

    path    drivers/video/fbdev/core/tileblit.c`, `drivers/video/fbdev/core
    crash   out-of-bounds in tile_putcs()
    commit  843bc34db94b

Config, environment, the sanitizer report and a C reproducer follow.

=3D=3D Notes =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
    If you patch the bug based on our artifacts, a tag would be
    appreciated:

Reported-by: co+1875dd47169bd757@bugs.sh

    Everything in this mail is validated by the reproducer below.

    We also hold an LLM-generated root-cause analysis and a candidate
    patch. The patch passes an A/B test: the same reproducer panics the
    unpatched kernel and runs clean on the patched one. Neither has had
    human review, so both still require validation before you send or
    apply them. Available on:

        patch.diff  https://bugs.sh/b/1875dd47169bd757/patch.diff
        report.md   https://bugs.sh/b/1875dd47169bd757/report.md

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
    VM setup       https://bugs.sh/b/1875dd47169bd757/run.sh
    config         https://bugs.sh/b/1875dd47169bd757/config.gz
    poc            https://bugs.sh/b/1875dd47169bd757/repro.c

=3D=3D Sanitizer Report =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
BUG: KASAN: slab-out-of-bounds in tile_putcs (drivers/video/fbdev/core/tile=
blit.c:69)
Write of size 4 at addr ffff88800c622000 by task exploit/143
Call Trace:
dump_stack_lvl (lib/dump_stack.c:94 lib/dump_stack.c:120)
print_report (mm/kasan/report.c:378 mm/kasan/report.c:482)
kasan_report (mm/kasan/report.c:595)
tile_putcs (drivers/video/fbdev/core/tileblit.c:69)
fbcon_putcs (drivers/video/fbdev/core/fbcon.c:1392 (discriminator 3))
do_update_region (drivers/tty/vt/vt.c:656)
redraw_screen (drivers/tty/vt/vt.c:1008)
fbcon_blank (drivers/video/fbdev/core/fbcon.c:2315)
do_unblank_screen (drivers/tty/vt/vt.c:4756 drivers/tty/vt/vt.c:4724)
vt_ioctl (drivers/tty/vt/vt_ioctl.c:276 drivers/tty/vt/vt_ioctl.c:381 drive=
rs/tty/vt/vt_ioctl.c:743)
tty_ioctl (drivers/tty/tty_io.c:2792)
__x64_sys_ioctl (fs/ioctl.c:51 fs/ioctl.c:597 fs/ioctl.c:583 fs/ioctl.c:583)
do_syscall_64 (arch/x86/entry/syscall_64.c:63 arch/x86/entry/syscall_64.c:9=
4)
entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:121)
Allocated by task 143:
__kmalloc_cache_noprof (include/linux/kasan.h:263 mm/slub.c:5515)
do_register_framebuffer (include/linux/slab.h:969 drivers/video/fbdev/core/=
fbmem.c:502)
register_framebuffer (drivers/video/fbdev/core/fbmem.c:602)
ark_pci_probe (drivers/video/fbdev/arkfb.c:1051)
local_pci_probe (drivers/pci/pci-driver.c:332)
pci_device_probe (drivers/pci/pci-driver.c:394 drivers/pci/pci-driver.c:455=
 drivers/pci/pci-driver.c:489)
really_probe (drivers/base/dd.c:628 drivers/base/dd.c:706)
__driver_probe_device (drivers/base/dd.c:868)
driver_probe_device (drivers/base/dd.c:898)
__driver_attach (drivers/base/dd.c:1292)
bus_for_each_dev (drivers/base/bus.c:383)
new_id_store (drivers/pci/pci-driver.c:249)
kernfs_fop_write_iter (fs/kernfs/file.c:345)
vfs_write (fs/read_write.c:595 fs/read_write.c:687)
ksys_write (fs/read_write.c:739)
do_syscall_64 (arch/x86/entry/syscall_64.c:63 arch/x86/entry/syscall_64.c:9=
4)
entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:121)
The buggy address belongs to the object at ffff88800c620000
which belongs to the cache kmalloc-8k of size 8192
The buggy address is located 0 bytes to the right of


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


