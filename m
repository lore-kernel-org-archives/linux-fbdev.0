From: Zhou Zhu <zzhu3@marvell.com>
Date: Tue, 14 Jan 2014 11:16:21 +0000
Subject: [PATCH v2 1/4] arm: mmp: remove not used disp clk_name in ttc_dkb
Message-Id: <1389698184-28761-2-git-send-email-zzhu3@marvell.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1389698184-28761-1-git-send-email-zzhu3@marvell.com>
In-Reply-To: <1389698184-28761-1-git-send-email-zzhu3-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>, Jean-Christophe Plagniol-Villard <plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org>, Haojian Zhuang <haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Chao Xie <chao.xie-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Guoqing Li <ligq-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Zhou Zhu <zzhu3-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>

remove clk_name of mmp_disp mach_info in ttc_dkb.
This field is not used by driver now.

Signed-off-by: Zhou Zhu <zzhu3@marvell.com>
---
 arch/arm/mach-mmp/ttc_dkb.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-mmp/ttc_dkb.c b/arch/arm/mach-mmp/ttc_dkb.c
index cfadd97..9437166 100644
--- a/arch/arm/mach-mmp/ttc_dkb.c
+++ b/arch/arm/mach-mmp/ttc_dkb.c
@@ -204,7 +204,6 @@ static struct mmp_mach_path_config dkb_disp_config[] = {
 
 static struct mmp_mach_plat_info dkb_disp_info = {
 	.name = "mmp-disp",
-	.clk_name = "disp0",
 	.path_num = 1,
 	.paths = dkb_disp_config,
 };
-- 
1.7.9.5

