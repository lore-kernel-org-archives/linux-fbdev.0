From: Alexander Kern <alex.kern@gmx.de>
Subject: [PATCH ATI Mach64 2.6.0] works better
Date: Sat, 27 Sep 2003 22:11:32 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <200309272211.32604.alex.kern@gmx.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1A3LSX-00005X-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Sat, 27 Sep 2003 13:14:29 -0700
Received: from mail.gmx.net ([213.165.64.20])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.22)
	id 1A3LSW-0002Dj-Nj
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 27 Sep 2003 13:14:28 -0700
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
To: fbdev <linux-fbdev-devel@lists.sourceforge.net>
Cc: =?utf-8?q?Dani=C3=ABl=20Mantione?= <daniel@deadlock.et.tudelft.nl>, Geert Uytterhoeven <geert@linux-m68k.org>, Nicolas Souchu <nsouch@free.fr>

Hi, 

new version now as appendix. I have problems with my FTP space, and hope 30KB 
is not too much for the list. Big change is, that I replace DSP_ON_OFF 
calculation with one from Daniels Mantione's version. Both was good in 
resolution from 1400x1050 - 640x400, but Daniel's is good for 320x200 too. My 
version sucks.

Yet not tested on my desktop, but I do not expect any troubles.

James, is it not the time to think about merge with main tree?

bye Alex


P.S. path will be posted today on http://home.arcor.de/alexander.khe/
ati_mobility
 





-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
