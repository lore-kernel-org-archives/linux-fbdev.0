From: Vassilis Virvilis <vasvir@iit.demokritos.gr>
Subject: Re: Twister savagefb doesn't sync (resolved for
 640x480@64K)
Date: Mon, 12 Jun 2006 18:50:03 +0300
Message-ID: <448D8D2B.4090908@iit.demokritos.gr>
References: <44698356.80806@iit.demokritos.gr>	
	<447AF58E.3050803@iit.demokritos.gr> <447B60D7.8020204@gmail.com>	
	<44845DEC.1000608@iit.demokritos.gr>	
	<a728f9f90606052211v43de97c7l91a22a9faa93f76c@mail.gmail.com>	
	<44855197.7040801@iit.demokritos.gr>	
	<a728f9f90606060743t7fd6dfdfia3e2a050ff954e06@mail.gmail.com>	
	<448C067B.3040404@iit.demokritos.gr>	
	<a728f9f90606110803v10ca364xf3e32e4a40f4bbfa@mail.gmail.com>	
	<448D05EA.8060501@iit.demokritos.gr>
	<a728f9f90606120737x41f3ae1en60acaa8f16a319f5@mail.gmail.com>
Reply-To: vasvir@iit.demokritos.gr,
	linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-list1-b.sourceforge.net ([10.3.1.7]
	helo=sc8-sf-list1.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1FpobL-0000cD-BV for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 12 Jun 2006 08:45:15 -0700
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FpobL-0005qc-1v for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 12 Jun 2006 08:45:15 -0700
Received: from zeus.iit.demokritos.gr ([143.233.226.2])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1FpobG-0004io-Rd
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 12 Jun 2006 08:45:15 -0700
In-Reply-To: <a728f9f90606120737x41f3ae1en60acaa8f16a319f5@mail.gmail.com>
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
To: Alex Deucher <alexdeucher@gmail.com>
Cc: linux-fbdev-devel@lists.sourceforge.net, "Antonino A. Daplas" <adaplas@gmail.com>

Alex Deucher wrote:
> 
> about they most you can get on the savage is detecting whether or not
> there is a panel attached and what size the panel is.  AFAIK, there's
> no way to detect the panel specifics.  However, if we got some more
> datapoints and found that most panels need the plls tweaked to a
> certain range we could probably handle it more gracefully.  You could
> probably even get it working now if you used a special modeline.
> 
> Alex
> 

That's true. See at the start of the thread...
http://marc.theaimsgroup.com/?l=linux-fbdev-devel&m=114781832315079&w=2

"""
 >As a workaround for my EIZO I tried (succesfully)

 >#This syncronize at 60Hz vertical refresh rate (fbset -i repors 160Hz)
 >fbset -xres 640 -yres 480 -depth 16 -t 15385 48 16 33 10 96 2

This is not working for my other monitor a TFT Medion (1280x1024). So
I guess that makes it an EDID dependent bug.
"""
