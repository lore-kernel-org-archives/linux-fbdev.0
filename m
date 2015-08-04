From: Julien Grall <julien.grall@citrix.com>
Date: Tue, 04 Aug 2015 18:12:44 +0000
Subject: [PATCH v2 0/8] Use correctly the Xen memory terminologies in Linux
Message-Id: <1438711972-18752-1-git-send-email-julien.grall@citrix.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: xen-devel@lists.xenproject.org
Cc: linux-fbdev@vger.kernel.org, x86@kernel.org, netdev@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Jiri Slaby <jslaby@suse.com>, Thomas Gleixner <tglx@linutronix.de>, Russell King <linux@arm.linux.org.uk>, linux-scsi@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@ti.com>, stefano.stabellini@eu.citrix.com, Ingo Molnar <mingo@redhat.com>, linux-input@vger.kernel.org, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, ian.campbell@citrix.com, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, "James E.J. Bottomley" <JBottomley@odin.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, linux-arm-kernel@lists.infradead.org, Juergen Gross <jgross@suse.com>, Wei Liu <wei.liu2@citrix.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-kernel@vger.kernel.org, Julien Grall <julien.grall@citrix.com>, David Vrabel <david.v>

Hi all,

This patch series aims to use the memory terminologies described in
include/xen/mm.h [1] for Linux xen code.

Linux is using mistakenly MFN when GFN is meant, I suspect this is because =
the
first support of Xen was for PV. This has brought some misimplementation
of memory helpers on ARM and make the developper confused about the expected
behavior.

For instance, with pfn_to_mfn, we expect to get a MFN based on the name.
Although, if we look at the implementation on x86, it's returning a GFN.
Most of the callers are also using it this way.

The first 2 patches of this series is ARM related in order to remove
PV specific helpers which should not be used and fixing the implementation =
of
pfn_to_mfn.

The rest of the series is here rename most of the usage in the common code
of MFN to GFN. I also took the opportunity to replace most of the call to
pfn_to_gfn in the common code by page_to_gfn avoid construction such
as pfn_to_gfn(page_to_pfn(...).

Note the one xen-blkfront will be dropped by 64K series [2], I can include =
it
if necessary.

Major changes in v2:
    - Use bfn rather than dfn for the DMA address
    - Re-introduced pfn_to_mfn for PV guests only
    - Typoes

For all the changes see in each patch.

This series is based on linus's branch. A branch with all the patches
can be found here:
    git://xenbits.xen.org/people/julieng/linux-arm.git branch page-renaming=
-v2

It was been boot tested on ARM64 and only built for x86 and ARM32.
I would be happy if someone can give a try on x86 as I don't have a x86
box setup with Xen.

Sincerely yours,

[1] http://xenbits.xen.org/gitweb/?p=3Dxen.git;a=3Dcommitdiff;h=E758ed14f39=
0342513405dd766e874934573e6cb
[2] https://lkml.org/lkml/2015/7/9/628

Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: David Vrabel <david.vrabel@citrix.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ian Campbell <ian.campbell@citrix.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: "James E.J. Bottomley" <JBottomley@odin.com>
Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
Cc: Jiri Slaby <jslaby@suse.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: linux-api@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-fbdev@vger.kernel.org
Cc: linux-input@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org
Cc: linux-scsi@vger.kernel.org
Cc: netdev@vger.kernel.org
Cc: "Roger Pau Monn=C3=A9" <roger.pau@citrix.com>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Wei Liu <wei.liu2@citrix.com>
Cc: x86@kernel.org

Julien Grall (8):
  arm/xen: Remove helpers which are PV specific
  xen: Make clear that swiotlb and biomerge are dealing with DMA address
  arm/xen: implement correctly pfn_to_mfn
  xen: Use the correctly the Xen memory terminologies
  xen/tmem: Use page_to_gfn rather than pfn_to_gfn
  video/xen-fbfront: Further s/MFN/GFN clean-up
  hvc/xen: Further s/MFN/GFN clean-up
  xen/privcmd: Further s/MFN/GFN/ clean-up

 arch/arm/include/asm/xen/page.h         | 44 ++++++++++++++++-------------=
----
 arch/arm/xen/enlighten.c                | 18 +++++++-------
 arch/arm/xen/mm.c                       |  4 +--
 arch/x86/include/asm/xen/page.h         | 37 +++++++++++++++++++++------
 arch/x86/xen/mmu.c                      | 32 ++++++++++++------------
 arch/x86/xen/smp.c                      |  2 +-
 drivers/block/xen-blkfront.c            |  6 ++---
 drivers/input/misc/xen-kbdfront.c       |  4 +--
 drivers/net/xen-netback/netback.c       |  4 +--
 drivers/net/xen-netfront.c              |  8 +++---
 drivers/scsi/xen-scsifront.c            |  8 +++---
 drivers/tty/hvc/hvc_xen.c               | 18 ++++++--------
 drivers/video/fbdev/xen-fbfront.c       | 20 +++++++--------
 drivers/xen/balloon.c                   |  2 +-
 drivers/xen/biomerge.c                  |  6 ++---
 drivers/xen/events/events_base.c        |  2 +-
 drivers/xen/events/events_fifo.c        |  4 +--
 drivers/xen/gntalloc.c                  |  3 ++-
 drivers/xen/manage.c                    |  2 +-
 drivers/xen/privcmd.c                   | 44 ++++++++++++++++-------------=
----
 drivers/xen/swiotlb-xen.c               | 16 ++++++------
 drivers/xen/tmem.c                      | 21 ++++++----------
 drivers/xen/xenbus/xenbus_client.c      |  2 +-
 drivers/xen/xenbus/xenbus_dev_backend.c |  2 +-
 drivers/xen/xenbus/xenbus_probe.c       |  8 +++---
 drivers/xen/xlate_mmu.c                 | 18 +++++++-------
 include/uapi/xen/privcmd.h              |  4 +++
 include/xen/page.h                      |  4 +--
 include/xen/xen-ops.h                   | 10 ++++----
 29 files changed, 183 insertions(+), 170 deletions(-)

--=20
2.1.4

