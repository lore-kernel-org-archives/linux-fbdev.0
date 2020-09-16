From: Bhaskar Chowdhury <unixbhaskar@gmail.com>
Date: Wed, 16 Sep 2020 23:41:00 +0000
Subject: [PATCH v3] docs: fb: Remove vesafb scrollback boot option
Message-Id: <20200916232900.23502-1-unixbhaskar@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: b.zolnierkie@samsung.com, linux-fbdev@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: corbet@lwn.net, rdunlap@infradead.org, gregkh@linuxfoundation.org, daniel@ffwll.ch, yuanmingbuaa@gmail.com, w@1wt.eu, nopitydays@gmail.com, zhangyunhai@nsfocus.com, luto@amacapital.net, torvalds@linux-foundation.org, Bhaskar Chowdhury <unixbhaskar@gmail.com>


This patch remove the reference of scrollback from this file. This is 
related to these below commits.

Commit 973c096f6a85(vgacon: remove software scrollback support)
Commit 50145474f6ef(fbcon: remove soft scrollback code)

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
Correcting the previous versions errors. Proper changelog and subject text.
Trying to incorporate Willy's and Greg's suggestions.

 Documentation/fb/vesafb.rst | 2 --
 1 file changed, 2 deletions(-)

diff --git a/Documentation/fb/vesafb.rst b/Documentation/fb/vesafb.rst
index 6821c87b7893..f890a4f5623b 100644
--- a/Documentation/fb/vesafb.rst
+++ b/Documentation/fb/vesafb.rst
@@ -135,8 +135,6 @@ ypan	  enable display panning using the VESA protected mode
 
                 * scrolling (fullscreen) is fast, because there is
 		  no need to copy around data.
-		* You'll get scrollback (the Shift-PgUp thing),
-		  the video memory can be used as scrollback buffer
 
           kontra:
 
-- 
2.28.0
