From: Michal Januszewski <spock@gentoo.org>
Subject: [announce 0/7] fbsplash - The Framebuffer Splash
Date: Tue, 8 Mar 2005 02:57:31 +0100
Message-ID: <20050308015731.GA26249@spock.one.pl>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D8Tya-0002dV-Pl
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 07 Mar 2005 17:57:36 -0800
Received: from ipp23-131.piekary.net ([80.48.23.131] helo=spock.one.pl)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41)
	id 1D8TyZ-0008Ln-29
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 07 Mar 2005 17:57:36 -0800
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
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: linux-fbdev-devel@lists.sourceforge.net

Fbsplash - The Framebuffer Splash - is a feature that allows displaying
images in the background of consoles that use fbcon. The project is
partially descended from bootsplash. 

Unlike bootsplash, fbsplash has no in-kernel image decoder. Picture 
decompression is handled by a userspace helper which provides raw image 
data to the kernel. There is also no support for things like the silent 
mode and progress bars, as these are best handled by userspace programs. 

Truecolor, directcolor and pseudocolor modes are supported. Fbsplash has
no dependency on a specific framebuffer driver. It has been tested with
at least vesafb, rivafb and radeonfb.

Technical details about the userspace<->kernelspace interface can be 
found in patch 07/07, which contains the documentation.

The userspace utilities that make use of fbsplash can be found on:
http://dev.gentoo.org/~spock/projects/splashutils/

Live long and prosper.
-- 
Michal 'Spock' Januszewski                        Gentoo Linux Developer
cell: +48504917690                         http://dev.gentoo.org/~spock/
JID: spock@im.gentoo.org               freenode: #gentoo-dev, #gentoo-pl





-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
