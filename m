From: Henk Vergonet <rememberme@systol.god.lan>
Subject: Re: PATCH Proposal make FB_ACCEL_ private to the driver
Date: Sun, 27 Feb 2005 23:17:15 +0100
Message-ID: <20050227221715.GA16837@systol.god.lan>
References: <20050227032611.GB14968@systol.god.lan> <Pine.LNX.4.62.0502271926560.3143@numbat.sonytel.be>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D5Wj6-0007Nq-9x
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 27 Feb 2005 14:17:24 -0800
Received: from god.demon.nl ([83.160.164.11] helo=god.dyndns.org)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1D5Wj4-0008Ss-0u
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 27 Feb 2005 14:17:23 -0800
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.62.0502271926560.3143@numbat.sonytel.be>
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
To: linux-fbdev-devel@lists.sourceforge.net

On Sun, Feb 27, 2005 at 07:28:47PM +0100, Geert Uytterhoeven wrote:
> On Sun, 27 Feb 2005, Henk Vergonet wrote:
> I'm afraid you will never see this reply, as rememberme@systol.god.lan won't
> resolve....

It is intentional, but if it's a problem I can fix it.

> 
> > I want to propose to localize the maintenance and registration of the
> > FB_ACCEL_ id's and remove it from the public fb.h include file.
> > 
> > Motivation:
> > - This removes an unneeded dependency to fb.h if an additional cards/chips are
> >   introduced. (These id's are only interesting for the driver anyhow. 
> >   Only fbset will print out the id, but I'll doubt this is used by anyone.)
> 
> Yes, it's used by userspace apps that need to know the graphics card type (e.g.
> DirectFB and the good old XF68_FBDev).

My point is not that there are no userspace utils that use it. But that
we should lose this identifier in the public interface eventually because it introduces unneeded dependencies as stated in my earlier post.

If it's used by userspace in any other way than for pure informational purposes:
For example to make certain assumptions on hardware capabilities, locations of specific hardware registers ...) then that's ok but should be considered as a make-shift solution until we have found a better solution drivers/API.

I know this may be only a small issue to most, I am sure there are more pressing issues, but small cleanups in the fb interface will eventually pay of in the long run.

What do we think developers... 

Do we think it's a good idea to remove the FB_ACCEL register in the fb.h in the future, or is it a no-go?
If nobody thinks it's a good idea I'll shut up, (for now ;)

Best regards,

Henk


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
