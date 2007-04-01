From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: [PATCH] nvidiafb: Fix reversed DDC port
Date: Mon, 02 Apr 2007 07:33:32 +0800
Message-ID: <1175470412.7772.12.camel@daplas>
References: <460F7CF4.60006@gmail.com>
	<21d7e9970704011607h3d901car4cdfe466396e7797@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HY9YW-000061-BQ for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 01 Apr 2007 16:33:52 -0700
Received: from nz-out-0506.google.com ([64.233.162.237])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HY9YU-0001UE-QN
	for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 01 Apr 2007 16:33:52 -0700
Received: by nz-out-0506.google.com with SMTP id i11so1635965nzi
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Sun, 01 Apr 2007 16:33:50 -0700 (PDT)
In-Reply-To: <21d7e9970704011607h3d901car4cdfe466396e7797@mail.gmail.com>
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
To: linux-fbdev-devel@lists.sourceforge.net
Cc: Andrew Morton <akpm@osdl.org>, Petr Vandrovec <vandrove@vc.cvut.cz>

On Mon, 2007-04-02 at 09:07 +1000, Dave Airlie wrote:
> > After I added some debugging printks I've found that code became a bit
> > confused because it believed that primary monitor is 1920x540, but later
> > it found in CRTC0's registers that panel size is 1920x1200 (Windows also
> > agree that 1920x1200 is primary monitor, and 1920x1080i secondary one).
> >
> > When I applied attached patch then my monitor became as happy as it was
> > before I connected HDMI cable to secondary output.
> >
> 
> I don't think this will do much except break other peoples cards,
> different nvidia cards map the i2c to outputs differently, the correct
> way to fix it is to read a table in the BIOS called the DCB table (for
> NV4x and above...) guess what? we don't know how to do that properly
> because nvidia are very unfriendly...
> 

True. The port assignment does not matter for a single display, or
dual-displays with different output types, as nvidiafb and nv has code
that matches the EDID output to the monitor type. 

If nvidia is not consistent with the port assignment, and there is no
sane way of determining this, the best hack we can do is a boot option.

Anyway, Petr's patch is still 'correct', because, in relation with X's
nv driver, the ports are indeed reversed :-)

Tony 



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
