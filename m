From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: Re: Resource management.
Date: Fri, 25 Feb 2005 07:05:47 +0800
Message-ID: <200502250705.48630.adaplas@hotpop.com>
References: <Pine.LNX.4.56.0502211908520.14500@pentafluge.infradead.org> <200502222206.31364.adaplas@hotpop.com> <Pine.LNX.4.56.0502241951001.5491@pentafluge.infradead.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D4S3c-000119-Sj
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 24 Feb 2005 15:06:08 -0800
Received: from smtp-out.hotpop.com ([38.113.3.71])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1D4S3a-0001aL-BX
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 24 Feb 2005 15:06:08 -0800
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id 94717141C0DE
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 24 Feb 2005 23:05:50 +0000 (UTC)
In-Reply-To: <Pine.LNX.4.56.0502241951001.5491@pentafluge.infradead.org>
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
To: James Simmons <jsimmons@www.infradead.org>, adaplas@pol.net
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, James Simmons <jsimmons@pentafluge.infradead.org>, Geert Uytterhoeven <geert@linux-m68k.org>

On Friday 25 February 2005 03:57, James Simmons wrote:
> > If you intend to insist on doing this, this is my proposal:
> >
> > The linked list of resources per fb_info can be kept. However, instead
> > of doing an fb_find_resource() per call to putcs and cursor, this can
> > be done only once, during initialization of fbcon or set_con2fb_map.
> > This resource can then be stored in an fbcon-private area.
>
> I fixed this in my latest work. Alot of cleanups has happened. Still a few
> issues to work out.

Looks much better. And yes, I also see a few issues but is not your fault.

>
> > The advantage of this is that fbcon will only look for the resource that
> > it needs, ie "scratchpad" but not, for example, "overlay". Similarly,
> > a user video application can totally ignore "scratchpad" but will search
> > for "overlay".  Secondly, the performance penalty suffered by the your
> > initial patch will be eliminated. We also eliminate one or two more
> > fields in fb_info directly accessed by fbcon.
>
> I removed the scratch pad. We use the data reflecting the "drawable"
> properties.
>
> > Also, instead of storing the resource type as a string, why not use a
> > constant?
>
> We would run out very fast. 

With a u32?

> Plus we would need a index field in the case
> we have more than one of the same kind.

Then use a u32 for type, u32 for index.

Tony




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
