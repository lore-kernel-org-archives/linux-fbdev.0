From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 26 Sep 2019 10:13:12 +0000
Subject: [PATCH -next] fbdev: c2p: Fix link failure on non-inlining
Message-Id: <20190926101312.32218-1-geert@linux-m68k.org>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Masahiro Yamada <yamada.masahiro@socionext.com>, Andrew Morton <akpm@linux-foundation.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Nick Desaulniers <ndesaulniers@google.com>, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>

When the compiler decides not to inline the Chunky-to-Planar core
functions, the build fails with:

    c2p_planar.c:(.text+0xd6): undefined reference to `c2p_unsupported'
    c2p_planar.c:(.text+0x1dc): undefined reference to `c2p_unsupported'
    c2p_iplan2.c:(.text+0xc4): undefined reference to `c2p_unsupported'
    c2p_iplan2.c:(.text+0x150): undefined reference to `c2p_unsupported'

Fix this by marking the functions __always_inline.

Reported-by: noreply@ellerman.id.au
Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
Fixes: 025f072e5823947c ("compiler: enable CONFIG_OPTIMIZE_INLINING forcibly")

As this is a patch in akpm's tree, the commit ID in the Fixes tag is not
stable.
---
 drivers/video/fbdev/c2p_core.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/video/fbdev/c2p_core.h b/drivers/video/fbdev/c2p_core.h
index e1035a865fb945f0..45a6d895a7d7208e 100644
--- a/drivers/video/fbdev/c2p_core.h
+++ b/drivers/video/fbdev/c2p_core.h
@@ -29,7 +29,7 @@ static inline void _transp(u32 d[], unsigned int i1, unsigned int i2,
 
 extern void c2p_unsupported(void);
 
-static inline u32 get_mask(unsigned int n)
+static __always_inline u32 get_mask(unsigned int n)
 {
 	switch (n) {
 	case 1:
@@ -57,7 +57,7 @@ static inline u32 get_mask(unsigned int n)
      *  Transpose operations on 8 32-bit words
      */
 
-static inline void transp8(u32 d[], unsigned int n, unsigned int m)
+static __always_inline void transp8(u32 d[], unsigned int n, unsigned int m)
 {
 	u32 mask = get_mask(n);
 
@@ -99,7 +99,7 @@ static inline void transp8(u32 d[], unsigned int n, unsigned int m)
      *  Transpose operations on 4 32-bit words
      */
 
-static inline void transp4(u32 d[], unsigned int n, unsigned int m)
+static __always_inline void transp4(u32 d[], unsigned int n, unsigned int m)
 {
 	u32 mask = get_mask(n);
 
@@ -126,7 +126,7 @@ static inline void transp4(u32 d[], unsigned int n, unsigned int m)
      *  Transpose operations on 4 32-bit words (reverse order)
      */
 
-static inline void transp4x(u32 d[], unsigned int n, unsigned int m)
+static __always_inline void transp4x(u32 d[], unsigned int n, unsigned int m)
 {
 	u32 mask = get_mask(n);
 
-- 
2.17.1
