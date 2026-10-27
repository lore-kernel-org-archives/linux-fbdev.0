Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793109228;
	b=QJUUXozEyk35JivmQy+HpLCCSKfBFI4GdbxRDfj+/k07wFe+7XDSjPhNa/3KUcYvAAK0
	 8NuYb8NEdG6GUatXk5E9xfYSIipr7RKSRBPs7kgFdANZwvKIriHLJabOcmgTBYJRofJd6
	 EHikVOaUDZnx4ALthTzbEP3xaDYz0zeoS/CxIqt0qT/SbusApW5RNCczm+k8p6kIhWrTS
	 KqFwcelTQ5e5IF1uThlwcbeDmZG3VKoXVw5AAxPKLVjb94qbY8vxm+rsvbcNenOC2fLvD
	 kVGrqbcSNUaiKECaN390LaCALJMyMe0wZlP6TzViP4SgKqAh3aYAbcsLlqggM6xjnow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793109228;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=4yYlKBraGeyDSZtRP780bGZYg4T76grB2ZaUR5krlrE=;
	b=tCzun7yQtWrM0WYtUCh5F8nLJojGuq2EDNldhEe/oX5MohDTeogZNXIE7Nl6aygvsuTi
	 yWq+cMtcyXGxAnjtCtvSDSUDNvXqi6Mey6zwJJ9ZcVhIM0gz3n7+4dqjlk4cg1mzXu+vm
	 g0ILD6hnb9smFteGNzMFZhk5ntw2t+wpFp1drYjd4VZkbKkIdJc1Po+iAYPBA37YZrLdl
	 CzeWJ2ubYx34nEYyG8vJQkH/bzCpxF9EOtntrV26dtCB8o7XrFQbsaBkA2/f38Yc4RMfW
	 PhNxs1NfNN7vXWyJFJHjbFDBhS7HhWzEJsPBKxvTiNpElBaBZWsg4nrSnntp7mHu6Wg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OFklEkAA;
	arc=none smtp.remote-ip=209.85.221.49
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68B2E606A31E
	for <linux-fbdev@vger.kernel.org>; Tue, 27 Oct 2026 13:53:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 68B2E606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OFklEkAA
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-48e3b22e971so1990273f8f.0
        for <linux-fbdev@vger.kernel.org>; Tue, 27 Oct 2026 06:53:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793109226; x=1793714026; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4yYlKBraGeyDSZtRP780bGZYg4T76grB2ZaUR5krlrE=;
        b=OFklEkAAZ42Ic3wuvqs6NapbT/giusyRUm4zxyujUTnEY+FG2/IZpAy5f6hT+TB/dV
         yKvr95dFCcakqGEAgS0mvxyDXlWmzBwm2pAfvLxCZlljYWd8jNWsoHot+vzWwN5T+rM0
         9QfCIN/miTTFx9xa93iWq/wKAqOmfdNBi3gtqo4t/Dj6MROX0rndRsCgwwV8qFL/NKCx
         HI04ErDo1Y0VppHV3djXSLCW5IH+D3jpPNglrLjhV259Z7VGlWNWTyCzpP5tLlzYDFGt
         ygMcytx/AI5wpiOyOdQA1HUG8RQ9ov0Drvwg/Ra6tFiSVv5223WaksZ/807KoPaVuIUv
         Dr8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793109226; x=1793714026;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=4yYlKBraGeyDSZtRP780bGZYg4T76grB2ZaUR5krlrE=;
        b=xnSwofgSMVInUP04J943UZpSI1bvsqtsQ20TNd1IJQaxayA8kDuQYBZGw5K8tm0h53
         lWHYvb7VN7YClQTY5SjdLkjARE2x1AYwRUsdkNU7EnfEZ0VLJ+okcMqeudL7T7XD63Zd
         grFXMVe7flBCagFj5JYULE97s+C0ySw79VaRjYkQRDLk+KNmxz3lZjqQH/KS7mjp1xFN
         vlUYB/sRL4uC3WfO0DZdOYnEKrEagC9Yeumdqg3B9xqbz1j6Yc9vGqSubxAMfXsrOpsK
         rALwdLvNvT+7/VjrWGsAIQtMzJorT84vYWWQchGVyAshZyXD0eaUjcxcNPsEcNOuYIZj
         w7Nw==
X-Forwarded-Encrypted: i=1; AKwUvBySEjds0Tf3O46h+SDNw3uUtF84i2gUXIr6LZXFPk1qXJfYcMUJWsyjHpkz4LMVxHM2cL5HX8rUxkxISw==@vger.kernel.org
X-Gm-Message-State: AFq9FYKtmvt6PhnYmhA7gY/i8IU6cm/gOWUb+gYsG8CBwPuxW4m/19u5
	HJsGgGG9VWljUl/cdQbAmMa4Itp0KUqDOzI9WXb448SBABTU/cwbyCHt
X-Gm-Gg: AYBFou0VzjwiPhFFdNpn83ME2j0XyQcSZ+cWtyccAxJwHlP5+RCTngzLqv6DZuaRfkk
	AyhbodT0R9ukAKe/ldfzMF0CKNYpEWU/hyP5Cwri5hI2irM+ccFysp4pLRL2DjfOC37x9uh0kJj
	HJ2tuDUe/L9upAFHO/krH6zasUTsazqBr8L1dpCzRXIjaKBpBzjdgiP1UNyWJ3gPRNHHlqPdnn3
	blNAINjxvUiSbgnX0f2AjBmHBvP78GylsTf7npCZi3t1AJhH7Lnisz8+6tB+zoviwfGpdx0tkvk
	KrWdB7HENfbnmgEeJKXpyJ30ePThuNibfOmZNhxUvOxQk2fFH85j5waNzT/xy5bVpgTHg3ifp5U
	kG08/qyI2W1cwbZnahNb9PUynggz9w92ZYY/jhRGfHV7JiwBMOhvR9HjI/VArH3wfUpflqvQ6Hc
	ng9z135IRpA+NwWgWZvp8HWtv2CGaZxiiq9+OhXjHDxvLQpwvl6xgU0t7kpFfXgoAFEHSuXkmfD
	oO/0KuFuhEwtdIjwgXn89KyNnXMqZKdA8aa7vbGDC3wVDezhhajJgWrt7SAX3eTo/ovpoIE7NhK
	0GUvr44=
X-Received: by 2002:a5d:5e8a:0:b0:48d:f56d:be56 with SMTP id ffacd0b85a97d-48e3eb7642cmr19481648f8f.13.1793109225124;
        Tue, 27 Oct 2026 06:53:45 -0700 (PDT)
Received: from ingenieria31.oficinasStQ.local ([79.117.46.175])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ebcb846sm23128058f8f.25.2026.10.27.06.53.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 06:53:44 -0700 (PDT)
From: =?UTF-8?q?M=C3=A0xim=20Pedraza=20Padilla?= <maximpedraza@gmail.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Helge Deller <deller@gmx.de>,
	Peter Jones <pjones@redhat.com>
Cc: Francesco Valla <francesco@valla.it>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Javier Martinez Canillas <javierm@redhat.com>,
	Jocelyn Falempe <jfalempe@redhat.com>,
	Sam Ravnborg <sam@ravnborg.org>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-efi@vger.kernel.org,
	linux-fbdev@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-embedded@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v6 00/15] Add splash DRM client
Date: Tue, 27 Oct 2026 14:53:27 +0100
Message-Id: <20261027135342.2003632-1-maximpedraza@gmail.com>
X-Mailer: git-send-email 2.39.5
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Post: <mailto:linux-fbdev@vger.kernel.org>
List-Help: <mailto:linux-fbdev+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fbdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This is the sixth version of the splash client, which I took over from
Francesco with v4 [1]. It works in Thomas's review of v5 [13] and Rob's
of the binding [18], fixes what sashiko found in v5 [11][12], and adds
three patches: the BMP headers move to <video/bmp.h> to be shared with
efifb (patch 3), the choice of the image source gets a patch of its own
(patch 8), and the splash follows the connector's orientation
(patch 14). The command line parameters are gone, as Thomas asked [20].

Why this is in the kernel
-------------------------

Maxime asked in v1 why this should not be left to userspace or to the
bootloader. The cases it is for are the ones neither covers:

  - Nothing initialises the display before the kernel does. U-Boot's
    Falcon mode, meant to cut boot time, starts the kernel from the SPL
    and never runs U-Boot proper, where display support lives: there is
    no bootloader splash to hand over, and the device tree is the only
    thing that reaches the kernel. Userspace comes seconds later.

  - One kernel image for several products. An image built into the
    kernel, with CONFIG_EXTRA_FIRMWARE, means one kernel per logo, or
    every logo in every product's kernel, all of them staying in memory
    for good. Francesco described exactly this case in v2: one board
    support package for a family of devices, each with its own logo and
    background, picked by the bootloader.

  - A splash handed over from the bootloader does not always survive the
    native driver taking over the display.

Where the image comes from
--------------------------

In this order: the device tree, the EFI BGRT, and a BMP loaded as
firmware, named at build time ("drm_splash.bmp" by default); with none
of them, only the background is drawn, in a colour set at build time
or, for a device tree image, by its node.

The device tree node lives under /chosen (patch 7) and carries the BMP
either in its "logo-image" property, which dtc fills in with /incbin/,
or in a reserved memory region the bootloader loaded it into. The
region keeps the image out of the device tree, so that it can be
changed from userspace by updating a partition, as Francesco suggested.
A node is only there if someone put it there for that board, so it goes
before the BGRT.

Placement uses a position with -1 centring an axis, plus an offset, in
screen pixels. A rotation turns the image and not the screen, counter
clockwise as for panels and as DRM_MODE_ROTATE_* count. A device tree
image is placed as its node says, a BGRT image at the table offsets, and
anything else is centred.

BGRT images with the ACPI 6.2 orientation bits set are no longer skipped
but turned (patch 13). I took the meaning of the bits and of the offsets
from Plymouth, the main user of the BGRT, so that the kernel and
Plymouth put the image in the same place and the handover does not
jump. Plymouth takes orientation 1 (90 degrees) for a panel mounted
left side up and 3 (270) for right side up, which DRM counts as
DRM_MODE_ROTATE_90 and DRM_MODE_ROTATE_270; with the bits set it draws
the image upright at offsets given on the turned screen, and without
them it takes the image as already turned for a turned panel, at
offsets on the native screen. Patches 13 and 14 do the same. I have
not found the specification text to check against; corrections are
welcome.

Changes since v5
----------------

From Thomas's review [13][14][15]:

  - Patch 4 draws from a work item on system_power_efficient_wq instead
    of a render thread. One mutex covers the scanouts, the image and
    the firmware handed over by its callback, and the image is kept
    until unregister, so that the work can run again.
  - Every hotplug sets the outputs up again, so an output plugged in
    later gets the splash, and one unplugged is no longer driven. The
    buffers on screen stay there until the new ones are committed, by
    the work or by a restore, so the outputs do not go dark in between,
    nor when a commit or the hotplug fails; and a hotplug that fails no
    longer stops the later ones.
  - Restore commits whatever the modesets hold: an output that has no
    buffer has no mode either, and is switched off rather than left
    showing something else.
  - New patch 3: the BMP headers move from efifb to include/video/bmp.h,
    as __le16/__le32 fields; efifb reads them with get_unaligned_le*(),
    with no change on the little endian systems EFI runs on.
  - The image is drawn in two steps: the BMP is read, flipped and turned
    into an XRGB8888 buffer, which is then converted into the
    framebuffer's format; filling and blitting go by the format's
    drm_format_info rather than by bpp. Rotation (patch 11) only
    touches the first step.
  - No command line parameters [13][16][17][20]: patch 4 drops
    splash_color and splash_bmp, the colour and the BMP's file name are
    set at build time (CONFIG_DRM_CLIENT_SPLASH_BMP_NAME is new), and
    the v5 patch that added splash_bmp=none, splash_pos, splash_offset
    and splash_rotation is gone.
  - New patch 8: the image source is an enum, picked in one place, so
    that the device tree patch only adds its entry; the switch on it
    has no default, so that -Wswitch catches a source left out.
  - Messages are drm_dbg(), selects in alphabetical order, the mutex is
    destroyed at unregister, and the commit message of patch 4 carries
    the changes of each version.

From Rob's review [18]:

  - Patch 7: "image" is now "logo-image", and "rotation" is the one of
    panel-common.yaml, keeping its own description, as it turns the
    image rather than say how a panel is mounted.

From sashiko's review of v5 [11][12], and further review:

  - The 24 bpp source pixels are read with get_unaligned_le24() rather
    than a u32 load, which read a byte past the last pixel of the image
    and was unaligned [11], and the BGRT offsets are checked without the
    addition that could overflow [11]. Later patches already did; the
    fix now comes with the code it fixes.
  - The device tree source holds the node for as long as it draws the
    image in place, and drops it with the image [12].
  - Patch 4: a tiled framebuffer is sized from the tile offsets, in
    whatever order the CRTCs come, and a tile whose plane cannot take
    its group's format is left out; a preferred format that cannot be
    drawn to, such as C8, is not picked; a modeset left without a buffer
    is switched off instead of failing the commit for every output, and
    never keeps the framebuffer it had; nothing is drawn or committed
    while the device is suspended, a restore included, and the work is
    queued again on resume; only formats the plane takes
    with the linear modifier are picked; a background drawn again gets
    the image drawn again on top; the V4 and V5 BMP headers, which GIMP
    and ImageMagick write, are accepted; the build time background
    colour is limited to RGB888; the Kconfig help says that the BMP is
    requested only once.
  - Patch 2: efi_bgrt_has_image() says no when the image address, a u64
    in the table, does not fit in phys_addr_t, so that it cannot
    disagree with efi_bgrt_image_address() on 32-bit kernels without
    PAE. Thomas, I have kept your Reviewed-by, as said in [19].
  - Patch 7: the node is a "logo" node under /chosen with compatible
    "boot-logo"; logo-position and logo-offset give their defaults, and
    "logo-image" says that some architectures limit the size of the
    device tree (arm64 to 2 MB), so a large image belongs in a reserved
    memory region.
  - Patch 9: the image is found when the source is picked, and a node
    whose image cannot be had (a region that does not resolve or cannot
    be mapped, or "memory-region" on a kernel without
    CONFIG_OF_RESERVED_MEM) is warned about once and skipped, so the
    other sources are tried, rather than giving no image.
  - Patch 10: logo-position and logo-offset must hold two cells each,
    within the binding's range; otherwise the kernel warns and keeps the
    default.
  - Patch 12: a background-color that is not one cell of RGB888 is
    warned about and left out.
  - New patch 14: the splash follows the connector's orientation, the
    panel's or video=...,rotate=, as fbdev does: the plane turns the
    buffer when it can, and the splash turns it in software otherwise.
    A BGRT image stays as the firmware drew it, and tiles that need
    different turns get none in software, as with fbdev; so does a
    reflection, which is not drawn, and the legacy commit, which leaves
    the plane upright, gets the whole turn in software. It can be
    dropped; see the open questions.
  - Patch 15: the documentation follows all of the above.

Changes in v5
-------------

  - efi: bgrt: patch 2 adds accessors for the boot graphics instead of
    exporting bgrt_tab and bgrt_image_size, with stubs in efi-bgrt.h for
    CONFIG_ACPI_BGRT=n (Jani [2]); both variables are __ro_after_init
    (Ard [3]). Ard, this is the shape we discussed [4]: it is no longer
    the patch you acked, so I have not carried your Acked-by.
  - The client reads the BGRT through those accessors only, and drops
    its own wrappers, its stubs and the #ifdef around them; no "static
    inline" in drm_splash.c any more (Jani [5]).
  - Fixes from sashiko's review [6]:
    - when the render thread could not be created, the framebuffers
      were freed but the modesets still pointed at them, and the next
      restore committed them: a use-after-free that closing the last
      DRM file is enough to trigger;
    - when no buffer could be created, the scanouts were not freed, and
      a later restore committed a mode without a framebuffer;
    - a BMP loaded as firmware that arrived after the render thread had
      left (another master took over) was kept until unbind; it is now
      released when it arrives.
  - The binding and the documentation now ask a bootloader that loads no
    image into the reserved region to disable or remove the node, rather
    than to clear the region, which left the kernel an invalid image to
    complain about on every boot (sashiko [7]).
  - Dropped the RFC tag.

Changes in v4
-------------

Fixes to Francesco's patches, folded in and listed in the commit notes;
most of them were also in sashiko's review of v3 [9]:

  - the render thread stayed in TASK_UNINTERRUPTIBLE for good when the
    BMP firmware was missing (hung task warning), could miss a wake up,
    and kthread_stop() was called on a thread that had already exited
    (use-after-free), never existed or failed to start;
  - a use-after-free on unbind: the image was released after
    drm_client_release(), which frees the client;
  - a use-after-free in the firmware callback when the device goes away
    first, as the request cannot be cancelled; unregister now waits;
  - the BMP bounds check could overflow and let a crafted bitmap offset
    read 4 GiB away;
  - the 24 bit blitters read a byte past the image;
  - buffers went to the wrong modesets when one was skipped, tiled
    groups dereferenced a buffer before creating it and swapped width
    and height, a failed dumb buffer left an ERR_PTR behind, and the
    modeset list was walked without modeset_mutex;
  - the BGRT symbols are exported (Mario's report [10]), GPL only;
  - the DRM_CLIENT_DEFAULT entry is indented with tabs (patch 1).

Additions: the device tree source and its binding, placement, rotation,
the background colour following the image, BGRT orientation, the
command line parameters, and the documentation.

Testing
-------

  - QEMU versatilepb (pl111, 16 bpp): 45 cases for the device tree
    source (inline and region, invalid nodes and values, placement,
    clamping, rotations, rows with and without padding, backgrounds, a
    V5 BMP header), plus 3 for the order of the sources, among them a
    region that cannot be read falling back to the BMP loaded as
    firmware, each compared pixel by pixel.
  - QEMU virt arm64 (virtio-gpu, 32 bpp) with KASAN and kmemleak, with
    the BMP loaded as firmware from an initramfs and the driver bound
    and unbound repeatedly: no reports, also with a crafted bitmap
    offset and with the firmware arriving only after the unbind (sysfs
    fallback).
  - Hotplug on vkms: when the connection moves from one connector to
    another after the splash is up, a restore drives the new one, and
    the old buffers go only once the new ones are committed; with the
    first hotplug forced to fail, the next one brings the splash up.
  - Several outputs: with the first output off and the second on, v3 put
    the buffer on the dead output and left the live one blank; now the
    splash is on the live one.
  - A tiled display, simulated by forcing on two virtio-gpu heads EDIDs
    with a DisplayID tiled topology block (2x1 tiles of 1024x768): one
    2048x768 buffer, the image centred across both tiles; v3 oopsed on
    such a display.
  - The error paths, with a debug patch forcing them: a buffer or a
    format that fails on one output of two leaves that one off and the
    splash on the other; work queued while suspended runs on resume; a
    background that fails to draw is drawn on the next try; no WARN or
    KASAN report in any of them.
  - x86-64 with OVMF for the BGRT through the new accessors, including
    forced orientation bits, a connector turned with video=...,rotate=,
    and drm_client_lib built as a module.
  - efifb before and after patch 3, with the BGRT replaced from the
    initrd to move the image: efifb draws it at the new place, the same
    pixel for pixel with and without the patch.
  - i386 without PAE on 32-bit OVMF, with the BGRT replaced from the
    initrd so that it points above 4 GiB: without the patch 2 check the
    splash draws the image at the truncated address; with it, the
    background alone.
  - An AM335x board (tilcdc, 800x480 panel of which only the bottom 297
    lines are visible, 16 bpp), booting over TFTP and NFS: 6 cases,
    plus 6 with the BMP loaded as firmware from an initramfs, and 5
    unbind and bind cycles of tilcdc, checked by reading the scanout
    buffer back through /dev/mem.
  - The handover on the same board, with the product's Qt5 application
    drawing through EGLFS and the SGX GPU: it takes the display straight
    from the splash, and when it exits the splash is restored, pixel for
    pixel.
  - Falcon mode, on an AM335x board booting from NAND: the SPL starts
    the kernel directly, with the device tree appended to it and the
    image inline in the node, and U-Boot proper never runs. The splash
    comes up as the node asks, checked pixel by pixel.
  - W=1 and sparse clean; every patch builds on its own on arm and
    x86-64; checkpatch --strict clean apart from a quoted modpost line,
    the MAINTAINERS reminder on patch 4, answered by patch 5, and the
    one on patch 3, whose new header FRAMEBUFFER LAYER already covers;
    dt_binding_check clean for the binding.

Not tested: a BGRT with orientation bits from real firmware, nor one
on a plane that turns in hardware.

Open questions
--------------

  - The second drawing step, from XRGB8888 into the framebuffer's
    format, converts each pixel itself for now. It is kept apart so that
    it can move onto a shared drawing interface for clients once there
    is one [15].
  - Rob: how the image should be described, a BMP in a property or raw
    pixels described like simple-framebuffer [8]. The binding here uses
    the BMP; the client would need a second drawing path for the other.
  - Once the binding settles I will send the dt-schema change that lets
    the node live under /chosen; until then dtbs_check flags it.
  - The splash is a DRM client, so a device using it has no fbdev
    emulation and no /dev/fb0. That rules it out where userspace still
    draws through fbdev.
  - Unbinding waits for a pending firmware request, as the request cannot
    be cancelled and its callback uses the splash, and it waits under
    the device's clientlist_mutex. Normally the request is long over; with
    the sysfs fallback enabled it can take up to the loading timeout
    (60 s by default). Not waiting would mean splitting what the callback
    uses into its own refcounted object; I left it as is, but can do it
    if preferred.
  - Patch 14 makes the splash follow the connector's orientation the way
    fbcon does: what the plane does not turn in hardware is turned in
    software, so the logo looks the same on every driver, and the logo's
    own rotation is relative to what is seen. Without it the logo
    follows the plane, which matches userspace that ignores the panel
    orientation, but the result depends on the driver (and can change
    when a native driver takes over from simpledrm). If following the
    plane is preferred, patch 14 can simply be dropped.
  - The BGRT offsets are for the mode the firmware drew in. When KMS
    picks another one (a non-atomic driver, a secondary output, or
    video=), the x86 sanity check taken from efifb leaves the screen
    without a logo, and elsewhere the logo lands off centre. The offsets
    could be used only when the scanout matches the firmware's
    framebuffer, as screen_info describes it, and the image centred
    otherwise; I have left it as efifb has it for now.

Based on drm-misc-next-2026-10-23 (cf5d8e390e2a).

[1] https://lore.kernel.org/all/aryqYhHqFk3cXh9d@bywater/
[2] https://lore.kernel.org/all/5c92c6f27b0778124d2365603374f70bd9b69b8d@intel.com/
[3] https://lore.kernel.org/all/001eb42a-ec22-474a-83c6-371f1f4b2b8c@app.fastmail.com/
[4] https://lore.kernel.org/all/9cf259a5-6083-433c-8544-ca3f6286334e@app.fastmail.com/
[5] https://lore.kernel.org/all/1800459b75ea057c42f8c601a09646cca938b3db@intel.com/
[6] https://lore.kernel.org/all/20261002091339.B64EB1F00893@smtp.kernel.org/
[7] https://lore.kernel.org/all/20261002091338.E12D61F000FF@smtp.kernel.org/
[8] https://lore.kernel.org/all/CAEUXW=Gh6wMk1i=x_KT0eSdkHeHs8Hkxkj4hfsuTRyY6=aphpw@mail.gmail.com/
[9] https://sashiko.dev/#/patchset/20260510-drm_client_splash-v3-0-a9aee9f0b2fc%40valla.it
[10] https://lore.kernel.org/dri-devel/5d7067de-97b7-4232-9cf6-e4b978696482@amd.com/
[11] https://lore.kernel.org/all/sashiko-outbox-169372@kernel.org/
[12] https://lore.kernel.org/all/sashiko-outbox-169390@kernel.org/
[13] https://lore.kernel.org/all/fafa7327-e624-49f2-98b2-83fd602a0ad7@suse.de/
[14] https://lore.kernel.org/all/9834b569-935c-484b-befb-b913acead9c1@suse.de/
[15] https://lore.kernel.org/all/350adc03-dd7f-4120-ac9c-b6d04ff44faf@suse.de/
[16] https://lore.kernel.org/all/ad6a04b7-cf57-4b22-9c22-85a61af29f1f@suse.de/
[17] https://lore.kernel.org/all/45b55f94-0cd2-425b-b985-ba3958502b06@suse.de/
[18] https://lore.kernel.org/all/20261020164651.GA4017884-robh@kernel.org/
[19] https://lore.kernel.org/all/20261021005006.2341200-1-maximpedraza@gmail.com/
[20] https://lore.kernel.org/all/645c1c2b-9aa8-44b4-8a67-dcd7bfbe8fbd@suse.de/

v5: https://lore.kernel.org/r/20261013093243.505776-1-maximpedraza@gmail.com
v4: https://lore.kernel.org/r/20261001195847.141192-1-maximpedraza@gmail.com
v3: https://lore.kernel.org/r/20260510-drm_client_splash-v3-0-a9aee9f0b2fc@valla.it
v2: https://lore.kernel.org/r/20260106-drm_client_splash-v2-0-6e86a7434b59@valla.it
v1: https://lore.kernel.org/r/20251027-drm_client_splash-v1-0-00698933b34a@valla.it

Màxim

Francesco Valla (3):
  drm: client: add splash client
  MAINTAINERS: add entry for DRM splash client
  drm: docs: remove bootsplash from TODO

Màxim Pedraza Padilla (12):
  drm/clients: Kconfig: indent DRM_CLIENT_DEFAULT with tabs
  efi: bgrt: add accessors for the boot graphics
  fbdev: efifb: move the BMP headers to <video/bmp.h>
  dt-bindings: display: add a boot logo node under /chosen
  drm/client: splash: pick the image source in one place
  drm/client: splash: add a device tree image source
  drm/client: splash: place the device tree image where it asks
  drm/client: splash: turn the device tree image as it asks
  drm/client: splash: take the background colour from the image source
  drm/client: splash: turn the BGRT image on panels mounted turned
  drm/client: splash: follow the connector's orientation
  drm/client: splash: document the image sources

 .../bindings/display/boot-logo.yaml           |  156 ++
 Documentation/gpu/drm-client.rst              |    6 +
 Documentation/gpu/todo.rst                    |   17 -
 MAINTAINERS                                   |    9 +
 drivers/firmware/efi/efi-bgrt.c               |   75 +-
 drivers/gpu/drm/clients/Kconfig               |   96 +-
 drivers/gpu/drm/clients/Makefile              |    1 +
 drivers/gpu/drm/clients/drm_client_internal.h |    9 +
 drivers/gpu/drm/clients/drm_client_setup.c    |    8 +
 drivers/gpu/drm/clients/drm_splash.c          | 1482 +++++++++++++++++
 drivers/video/fbdev/efifb.c                   |   49 +-
 include/linux/efi-bgrt.h                      |   39 +-
 include/video/bmp.h                           |   40 +
 13 files changed, 1930 insertions(+), 57 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/display/boot-logo.yaml
 create mode 100644 drivers/gpu/drm/clients/drm_splash.c
 create mode 100644 include/video/bmp.h


base-commit: cf5d8e390e2ac2cfa24a50645efdbb9f0eebe65f
-- 
2.39.5

