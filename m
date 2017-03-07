From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 07 Mar 2017 01:24:11 +0000
Subject: About boot time Tux logo with -EPROBE_DEFER
Message-Id: <87shmp991p.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <redmine.issue-116282.20170227003040@dm.renesas.com>
        <redmine.journal-935021.20170228120819.2026321c0ca0beea@dm.renesas.com>
In-Reply-To: <redmine.journal-935021.20170228120819.2026321c0ca0beea@dm.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Laurent <laurent.pinchart@ideasonboard.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Fabian Frederick <fabf@skynet.be>, Andrew Morton <akpm@linux-foundation.org>
Cc: shimoda <yoshihiro.shimoda.uh@renesas.com>, koji.matsuoka.xm@renesas.com, shiiba <naoya.shiiba.nx@renesas.com>, sakato <ryusuke.sakato.bx@renesas.com>, Hosoya <yoshifumi.hosoya.wj@renesas.com>, Fukawa <tomoharu.fukawa.eb@renesas.com>, hien.dang.eb@renesas.com, khiem.nguyen.xt@renesas.com, kouei.abe.cp@renesas.com, harunobu.kurokawa.dn@renesas.com, hiroyuki.yokoyama.vx@renesas.com, takeshi.kihara.df@renesas.com, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org


Hi

I want to ask you about boot time Tux logo.

For some reasons, current our video driver returns -EPROBE_DEFER when
probe timing, but logo init function doesn't care it.
Thus, our kernel can't have logo when boot time.

I think this is not only our issue, but general issue ?

Thus, I think logo init function should care about -EPROBE_DEFER
or something. In our quick hack, this issue was solved by below patch,
but I don't know this is OK.

So, how to solve this issue ? do you have nice idea ?
or can maintainer accept below patch ?

-------------------
diff --git a/drivers/video/logo/logo.c b/drivers/video/logo/logo.c
index b6bc4a0bda2a..4d50bfd13e7c 100644
--- a/drivers/video/logo/logo.c
+++ b/drivers/video/logo/logo.c
@@ -34,7 +34,7 @@ static int __init fb_logo_late_init(void)
     return 0;
 }

-late_initcall(fb_logo_late_init);
+late_initcall_sync(fb_logo_late_init);

 /* logo's are marked __initdata. Use __ref to tell
  * modpost that it is intended that this function uses data
-------------------

Best regards
---
Kuninori Morimoto
