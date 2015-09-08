From: Olliver Schinagl <o.schinagl@ultimaker.com>
Date: Tue, 08 Sep 2015 19:19:49 +0000
Subject: [PATCH 0/2] SSD1307fb updates
Message-Id: <1441739991-4676-1-git-send-email-o.schinagl@ultimaker.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Olliver Schinagl <oliver-dxLnbx3+1qmEVqv0pETR8A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Jean-Christophe Plagniol-Villard <plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org>
Cc: Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>, =?UTF-8?q?Thomas=20Niederpr=C3=BCm?= <niederp-PRwTpj6vllL6m1q2wEL4bg@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Prabhakar Lad <prabhakar.csengg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Olliver Schinagl <o.schinagl-U3FVU11NWA554TAoqtyWWQ@public.gmane.org>

Having a few ssd1309 128x64 OLED displays laying around, I added support for it to the existing 1307fb driver. While doing this I noticed the headers where out of order so I fixed those as well.

For this specific display, the following can be used in a i2c node for example.

	ssd1309: oled@3c {
		compatible = "solomon,ssd1309fb-i2c";
		pinctrl-names = "default";
		pinctrl-0 = <&oled_pins>;
		reg = <0x3c>;
		reset-gpios = <&pio 8 13 GPIO_ACTIVE_HIGH>;
		solomon,width = <128>;
		solomon,height = <64>;
		solomon,com-invdir;
		solomon,page-offset = <0>;
		solomon,prechargep1 = <2>;
		solomon,prechargep2 = <8>;
	};

Olliver Schinagl (2):
  fbdev: ssd1307fb: alphabetize headers
  fbdev: ssd1307fb: add ssd1309 support

 .../devicetree/bindings/video/ssd1307fb.txt         |  3 ++-
 drivers/video/fbdev/ssd1307fb.c                     | 21 ++++++++++++++++-----
 2 files changed, 18 insertions(+), 6 deletions(-)

-- 
2.1.4

