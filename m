From: Maxime Ripard <maxime.ripard@free-electrons.com>
Date: Wed, 05 Sep 2012 09:35:31 +0000
Subject: [PATCHv4] Add support for the OLED in the CFA10036
Message-Id: <1346837733-7264-1-git-send-email-maxime.ripard@free-electrons.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi everyone,

This patchset adds support for the solomon SSD1307 OLED controller present
in the CFA-10036 board.

It first adds the framebuffer driver for this controller, and then the
needed bits to enable it in the cfa10036 dts.

Considering that the driver has been around since almost two months now, and
I have not received any comments on the framebuffer part, I'd very much like it
to be included in 3.7 if possible.

Thanks,
Maxime

Changes from v3:
  * Changed the dt property name to remove the leading oled- and changed the
    reset-gpio property to reset-gpios

Changes from v2:
  * Add the pin name as comment to the pwm4 pinctrl declaration
  * Change slightly the documentation of the dt bindings for the gpios to remove
    the mxs-specific cell.

Changes from v1:
  * Did some factorisation of the ssd1307fb_write* functions.
  * Filled the smem_start field of the fb_fix_screeninfo structure
  * Fixed the broken pwm declaration
  * Change the names of oled-reset-gpios and reset-active-low properties in the
    device tree to oled-reset-gpio and oled-reset-active-low for consistency

