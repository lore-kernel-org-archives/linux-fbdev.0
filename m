From: James Simmons <jsimmons@www.infradead.org>
Subject: Re: rotate the screen on ARM board
Date: Wed, 2 Mar 2005 17:21:22 +0000 (GMT)
Message-ID: <Pine.LNX.4.56.0503021719550.20488@pentafluge.infradead.org>
References: <4EE0CBA31942E547B99B3D4BFAB348113A4341@mail.esn.co.in>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D6XXP-0006Xc-DS
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 02 Mar 2005 09:21:31 -0800
Received: from pentafluge.infradead.org ([213.146.154.40])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41)
	id 1D6XXM-0005OV-Fx
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 02 Mar 2005 09:21:31 -0800
In-Reply-To: <4EE0CBA31942E547B99B3D4BFAB348113A4341@mail.esn.co.in>
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
To: "Mukund JB." <mukundjb@esntechnologies.co.in>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>


> I have query about how to rotate the screen on an ARM board i.e EDB9312
> which I recently brought.
> 
> I want rotate it by 90 degree.

It depends. First does the hardware support it? If it does in 2.6.X there 
is a hook for framebuffer rotation. If it doesn't then life will be harder 
since no one has write a software rotation. Personally I wouldn't like to 
have software rotation code in the kernel. 


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
