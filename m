From: Michal Suchanek <hramrach@centrum.cz>
Subject: Re: [RFC 2.6.28 1/1] defio: convert pagelist
	into pagemap
Date: Wed, 21 Jan 2009 14:45:13 +0100
Message-ID: <a5d587fb0901210545l679c106lebadd7b7134a8ead@mail.gmail.com>
References: <12321948953089-git-send-email-jayakumar.lkml@gmail.com>
	<aec7e5c30901181922o65e7eb4avc57a5e93ad517ddf@mail.gmail.com>
	<45a44e480901190658o78353f53x264bca09003b4b21@mail.gmail.com>
	<aec7e5c30901192138m1ec51767m44dc39d61ae270ce@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <hramrach@gmail.com>) id 1LPdOQ-0003fV-NZ
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 21 Jan 2009 13:45:18 +0000
Received: from fg-out-1718.google.com ([72.14.220.152])
	by 1b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1LPdON-0003Bs-1U for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 21 Jan 2009 13:45:18 +0000
Received: by fg-out-1718.google.com with SMTP id d23so1697599fga.32
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Wed, 21 Jan 2009 05:45:13 -0800 (PST)
In-Reply-To: <aec7e5c30901192138m1ec51767m44dc39d61ae270ce@mail.gmail.com>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Magnus Damm <magnus.damm@gmail.com>
Cc: linux-fbdev-devel@lists.sourceforge.net, adaplas@gmail.com, armbru@redhat.com, lethal@linux-sh.org, Geert Uytterhoeven <geert@linux-m68k.org>, Jaya Kumar <jayakumar.lkml@gmail.com>

2009/1/20 Magnus Damm <magnus.damm@gmail.com>:

> Double buffering and diffing sounds like an interesting strategy, but
> that is not what I had in mind with the tile bitmap. =) My plan is to
> keep the format of the frame buffer unchanged. Still a range of pages.
>
> The frame buffer pages have dirty bits associated with them. One way
> or the other. =) Each bit represents one page, and the frame buffer
> data stored in a page most likely consists of several lines. The start
> and end x position of the data in a page varies unless the page size
> can be evenly divided by the width of the frame buffer. Which is
> seldom the case. So the dirty bits associated with pages seldom form
> rectangles.
>
> With the tile bitmap the frame buffer is divided into rectangles. The
> frame buffer data is still kept the same way as usual, but we also
> have a bitmap which represents the screen as a matrix of bits. Each
> bit maps to one rectangle. The size of the rectangle can be anything
> from 1x1 pixel up to width x height, but all rectangles have the same
> size for a single frame buffer. (2 ^ order side squares simple?)
>
> This tile bitmap is then used to mark which rectangles that are dirty.
> The damage API and fillrect/copyarea/imageblit functions then all set
> bits in the tile bitmap to mark dirty areas of the frame buffer. I
> guess write and deferred io mmap still need to operate on the page
> bitmap.
>
> When it's time to update the screen we can either transform the page
> bitmap into the tile bitmap or the other way around. Then   generate
> dma requests from that.
>
> Does it sound strange? =)
>
Yes, it does.

Suppose I write an application that plots a pixel on the framebuffer,
and tells the kernel that this particular 1x1 square is dirty.

Now the kernel expands the 1x1 square to a tile and marks it dirty,
and it also finds out that the FB memory was written and one of its
pages is dirty. So it

a) expands the page to tiles, resulting in a whole row(s) of tiles dirtied

b) expands the tile to pages resulting in several consecutive pages
that cross the tile dirtied

Either way it expands the area that is transferred which is what this
whole thing was trying to prevent, right?

Well, perhaps you had something else in mind which I don't quite understand.

Thanks

Michal

------------------------------------------------------------------------------
This SF.net email is sponsored by:
SourcForge Community
SourceForge wants to tell your story.
http://p.sf.net/sfu/sf-spreadtheword
