From: Siarhei Siamashka <siarhei.siamashka@gmail.com>
Date: Tue, 22 May 2012 19:54:03 +0000
Subject: [PATCH 1/2] ARM: pgtable: add pgprot_writethrough() macro
Message-Id: <1337716444-30139-2-git-send-email-siarhei.siamashka@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1337716444-30139-1-git-send-email-siarhei.siamashka@gmail.com>
In-Reply-To: <1337716444-30139-1-git-send-email-siarhei.siamashka@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Needed for remapping pages with write-through cacheable
attribute. May be useful for framebuffers.

Signed-off-by: Siarhei Siamashka <siarhei.siamashka@gmail.com>
---
 arch/arm/include/asm/pgtable.h |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/arm/include/asm/pgtable.h b/arch/arm/include/asm/pgtable.h
index f66626d..04297fa 100644
--- a/arch/arm/include/asm/pgtable.h
+++ b/arch/arm/include/asm/pgtable.h
@@ -103,6 +103,9 @@ extern pgprot_t		pgprot_kernel;
 #define pgprot_stronglyordered(prot) \
 	__pgprot_modify(prot, L_PTE_MT_MASK, L_PTE_MT_UNCACHED)
 
+#define pgprot_writethrough(prot) \
+	__pgprot_modify(prot, L_PTE_MT_MASK, L_PTE_MT_WRITETHROUGH)
+
 #ifdef CONFIG_ARM_DMA_MEM_BUFFERABLE
 #define pgprot_dmacoherent(prot) \
 	__pgprot_modify(prot, L_PTE_MT_MASK, L_PTE_MT_BUFFERABLE | L_PTE_XN)
-- 
1.7.3.4

