Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 101E47A70A
	for <linux-fbdev@vger.kernel.org>; Tue, 12 Mar 2024 15:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710258521; cv=none; b=L4wnGmK42krx6Kas9uWrCkhb+QerzJmw/xWPZY0GAAkm+Nn27v+0ido45kIdc86BNSRdp/iN/GbZn+JxED3p7zUSYiN/9nAQCe3qt6F2jiaMusrjMBJmKq3R1mkQ6TVJCS8MuGz3FWqRrYANOdNBHssMp4NKjvZtMA4B0uFEXNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710258521; c=relaxed/simple;
	bh=dL2UG/dyidCH+K9j9iWHQ1j0M10haldjAmZsnn3JJzk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ClFf7KlkgoDX8ueh3YDR+CI2KedppMMwHp75+Z27/Z8xtylqbYA5qBYx0ON9UzokiyBy2g0ii1m6kOgwZsx2tszK52Uz7uWMADCE6lNd9F2Qp2U1ARFS4W4Uk3wbett3RcjdC9MJR5PjLQAUWSuxtnspgpaAQ+fwjnf9hXzbvXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=yRkGpNSg; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=MeszIvPB; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=yRkGpNSg; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=MeszIvPB; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="yRkGpNSg";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="MeszIvPB";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="yRkGpNSg";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="MeszIvPB"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 1A7FE5D6C6;
	Tue, 12 Mar 2024 15:48:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1710258517; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=6CtdHZn7M++63gs8y2acpS5Q+y2lx0SFvFzxFePDYuE=;
	b=yRkGpNSgCGXF6W8E8SP6Qyhozp6Wok7czo3W537itjlnv2lLxvh9Q6S0XOgJGeux+miF19
	Vbe52ZgRQ//a8CbG5Okp0AWHbhbTqjyb54drkBhUs4yjqdTNRibT53HoUOcgjIWdfWnhmk
	tKiajGoglSqYkwUMfyJPFQCqDmta/Is=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1710258517;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=6CtdHZn7M++63gs8y2acpS5Q+y2lx0SFvFzxFePDYuE=;
	b=MeszIvPBmQvYtJABOSEuf3uPcF2VTBvSVRGZD0D1HfTW9TfiKba+kHK6b42dXqD5nH+ldJ
	6NHODzX+2ClIGIBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1710258517; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=6CtdHZn7M++63gs8y2acpS5Q+y2lx0SFvFzxFePDYuE=;
	b=yRkGpNSgCGXF6W8E8SP6Qyhozp6Wok7czo3W537itjlnv2lLxvh9Q6S0XOgJGeux+miF19
	Vbe52ZgRQ//a8CbG5Okp0AWHbhbTqjyb54drkBhUs4yjqdTNRibT53HoUOcgjIWdfWnhmk
	tKiajGoglSqYkwUMfyJPFQCqDmta/Is=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1710258517;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=6CtdHZn7M++63gs8y2acpS5Q+y2lx0SFvFzxFePDYuE=;
	b=MeszIvPBmQvYtJABOSEuf3uPcF2VTBvSVRGZD0D1HfTW9TfiKba+kHK6b42dXqD5nH+ldJ
	6NHODzX+2ClIGIBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D54F51364F;
	Tue, 12 Mar 2024 15:48:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id nimeMlR58GUhPwAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Tue, 12 Mar 2024 15:48:36 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: daniel@ffwll.ch,
	airlied@gmail.com,
	deller@gmx.de,
	javierm@redhat.com
Cc: linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH 00/43] drm: Provide fbdev emulation per memory manager
Date: Tue, 12 Mar 2024 16:44:55 +0100
Message-ID: <20240312154834.26178-1-tzimmermann@suse.de>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-2.10 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com,gmx.de];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 RCPT_COUNT_SEVEN(0.00)[7];
	 MID_CONTAINS_FROM(1.00)[];
	 FREEMAIL_TO(0.00)[ffwll.ch,gmail.com,gmx.de,redhat.com];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Score: -2.10
X-Spam-Flag: NO

DRM provides 3 different memory managers with slightly different
characteristics: DMA-based, SHMEM-based and TTM. This effects fbdev
emulation as each requires different handling of mmap(). This series
reworks fbdev emualtion to provide an optimized emulation for each
of the memory managers.

Patch 1 fixes a minor bug in fbdev-generic.

Patches 2 to 8 implement fbdev-shmem, which is optimized for drivers
with SHMEM-based allocation. Patches 2 to 7 prepare deferred I/O to
support driver-custom page lookups. When the mmap'ed framebuffer sees
a pagefault, the deferred-I/O code can ask the graphics driver of the
page (instead of trying to detect it by itself). Using this hook,
patch 8 implements fbdev-shmem. The code is similar to fbdev-generic,
but does not require an additional shadow buffer for mmap(). Mmap'ed
pages are instead provided from the GEM buffer object. That saves a
few MiB of framebuffer memory and copying between the internal buffers.

Patches 9 to 20 convert SHMEM-based drivers to fbdev-shmem.

Patch 21 adds damage handling and deferred I/O to fbdev-dma. Such
code has been tested on the DMA-based omapdrm and can be adopted for
all drivers.

Patches 22 to 41 convert DMA-based drivers to fbdev-dma. These drivers
could not use it because of the missing support for damage handling.

Patch 42 renames fbdev-generic to fbdev-ttm. Only TTM-based drivers
still use it, so building it can be linked to TTM as well.

Patch 43 cleans up the documentation.

Tested with simpledrm, vc4 and amdgpu.

Thomas Zimmermann (43):
  drm/fbdev-generic: Do not set physical framebuffer address
  fbdev/deferred-io: Move pageref setup into separate helper
  fbdev/deferred-io: Clean up pageref on lastclose
  fbdev/deferred-io: Test screen_buffer for vmalloc'ed memory
  fbdev/deferred-io: Test smem_start for I/O memory
  fbdev/deferred-io: Always call get_page() for framebuffer pages
  fbdev/deferred-io: Provide get_page hook in struct fb_deferred_io
  drm/fbdev: Add fbdev-shmem
  drm/ast: Use fbdev-shmem
  drm/gud: Use fbdev-shmem
  drm/hyperv: Use fbdev-shmem
  drm/mgag200: Use fbdev-shmem
  drm/solomon: Use fbdev-shmem
  drm/tiny/cirrus: Use fbdev-shmem
  drm/tiny/gm12u320: Use fbdev-shmem
  drm/tiny/ofdrm: Use fbdev-shmem
  drm/tiny/simpledrm: Use fbdev-shmem
  drm/udl: Use fbdev-shmem
  drm/virtio: Use fbdev-shmem
  drm/vkms: Use fbdev-shmem
  drm/fbdev-dma: Implement damage handling and deferred I/O
  drm/arm/komeda: Use fbdev-dma
  drm/hisilicon/kirin: Use fbdev-dma
  drm/imx/lcdc: Use fbdev-dma
  drm/ingenic: Use fbdev-dma
  drm/mediatek: Use fbdev-dma
  drm/panel/panel-ilitek-9341: Use fbdev-dma
  drm/renesas/rcar-du: Use fbdev-dma
  drm/renesas/rz-du: Use fbdev-dma
  drm/renesas/shmobile: Use fbdev-dma
  drm/rockchip: Use fbdev-dma
  drm/tiny/hx8357d: Use fbdev-dma
  drm/tiny/ili9163: Use fbdev-dma
  drm/tiny/ili9225: Use fbdev-dma
  drm/tiny/ili9341: Use fbdev-dma
  drm/tiny/ili9486: Use fbdev-dma
  drm/tiny/mi0283qt: Use fbdev-dma
  drm/tiny/panel-mipi-dbi: Use fbdev-dma
  drm/tiny/repaper: Use fbdev-dma
  drm/tiny/st7586: Use fbdev-dma
  drm/tiny/st7735r: Use fbdev-dma
  drm/fbdev-generic: Convert to fbdev-ttm
  drm/fbdev: Clean up fbdev documentation

 Documentation/gpu/drm-kms-helpers.rst         |  12 +-
 Documentation/gpu/todo.rst                    |  13 -
 drivers/gpu/drm/Makefile                      |   6 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |   6 +-
 .../gpu/drm/arm/display/komeda/komeda_drv.c   |   4 +-
 drivers/gpu/drm/ast/ast_drv.c                 |   4 +-
 drivers/gpu/drm/drm_drv.c                     |   2 +-
 drivers/gpu/drm/drm_fb_helper.c               |  11 +-
 drivers/gpu/drm/drm_fbdev_dma.c               |  65 +++-
 drivers/gpu/drm/drm_fbdev_shmem.c             | 316 ++++++++++++++++++
 .../{drm_fbdev_generic.c => drm_fbdev_ttm.c}  |  81 +++--
 drivers/gpu/drm/gud/gud_drv.c                 |   4 +-
 .../gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c   |   4 +-
 .../gpu/drm/hisilicon/kirin/kirin_drm_drv.c   |   4 +-
 drivers/gpu/drm/hyperv/hyperv_drm_drv.c       |   4 +-
 drivers/gpu/drm/imx/lcdc/imx-lcdc.c           |   4 +-
 drivers/gpu/drm/ingenic/ingenic-drm-drv.c     |   4 +-
 drivers/gpu/drm/loongson/Kconfig              |   1 +
 drivers/gpu/drm/loongson/lsdc_drv.c           |   4 +-
 drivers/gpu/drm/mediatek/mtk_drm_drv.c        |   4 +-
 drivers/gpu/drm/mgag200/mgag200_drv.c         |   4 +-
 drivers/gpu/drm/nouveau/nouveau_drm.c         |   6 +-
 drivers/gpu/drm/panel/panel-ilitek-ili9341.c  |   4 +-
 drivers/gpu/drm/qxl/qxl_drv.c                 |   4 +-
 drivers/gpu/drm/renesas/rcar-du/rcar_du_drv.c |   4 +-
 drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.c  |   4 +-
 .../gpu/drm/renesas/shmobile/shmob_drm_drv.c  |   4 +-
 drivers/gpu/drm/rockchip/rockchip_drm_drv.c   |   4 +-
 drivers/gpu/drm/solomon/ssd130x.c             |   4 +-
 drivers/gpu/drm/tiny/bochs.c                  |   4 +-
 drivers/gpu/drm/tiny/cirrus.c                 |   4 +-
 drivers/gpu/drm/tiny/gm12u320.c               |   4 +-
 drivers/gpu/drm/tiny/hx8357d.c                |   4 +-
 drivers/gpu/drm/tiny/ili9163.c                |   4 +-
 drivers/gpu/drm/tiny/ili9225.c                |   4 +-
 drivers/gpu/drm/tiny/ili9341.c                |   4 +-
 drivers/gpu/drm/tiny/ili9486.c                |   4 +-
 drivers/gpu/drm/tiny/mi0283qt.c               |   4 +-
 drivers/gpu/drm/tiny/ofdrm.c                  |   4 +-
 drivers/gpu/drm/tiny/panel-mipi-dbi.c         |   4 +-
 drivers/gpu/drm/tiny/repaper.c                |   4 +-
 drivers/gpu/drm/tiny/simpledrm.c              |   4 +-
 drivers/gpu/drm/tiny/st7586.c                 |   4 +-
 drivers/gpu/drm/tiny/st7735r.c                |   4 +-
 drivers/gpu/drm/udl/udl_drv.c                 |   4 +-
 drivers/gpu/drm/vboxvideo/vbox_drv.c          |   4 +-
 drivers/gpu/drm/virtio/virtgpu_drv.c          |   4 +-
 drivers/gpu/drm/vkms/vkms_drv.c               |   4 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_drv.c           |   4 +-
 drivers/video/fbdev/core/fb_defio.c           |  82 +++--
 include/drm/drm_fbdev_generic.h               |  15 -
 include/drm/drm_fbdev_shmem.h                 |  15 +
 include/drm/drm_fbdev_ttm.h                   |  15 +
 include/drm/drm_mode_config.h                 |   4 +-
 include/linux/fb.h                            |   1 +
 55 files changed, 593 insertions(+), 210 deletions(-)
 create mode 100644 drivers/gpu/drm/drm_fbdev_shmem.c
 rename drivers/gpu/drm/{drm_fbdev_generic.c => drm_fbdev_ttm.c} (76%)
 delete mode 100644 include/drm/drm_fbdev_generic.h
 create mode 100644 include/drm/drm_fbdev_shmem.h
 create mode 100644 include/drm/drm_fbdev_ttm.h

-- 
2.44.0

