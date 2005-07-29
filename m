From: James Simmons <jsimmons@infradead.org>
Subject: Re: Re: [PATCH] fbdev: colormap fixes
Date: Fri, 29 Jul 2005 21:20:21 +0100 (BST)
Message-ID: <Pine.LNX.4.56.0507292119340.17988@pentafluge.infradead.org>
References: <200507280031.j6S0V3L3016861@hera.kernel.org>  <42E8F0CD.6070500@gmail.com>
  <Pine.LNX.4.62.0507281758080.24391@numbat.sonytel.be> 
 <9e473391050728092936794718@mail.gmail.com>  <9e47339105072811183ac0f008@mail.gmail.com>
  <Pine.LNX.4.62.0507282202450.29876@numbat.sonytel.be> 
 <9e4733910507281315419c3c12@mail.gmail.com>  <9e47339105072813213db7cee4@mail.gmail.com>
  <9e47339105072813507c00687e@mail.gmail.com>  <Pine.LNX.4.62.0507282337410.29876@numbat.sonytel.be>
 <9e47339105072814505b6fe4f8@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DybLU-0001J0-DF
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 29 Jul 2005 13:20:40 -0700
Received: from pentafluge.infradead.org ([213.146.154.40])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44)
	id 1DybLS-0005vS-So
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 29 Jul 2005 13:20:40 -0700
In-Reply-To: <9e47339105072814505b6fe4f8@mail.gmail.com>
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
To: Jon Smirl <jonsmirl@gmail.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, "Antonino A. Daplas" <adaplas@gmail.com>, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>, Linux Kernel Development <linux-kernel@vger.kernel.org>


> > No, bits_per_pixel can be (much) larger than the color map size. E.g. a simple
> > ARGB8888 directcolor mode has bits_per_pixel = 32 and color map size = 256.
> 
> So I have the bits_per_pixel attribute wrong in sysfs. It needs to be
> bits_per_color and then let the driver sort it out.  Otherwise there
> is no way to set ARGB8888 versus ARGB2101010. With bits per color you
> would set 8 or 10.

You would need bits_per_read, bit_per_green. This doesn't event count the 
other color spaces avaliable like YUV.



-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
