From: gyungoh@gmail.com
Date: Wed, 07 Jan 2015 02:19:26 +0000
Subject: [PATCH v10 5/6] devicetree: Add vendor prefix for Skyworks Solutions, Inc.
Message-Id: <1420597167-3188-6-git-send-email-jack.yoo@skyworksinc.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1420597167-3188-1-git-send-email-jack.yoo@skyworksinc.com>
In-Reply-To: <1420597167-3188-1-git-send-email-jack.yoo@skyworksinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sameo@linux.intel.com, lee.jones@linaro.org, grant.likely@linaro.org, robh+dt@kernel.org, jg1.han@samsung.com, cooloney@gmail.com, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, trivial@kernel.org
Cc: akpm@linux-foundation.org, jic23@kernel.org, thomas.petazzoni@free-electrons.com, ktsai@capellamicro.com, hs@denx.de, stwiss.opensource@diasemi.com, matti.vaittinen@nsn.com, broonie@kernel.org, jason@lakedaemon.net, heiko@sntech.de, shawn.guo@freescale.com, florian.vaussard@epfl.ch, andrew@lunn.ch, antonynpavlov@gmail.com, hytszk@gmail.com, plagnioj@jcrosoft.com, tomi.valkeinen@ti.com, jack.yoo@skyworksinc.com, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org

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

