From: Bhaskar Chowdhury <unixbhaskar@gmail.com>
Date: Tue, 15 Sep 2020 05:24:19 +0000
Subject: [PATCH] docs : fb : vesafb.rst : Removed scrollback related lines
Message-Id: <20200915051219.19479-1-unixbhaskar@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20200915051907.GA12074@kroah.com>
In-Reply-To: <20200915051907.GA12074@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: b.zolnierkie@samsung.com, linux-fbdev@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: corbet@lwn.net, rdunlap@infradead.org, gregkh@linuxfoundation.org, daniel@ffwll.ch, yuanmingbuaa@gmail.com, w@1wt.eu, nopitydays@gmail.com, zhangyunhai@nsfocus.com, luto@amacapital.net, torvalds@linux-foundation.org, Bhaskar Chowdhury <unixbhaskar@gmail.com>

This patch removed the scrollback related lines from this file : vesafb.rst

In the effect of this commit hashes : 50145474f6ef4a9c19205b173da6264a644c7489
and 973c096f6a85e5b5f2a295126ba6928d9a6afd45
 

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
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
2.26.2
