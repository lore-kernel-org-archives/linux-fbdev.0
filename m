From: Ian Romanick <idr@us.ibm.com>
Subject: Re: FB model basic issues (WAS: radeon, apertures & memory mapping)
Date: Tue, 15 Mar 2005 13:58:37 -0800
Message-ID: <42375A8D.8000704@us.ibm.com>
References: <1110677744.19810.80.camel@gaston>	 <9e47339105031219223e606a52@mail.gmail.com>	 <1110696189.5787.100.camel@gaston>	 <1110774523.4003.511.camel@localhost>	 <1110784327.5787.288.camel@gaston>	 <1110817205.4004.527.camel@localhost>	 <1110837171.5863.16.camel@gaston>	 <1110838356.4003.548.camel@localhost>	 <1110839873.5673.41.camel@gaston> <9e473391050314213075ce0e47@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
In-Reply-To: <9e473391050314213075ce0e47@mail.gmail.com>
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
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: dri-devel@lists.sourceforge.net
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, xorg@lists.freedesktop.org

Jon Smirl wrote:

> Can we put in our own fault handler for the mmap, trap the directfb
> accesses and do the proper locking?

Some SGI hardware used to work like that.  When they asked Linus for 
some kernel hooks to support that type of thing, well...I'm just glad 
*I* wasn't in the line of fire. ;)  I seriously doubt that it would be 
looked upon any kinder now.


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
