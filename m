From: James Simmons <jsimmons@transvirtual.com>
Subject: Re: Linux 2.5.19
Date: Wed, 29 May 2002 15:43:37 -0700 (PDT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.10.10205291443020.19493-100000@www.transvirtual.com>
References: <20020529214739.F30585@flint.arm.linux.org.uk>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from www.transvirtual.com ([206.14.214.140])
	by usw-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 17DCAb-0003hO-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 29 May 2002 15:43:53 -0700
In-Reply-To: <20020529214739.F30585@flint.arm.linux.org.uk>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=linux-fbdev-devel>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Russell King <rmk@arm.linux.org.uk>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>


> > Due to a error with merging some stuff from a older DJ tree. I fixed it
> > in the fbdev BK repository.
> 
> They haven't *been* in any DJ tree.

    Looking threw the many patches I have from people I did grab it from 
patch-2.5.15-rmk1. It is right above the fbcmap.c fix which I did need.
That is where I go it from. Thank you for that fix.  

    While grabbing that fix I noticed what a appeared to be a simple two
line fix for the cyber2000fb driver. Actually I was tempted to port the
whole driver over to the new api but I didn't because I feared you be
ticked off. Especially since I don't have the hardware. The only drivers I
have ported over are the ones that are really simple. I touched the
anakin driver because of this reason. The complex one where I don't have
the hardware I don't touch. Now that we have enough functionally drivers
people can see the new changes needed to be done. 

> Why the fuck should I go around finding and testing peoples trees when I
> haven't submitted the stuff to them?  

    Look here. I'm not looking for trouble or to upset anyone. I know alot
of the fbdev driver maintainers are too busy to properly maintain the
drivers. Several have told me this. Or the drivers have been abandon.
Plus the docs have been shotty for porting to the new api. I am willing to
do extra work and port these drivers to save the maintainers time. I'm
not going to do a perfect port but I do hope what work I did do will help 
them out.  

    I do admit and apologize for not properly saying which drivers have
been altered. I will make a special note of doing that in the future.
Especially since very few actually look at my patches.
           





_______________________________________________________________

Don't miss the 2002 Sprint PCS Application Developer's Conference
August 25-28 in Las Vegas -- http://devcon.sprintpcs.com/adp/index.cfm
