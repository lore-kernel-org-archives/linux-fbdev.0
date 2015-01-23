From: gyungoh@gmail.com
Date: Fri, 23 Jan 2015 06:28:34 +0000
Subject: [PATCH v10 5/6] devicetree: Add vendor prefix for Skyworks Solutions, Inc.
Message-Id: <1421994515-3070-6-git-send-email-jack.yoo@skyworksinc.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1421994515-3070-1-git-send-email-jack.yoo@skyworksinc.com>
In-Reply-To: <1421994515-3070-1-git-send-email-jack.yoo-tjhQNA90jdKqndwCJWfcng@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, cooloney-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, trivial-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Cc: akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, ktsai-GubuWUlQtMwciDkP5Hr2oA@public.gmane.org, hs-ynQEQJNshbs@public.gmane.org, stwiss.opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org, matti.vaittinen-OYasijW0DpE@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org, heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org, shawn.guo-KZfg59tc24xl57MIdRCFDg@public.gmane.org, florian.vaussard-p8DiymsW2f8@public.gmane.org, andrew-g2DYL2Zd6BY@public.gmane.org, antonynpavlov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, hytszk-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org, tomi.valkeinen-l0cyMroinI0@public.gmane.org, jack.yoo-tjhQNA90jdKqndwCJWfcng@public.gmane.org, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

From: Gyungoh Yoo <jack.yoo@skyworksinc.com>

Signed-off-by: Gyungoh Yoo <jack.yoo@skyworksinc.com>
Acked-by: Lee Jones <lee.jones@linaro.org>
---
Changes v10:
Nothing

Changes v9:
Nothing

Changes v8:
Nothing

Changes v7:
Nothing

Changes v6:
Nothing

Changes v5:
Nothing

Changes v4:
Nothing

Changes v3:
Nothing

Changes v2:
Added vendor prefix for Skyworks Solutions, Inc.

 Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index a344ec2..68143f0 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -140,6 +140,7 @@ sii	Seiko Instruments, Inc.
 silergy	Silergy Corp.
 sirf	SiRF Technology, Inc.
 sitronix	Sitronix Technology Corporation
+skyworks	Skyworks Solutions, Inc.
 smsc	Standard Microsystems Corporation
 snps	Synopsys, Inc.
 solidrun	SolidRun
-- 
1.9.1

