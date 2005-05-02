From: James Simmons <jsimmons@www.infradead.org>
Subject: Re: [PATCH] Resource management for fbdev.
Date: Mon, 2 May 2005 20:28:40 +0100 (BST)
Message-ID: <Pine.LNX.4.56.0505022013360.25864@pentafluge.infradead.org>
References: <Pine.LNX.4.56.0503260019020.20306@pentafluge.infradead.org>
 <1112925171.9517.358.camel@gaston>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DSgay-0004L9-RP
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 02 May 2005 12:28:44 -0700
Received: from pentafluge.infradead.org ([213.146.154.40])
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41)
	id 1DSgax-0004pN-7M
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 02 May 2005 12:28:44 -0700
In-Reply-To: <1112925171.9517.358.camel@gaston>
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
To: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>
Cc: "Antonino A. Daplas" <adaplas@hotpop.com>, Andrew Morton <akpm@osdl.org>, Geert Uytterhoeven <geert@linux-m68k.org>


> I had a quick look, and I'm fairly confused. That patch introduces a lot
> of changes all over the place without any comment or explanation, in
> code that has proven in the past to be fragile and prone to side
> effects. Also, I see no explanation of the rationale for the resource
> manager and it's API. At a minimum, the patch should be split into
> 
>  - implementation of the resource manager with appropriate explanations
> and documentation
>  - driver updates

I have no problem splitting the patch up into several parts. It was 
addressing several problems. Plus I was doing some cleanups. Currently 
we have sprite and pixmap for drawing images and the cursor. We also need
one for merging the font images for framebuffer console. I really didn't 
want to add another fb_pixmap to struct fb_info. I will send some stuff 
later. 

 
> Have you worked at all with the DRM folks ? We have a bad need to merge
> DRM and fbdev as soon as possible and we need while doing so to impement
> some kind of efficient memory manager for the card video RAM. I'm not
> sure your proposal fits into this picture.

No. I haven't heard anything on this mailing list. Also I'm preparing for 
a plug fest for work. So I will be gone for May 16-18. We have been 
working like mad getting ready for it.



-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.
Get your fingers limbered up and give it your best shot. 4 great events, 4
opportunities to win big! Highest score wins.NEC IT Guy Games. Play to
win an NEC 61 plasma display. Visit http://www.necitguy.com/?r=20
