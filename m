From: Helge Hafting <helgehaf@aitel.hist.no>
Subject: Minor problem with matrox framebuffer in 2.5.70-mm4
Date: Wed, 4 Jun 2003 23:25:31 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20030604212531.GB2436@hh.idb.hist.no>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from hermine.idb.hist.no ([158.38.50.15])
	by sc8-sf-list1.sourceforge.net with smtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 19Nfh7-0004YI-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 04 Jun 2003 14:21:17 -0700
Content-Disposition: inline
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: jsimmons@infradead.org, linux-fbdev-devel@lists.sourceforge.net, vandrove@vc.cvut.cz

The matrox framebuffer works on my G550 (until
2.5.70-mm4 dies from raid trouble )-:

There is a minor glitch though.  I get two
penguins as expected, but they're on a white
rectangle that extends below and to the right of them.

This don't look good, and the white rectangle don't
scroll, so my initial boot display has fewer lines
than it should.  I use the 8x8 font on a
1280x1024 screen in order to capture long
backtraces when the kernel oopses.

The matrox framebuffer before the big fb
cleanup didn't have this cosmetic problem.

The machine is a dual celeron, using
video=matrox:vesa:0x1BB

Helge Hafting




-------------------------------------------------------
This SF.net email is sponsored by:  Etnus, makers of TotalView, The best
thread debugger on the planet. Designed with thread debugging features
you've never dreamed of, try TotalView 6 free at www.etnus.com.
