From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: Re: Re: Radeon framebuffer weirdness in -mm2
Date: Sat, 22 Jan 2005 00:36:38 +0800
Message-ID: <200501220036.41359.adaplas@hotpop.com>
References: <20050120232122.GF3867@waste.org> <20050120160123.14f13ca6.akpm@osdl.org> <20050121035758.GH12076@waste.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Cs1mP-0005uy-1A
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 21 Jan 2005 08:37:01 -0800
Received: from smtp-out.hotpop.com ([38.113.3.61])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1Cs1mN-0006Ej-9s
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 21 Jan 2005 08:37:00 -0800
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id 340FFD4107C
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 21 Jan 2005 16:36:50 +0000 (UTC)
In-Reply-To: <20050121035758.GH12076@waste.org>
Content-Disposition: inline
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
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
To: Matt Mackall <mpm@selenic.com>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net, benh@kernel.crashing.org

On Friday 21 January 2005 11:57, Matt Mackall wrote:
> On Thu, Jan 20, 2005 at 04:01:23PM -0800, Andrew Morton wrote:
> > Matt Mackall <mpm@selenic.com> wrote:

> If I do a reboot(8) from inside X, I get switched to vt 0, but the
> shutdown messages come out on vt 7, where X was running. As I'm
> sitting on vt 0 during shutdown, I see character cells changed to
> something like "_" (last two scanlines filled) slowly marching down
> the screen corresponding to the shutdown messages.

Confirmed that this also occurs with vesafb.

This corruption (underscores) is due to the cursor of a not visibile console
being drawn on the foreground display. The console layer should decide when
and where to draw the console but, for now, a simple workaround is to
disallow drawing of the fbcon cursor if the console is not visible.

Signed-off-by: Antonino  Daplas <adaplas@pol.net>
---

 fbcon.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -Nru a/drivers/video/console/fbcon.c b/drivers/video/console/fbcon.c
--- a/drivers/video/console/fbcon.c	2005-01-21 20:15:20 +08:00
+++ b/drivers/video/console/fbcon.c	2005-01-22 00:31:30 +08:00
@@ -1087,7 +1087,7 @@
 	int y = real_y(p, vc->vc_y);
  	int c = scr_readw((u16 *) vc->vc_pos);
 
-	if (fbcon_is_inactive(vc, info))
+	if (fbcon_is_inactive(vc, info) || !CON_IS_VISIBLE(vc))
 		return;
 
 	ops->cursor_flash = 1;




-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
