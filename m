From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: clipping
Date: Fri, 10 Jan 2003 20:48:11 +0100 (MET)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.21.0301102045100.18440-100000@vervain.sonytel.be>
References: <Pine.LNX.4.44.0301101936110.18287-100000@phoenix.infradead.org>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from mail2.sonytel.be ([195.0.45.172] helo=mail.sonytel.be)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18X59p-0003Ac-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 10 Jan 2003 11:49:33 -0800
In-Reply-To: <Pine.LNX.4.44.0301101936110.18287-100000@phoenix.infradead.org>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: James Simmons <jsimmons@infradead.org>
Cc: Antonino Daplas <adaplas@pol.net>, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>

On Fri, 10 Jan 2003, James Simmons wrote:
> > > I thought about this. Originally I did have this function but removed it.
> > > WHat do you think Geert?
> > 
> > Yes, that's OK.
> > 
> > But I was most concerned about fb_ops.fb_imageblit(), since clipping impacts
> > fb_image.data as well. IIRC, all (most?) current clipping implementations
> > modify fb_image.{dx,dy,width,height} only, without updating fb_image.data.
> 
> Good point. Of course we could ignore pieces of data in that image instead 
> of altering the data. Altering the entire data would be expensive.

Actually I thought about modifying the fb_image.data pointer only. But indeed,
for monochrome expansion you may have to modify the data, since pixel
boundaries in a bitmap don't correspond to byte boundaries.

Alternatively, if fb_image would countain sx and sy fields (cfr. fb_copyarea),
we can just alter (a copy of) sx and sy when clipping.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds



-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
