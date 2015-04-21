From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Date: Tue, 21 Apr 2015 20:37:55 +0000
Subject: [PATCH v3 2/3] IB/qib: use arch_phys_wc_add()
Message-Id: <1429648676-17755-3-git-send-email-mcgrof@do-not-panic.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1429648676-17755-1-git-send-email-mcgrof@do-not-panic.com>
In-Reply-To: <1429648676-17755-1-git-send-email-mcgrof@do-not-panic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: cocci@systeme.lip6.fr

From: "Luis R. Rodriguez" <mcgrof@suse.com>

This driver already makes use of ioremap_wc() on PIO buffers,
so convert it to use arch_phys_wc_add().

Cc: Toshi Kani <toshi.kani@hp.com>
Cc: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
Cc: Mike Marciniszyn <mike.marciniszyn@intel.com>
Cc: Roland Dreier <roland@purestorage.com>
Cc: Sean Hefty <sean.hefty@intel.com>
Cc: Hal Rosenstock <hal.rosenstock@gmail.com>
Cc: Dennis Dalessandro <dennis.dalessandro@intel.com>
Cc: Andy Lutomirski <luto@amacapital.net>
Cc: Suresh Siddha <sbsiddha@gmail.com>
Cc: Ingo Molnar <mingo@elte.hu>
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
Cc: Stefan Bader <stefan.bader@canonical.com>
Cc: konrad.wilk@oracle.com
Cc: ville.syrjala@linux.intel.com
Cc: david.vrabel@citrix.com
Cc: jbeulich@suse.com
Cc: Roger Pau Monn=C3=A9 <roger.pau@citrix.com>
Cc: infinipath@intel.com
Cc: linux-rdma@vger.kernel.org
Cc: linux-fbdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: xen-devel@lists.xensource.com
Signed-off-by: Luis R. Rodriguez <mcgrof@suse.com>
---
 drivers/infiniband/hw/qib/qib_wc_x86_64.c | 31 ++++-----------------------=
----
 1 file changed, 4 insertions(+), 27 deletions(-)

diff --git a/drivers/infiniband/hw/qib/qib_wc_x86_64.c b/drivers/infiniband=
/hw/qib/qib_wc_x86_64.c
index fe0850a..6d61ef9 100644
--- a/drivers/infiniband/hw/qib/qib_wc_x86_64.c
+++ b/drivers/infiniband/hw/qib/qib_wc_x86_64.c
@@ -116,21 +116,9 @@ int qib_enable_wc(struct qib_devdata *dd)
 	}
=20
 	if (!ret) {
-		int cookie;
-
-		cookie =3D mtrr_add(pioaddr, piolen, MTRR_TYPE_WRCOMB, 1);
-		if (cookie < 0) {
-			{
-				qib_devinfo(dd->pcidev,
-					 "mtrr_add()  WC for PIO bufs failed (%d)\n",
-					 cookie);
-				ret =3D -EINVAL;
-			}
-		} else {
-			dd->wc_cookie =3D cookie;
-			dd->wc_base =3D (unsigned long) pioaddr;
-			dd->wc_len =3D (unsigned long) piolen;
-		}
+		dd->wc_cookie =3D arch_phys_wc_add(pioaddr, piolen);
+		if (dd->wc_cookie < 0)
+			ret =3D -EINVAL;
 	}
=20
 	return ret;
@@ -142,18 +130,7 @@ int qib_enable_wc(struct qib_devdata *dd)
  */
 void qib_disable_wc(struct qib_devdata *dd)
 {
-	if (dd->wc_cookie) {
-		int r;
-
-		r =3D mtrr_del(dd->wc_cookie, dd->wc_base,
-			     dd->wc_len);
-		if (r < 0)
-			qib_devinfo(dd->pcidev,
-				 "mtrr_del(%lx, %lx, %lx) failed: %d\n",
-				 dd->wc_cookie, dd->wc_base,
-				 dd->wc_len, r);
-		dd->wc_cookie =3D 0; /* even on failure */
-	}
+	arch_phys_wc_del(dd->wc_cookie);
 }
=20
 /**
--=20
2.3.2.209.gd67f9d5.dirty

