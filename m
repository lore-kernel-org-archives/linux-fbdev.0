Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CCDA32FA2B
	for <linux-fbdev@vger.kernel.org>; Fri, 31 Jul 2026 21:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785534649; cv=none; b=VbS8P1hg1OnNAVmBGKefQCZ9W9anWXUhRi789AD/xg+ItAr6NgRB60afHRgLx0Siyj/HHgFowZj+K/mpvKZtvTTWEL7sYTEh2aQZya2qyFuhDnp/EBxbc8ruskeE30Lbom0NusS+GJTYUzMLoTIWpBb64IkYUr9DAN9aOJuw7u8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785534649; c=relaxed/simple;
	bh=+ktTmeG0PECnEwvqMK2dDejo2W8WrggRDEWZz2VJGTc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UEmKv+Bc/RoiErDk/rAjYRc5lNPReNR8SY2DGB5ccXqnRG2EXT4FIXiqIRe6CMRYc73R+7rQ9DtAThal/vKAzG4wsekMp2RBLmDBQZGGAdVHuC92z3PZauD2G4KcLUXh5Mfo2+NoUYvyO43e+19AZcnxScyaUam+f/hxWFu7SDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C3wnjzAo; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C3wnjzAo"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-47640541585so1157273f8f.1
        for <linux-fbdev@vger.kernel.org>; Fri, 31 Jul 2026 14:50:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785534646; x=1786139446; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Qjxvx3SRHRdNngyn+BsnRyiaEmpffW5fc35P9viCcxY=;
        b=C3wnjzAo87IXqcreNOSWBhcNVoWn6mSyzDRNhAca0xB96owNrkciTkPMjcB2MTCjrn
         d1PaLNjp1ANP8gi3+jq3NlPcNIQirOXAUDg7qwMwaMrjdbBECREpruu+7T6x6+e1liCO
         Q2zc4S6h2fpyBBO1IRYt955zSmvKQQApAX09kmO9CpBf/uP6UgNZU8kv6BNovO/nkOLo
         hjYnzd8eNv/OSVEEWNFpdqeOERDRzZFc/h5vm1zjxCAdjv/LuoEur5JFmCs2lsnkr6HM
         YUcjPYCX8mD5Rp1AaLORZ0wLYaddzNeA/a+hKUoSd4uU1dktLV/RSD/KUEuX/UXmUoUA
         jVkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785534646; x=1786139446;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Qjxvx3SRHRdNngyn+BsnRyiaEmpffW5fc35P9viCcxY=;
        b=jj3C3TDGLDQE0m7G9oIaphtn6o/UyvcUCYM+Uhuncs/gZp78JAviZKLx8kOxP52Zp0
         asO6rZEoKTevSvV5TpxGNwivvwaBIgQLpvDJzQHFP+exOLsEOj2jk/VJ1HRFD6WwX3Uc
         WxU6RyA+3GxU8cHtaj+k8HlMYNGujxDS3j04CMMEvZWCxYx3JviCErbIegqvqoPx6+jl
         WzvQwkHQzmvdstBKVbm/L7uxIbgo2jAl6Q+/+yGPeRZEu5BIRUE5phFrBckdpahWPVkY
         s4vMaietytfc/0rQLAbjE1DPoI/sBSOoZerW/3OA+XPAqKhPkGaSgu0yJi2CbrwFbY+f
         HnAQ==
X-Forwarded-Encrypted: i=1; AHgh+RqTmSbQXCUtSmRi+4J1T+L5HFmuHEd9JJifNHg2gczoJmrAhvDbQMUvpSwNdIwZkKnsmA+rHmv90J1rMw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzOscoI1jkq8BUbyX0qVL2WQ+uRoxlnEJUf+g/8fHqGq/J+GmNQ
	eYvr6buLYoMMD38VHtW+2ucmb4DRkx7h6a2x6TYsfHNFP9Qr/+Dtdyq2
X-Gm-Gg: AR+sD10P/jE+0mUSCZSs8+dbJnk2hfeTz8+X/Q8Tjkw/OZ5FbX2Kge8i2Ideyj1SOyv
	E7dfc+7T1QlzPXOBd8Z29SCfXqtrx+WFb3swjvbnMOrqW0BirPY3EhfkvLAhaTrmPOLzd2SZE11
	VtdhlF6NsJQTRW47a6NjtW6oHw0fRsdv3QyYsUVnHjRdJwiuvvySusYlgQdTnJlZF0yqzBO5ezy
	+yqGQGEmqp9xffhHP+T8ubz7ydn7f49JJpfvhTwrjznhJWvuxnt6qyyqRupwfr6bABC0ISn8eYY
	ZeGfjJk8wJZmzUMjl/J9c0TG0zXK7QE+qyZyJZAPyK3cGIa+YykuD8c/0sRiodDWSYux4MG+zcZ
	DH6mNnEcfIBATqyZLll7dBOguRT2erVSrp70jEIQT/eYwbtMPjABC5vjMLZlbgV1Jw1kOLeLqOx
	CW0fv+kBk1F+B8qsNAQHFnRxqsstDnFGT10Tr75e18gBH+c4DZ9kHVaurOZPK5FfQRKmeb5Nfra
	Mw96Z/hmtzwfg==
X-Received: by 2002:adf:fd4e:0:b0:47f:8e78:4d0c with SMTP id ffacd0b85a97d-47fd72fc101mr1754482f8f.48.1785534645758;
        Fri, 31 Jul 2026 14:50:45 -0700 (PDT)
Received: from ingenieria31.oficinasStQ.local ([79.116.62.64])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fd41e2484sm10186342f8f.11.2026.07.31.14.50.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 14:50:45 -0700 (PDT)
From: Max Pedraza <maximpedraza@gmail.com>
To: Helge Deller <deller@gmx.de>
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Maxime Ripard <mripard@kernel.org>,
	linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Max Pedraza <maximpedraza@gmail.com>
Subject: [RFC PATCH 0/6] Boot logo supplied by the device tree
Date: Fri, 31 Jul 2026 23:50:37 +0200
Message-Id: <20260731215043.30392-1-maximpedraza@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Embedded products routinely need their own boot logo. Today the only way to
get one is to replace one of the logo_*_clut224.ppm files in the kernel
source tree, which bakes the image into the kernel image. Two products that
share a board support package but differ in branding therefore need two
kernel builds, and rebranding an existing product means rebuilding and
requalifying a kernel for what is purely a cosmetic change.

This series lets the logo be described by the device tree instead: a node
compatible with "linux,boot-logo-clut224" supplies the image in the same
paletted format the built-in CLUT224 logos already use, and the kernel
prefers it over the built-in ones when it is present and enabled. If the
node is absent or disabled, nothing changes.

The image can come from the node itself (patches 1-2) or from a reserved
memory region the bootloader filled in (patches 4-5), because the image and
its placement are independent axes of variation. One board sold to several
customers wants several device trees differing in the logo. One customer
with several products built on that board, with different panels, wants the
same logo placed differently on each: there the image belongs in a shared
binary and only the placement belongs in the device tree. Patch 3 adds that
placement.

We have been carrying a cruder version of this downstream on an AM335x
product since 2020, across a handful of board revisions, and it has removed
a real maintenance burden for us. This is an attempt to find out whether
something along these lines is wanted upstream, and if so in what shape --
hence RFC.

I am aware of the contentious part: a bitmap is not hardware, and the device
tree is not an obvious place to put one. The argument for it is that the
logo identifies the board in the same way the model property does, it is
available before any filesystem is mounted, and it is per board rather than
per kernel. The argument against is presumably that this is policy and
belongs in userspace or in the bootloader. I would rather hear that
explicitly than keep the patch downstream on a guess, and if the concept is
rejected I would still like to know whether a smaller subset -- say the
placement properties driven from the fbcon command line, without any image
in the device tree -- would be worth submitting separately.

Patches 4 and 5 are separable; the series is useful without them if the
reserved memory path is thought to be one mechanism too many.

Not included, though it exists in our downstream version: a hook in
drm_fb_helper so the logo is drawn when CONFIG_FRAMEBUFFER_CONSOLE is
disabled, which is the common case for a product that only wants a splash
screen. Today fb_show_logo() is reached from fbcon alone. That is a DRM
question rather than an fbdev one and deserves a separate posting.

Notes on the binding:

  - The palette size is derived from the length of the "clut" property
    instead of being a separate property, so it cannot disagree with the
    palette actually supplied.
  - "data" holds plain palette indices. The 32 entry offset the frame
    buffer layer reserves for the console is an implementation detail and
    is applied by the kernel.
  - "logo-position" and "logo-offset" are spelled with the prefix because
    plain "position" and "offset" are already used elsewhere in the tree
    with an incompatible type, which dtschema rejects.
  - "logo-centered" overlaps with the existing fb_center_logo, but it is
    per device tree rather than per fbcon command line, and it composes
    with "logo-offset". That combination is what panels with a partially
    visible area need, where the usable region is not the centre of the
    mode; the hardware this came from is an 800x480 panel of which only the
    bottom 320 rows are visible.
  - The reserved memory path takes a "memory-region" phandle rather than a
    bare address. The reservation is what makes the memory safe to read at
    all, and it is what gives the kernel a size to bounds check against.

The byte arrays are not written by hand: patch 6 adds ppmtodtlogo, a host
tool along the lines of the existing pnmtologo -- plain C, no dependencies,
no quantization of its own -- that turns a PPM image into the node or into
the memory region blob. It is what produced everything tested below.

Testing: build tested for arm with CONFIG_LOGO_DT_CLUT224 both enabled and
disabled, W=1 clean, checkpatch --strict clean, dt_binding_check clean. The
schema was also checked against deliberately malformed nodes, including
supplying both image sources at once and neither.

Boot tested under qemu-system-arm -M versatilepb with PL111 and fbcon, at
16bpp. A 160x120 logo placed with "logo-centered" plus a "logo-offset" of
<0 120> lands at exactly the expected coordinates, and every pixel matches
the source image once the source is truncated to RGB565, with identical
per-colour pixel counts. Supplying the same image through a reserved region
loaded at boot produces a bit for bit identical screen. Blobs with a bad
magic, a geometry larger than the reservation, an out of range pixel and an
oversized palette are each rejected with a warning and fall back to the
built-in logo, with no crash.

That boot test earned its keep: the first version of patch 3 drew the logo
correctly and then had it erased, because fb_prepare_logo() still reserved
only the logo's own height while the logo itself had been moved further
down. Nothing in the build or the static checks catches that.

Also boot tested on real hardware: an AM335x board (tilcdc) with an 800x480
panel, migrated from the 4.19 product kernel this derives from. Both image
sources show the product logo where expected -- embedded in the device tree,
and in a bootloader-loaded reserved memory region at the same address the
4.19 system already used. That system builds without
CONFIG_FRAMEBUFFER_CONSOLE, so the drawing there goes through the separate
drm_fb_helper hook mentioned above as not included; the parsing, validation
and placement exercised are those of this series.

Max Pedraza (6):
  dt-bindings: display: add a device tree supplied boot logo
  video: logo: allow the boot logo to come from the device tree
  fbdev: honour the device tree boot logo placement properties
  dt-bindings: display: allow the boot logo in a reserved memory region
  video: logo: allow the boot logo to come from a reserved memory region
  video: logo: add ppmtodtlogo host tool

 .../display/linux,boot-logo-clut224.yaml      | 152 +++++++
 MAINTAINERS                                   |   1 +
 drivers/video/fbdev/core/fb_logo.c            | 174 ++++++++
 drivers/video/logo/Kconfig                    |  13 +
 drivers/video/logo/Makefile                   |   6 +-
 drivers/video/logo/logo.c                     | 256 +++++++++++
 drivers/video/logo/ppmtodtlogo.c              | 402 ++++++++++++++++++
 7 files changed, 1003 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/display/linux,boot-logo-clut224.yaml
 create mode 100644 drivers/video/logo/ppmtodtlogo.c

-- 
2.39.5

