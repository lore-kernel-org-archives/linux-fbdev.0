From: Paul Mackerras <paulus@samba.org>
Subject: [PATCH] convert aty128fb to new framebuffer API
Date: Mon, 19 Aug 2002 21:45:13 +1000 (EST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <15712.55881.945932.782684@argo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from dp.samba.org ([66.70.73.150] helo=lists.samba.org)
	by usw-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 17gl9n-0005Y0-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 19 Aug 2002 04:57:15 -0700
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


-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
