From: Bhaskar Chowdhury <unixbhaskar@gmail.com>
Date: Tue, 15 Sep 2020 04:31:55 +0000
Subject: [PATCH] docs : fb :  matroxfb.rst : Remove the stale information lines i.e framebuffer scrollback
Message-Id: <20200915041954.5110-1-unixbhaskar@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: b.zolnierkie@samsung.com, linux-fbdev@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: corbet@lwn.net, rdunlap@infradead.org, gregkh@linuxfoundation.org, daniel@ffwll.ch, yuanmingbuaa@gmail.com, w@1wt.eu, nopitydays@gmail.com, zhangyunhai@nsfocus.com, luto@amacapital.net, torvalds@linux-foundation.org, Bhaskar Chowdhury <unixbhaskar@gmail.com>

This patch remove stale information lines from this file :  matroxfb.rst

In effect of the the commit hashes : 50145474f6ef4a9c19205b173da6264a644c7489  and
973c096f6a85e5b5f2a295126ba6928d9a6afd45


Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 Documentation/fb/matroxfb.rst | 2 --
 1 file changed, 2 deletions(-)

diff --git a/Documentation/fb/matroxfb.rst b/Documentation/fb/matroxfb.rst
index f1859d98606e..6158c49c8571 100644
--- a/Documentation/fb/matroxfb.rst
+++ b/Documentation/fb/matroxfb.rst
@@ -317,8 +317,6 @@ Currently there are following known bugs:
  - interlaced text mode is not supported; it looks like hardware limitation,
    but I'm not sure.
  - Gxx0 SGRAM/SDRAM is not autodetected.
- - If you are using more than one framebuffer device, you must boot kernel
-   with 'video=scrollback:0'.
  - maybe more...
 
 And following misfeatures:
-- 
2.26.2
