From: Michal Januszewski <spock@gentoo.org>
Subject: [PATCH v2 0/5] uvesafb: a general description
Date: Sat, 30 Jun 2007 18:31:01 +0200
Message-ID: <20070630163101.GA3838@spock.one.pl>
Reply-To: spock@gentoo.org, linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1I4fql-00041U-2l for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 30 Jun 2007 09:31:08 -0700
Received: from ipn26-148.piekary.net ([83.238.26.148])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1I4fqi-0000hp-Gj
	for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 30 Jun 2007 09:31:06 -0700
Content-Disposition: inline
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: linux-fbdev-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org, hpa@zytor.com

uvesafb is a generic driver for VBE2+ compliant video cards; an enhanced
version of vesafb and a direct successor of vesafb-tng [1].

This is the second version of this patch, and it incorporates all fixes
and cleanups suggested on the lkml.  My thanks to everyone who took
their time to review the first version.

uvesafb uses a userspace helper application (v86d, [2]) to run the x86
Video BIOS code.  This makes it possible to include in uvesafb all the
standard features (refresh rate control, video mode changes etc) that
are missing from vesafb without resorting to ugly hacks such as the ones
used in [1].  The current implementation of v86d can use either LRMI or
x86emu to run the BIOS code and supports both x86 and x86_64.

[1] http://dev.gentoo.org/~spock/projects/vesafb-tng/
[2] http://dev.gentoo.org/~spock/projects/uvesafb/

Best regards.
-- 
Michal Januszewski                              JID: spock@im.gentoo.org
Gentoo Linux Developer                    http://people.gentoo.org/spock


-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
