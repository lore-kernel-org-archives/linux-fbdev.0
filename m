From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Wed, 03 Jan 2018 15:16:08 +0000
Subject: Re: [-next PATCH 2/4] treewide: Use DEVICE_ATTR_RW
Message-Id: <4624388.pPJCIclP0U@amdc3058>
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1513706701.git.joe@perches.com>
 <CGME20171219181536epcas2p18d023209dc13ac504457c07b8b2b8965@epcas2p1.samsung.com>
 <cd38f14f06e1f447b3159ffe8c69c0df8241bb6e.1513706701.git.joe@perches.com>
In-Reply-To: <cd38f14f06e1f447b3159ffe8c69c0df8241bb6e.1513706701.git.joe@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Joe Perches <joe@perches.com>
Cc: linux-fbdev@vger.kernel.org, David Airlie <airlied@linux.ie>, Heiko Carstens <heiko.carstens@de.ibm.com>, alsa-devel@alsa-project.org, dri-devel@lists.freedesktop.org, Jaroslav Kysela <perex@perex.cz>, Peter Ujfalusi <peter.ujfalusi@ti.com>, linux-s390@vger.kernel.org, linux-omap@vger.kernel.org, "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>, linux-scsi@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Sebastian Ott <sebott@linux.vnet.ibm.com>, James Smart <james.smart@broadcom.com>, Cezary Jackiewicz <cezary.jackiewicz@gmail.com>, linux-serial@vger.kernel.org, Jiri Slaby <jslaby@suse.com>, Darren Hart <dvhart@infradead.org>, Zhang Rui <rui.zhang@intel.com>, Dick Kennedy <dick.kennedy@broadcom.com>, Mathias Nyman <mathias.nyman@intel.com>, linux-pm@vger.kernel.org, Peter Oberparleiter <oberpar@linux.vnet.ibm.com>, intel-gfx@lists.freedesktop.org, Eduardo Valentin <edube>

On Tuesday, December 19, 2017 10:15:07 AM Joe Perches wrote:
> Convert DEVICE_ATTR uses to DEVICE_ATTR_RW where possible.
> 
> Done with perl script:
> 
> $ git grep -w --name-only DEVICE_ATTR | \
>   xargs perl -i -e 'local $/; while (<>) { s/\bDEVICE_ATTR\s*\(\s*(\w+)\s*,\s*\(?(\s*S_IRUGO\s*\|\s*S_IWUSR|\s*S_IWUSR\s*\|\s*S_IRUGO\s*|\s*0644\s*)\)?\s*,\s*\1_show\s*,\s*\1_store\s*\)/DEVICE_ATTR_RW(\1)/g; print;}'
> 
> Signed-off-by: Joe Perches <joe@perches.com>
> ---
>  arch/s390/kernel/topology.c          |  3 +--
>  arch/tile/kernel/sysfs.c             |  2 +-
>  drivers/gpu/drm/i915/i915_sysfs.c    |  6 ++---
>  drivers/platform/x86/compal-laptop.c | 18 +++++----------
>  drivers/s390/cio/device.c            |  2 +-
>  drivers/scsi/lpfc/lpfc_attr.c        | 43 ++++++++++++------------------------
>  drivers/thermal/thermal_sysfs.c      |  9 ++++----
>  drivers/tty/serial/sh-sci.c          |  2 +-
>  drivers/usb/host/xhci-dbgcap.c       |  2 +-
>  drivers/usb/phy/phy-tahvo.c          |  2 +-
>  drivers/video/fbdev/auo_k190x.c      |  4 ++--
>  drivers/video/fbdev/w100fb.c         |  4 ++--
>  lib/test_firmware.c                  | 14 +++++-------
>  lib/test_kmod.c                      | 14 +++++-------
>  sound/soc/omap/mcbsp.c               |  4 ++--
>  15 files changed, 49 insertions(+), 80 deletions(-)

For fbdev changes:

Acked-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

