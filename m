From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Fwd: linux-kernel radeonfb: Display corruption with power
 managment, after a while it goes away automatically
Date: Fri, 18 Mar 2005 10:55:39 +1100
Message-ID: <1111103739.25179.25.camel@gaston>
References: <20050317234540.12743.qmail@web53307.mail.yahoo.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DC4qu-0004qe-BD
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 17 Mar 2005 15:56:32 -0800
Received: from gate.crashing.org ([63.228.1.57])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41)
	id 1DC4qr-00060t-UG
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 17 Mar 2005 15:56:32 -0800
In-Reply-To: <20050317234540.12743.qmail@web53307.mail.yahoo.com>
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
To: Tony Daplas <aadaplas@yahoo.com>
Cc: adaplas@pol.net, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, sebastian_ml@gmx.net

On Thu, 2005-03-17 at 15:45 -0800, Tony Daplas wrote:

> > I have a desktop computer with a radeon 9250 agp
> > card from connect3d. I
> > append radeonfb.default_dynclk=1 when loading the
> > kernel or use options
> > radeonfb default.dynclk=1 when using modules. I
> > understand the power
> > managment feature is mostly for mobility cards for
> > laptops, but I like
> > it very much because my card stays much cooler with
> > it.
> > The problem is that, no matter if I load the module
> > or build it
> > statically in the kernel the screen gets garbled
> > until init says it's
> > "Setting user font".

Not forcing the power management makes a difference ?

Ben.




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
