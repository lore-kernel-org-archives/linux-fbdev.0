From: Andreas Schwab <schwab@suse.de>
Subject: Re: [PATCH] radeonfb: (#2) Implement proper workarounds for PLL
 accesses
Date: Sat, 09 Apr 2005 18:24:42 +0200
Message-ID: <jey8brj4tx.fsf@sykes.suse.de>
References: <1110519743.5810.13.camel@gaston>
	<1110672745.5787.60.camel@gaston> <je8y3wyk3g.fsf@sykes.suse.de>
	<1112743901.9568.67.camel@gaston> <jeoecr1qk8.fsf@sykes.suse.de>
	<1112827655.9518.194.camel@gaston> <jehdii8hjk.fsf@sykes.suse.de>
	<21d7e9970504071422349426eb@mail.gmail.com>
	<1112914795.9568.320.camel@gaston> <jemzsa6sxg.fsf@sykes.suse.de>
	<1112923186.9567.349.camel@gaston> <jezmw9ug7j.fsf@sykes.suse.de>
	<1113005006.9568.402.camel@gaston>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S261355AbVDIQZ0@vger.kernel.org>
In-Reply-To: <1113005006.9568.402.camel@gaston> (Benjamin Herrenschmidt's
 message of "Sat, 09 Apr 2005 10:03:25 +1000")
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="iso-8859-1"
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Dave Airlie <airlied@gmail.com>, Linux Kernel list <linux-kernel@vger.kernel.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:

> Can you redo the counting of the workarounds with the patch ?

Switching from X to console:

radeon_write_pll_regs: INPLL
radeon_write_pll_regs: INPLL
radeon_write_mode: OUTPLL
radeonfb_engine_reset: INPLL
radeonfb_engine_reset: OUTPLL
radeonfb_engine_reset: OUTPLL
radeonfb_setcmap: INPLL
radeonfb_setcmap: OUTPLL
radeonfb_setcmap: OUTPLL
radeon_write_pll_regs: INPLL
radeon_write_pll_regs: INPLL
radeon_write_mode: OUTPLL
radeonfb_engine_reset: INPLL
radeonfb_engine_reset: OUTPLL
radeonfb_engine_reset: OUTPLL
radeonfb_setcmap: INPLL
radeonfb_setcmap: OUTPLL
radeonfb_setcmap: OUTPLL
radeonfb_setcmap: INPLL
radeonfb_setcmap: OUTPLL
radeonfb_setcmap: OUTPLL
radeonfb_setcmap: INPLL
radeonfb_setcmap: OUTPLL
radeonfb_setcmap: OUTPLL
radeonfb_setcmap: INPLL
radeonfb_setcmap: OUTPLL

Switching from console to X:

radeonfb_setcmap: OUTPLL
radeon_write_pll_regs: INPLL
radeon_write_pll_regs: INPLL
radeon_write_mode: OUTPLL
radeonfb_engine_reset: INPLL
radeonfb_engine_reset: OUTPLL
radeonfb_engine_reset: OUTPLL
radeonfb_setcmap: INPLL
radeonfb_setcmap: OUTPLL
radeonfb_setcmap: OUTPLL
agpgart: Putting AGP V2 device at 0000:00:0b.0 into 1x mode
agpgart: Putting AGP V2 device at 0000:00:10.0 into 1x mode
radeonfb_setcolreg: INPLL
radeonfb_setcolreg: OUTPLL
radeonfb_setcolreg: OUTPLL
=2E.. last three lines repeated 63 times

Andreas.

--=20
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux Products GmbH, Maxfeldstra=DFe 5, 90409 N=FCrnberg, Germany
Key fingerprint =3D 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
