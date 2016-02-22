From: Stephen Boyd <sboyd@codeaurora.org>
Date: Mon, 22 Feb 2016 20:54:38 +0000
Subject: [PATCH 0/9] Change return type of of_clk_get_parent_count() to unsigned
Message-Id: <1456174487-28397-1-git-send-email-sboyd@codeaurora.org>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>
Cc: linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, Boris Brezillon <boris.brezillon@free-electrons.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, uclinux-h8-devel@lists.sourceforge.jp, Gabriel Fernandez <gabriel.fernandez@st.com>, Maxime Ripard <maxime.ripard@free-electrons.com>, Chen-Yu Tsai <wens@csie.org>, Tero Kristo <t-kristo@ti.com>, Felipe Balbi <balbi@ti.com>, linux-usb@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-fbdev@vger.kernel.org

Russell King recently pointed out that of_clk_get_parent_count() can
return a negative number if the "clocks" property isn't present in a
node. Upon investigating all the callers of this API, none of the them
seem to care about that case, and furthermore some callers are assigning
the return value to an unsigned int which could cause very large numbers
of parents to be used.

This series changes the API to return an unsigned int from 0 (no parents)
to N, thereby avoiding any problems with negative return values.

Cc: Boris Brezillon <boris.brezillon@free-electrons.com>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: <uclinux-h8-devel@lists.sourceforge.jp>
Cc: Gabriel Fernandez <gabriel.fernandez@st.com>
Cc: Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: Chen-Yu Tsai <wens@csie.org> 
Cc: Tero Kristo <t-kristo@ti.com>
Cc: Felipe Balbi <balbi@ti.com>
Cc: <linux-usb@vger.kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>
Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: <linux-fbdev@vger.kernel.org>

Stephen Boyd (9):
  clk: Make of_clk_get_parent_count() return unsigned ints
  clk: at91: Remove impossible checks for of_clk_get_parent_count()
  clk: gpio: Remove impossible check for of_clk_get_parent_count() < 0
  clk: h8300: Remove impossible check for of_clk_get_parent_count()
  clk: st: Remove impossible check for of_clk_get_parent_count() < 0
  clk: sunxi: Use proper type for of_clk_get_parent_count() return value
  clk: ti: Update for of_clk_get_parent_count() returning unsigned int
  usb: dwc3: Remove impossible check for of_clk_get_parent_count() < 0
  simplefb: Remove impossible check for of_clk_get_parent_count() < 0

 drivers/clk/at91/clk-generated.c    |  4 ++--
 drivers/clk/at91/clk-main.c         |  4 ++--
 drivers/clk/at91/clk-master.c       |  4 ++--
 drivers/clk/at91/clk-programmable.c |  4 ++--
 drivers/clk/at91/clk-slow.c         |  6 +++---
 drivers/clk/at91/clk-smd.c          |  4 ++--
 drivers/clk/at91/clk-usb.c          |  4 ++--
 drivers/clk/clk-gpio.c              |  6 ++----
 drivers/clk/clk.c                   | 16 ++++++++++++++--
 drivers/clk/h8300/clk-div.c         |  4 ++--
 drivers/clk/h8300/clk-h8s2678.c     |  4 ++--
 drivers/clk/st/clk-flexgen.c        |  4 ++--
 drivers/clk/st/clkgen-mux.c         |  4 ++--
 drivers/clk/sunxi/clk-sun6i-ar100.c |  2 +-
 drivers/clk/ti/clockdomain.c        |  2 +-
 drivers/clk/ti/composite.c          |  8 ++++----
 drivers/clk/ti/dpll.c               |  2 +-
 drivers/clk/ti/mux.c                |  4 ++--
 drivers/usb/dwc3/dwc3-of-simple.c   |  9 +++++----
 drivers/video/fbdev/simplefb.c      |  4 ++--
 include/linux/clk-provider.h        |  2 +-
 21 files changed, 56 insertions(+), 45 deletions(-)

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

