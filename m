From: Bhaskar Chowdhury <unixbhaskar@gmail.com>
Date: Thu, 17 Sep 2020 10:38:14 +0000
Subject: [PATCH 3/4] docs: fb: Remove sstfb scrollback boot option
Message-Id: <d7e3e91ca0282d7e33a29476e51c1dd75aa1675f.1600333774.git.unixbhaskar@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1600333774.git.unixbhaskar@gmail.com>
In-Reply-To: <cover.1600333774.git.unixbhaskar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: b.zolnierkie@samsung.com, linux-fbdev@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: corbet@lwn.net, rdunlap@infradead.org, gregkh@linuxfoundation.org, daniel@ffwll.ch, yuanmingbuaa@gmail.com, w@1wt.eu, nopitydays@gmail.com, zhangyunhai@nsfocus.com, luto@amacapital.net, torvalds@linux-foundation.org, Bhaskar Chowdhury <unixbhaskar@gmail.com>

In commit 50145474f6ef ("fbcon: remove soft scrollback code"), the
framebuffer scrollback mode was removed, but the documentation was not
updated.  Properly update the documentation by removing the option that
is no longer present i.e remove a stanza related to scrollback.

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
Changesince V3:
Following Willy's and Greg's suggestion remove the not relevant
commit hash and message from the changelog and put a correct one.
 Documentation/fb/sstfb.rst | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/Documentation/fb/sstfb.rst b/Documentation/fb/sstfb.rst
index 8e8c1b940359..42466ff49c58 100644
--- a/Documentation/fb/sstfb.rst
+++ b/Documentation/fb/sstfb.rst
@@ -185,9 +185,6 @@ Bugs
   contact me.
 - The 24/32 is not likely to work anytime soon, knowing that the
   hardware does ... unusual things in 24/32 bpp.
-- When used with another video board, current limitations of the linux
-  console subsystem can cause some troubles, specifically, you should
-  disable software scrollback, as it can oops badly ...
 
 Todo
 ==
-- 
2.28.0
