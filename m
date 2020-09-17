From: Bhaskar Chowdhury <unixbhaskar@gmail.com>
Date: Thu, 17 Sep 2020 10:38:15 +0000
Subject: [PATCH 4/4] docs: fb: Remove vesafb scrollback boot option
Message-Id: <799e4d6ecca9aab53e823fc0001887d728be0aa5.1600333774.git.unixbhaskar@gmail.com>
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
is no longer present,remove the scrollback option.

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
Changes since V3:
Following Willy's and Greg's suggestion,get rid of not relevant commit 
hash and message from changelog and put a correct one.
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
