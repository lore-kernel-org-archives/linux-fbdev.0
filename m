From: Adrian Bunk <bunk@stusta.de>
Subject: Re: [2.6 patch] sstfb.c: make some code static
Date: Thu, 25 Nov 2004 16:36:07 +0100
Message-ID: <20041125153607.GC3537@stusta.de>
References: <20041121153646.GA2829@stusta.de> <1101336587.2571.1.camel@localhost.localdomain>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CXLg7-0001dB-AG
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 25 Nov 2004 07:37:03 -0800
Received: from mailout.stusta.mhn.de ([141.84.69.5])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.41)
	id 1CXLg6-0000Oi-80
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 25 Nov 2004 07:37:03 -0800
Content-Disposition: inline
In-Reply-To: <1101336587.2571.1.camel@localhost.localdomain>
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
Content-Transfer-Encoding: 7bit
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Ghozlane Toumi <gtoumi@laposte.net>, Antonino Daplas <adaplas@pol.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-fbdev-devel@lists.sourceforge.net

On Wed, Nov 24, 2004 at 10:49:47PM +0000, Alan Cox wrote:
> On Sul, 2004-11-21 at 15:36, Adrian Bunk wrote:
> > The patch below makes some needlessly global code static.
> 
> No it doesn't. It makes some functions static (which is fine) and adds
> some nasty messy pointless #ifdefs. It touches no variable at all.
> 
> Please check your description texts and also don't fill the kernel with
> ifdef crap. Probably the __setup stuff should be a module param new
> style too.

Yes, the description text could have been better.

The "ifdef crap" comes from the fact, that after making the functions 
static, gcc warns if they are unused.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
