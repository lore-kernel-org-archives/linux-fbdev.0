From: Jani Monoses <jani@iv.ro>
Subject: gen_set_var() fix?
Date: Wed, 28 Aug 2002 10:00:48 +0000
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20020828100048.2dde942e.jani@iv.ro>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from iv.ro ([194.105.28.94])
	by usw-sf-list1.sourceforge.net with smtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 17jwmI-00007y-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 27 Aug 2002 23:58:10 -0700
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: linux-fbdev-devel@lists.sourceforge.net

James
Should't gen_set_var set the var in info here as well? (when no check_var present)
BTW is gen_set_var going to stay in the new API or go away ?

--- fbgen.c.orig       Wed Aug 28 09:49:45 2002
+++ fbgen.c     Wed Aug 28 09:57:32 2002
@@ -36,7 +36,7 @@

        if (con < 0 || (memcmp(&info->var, var, sizeof(struct fb_var_screeninfo)))) {
                if (!info->fbops->fb_check_var) {
-                       *var = info->var;
+                       info->var = *var;
                        return 0;
                }


-------------------------------------------------------
This sf.net email is sponsored by: Jabber - The world's fastest growing 
real-time communications platform! Don't just IM. Build it in! 
http://www.jabber.com/osdn/xim
