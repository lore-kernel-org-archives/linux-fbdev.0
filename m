From: Adam Borowski <kilobyte@angband.pl>
Date: Wed, 18 Jul 2018 03:01:52 +0000
Subject: [PATCH 0/6] vt: no blinking on console, 256/24-bit color improvements
Message-Id: <20180718030152.kdq53mwpdfusvwl5@angband.pl>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-console@vger.kernel.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hi!
Here's a patchset with two entangled improvements:

* it'd be good to get rid of blinking where possible.  Even CGA (thus VGA)
  allows disabling it, rendering such characters with a bright background
  instead.
* due to my error, 256-color mode uses a much darker palette for conversion,
  resulting in behaving inconsistently with 24-bit mode.

The new code uses bright backgrounds when possible, enabled with \e[100m or
\e[48;m.

Despite the whole idea following a VGA capability, this patchset doesn't
change vgacon yet, just fbcon.  The reason being: ~80% of x86 users have an
nVidia chip, which means nouveau or nvidia-proprietary.  Nouveau implies
fbcon, nvidia-proprietary fails to properly restore text flags (as evidenced
by 512 glyph mode turning to 256 on switch from graphics).  You don't care
about the proprietary driver, but let's not break it pointlessly, and as
both nVidia cards I own work only with nouveau, I don't want to touch what I
can't test.

Thus, let's enable unblinking on fbcon for now.  We can flip that bit (in
register 0x10) later.

This fixes the display of catimg and similar tools.


Diffstat:
 drivers/tty/vt/vt.c              | 56 +++++++++++++++++++++++++++++---------------------------
 drivers/video/fbdev/core/fbcon.c |  1 +
 include/linux/console_struct.h   |  4 ++--
 3 files changed, 32 insertions(+), 29 deletions(-)

-- 
⢀⣴⠾⠻⢶⣦⠀ 
⣾⠁⢠⠒⠀⣿⡁ A dumb species has no way to open a tuna can.
⢿⡄⠘⠷⠚⠋⠀ A smart species invents a can opener.
⠈⠳⣄⠀⠀⠀⠀ A master species delegates.
