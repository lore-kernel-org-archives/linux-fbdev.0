From: James Simmons <jsimmons@www.infradead.org>
Subject: Re: Geode now shows up in sysfs.
Date: Wed, 6 Jul 2005 23:31:36 +0100 (BST)
Message-ID: <Pine.LNX.4.56.0507062331170.6528@pentafluge.infradead.org>
References: <Pine.LNX.4.56.0507020032330.14405@pentafluge.infradead.org>
 <42C90AEF.4030601@arcom.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DqIQr-00076T-Ao
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 06 Jul 2005 15:31:53 -0700
Received: from pentafluge.infradead.org ([213.146.154.40])
	by sc8-sf-mx1-new.sourceforge.net with esmtp (Exim 4.44)
	id 1DqIQq-0006NK-2J
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 06 Jul 2005 15:31:53 -0700
In-Reply-To: <42C90AEF.4030601@arcom.com>
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
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev-devel@lists.sourceforge.net
Cc: "Antonino A. Daplas" <adaplas@hotpop.com>, Geert Uytterhoeven <geert@linux-m68k.org>, nat.ersoz@myrio.com, jsimmons@pentafluge.infradead.org


It is a pci device. I will send another patch to convert it to a pci 
device.

On Mon, 4 Jul 2005, David Vrabel wrote:

> James Simmons wrote:
> > Going through the drivers I noticed two drivers using framebuffer_alloc 
> > without a sturct device, Mach64 for atari and geode. Here is a patch for 
> > geode.
> 
> Thanks. It looks fine.
> 
> I've merged this patch with some other updates I had.  Please apply.
> 
> David Vrabel
> -- 
> David Vrabel, Design Engineer
> 
> Arcom, Clifton Road           Tel: +44 (0)1223 411200 ext. 3233
> Cambridge CB1 7EA, UK         Web: http://www.arcom.com/
> 


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
