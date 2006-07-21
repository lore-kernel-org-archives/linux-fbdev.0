From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: YUV support
Date: Sat, 22 Jul 2006 05:19:45 +0800
Message-ID: <44C144F1.4060608@gmail.com>
References: <A52F3235-4BC6-4B97-921D-5FFD642AA044@cecropia.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1G42Pg-0008R7-Co for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 21 Jul 2006 14:20:00 -0700
Received: from py-out-1112.google.com ([64.233.166.177])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1G42Pd-00034o-Rs
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 21 Jul 2006 14:20:00 -0700
Received: by py-out-1112.google.com with SMTP id d42so1364684pyd
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Fri, 21 Jul 2006 14:19:54 -0700 (PDT)
In-Reply-To: <A52F3235-4BC6-4B97-921D-5FFD642AA044@cecropia.com>
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
Cc: Dennis Munsie <dmunsie@cecropia.com>

Dennis Munsie wrote:
> Hi again,
> 
> I'm starting to investigate adding YUV support to the intelfb driver,  
> and I was wondering what support is already in the framebuffer  
> subsystem for YUV.  Doing a quick grep for YUV only yielded a handful  
> of references -- all in drivers.  Nothing seems to be there for  
> generic YUV support.
> 
> Am I correct in this assumption?

Yes, you are correct.

> And, if so, what would be the best  
> way to expose YUV support?

Create a new visual, FB_VISUAL_YUV_PACKED, then treat 
var->{red,green,blue} as Y, U and V instead. This way, one can continue
to use the cfb_* generic drawing funtions.

For planar formats, it's pretty much the same except you have to provide
your own drawing functions.

> Driver specific ioctl's?

sysfs is probably better.

> Separate fb  
> device for the YUV overlay?

Yes. Some drivers have fb0 for the primary, fb1 for the overlay, and fb2 for
the cursor.

>  Give up and use X?

Or you can use directfb, I bet the i830 there has overlay support.

Tony

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
