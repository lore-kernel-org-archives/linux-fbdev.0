From: Joe Perches <joe@perches.com>
Date: Tue, 25 Jun 2019 16:52:23 +0000
Subject: Re: [PATCH] video: fbdev: s3c-fb: Mark expected switch fall-throughs
Message-Id: <2bdbbd7909c5c4ad96d32c0c5be4690292132a34.camel@perches.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190625160103.GA13133@embeddedor>
In-Reply-To: <20190625160103.GA13133@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>, Jingoo Han <jingoohan1@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: linux-fbdev@vger.kernel.org, Michal Marek <michal.lkml@markovi.net>, Kees Cook <keescook@chromium.org>, linux-kbuild <linux-kbuild@vger.kernel.org>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, Masahiro Yamada <yamada.masahiro@socionext.com>

On Tue, 2019-06-25 at 11:01 -0500, Gustavo A. R. Silva wrote:
> In preparation to enabling -Wimplicit-fallthrough, mark switch
> cases where we are expecting to fall through.
[]
> This patch is part of the ongoing efforts to enable
> -Wimplicit-fallthrough.

Just enable the thing already.

If you stopped trying to do it all yourself, others
will help resolve any new build warnings.

For instance: a build of -next x86/64 defconfig has 2.  nbd.
---
 Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Makefile b/Makefile
index 5102b2bbd224..df909ffdfcdb 100644
--- a/Makefile
+++ b/Makefile
@@ -690,6 +690,7 @@ endif # may-sync-config
 endif # $(dot-config)
 
 KBUILD_CFLAGS	+= $(call cc-option,-fno-delete-null-pointer-checks,)
+KBUILD_CFLAGS	+= $(call cc-option, -Wimplicit-fallthrough)
 KBUILD_CFLAGS	+= $(call cc-disable-warning,frame-address,)
 KBUILD_CFLAGS	+= $(call cc-disable-warning, format-truncation)
 KBUILD_CFLAGS	+= $(call cc-disable-warning, format-overflow)
