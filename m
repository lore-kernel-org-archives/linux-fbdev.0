From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Fri, 22 Jun 2018 07:52:48 +0000
Subject: [PATCH v2 0/2] efi: add support for cacheable efifb mappings
Message-Id: <20180622075250.14075-1-ard.biesheuvel@linaro.org>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

KVM guests on ARM have special requirements when it comes to mapping
framebuffers: given that the host [emulating the framebuffer] uses
cacheable accesses to read from the framebuffer region, the guest
should uses cacheable accesses as well, or coherency is lost, i.e.,
the host does not see what the guest writes.

Modifying PCI drivers to take this into account just for KVM on ARM is
unreasonable, given that mapping BARs cacheable and still expecting
side effects does not make any sense. However, doing the same for
regions of system memory does make sense, since a framebuffer in DRAM
could be accessed via DMA by a coherent master, and so it makes sense
to take the memory attributes described by the UEFI memory map into
account if it covers the efifb region.

Patch #2 implements this. Patch #1 is a preparatory patch that makes
efi_mem_desc_lookup() usable for us in #2.

Changes since v1:
- fix Peter's email address in CC tag (#1)
- add Laszlo's tested-by

Bartlomiej, could we please take this through the EFI tree? (with your ack)

Cc: linux-fbdev@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Peter Jones <pjones@redhat.com>

Ard Biesheuvel (2):
  efi: drop type and attribute checks in efi_mem_desc_lookup()
  fbdev/efifb: honour UEFI memory map attributes when mapping the fb

 arch/x86/platform/efi/quirks.c |  3 +-
 drivers/firmware/efi/efi.c     |  8 +--
 drivers/firmware/efi/esrt.c    |  5 +-
 drivers/video/fbdev/efifb.c    | 52 ++++++++++++++++----
 4 files changed, 49 insertions(+), 19 deletions(-)

-- 
2.17.1

