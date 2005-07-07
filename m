From: David Vrabel <dvrabel@arcom.com>
Subject: Re: Geode now shows up in sysfs.
Date: Thu, 07 Jul 2005 17:09:15 +0100
Message-ID: <42CD53AB.7040207@arcom.com>
References: <Pine.LNX.4.56.0507020032330.14405@pentafluge.infradead.org> <42C90AEF.4030601@arcom.com> <Pine.LNX.4.56.0507062331170.6528@pentafluge.infradead.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DqYwJ-0002TG-Gb
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 07 Jul 2005 09:09:27 -0700
Received: from webapps.arcom.com ([194.200.159.168])
	by sc8-sf-mx1-new.sourceforge.net with esmtp (Exim 4.44)
	id 1DqYwF-0005iB-Nk
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 07 Jul 2005 09:09:27 -0700
In-Reply-To: <Pine.LNX.4.56.0507062331170.6528@pentafluge.infradead.org>
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
To: linux-fbdev-devel@lists.sourceforge.net
Cc: "Antonino A. Daplas" <adaplas@hotpop.com>, Geert Uytterhoeven <geert@linux-m68k.org>, nat.ersoz@myrio.com, jsimmons@pentafluge.infradead.org

James Simmons wrote:
> It is a pci device. I will send another patch to convert it to a pci 
> device.

I think it should remain as a platform device because the principle
device involved (the display controller which does all the framebuffer
stuff) is not a PCI device.

David Vrabel
-- 
David Vrabel, Design Engineer

Arcom, Clifton Road           Tel: +44 (0)1223 411200 ext. 3233
Cambridge CB1 7EA, UK         Web: http://www.arcom.com/


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
