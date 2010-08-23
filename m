From: Christian Dietrich <qy03fugy@stud.informatik.uni-erlangen.de>
Date: Mon, 23 Aug 2010 09:59:33 +0000
Subject: [PATCH 0/2] Removing dead code
Message-Id: <cover.1282554255.git.qy03fugy@stud.informatik.uni-erlangen.de>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tejun Heo <tj@kernel.org>, Jiri Kosina <jkosina@suse.cz>, Daniel Mack <daniel@caiaq.de>, Joseph Chan <JosephChan@via.com.tw>, Florian Tobias Schandinat <FlorianSchandinat@gmx.de>, Andrew Morton <akpm@linux-foundation.org>, Jonathan Corbet <corbet@lwn.net>, Erik-Jan Post <ej.lfs@xs4all.nl>, linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: vamos-dev@i4.informatik.uni-erlangen.de

Hi all!
       
        As part of the VAMOS[0] research project at the University of
Erlangen we are looking at multiple integrity errors in linux'
configuration system.

        I've been running a check on the drivers/video sourcetree for
config Items not defined in Kconfig and found 2 such cases. Sourcecode
blocks depending on these Items are not reachable from a vanilla
kernel -- dead code. I've seen such dead blocks made on purpose
e.g. while integrating new features into the kernel but generally
they're just useless.

        Each of the patches in this patchset removes on such dead
config Item, I'd be glad if you consider applying them. I've been
doing deeper analysis of such issues before and can do so again but
I'm not so sure they were fastly usefull.

        I build the patches against a vanilla kernel in order to
try if the kernel compiles with this patches

        Please keep me informed of this patch getting confirmed /
merged so we can keep track of it.

Regards

        Christian Dietrich

[0] http://vamos1.informatik.uni-erlangen.de/

Christian Dietrich (2):
  drivers/video: Removing dead FB_VIA_CAMERA config option
  drivers/video: Removing dead FB_68328_INVERT config option

 drivers/video/68328fb.c   |    4 ----
 drivers/video/via/accel.c |   16 ----------------
 include/linux/via-core.h  |    5 +----
 3 files changed, 1 insertions(+), 24 deletions(-)

