From: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: waitforVBlank, how does this even work?
Date: Wed, 2 Mar 2005 12:09:12 -0500
Message-ID: <9e473391050302090926854d95@mail.gmail.com>
References: <9e473391050301215019081bce@mail.gmail.com>
	 <Pine.LNX.4.62.0503021128001.14333@node2.an-vo.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
In-Reply-To: <Pine.LNX.4.62.0503021128001.14333@node2.an-vo.com>
Sender: dri-devel-admin@lists.sourceforge.net
Errors-To: dri-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/dri-devel>,
	<mailto:dri-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:dri-devel@lists.sourceforge.net>
List-Help: <mailto:dri-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/dri-devel>,
	<mailto:dri-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=dri-devel>
Content-Type: text/plain; charset="us-ascii"
To: Vladimir Dergachev <volodya@mindspring.com>
Cc: fbdev <linux-fbdev-devel@lists.sourceforge.net>, DRI developer's list <dri-devel@lists.sourceforge.net>

On Wed, 2 Mar 2005 11:32:44 -0500 (EST), Vladimir Dergachev
<volodya@mindspring.com> wrote:
>     What about isolating interrupt-handling code into a small driver ?
> Something simple to respond to interrupts and call all handlers with a
> certain mask.

My current plan is that fbdev is the base driver and I will modify the
other drivers to bind to it. It is possible to split about 50K out of
the fbdev driver into another module and make a smaller base driver
but I'm not working on size isssues. Right now all I want to do is get
a combined fbdev/DRM on the radeon with enough features to support
mesa-solo. XGL needs most of both DRM and fbdev features. After that I
have to spend a bunch of time getting it into Linus' tree.

I would find it useful if someone came up with a standard kernel space
V4L radeon driver instead of the Gatos stuff.


-- 
Jon Smirl
jonsmirl@gmail.com


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
--
