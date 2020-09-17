From: Bhaskar Chowdhury <unixbhaskar@gmail.com>
Date: Thu, 17 Sep 2020 10:38:11 +0000
Subject: [PATCH v4 0/4] docs: fb: Removed framebuffer scrollback related documentations
Message-Id: <cover.1600333774.git.unixbhaskar@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: b.zolnierkie@samsung.com, linux-fbdev@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: corbet@lwn.net, rdunlap@infradead.org, gregkh@linuxfoundation.org, daniel@ffwll.ch, yuanmingbuaa@gmail.com, w@1wt.eu, nopitydays@gmail.com, zhangyunhai@nsfocus.com, luto@amacapital.net, torvalds@linux-foundation.org, Bhaskar Chowdhury <unixbhaskar@gmail.com>


In this patch series, documentation get in sync with the code removal
of scrollback,by this commit 50145474f6ef ("fbcon: remove soft scrollback code"),
by eliminating the information related to it.


Changes since V3:

Remove the wrong commit hash and messages from all the 4 patches i.e 
Commit 973c096f6a85(vgacon: remove software scrollback support)
from the patches as suggested by Willy and Greg.

Patch 1: Remove the documentation related to framebuffer scrollback from the file
   fbcon.rst

Patch 2: Remove the documentation  boot option for scrollback from the file matroxfb.rst

Patch 3: Remove the documentation scrollback option from sstfb.rst file.

Patch 4: Remove the documentation scrollback option from vesafb.rst file. 

Bhaskar Chowdhury (4):
  Remove framebuffer scrollback boot option
  Remove matroxfb scrollback boot option
  Remove sstfb scrollback boot option
  Remove vesafb scrollback boot option

 Documentation/fb/fbcon.rst    | 21 +++++++--------------
 Documentation/fb/matroxfb.rst |  2 --
 Documentation/fb/sstfb.rst    |  3 ---
 Documentation/fb/vesafb.rst   |  2 --
 4 files changed, 7 insertions(+), 21 deletions(-)

-- 
2.28.0
