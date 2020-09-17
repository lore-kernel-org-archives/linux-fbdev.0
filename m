From: Bhaskar Chowdhury <unixbhaskar@gmail.com>
Date: Thu, 17 Sep 2020 10:38:13 +0000
Subject: [PATCH 2/4] docs: fb: Remove matroxfb scrollback boot option
Message-Id: <e5187e70faf8237825a142313802983a6c214baa.1600333774.git.unixbhaskar@gmail.com>
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
is no longer pressent, and removed the particular scrollback option.

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
Change since V3:
Following Willy's and Greg's suggestion ,in this version removing the not relevant 
hash and commit from the changelog and put a proper one.
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
2.28.0
