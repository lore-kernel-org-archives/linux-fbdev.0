From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Fw: [Bugme-new] [Bug 4218] New: Radeon fb doesn't have correct
 resolution for lcd screen
Date: Thu, 17 Feb 2005 09:12:56 +1100
Message-ID: <1108591976.5533.4.camel@gaston>
References: <20050215133933.61769fd0.akpm@osdl.org>
	 <1108504048.13376.11.camel@gaston>  <200502160948.51781.bart@verwilst.be>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D1XR0-00056c-Bx
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 16 Feb 2005 14:14:14 -0800
Received: from gate.crashing.org ([63.228.1.57])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41)
	id 1D1XQy-0002KC-PA
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 16 Feb 2005 14:14:14 -0800
In-Reply-To: <200502160948.51781.bart@verwilst.be>
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
To: Bart Verwilst <bart@verwilst.be>
Cc: Andrew Morton <akpm@osdl.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Wed, 2005-02-16 at 09:48 +0100, Bart Verwilst wrote:
> Hi!
> 
> Hm, i'm not sure wether it's radeonfb or not 
> 
> ----
> 
> vesafb: framebuffer at 0xe0000000, mapped to 0xdc880000, using 1875k, total 
> 65472k
> vesafb: mode is 800x600x16, linelength=1600, pages=67
> vesafb: protected mode interface info at c000:51a9
> vesafb: scrolling: redraw
> vesafb: Truecolor: size=0:5:6:5, shift=0:11:5:0
> bootsplash 3.1.4-2004/02/19: looking for picture.... silentjpeg size 14554 
> bytes, found (800x600, 14506 bytes, v3).
> Console: switching to colour frame buffer device 92x32
> fb0: VESA VGA frame buffer device
> 
> ---
> 
> Is radeonfb a driver for vesafb? Or are they unrelated?
> 
> Could you give me some more pointers for me what i could do to test more? Or 
> will enabling radeonfb debug support still be helpful?

They are unrelated, so your problem is probably not related to
radeonfb...

Ben.
 



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
