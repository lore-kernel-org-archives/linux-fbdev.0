From: James Simmons <jsimmons@www.infradead.org>
Subject: Re: [announce 0/7] fbsplash - The Framebuffer
 Splash
Date: Tue, 15 Mar 2005 19:22:36 +0000 (GMT)
Message-ID: <Pine.LNX.4.56.0503151920080.5506@pentafluge.infradead.org>
References: <20050308015731.GA26249@spock.one.pl> 
 <Pine.LNX.4.62.0503091033400.22598@numbat.sonytel.be> 
 <1110392212.3116.215.camel@localhost.localdomain> 
 <Pine.LNX.4.56.0503092043380.7510@pentafluge.infradead.org> 
 <1110408049.9942.275.camel@localhost.localdomain> 
 <Pine.LNX.4.62.0503101009240.9227@numbat.sonytel.be>  <20050310145419.GD632@openzaurus.ucw.cz>
  <Pine.LNX.4.56.0503111801550.10827@pentafluge.infradead.org> 
 <9e473391050311101356536667@mail.gmail.com> 
 <Pine.LNX.4.56.0503151855430.5506@pentafluge.infradead.org>
 <9e4733910503151103b8a9c8f@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DBHcs-0003mf-RF
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 15 Mar 2005 11:22:46 -0800
Received: from pentafluge.infradead.org ([213.146.154.40])
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41)
	id 1DBHcr-0000aI-CP
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 15 Mar 2005 11:22:46 -0800
In-Reply-To: <9e4733910503151103b8a9c8f@mail.gmail.com>
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
Cc: linux-fbdev-devel@lists.sourceforge.net, Geert Uytterhoeven <geert@linux-m68k.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, James Simmons <jsimmons@pentafluge.infradead.org>, Michal Januszewski <spock@gentoo.org>, Linux Kernel Development <linux-kernel@vger.kernel.org>, "Antonino A. Daplas" <adaplas@hotpop.com>


> DRM doesn't know a thing about 3D. All it does is DMA, memory
> management and queue things up for the GPU to work on. You don't even
> have to have a GPU processor you could use the CPU to execute the
> commands.
> 
> It's the code up in mesa that knows about 3D and builds the commands
> to be sent to DRM.

Not all devices are DMA. Personally since it is generic DMA engine then 
why not move it to the device api so everyone could use it. We already 
have DMA pools. Actually I have started some work for some generic DMA 
handling for the device api core but I have other fish to fry first.



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
