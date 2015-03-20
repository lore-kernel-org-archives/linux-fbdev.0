From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Date: Fri, 20 Mar 2015 23:18:04 +0000
Subject: [PATCH v1 14/47] IB/ipath: use __arch_phys_wc_add()
Message-Id: <1426893517-2511-15-git-send-email-mcgrof@do-not-panic.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1426893517-2511-1-git-send-email-mcgrof@do-not-panic.com>
In-Reply-To: <1426893517-2511-1-git-send-email-mcgrof@do-not-panic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: luto@amacapital.net, mingo@redhat.com, tglx@linutronix.de, hpa@zytor.com, jgross@suse.com, JBeulich@suse.com, bp@suse.de, suresh.b.siddha@intel.com, venkatesh.pallipadi@intel.com, airlied@redhat.com
Cc: linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, x86@kernel.org, xen-devel@lists.xenproject.org, "Luis R. Rodriguez" <mcgrof@suse.com>, Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>, Mike Marciniszyn <mike.marciniszyn@intel.com>, Roland Dreier <roland@purestorage.com>, Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@linux-foundation.org>, Daniel Vetter <daniel.vetter@ffwll.ch>, Bjorn Helgaas <bhelgaas@google.com>, Antonino Daplas <adaplas@gmail.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Dave Hansen <dave.hansen@linux.intel.com>, Arnd Bergmann <arnd@arndb.de>, "Michael S. Tsirkin" <mst@redhat.com>, Stefan Bader <stefan.bader@canonical.com>, konrad.wilk@oracle.com, ville.syrjala@linux.intel.com, david.vrabel@citrix.com, jbeulich@suse.com, toshi.kani@hp.com, =?UTF-8?q?Roger=20Pau=20Monn=C3=A9?= <roger.pau@citrix.com>, xen-devel@lists.xensource.com

From: "Luis R. Rodriguez" <mcgrof@suse.com>

This driver sadly does not have the MMIO registers and WC
desired areas (PIO buffers in this case) properly split up
and addressing a split is considerable work, as such this
such requires using the __arch_phys_wc_add() call to
ensure write combining is enforced using MTRR on x86
even when PAT is available.

Cc: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
Cc: Mike Marciniszyn <mike.marciniszyn@intel.com>
Cc: Roland Dreier <roland@purestorage.com>
Cc: Andy Lutomirski <luto@amacapital.net>
Cc: Suresh Siddha <suresh.b.siddha@intel.com>
Cc: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
Cc: Ingo Molnar <mingo@elte.hu>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Juergen Gross <jgross@suse.com>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: Dave Airlie <airlied@redhat.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Antonino Daplas <adaplas@gmail.com>
Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: venkatesh.pallipadi@intel.com
Cc: Stefan Bader <stefan.bader@canonical.com>
Cc: konrad.wilk@oracle.com
Cc: ville.syrjala@linux.intel.com
Cc: david.vrabel@citrix.com
Cc: jbeulich@suse.com
Cc: toshi.kani@hp.com
Cc: Roger Pau Monn=C3=A9 <roger.pau@citrix.com>
Cc: linux-fbdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: xen-devel@lists.xensource.com
Signed-off-by: Luis R. Rodriguez <mcgrof@suse.com>
---
 drivers/infiniband/hw/ipath/ipath_driver.c    |  7 ++--
 drivers/infiniband/hw/ipath/ipath_kernel.h    |  4 +--
 drivers/infiniband/hw/ipath/ipath_wc_x86_64.c | 47 ++++++++++-------------=
----
 3 files changed, 20 insertions(+), 38 deletions(-)

diff --git a/drivers/infiniband/hw/ipath/ipath_driver.c b/drivers/infiniban=
d/hw/ipath/ipath_driver.c
index bd0caed..464f39c 100644
--- a/drivers/infiniband/hw/ipath/ipath_driver.c
+++ b/drivers/infiniband/hw/ipath/ipath_driver.c
@@ -542,6 +542,7 @@ static int ipath_init_one(struct pci_dev *pdev, const s=
truct pci_device_id *ent)
 	dd->ipath_kregbase =3D __ioremap(addr, len,
 		(_PAGE_NO_CACHE|_PAGE_WRITETHRU));
 #else
+	/* XXX: split pio on a separate ioremap_wc() */
 	dd->ipath_kregbase =3D ioremap_nocache(addr, len);
 #endif
=20
@@ -587,12 +588,8 @@ static int ipath_init_one(struct pci_dev *pdev, const =
struct pci_device_id *ent)
=20
 	ret =3D ipath_enable_wc(dd);
=20
-	if (ret) {
-		ipath_dev_err(dd, "Write combining not enabled "
-			      "(err %d): performance may be poor\n",
-			      -ret);
+	if (ret)
 		ret =3D 0;
-	}
=20
 	ipath_verify_pioperf(dd);
=20
diff --git a/drivers/infiniband/hw/ipath/ipath_kernel.h b/drivers/infiniban=
d/hw/ipath/ipath_kernel.h
index e08db70..f0f9471 100644
--- a/drivers/infiniband/hw/ipath/ipath_kernel.h
+++ b/drivers/infiniband/hw/ipath/ipath_kernel.h
@@ -463,9 +463,7 @@ struct ipath_devdata {
 	/* offset in HT config space of slave/primary interface block */
 	u8 ipath_ht_slave_off;
 	/* for write combining settings */
-	unsigned long ipath_wc_cookie;
-	unsigned long ipath_wc_base;
-	unsigned long ipath_wc_len;
+	int wc_cookie;
 	/* ref count for each pkey */
 	atomic_t ipath_pkeyrefs[4];
 	/* shadow copy of struct page *'s for exp tid pages */
diff --git a/drivers/infiniband/hw/ipath/ipath_wc_x86_64.c b/drivers/infini=
band/hw/ipath/ipath_wc_x86_64.c
index 70c1f3a..88709c1 100644
--- a/drivers/infiniband/hw/ipath/ipath_wc_x86_64.c
+++ b/drivers/infiniband/hw/ipath/ipath_wc_x86_64.c
@@ -37,7 +37,6 @@
  */
=20
 #include <linux/pci.h>
-#include <asm/mtrr.h>
 #include <asm/processor.h>
=20
 #include "ipath_kernel.h"
@@ -122,27 +121,26 @@ int ipath_enable_wc(struct ipath_devdata *dd)
 	}
=20
 	if (!ret) {
-		int cookie;
 		ipath_cdbg(VERBOSE, "Setting mtrr for chip to WC "
 			   "(addr %llx, len=3D0x%llx)\n",
 			   (unsigned long long) pioaddr,
 			   (unsigned long long) piolen);
-		cookie =3D mtrr_add(pioaddr, piolen, MTRR_TYPE_WRCOMB, 1);
-		if (cookie < 0) {
-			{
-				dev_info(&dd->pcidev->dev,
-					 "mtrr_add()  WC for PIO bufs "
-					 "failed (%d)\n",
-					 cookie);
-				ret =3D -EINVAL;
-			}
-		} else {
-			ipath_cdbg(VERBOSE, "Set mtrr for chip to WC, "
-				   "cookie is %d\n", cookie);
-			dd->ipath_wc_cookie =3D cookie;
-			dd->ipath_wc_base =3D (unsigned long) pioaddr;
-			dd->ipath_wc_len =3D (unsigned long) piolen;
-		}
+		dd->wc_cookie =3D __arch_phys_wc_add(pioaddr, piolen);
+		if (dd->wc_cookie <=3D 0) {
+				/*
+				 * If MTRR is not available on an architecture
+				 * or if it could not be enabled at run time
+				 * folks who care should work towards the
+				 * ioremap_wc() split.
+				 */
+				if (!dd->wc_cookie)
+					ipath_dev_err(dd, "System does not support MTRR\n");
+				else {
+					ipath_dev_err(dd, "Seting mtrr failed on PIO buffers\n");
+					ret =3D -EINVAL;
+				}
+		} else
+			ipath_cdbg(VERBOSE, "Set mtrr for chip to WC\n");
 	}
=20
 	return ret;
@@ -154,16 +152,5 @@ int ipath_enable_wc(struct ipath_devdata *dd)
  */
 void ipath_disable_wc(struct ipath_devdata *dd)
 {
-	if (dd->ipath_wc_cookie) {
-		int r;
-		ipath_cdbg(VERBOSE, "undoing WCCOMB on pio buffers\n");
-		r =3D mtrr_del(dd->ipath_wc_cookie, dd->ipath_wc_base,
-			     dd->ipath_wc_len);
-		if (r < 0)
-			dev_info(&dd->pcidev->dev,
-				 "mtrr_del(%lx, %lx, %lx) failed: %d\n",
-				 dd->ipath_wc_cookie, dd->ipath_wc_base,
-				 dd->ipath_wc_len, r);
-		dd->ipath_wc_cookie =3D 0; /* even on failure */
-	}
+	arch_phys_wc_del(dd->wc_cookie);
 }
--=20
2.3.2.209.gd67f9d5.dirty

