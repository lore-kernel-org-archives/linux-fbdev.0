From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Subject: [patch 0/8] PS3 AV/FB patches
Date: Wed, 02 May 2007 14:48:30 +0200
Message-ID: <20070502124830.911142000@pademelon.sonytel.be>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HjEHh-0007ND-8X for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 02 May 2007 05:50:17 -0700
Received: from [80.88.33.193] (helo=vervifontaine.sonycom.com)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HjEHe-0005nx-Jf
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 02 May 2007 05:50:17 -0700
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
To: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: Paul Mackerras <paulus@samba.org>, James Simmons <jsimmons@infradead.org>, linux-fbdev-devel@lists.sourceforge.net, Antonino Daplas <adaplas@gmail.com>, linuxppc-dev@ozlabs.org

        Hi Linus, Andrew,

Here are our patches for the PS3 Audio Video Settings and Virtual Frame
Buffer
drivers for 2.6.22:

[1/8] ps3fb: thread updates
[2/8] ps3fb: atomic fixes
[3/8] ps3av: thread updates
[4/8] ps3fb: kill superfluous zero initializations
[5/8] ps3av: misc updates
[6/8] [PATCH] ps3: Make `ps3videomode -v 0' (auto mode) work again
[7/8] ps3fb: Use __func__ instead of __FUNCTION__
[8/8] ps3av: Use __func__ instead of __FUNCTION__

The last 3 are new, but they are quite simple/trivial.

Please apply. Thanks!

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- Sony Network and Software Technology Center Europe (NSCE)
Geert.Uytterhoeven@sonycom.com ------- The Corporate Village, Da Vincilaan 7-D1
Voice +32-2-7008453 Fax +32-2-7008622 ---------------- B-1935 Zaventem, Belgium


-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
