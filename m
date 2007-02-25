From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH RESEND 7/9] atyfb: Kill dead code
Date: Sun, 25 Feb 2007 18:20:32 +0800
Message-ID: <45E162F0.7010803@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HLGbD-0006Cb-92 for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 25 Feb 2007 02:27:23 -0800
Received: from py-out-1112.google.com ([64.233.166.177])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HLGbB-00021L-W1
	for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 25 Feb 2007 02:27:23 -0800
Received: by py-out-1112.google.com with SMTP id a29so536398pyi
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Sun, 25 Feb 2007 02:27:21 -0800 (PST)
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Andrew Morton <akpm@osdl.org>
Cc: =?ISO-8859-1?Q?Ville_Syrj=E4l=E4?= <syrjala@sci.fi>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

Coverity Bug 68, kill dead code.

Signed-off-by: Antonino Daplas <adaplas@gmail.com>
---

 drivers/video/aty/atyfb_base.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/video/aty/atyfb_base.c b/drivers/video/aty/atyfb_base.c
index a7e0062..56b38f5 100644
--- a/drivers/video/aty/atyfb_base.c
+++ b/drivers/video/aty/atyfb_base.c
@@ -2331,6 +2331,7 @@ #endif
 		case DAC_IBMRGB514:
 			par->dac_ops = &aty_dac_ibm514;
 			break;
+#ifdef CONFIG_ATARI
 		case DAC_ATI68860_B:
 		case DAC_ATI68860_C:
 			par->dac_ops = &aty_dac_ati68860b;
@@ -2339,6 +2340,7 @@ #endif
 		case DAC_ATT21C498:
 			par->dac_ops = &aty_dac_att21c498;
 			break;
+#endif
 		default:
 			PRINTKI("aty_init: DAC type not implemented yet!\n");
 			par->dac_ops = &aty_dac_unsupported;


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
