From: Daniel Drake <dsd@laptop.org>
Date: Sat, 18 Aug 2012 15:53:34 +0000
Subject: viafb PLL/clock tweaking causes XO-1.5 instability
Message-Id: <CAMLZHHRxE1zJ9nDPEG7owU6qNxYz1iVDM5CjedqBKKUY+VfBjg@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Hi,

I've been investigating a strange regression where in recent kernel
releases, the XO-1.5 cannot reliably suspend/resume when on a virtual
terminal (driven by viafb). Under X there is no instability.

The test case is to suspend and resume a lot (about 10 times a
minute). In less than an hour the system will fail to resume - the
system RAM becomes corrupt on resume and the firmware can't find its
way back into Linux, so it reboots. This is presumably because the GPU
is accessing main memory while the system is suspended, causing the
RAM to come out of self-refresh and lose all its contents before the
CPU wakes up to resume the system.

I have bisected this to find the first bad commit:

commit b692a63af8b63a7a7e84702a713d0072e336b326
Author: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Date:   Thu Mar 24 14:25:51 2011 +0000

    viafb: add VIA slapping capability


On the XO-1.5 this code tries to set IGA1=off IGA2=on. However, a
later commit causes them both to be turned on, since we enable
X_COMPATIBILITY (we use X, and we find that setting to be necessary
for X to work).


If I comment the code that modifies IGA1, I find that setting IGA2=on
causes the crashyness, setting IGA2=off results in the display not
working at all. The only non-crashy setting here I can find is to not
touch the IGA2 configuration.

If I comment out the code that modifies IGA2, I find that setting
IGA1=on causes the crashyness, and setting IGA1=off is stable.

Going one step lower to find exactly which calls are responsible for
triggering the crashyness, by only enabling one function call at a
time, I find:
set_secondary_pll_state(on) only = stable
set_secondary_clock_state(on) only = crashy

set_primary_pll_state(on) only = stable
set_primary_clock_state(on) only = crashy

Looking at the set_secondary_clock_state(on) case, I find that the
Secondary Display Engine (Gated Clock <LCK>) bits 7:6 in IO Port
3C5.1B are 11 when untouched, and 10 after
set_secondary_clock_state(on) has run. So the code seems to be doing
what it intends to do, but its not clear why modifying this register
effectively switches between 3 behavioural states (stable, no display
at all, display active but crashy suspend/resume). Also is there
really any need to modify it or would the default (enable clock only
if its needed) suffice?

Any ideas?

Thanks,
Daniel
