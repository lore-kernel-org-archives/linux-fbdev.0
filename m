From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: [PATCH 4/5] [RIVAFB]: Do not tap VGA ports if not X86
Date: Thu, 29 Jul 2004 10:04:26 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <200407291004.26089.adaplas@hotpop.com>
Reply-To: adaplas@pol.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Bq0RT-0002pc-LL
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 28 Jul 2004 19:14:47 -0700
Received: from twix.hotpop.com ([38.113.3.71])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.34)
	id 1Bq0RT-0002FS-4I
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 28 Jul 2004 19:14:47 -0700
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by twix.hotpop.com (Postfix) with SMTP id 782E2101A44A
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 29 Jul 2004 01:52:19 +0000 (UTC)
Content-Disposition: inline
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, linux-kernel@vger.kernel.org

Do not tap VGA ports if arch is not X86.

Tony

Signed-off-by: Antonino Daplas <adaplas@pol.net>

 fbdev.c  |    5 ++++-
 rivafb.h |    2 ++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff -uprN linux-2.6.8-rc2-mm1-orig/drivers/video/riva/fbdev.c linux-2.6.8-rc2-mm1/drivers/video/riva/fbdev.c
--- linux-2.6.8-rc2-mm1-orig/drivers/video/riva/fbdev.c	2004-07-28 20:07:59.018089680 +0000
+++ linux-2.6.8-rc2-mm1/drivers/video/riva/fbdev.c	2004-07-28 20:08:30.286336184 +0000
@@ -1090,13 +1090,14 @@ static int rivafb_open(struct fb_info *i
 
 	NVTRACE_ENTER();
 	if (!cnt) {
+#ifdef CONFIG_X86
 		memset(&par->state, 0, sizeof(struct vgastate));
 		par->state.flags = VGA_SAVE_MODE  | VGA_SAVE_FONTS;
 		/* save the DAC for Riva128 */
 		if (par->riva.Architecture == NV_ARCH_03)
 			par->state.flags |= VGA_SAVE_CMAP;
 		save_vga(&par->state);
-
+#endif
 		RivaGetConfig(&par->riva, par->Chipset);
 		/* vgaHWunlock() + riva unlock (0x7F) */
 		CRTCout(par, 0x11, 0xFF);
@@ -1121,7 +1122,9 @@ static int rivafb_release(struct fb_info
 		par->riva.LockUnlock(&par->riva, 0);
 		par->riva.LoadStateExt(&par->riva, &par->initial_state.ext);
 		riva_load_state(par, &par->initial_state);
+#ifdef CONFIG_X86
 		restore_vga(&par->state);
+#endif
 		par->riva.LockUnlock(&par->riva, 1);
 	}
 	atomic_dec(&par->ref_count);
diff -uprN linux-2.6.8-rc2-mm1-orig/drivers/video/riva/rivafb.h linux-2.6.8-rc2-mm1/drivers/video/riva/rivafb.h
--- linux-2.6.8-rc2-mm1-orig/drivers/video/riva/rivafb.h	2004-07-28 20:08:03.560399144 +0000
+++ linux-2.6.8-rc2-mm1/drivers/video/riva/rivafb.h	2004-07-28 20:08:34.671669512 +0000
@@ -50,7 +50,9 @@ struct riva_par {
 
 	struct riva_regs initial_state;	/* initial startup video mode */
 	struct riva_regs current_state;
+#ifdef CONFIG_X86
 	struct vgastate state;
+#endif
 	atomic_t ref_count;
 	u32 cursor_data[32 * 32/4];
 	int cursor_reset;




-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
