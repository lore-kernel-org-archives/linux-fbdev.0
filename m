From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: Re: Fw: Initialisation sequencing.
Date: Thu, 3 Mar 2005 14:38:46 +0800
Message-ID: <200503031438.48357.adaplas@hotpop.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D6jzW-0008IV-2D
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 02 Mar 2005 22:39:22 -0800
Received: from smtp-out.hotpop.com ([38.113.3.61])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1D6jzU-0005oR-NX
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 02 Mar 2005 22:39:21 -0800
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id F265AF4B39C
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu,  3 Mar 2005 06:38:53 +0000 (UTC)
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
To: linux-fbdev-devel@lists.sourceforge.net
Cc: Ian Molton <spyro@f2s.com>


--- Andrew Morton <akpm@osdl.org> wrote:

> 
> 
> Begin forwarded message:
> 
> Date: Wed, 02 Mar 2005 23:32:51 +0000
> From: Ian Molton <spyro@f2s.com>
> To: Kernel Mailing List
> <linux-kernel@vger.kernel.org>
> Subject: Initialisation sequencing.
> 
> 
> Hi.
> 
> I have a problem. It affects both modular and non
> modular builds, and I 
> dont see an obviously correct solution.
> 
> The problem is that I have a video chip which
> supports some GPIOs and an 
> LCD display.
> 
> some LCD functions are controlled via the GPIOs,
> like backlighting.
> 
> so the driver is split into a video driver which
> exports three GPIO 
> related functions, and a backlight driver which
> requires them to work. 
> Both are on the platform bus.
> 
> the problem occurs when the backlight driver gets
> probed before the 
> video driver. it tries to access the GPIO functions,
> which try to write 
> to random locations as the memory hasnt been
> ioremap()ed by the as yet 
> unprobed video driver, and it all predictably falls
> over in a gibbering 
> heap.
> 

If your backlight driver depends on the video driver, then you
just have to initialize backlight after video.

Why not place your backlight driver in after drivers/video in
drivers/Makefile?

Tony 
> I cant spin at this point without deadlocking the
> video driver and 
> ending up never being able to call the gpio
> functions, for obvious reasons.
> 
> I've tried making the backlight driver a child of
> the video driver, 
> hoping the probe functions are called in 'bus
> order', ie. parents first. 
> This failed.
> 
> I could make the backlight driver initialise late,
> but that seems like a 
> hack. scheduling work risks deadlock.
> 
> what is the correct solution? does one exist?
> -
> To unsubscribe from this list: send the line
> "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at 
> http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
> 
> -------------------------------------------------------
> SF email is sponsored by - The IT Product Guide
> Read honest & candid reviews on hundreds of IT
> Products from real users.
> Discover which products truly live up to the hype.
> Start reading now.
> http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
> _______________________________________________
> Linux-fbdev-devel mailing list
> Linux-fbdev-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel
> 
> 




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
