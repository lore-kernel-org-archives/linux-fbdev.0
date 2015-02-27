From: gyungoh@gmail.com
Date: Fri, 27 Feb 2015 06:42:26 +0000
Subject: [PATCH v11 6/6] devicetree: Add SKY81452 to the Trivial Devices list
Message-Id: <1425019346-4559-7-git-send-email-jack.yoo@skyworksinc.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1425019346-4559-1-git-send-email-jack.yoo@skyworksinc.com>
In-Reply-To: <1425019346-4559-1-git-send-email-jack.yoo@skyworksinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sameo@linux.intel.com, lee.jones@linaro.org, robh+dt@kernel.org, jg1.han@samsung.com, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, trivial@kernel.org
Cc: broonie@kernel.org, florian.vaussard@epfl.ch, andrew@lunn.ch, antonynpavlov@gmail.com, hytszk@gmail.com, plagnioj@jcrosoft.com, tomi.valkeinen@ti.com, jack.yoo@skyworksinc.com, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, treding@nvidia.com, p.zabel@pengutronix.de, arno@natisbad.org, kuninori.morimoto.gx@renesas.com

From: Gyungoh Yoo <jack.yoo@skyworksinc.com>

Signed-off-by: Gyungoh Yoo <jack.yoo@skyworksinc.com>
---
Changes v11:
Nothing

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
Add SKY81452 to the Trivial Devices list

 Documentation/devicetree/bindings/i2c/trivial-devices.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/i2c/trivial-devices.txt b/Documentation/devicetree/bindings/i2c/trivial-devices.txt
index aaa8325..003bd77 100644
--- a/Documentation/devicetree/bindings/i2c/trivial-devices.txt
+++ b/Documentation/devicetree/bindings/i2c/trivial-devices.txt
@@ -89,6 +89,7 @@ ricoh,rv5c386		I2C bus SERIAL INTERFACE REAL-TIME CLOCK IC
 ricoh,rv5c387a		I2C bus SERIAL INTERFACE REAL-TIME CLOCK IC
 samsung,24ad0xd1	S524AD0XF1 (128K/256K-bit Serial EEPROM for Low Power)
 sii,s35390a		2-wire CMOS real-time clock
+skyworks,sky81452	Skyworks SKY81452: Six-Channel White LED Driver with Touch Panel Bias Supply
 st-micro,24c256		i2c serial eeprom  (24cxx)
 stm,m41t00		Serial Access TIMEKEEPER
 stm,m41t62		Serial real-time clock (RTC) with alarm
-- 
1.9.1

