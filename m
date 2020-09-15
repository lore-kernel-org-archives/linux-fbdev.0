From: Bhaskar Chowdhury <unixbhaskar@gmail.com>
Date: Tue, 15 Sep 2020 04:51:05 +0000
Subject: [PATCH] docs : fb: sstfb.rst : Remove the scrollback related stanza
Message-Id: <20200915044817.29172-1-unixbhaskar@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: b.zolnierkie@samsung.com, linux-fbdev@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: corbet@lwn.net, rdunlap@infradead.org, gregkh@linuxfoundation.org, daniel@ffwll.ch, yuanmingbuaa@gmail.com, w@1wt.eu, nopitydays@gmail.com, zhangyunhai@nsfocus.com, luto@amacapital.net, torvalds@linux-foundation.org, Bhaskar Chowdhury <unixbhaskar@gmail.com>

This patch remove the stanza related to framebuffer scrollback effect.

It is the the effect of commit hashes : 50145474f6ef4a9c19205b173da6264a644c7489 
and 973c096f6a85e5b5f2a295126ba6928d9a6afd45


Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
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
2.26.2
