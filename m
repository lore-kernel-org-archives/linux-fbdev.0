From: Paul Mackerras <paulus@samba.org>
Subject: [PATCH] convert aty128fb to new framebuffer API
Date: 20 Aug 2002 18:31:51 -0500
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <29051.1858453558$1029886177@news.gmane.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from [132.248.33.226] (helo=garaged.homeip.net)
	by usw-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 17hIR8-0005hj-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 20 Aug 2002 16:29:22 -0700
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
To: linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net

I have converted aty128fb.c in current 2.5 to the new framebuffer API,
imported various fixes from the 2.4 PPC tree (fixes for running at
15bpp and 16bpp, plus support for sleeping (suspending) on
powerbooks), and reindented it to 8-column tabs.  Since the patch is
rather large, I didn't include it here.  It is available at
ftp://ftp.samba.org/pub/paulus/aty128.patch instead.

Paul.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/



-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
