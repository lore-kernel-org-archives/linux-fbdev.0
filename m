From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Date: Tue, 21 Apr 2015 20:26:04 +0000
Subject: [PATCH v3 0/6] x86: document and address MTRR corner cases
Message-Id: <1429647970-17479-1-git-send-email-mcgrof@do-not-panic.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: cocci@systeme.lip6.fr

From: "Luis R. Rodriguez" <mcgrof@suse.com>

As we phase out MTRR we need to also prepare for the flip of
the default ioremap() behaviour from UC- to strong UC. There
are a few remaining drivers which does not allow us to make
a smooth transition over and which do not allow us to remove
MTRR use. The atyfb is a good example driver and this series
addresses the work required to avoid such regressions and
cover MTRR size contraint use cases.

This series also documents what we've learned along on the
way in order to address removal of MTRR use and its corner
cases.

Luis R. Rodriguez (6):
  x86: add ioremap_uc() - force strong UC, PCD=1, PWT=1
  x86: document WC MTRR effects on PAT / non-PAT pages
  video: fbdev: atyfb: move framebuffer length fudging to helper
  video: fbdev: atyfb: clarify ioremap() base and length used
  video: fbdev: atyfb: replace MTRR UC hole with strong UC
  video: fbdev: atyfb: use arch_phys_wc_add() and ioremap_wc()

 Documentation/x86/mtrr.txt           | 18 +++++--
 Documentation/x86/pat.txt            | 40 ++++++++++++++-
 arch/x86/include/asm/io.h            |  1 +
 arch/x86/kernel/cpu/mtrr/main.c      |  3 ++
 arch/x86/mm/ioremap.c                | 36 ++++++++++++-
 arch/x86/mm/pageattr.c               |  3 ++
 drivers/video/fbdev/aty/atyfb.h      |  5 +-
 drivers/video/fbdev/aty/atyfb_base.c | 98 ++++++++++++++----------------------
 include/asm-generic/io.h             |  8 +++
 9 files changed, 143 insertions(+), 69 deletions(-)

-- 
2.3.2.209.gd67f9d5.dirty

