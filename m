From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH] More radeonfb fixes
Date: 11 Apr 2003 14:03:13 +0200
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <1050062592.562.14.camel@zion.wanadoo.fr>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
To: linux-kernel mailing list <linux-kernel@vger.kernel.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

Here's a new patch against 2.4.20 and 2.4.21-pre7 which brings more
fixes to radeonfb:

- Fix the M6 video RAM workaround
- Some bits in the PM code were flipped, fix that.
- RB2D_DSTCACHE_MODE shouldn't be cleared on r300 (and
  maybe not on others according to a comment in XFree, but
  we keep working code for now).
- Re-change the pitch workaround. We now align the pitch
  when accel is enabled for a given mode, and we don't when
  accel is disabled. That should properly deal with all cases
  and allows us to remove the "special case" accel code
- Bring in XFree workaround to not write the same value to
  the PLL (can cause blanking of some panels)
- Bring in some of Peter Horton fixes (accel reset, cleanups)
  still some more to get in though...
- Properly reset accel engine on each console switch so
  we work around switching from XFree leaving it in a weird
  state. Also extend the comparison of values causing us to
  reload the mode on console switch.

NOTE: The 2.4.20 patch no longer mess with non related entries
in pci_ids.h, however the 2.4.21 patch still adds a couple of
new ones not related to radeons, but that should be harmless.

Patches available at:

http://www.penguinppc.org/~benh/radeonfb-041103-2.4.20.diff
http://www.penguinppc.org/~benh/radeonfb-041103-2.4.21-pre7.diff

Ben.
