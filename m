From: Tom Li <tomli@tomli.me>
Date: Tue, 02 Apr 2019 12:38:50 +0000
Subject: Re: linux-next: build warning after merge of the fbdev tree
Message-Id: <20190402123849.GA4562@localhost.localdomain>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190402093007.0b03b02e@canb.auug.org.au>
In-Reply-To: <20190402093007.0b03b02e@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc: Linux Next Mailing List <linux-next@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Yifeng Li <tomli@tomli.me>, "Gustavo A. R. Silva" <gustavo@embeddedor.com>, Kees Cook <keescook@chromium.org>, linux-fbdev@vger.kernel.org

On Tue, Apr 02, 2019 at 09:30:07AM +1100, Stephen Rothwell wrote:
> Hi Bartlomiej,
> 
> After merging the fbdev tree, today's linux-next build (x86_64
> allmodconfig) produced this warning:
> 
> drivers/video/fbdev/sm712fb.c: In function 'smtc_blank':
> drivers/video/fbdev/sm712fb.c:900:4: warning: this statement may fall through [-Wimplicit-fallthrough=]
>     smtc_seqw(0x6b, 0x02);
>     ^~~~~~~~~~~~~~~~~~~~~
> drivers/video/fbdev/sm712fb.c:901:3: note: here
>    case 0x720:
>    ^~~~
> 
> Introduced by commit
> 
>   f627caf55b8e ("fbdev: sm712fb: fix crashes and garbled display during DPMS modesetting")
> 

Nice catch! Thanks!

This bug was introduced by me while attempting to fix another issue, a result of
my copy-paste error. Since it only reprograms the clock to a different frequency,
it's only a benign issue without visible side-effect, so it also evaded Sudip
Mukherjee's code review and regression tests.

But what's I'm more concerned here is the failure of scripts/checkpatch.pl. I
thought ./checkpatch.pl should have caught it, but for some reasons it cannot
detect this one.

$ ./scripts/checkpatch.pl 0001-fbdev-sm712fb-fix-crashes-and-garbled-display-during.patch
total: 0 errors, 0 warnings, 105 lines checked

So I mistakenly assumed the patch doesn't have a problem... It seems checkpatch.pl
cannot detect fallthroughs in nested switch/case statements? I'm not sure. Should I
report it to the maintainers of checkpatch.pl?

Anyway, please apply the following patch ASAP.

Thanks,
Tom Li

From 040fa4e6cc8b338cd845c11fd3efd7394ca55108 Mon Sep 17 00:00:00 2001
From: Yifeng Li <tomli@tomli.me>
Date: Tue, 2 Apr 2019 20:25:20 +0800
Subject: [PATCH] fbdev: sm712fb: fix memory frequency by avoiding a
 switch/case fallthrough.

A fallthrough in switch/case was introduced in f627caf55b8e ("fbdev:
sm712fb: fix crashes and garbled display during DPMS modesetting"),
due to my copy-paste error, which would cause the memory clock frequency
for SM720 to be programmed to SM712.

Since it only reprograms the clock to a different frequency, it's only
a benign issue without visible side-effect, so it also evaded Sudip
Mukherjee's code review and regression tests. scripts/checkpatch.pl
also failed to discover the issue, possibly due to nested switch
statements.

This issue was found by Stephen Rothwell by building linux-next with
-Wimplicit-fallthrough.

Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Fixes: f627caf55b8e ("fbdev: sm712fb: fix crashes and garbled display during DPMS modesetting")
Signed-off-by: Yifeng Li <tomli@tomli.me>
---
 drivers/video/fbdev/sm712fb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/video/fbdev/sm712fb.c b/drivers/video/fbdev/sm712fb.c
index 1e2503b52c6f..f1dcc6766d1e 100644
--- a/drivers/video/fbdev/sm712fb.c
+++ b/drivers/video/fbdev/sm712fb.c
@@ -898,6 +898,7 @@ static int smtc_blank(int blank_mode, struct fb_info *info)
 		case 0x712:
 			smtc_seqw(0x6a, 0x16);
 			smtc_seqw(0x6b, 0x02);
+			break;
 		case 0x720:
 			smtc_seqw(0x6a, 0x0d);
 			smtc_seqw(0x6b, 0x02);
-- 
2.20.1
