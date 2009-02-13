From: Yang Hongyang <yanghy@cn.fujitsu.com>
Subject: [PATCH]atyfb:remove  unused variable =?windows-1252?Q?=91pwr=5Fc?=
 =?windows-1252?Q?ommand=92?=
Date: Fri, 13 Feb 2009 17:34:08 +0800
Message-ID: <49953E90.8030306@cn.fujitsu.com>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1756692AbZBMJdR@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="windows-1252"
To: linux-fbdev-devel@lists.sourceforge.net
Cc: rjw@sisk.pl, linux-kernel@vger.kernel.org, rui.zhang@intel.com

remove  unused variable =91pwr_command=92=20

Signed-off-by: Yang Hongyang<yanghy@cn.fujitsu.com>

---
 drivers/video/aty/aty128fb.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/drivers/video/aty/aty128fb.c b/drivers/video/aty/aty128fb.=
c
index e6e299f..2181ce4 100644
--- a/drivers/video/aty/aty128fb.c
+++ b/drivers/video/aty/aty128fb.c
@@ -2365,7 +2365,6 @@ static void fbcon_aty128_bmove(struct display *p,=
 int sy, int sx, int dy, int dx
 static void aty128_set_suspend(struct aty128fb_par *par, int suspend)
 {
 	u32	pmgt;
-	u16	pwr_command;
 	struct pci_dev *pdev =3D par->pdev;
=20
 	if (!par->pm_reg)
--=20
1.6.0.3

--=20
Regards
Yang Hongyang
