From: Alexander Kern <alex.kern@gmx.de>
Subject: [Question] Colour management
Date: Fri, 30 Jul 2004 20:12:36 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <200407302012.36325.alex.kern@gmx.de>
References: <20040722184937.GA11361@sci.fi> <200407252036.52194.alex.kern@gmx.de> <200407260647.03489.adaplas@hotpop.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Bqbs9-0006UU-Ll
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 30 Jul 2004 11:12:49 -0700
Received: from mail.gmx.de ([213.165.64.20] helo=mail.gmx.net)
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.34)
	id 1Bqbs9-0001Pz-2o
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 30 Jul 2004 11:12:49 -0700
In-Reply-To: <200407260647.03489.adaplas@hotpop.com>
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
To: adaplas@pol.net
Cc: linux-fbdev-devel@lists.sourceforge.net, Ville =?iso-8859-15?q?Syrj=E4l=E4?= <syrjala@sci.fi>


Hallo Tony,

can you explain the deep mining of fb_setcolreg. Background, I observe wrong 
palette using in 15 and 16 bpp modes, but can not understand, what is 
the right approach. In both cases from penguin logo I can see only contour in 
honey yellow and blue vertical string jsimmons, pretty scury ;-) The rest is 
black! The simple text or ncurses applications have always right colours.
Additionally and only by 16bpp fbi shows blurry images. In 15bpp fbi works 
fine. fbtest works fine and his penguins look good in all resolutions ?!

Regards Alex

P.S. where is our current tree of fbdev changes?


-------------------------------------------------------
This SF.Net email is sponsored by OSTG. Have you noticed the changes on
Linux.com, ITManagersJournal and NewsForge in the past few weeks? Now,
one more big change to announce. We are now OSTG- Open Source Technology
Group. Come see the changes on the new OSTG site. www.ostg.com
