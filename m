From: David Howells <dhowells@redhat.com>
Date: Thu, 20 Dec 2012 17:49:17 +0000
Subject: [GIT PULL] UAPI disintegration for fbdev
Message-Id: <1565.1356025757@warthog.procyon.org.uk>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: torvalds@linux-foundation.org
Cc: dhowells@redhat.com, FlorianSchandinat@gmx.de, tomi.valkeinen@ti.com, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org


Hi Linus,

Could you consider pulling my UAPI disintegration for fbdev branch please?
The maintainer (Florian Tobias Schandinat) said he didn't mind if I wanted to
push it forward.

David
---
The following changes since commit 1800098549fc310cffffefdcb3722adaad0edda8:

  ARM: OMAP: Fix build breakage due to missing include in i2c.c (2012-12-20 08:43:25 -0800)

are available in the git repository at:

  git://git.infradead.org/users/dhowells/linux-headers.git tags/disintegrate-fbdev-20121220

for you to fetch changes up to b889fcf63cb62e7fdb7816565e28f44dbe4a76a5:

  UAPI: (Scripted) Disintegrate include/video (2012-12-20 17:14:26 +0000)

----------------------------------------------------------------
UAPI disintegration 2012-12-20

----------------------------------------------------------------
David Howells (1):
      UAPI: (Scripted) Disintegrate include/video

 include/uapi/video/Kbuild    |   3 +
 include/uapi/video/edid.h    |   9 ++
 include/uapi/video/sisfb.h   | 209 +++++++++++++++++++++++++++++++++++++++++++
 include/uapi/video/uvesafb.h |  60 +++++++++++++
 include/video/Kbuild         |   3 -
 include/video/edid.h         |   7 +-
 include/video/sisfb.h        | 189 +-------------------------------------
 include/video/uvesafb.h      |  58 +-----------
 8 files changed, 284 insertions(+), 254 deletions(-)
 create mode 100644 include/uapi/video/edid.h
 create mode 100644 include/uapi/video/sisfb.h
 create mode 100644 include/uapi/video/uvesafb.h
