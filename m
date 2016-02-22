From: "Maciej W. Rozycki" <macro@linux-mips.org>
Date: Mon, 22 Feb 2016 01:54:54 +0000
Subject: [PATCH 0/7] PMAG-AA frame buffer driver rework
Message-Id: <alpine.LFD.2.20.1602220110330.7431@eddie.linux-mips.org>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hi,

 This is an update to the PMAG-AA frame buffer driver to adapt it to our 
current APIs, which I promised a while ago (too much of a while, which I 
apologise for).

 This series starts with a change that makes the driver build and retains 
its previous functionality.  A bunch of further clean-ups follow, each of 
which is explained individually.  There's a potential in this code for 
further clean-ups and improvements, but the weekend is running out quick 
now, so I had to stop somewhere.  Next time then.

 A couple of checkpatch.pl warnings are noted.

 First on using `printk(KERN_ERR ...' rather tha `pr_err'.  I could 
probably fix it, but I think it's not worth it by itself, the interface is 
not wrong and the issue is mainly cosmetical.  I think I'll just go across 
all the pmag* drivers at once and bulk convert these calls sometime.

 Second on using `mb()' (without a comment).  This is not a new problem as 
the driver has lots of these calls throughout.  Fixing them is blocked on 
the unavailability of generic cross-platform MMIO synchronisation and 
completion barriers.  See the discussion at: 
<http://www.linux-mips.org/cgi-bin/mesg.cgi?a=linux-mips&i=alpine.LFD.2.11.1404280048540.11598%40eddie.linux-mips.org> 
for details.  Most TURBOchannel drivers suffer from this problem due to 
the complexities around many MIPS processors being weakly ordered, 
including in particular those used in TURBOchannel systems.  Once the 
generic issue of MMIO barriers has been sorted out the hacks to use memory 
barriers (which just happen to DTRT on the MIPS platform, because there's 
just a single underlying mechanism for all kinds of barriers in the MIPS
architecture) in their place can be removed.

 All of these pieces have been visually tested with a live specimen.  VT 
only however at this point, no X11.

 Please apply,

  Maciej
