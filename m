From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Date: Fri, 20 Mar 2015 23:18:02 +0000
Subject: [PATCH v1 12/47] IB/qib: use arch_phys_wc_add()
Message-Id: <1426893517-2511-13-git-send-email-mcgrof@do-not-panic.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1426893517-2511-1-git-send-email-mcgrof@do-not-panic.com>
In-Reply-To: <1426893517-2511-1-git-send-email-mcgrof@do-not-panic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: luto@amacapital.net, mingo@redhat.com, tglx@linutronix.de, hpa@zytor.com, jgross@suse.com, JBeulich@suse.com, bp@suse.de, suresh.b.siddha@intel.com, venkatesh.pallipadi@intel.com, airlied@redhat.com
Cc: linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, x86@kernel.org, xen-devel@lists.xenproject.org, "Luis R. Rodriguez" <mcgrof@suse.com>, Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>, Dennis Dalessandro <dennis.dalessandro@intel.com>, Mike Marciniszyn <mike.marciniszyn@intel.com>, Roland Dreier <roland@purestorage.com>, Ingo Molnar <mingo@elte.hu>, Daniel Vetter <daniel.vetter@ffwll.ch>, Bjorn Helgaas <bhelgaas@google.com>, Antonino Daplas <adaplas@gmail.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Dave Hansen <dave.hansen@linux.intel.com>, Arnd Bergmann <arnd@arndb.de>, "Michael S. Tsirkin" <mst@redhat.com>, Stefan Bader <stefan.bader@canonical.com>, konrad.wilk@oracle.com, ville.syrjala@linux.intel.com, david.vrabel@citrix.com, jbeulich@suse.com, toshi.kani@hp.com, =?UTF-8?q?Roger=20Pau=20Monn=C3=A9?= <roger.pau@citrix.com>, xen-devel@lists.xensource.com

From: "Luis R. Rodriguez" <mcgrof@suse.com>

This driver already makes use of ioremap_wc() on PIO buffers,
so convert it to use arch_phys_wc_add().

Cc: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
Cc: Dennis Dalessandro <dennis.dalessandro@intel.com>
Cc: Mike Marciniszyn <mike.marciniszyn@intel.com>
Cc: Roland Dreier <roland@purestorage.com>
Cc: Andy Lutomirski <luto@amacapital.net>
Cc: Suresh Siddha <suresh.b.siddha@intel.com>
Cc: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
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

