From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: video dir reorg
Date: Wed, 15 Jan 2003 10:39:47 +0100 (MET)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.21.0301151038490.4227-100000@vervain.sonytel.be>
References: <Pine.LNX.4.44.0301150035470.23774-100000@phoenix.infradead.org>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from mail2.sonytel.be ([195.0.45.172] helo=mail.sonytel.be)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18Yk2j-0004qF-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 15 Jan 2003 01:41:05 -0800
In-Reply-To: <Pine.LNX.4.44.0301150035470.23774-100000@phoenix.infradead.org>
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
Cc: Sven Luther <luther@dpt-info.u-strasbg.fr>, Jon Smirl <jonsmirl@yahoo.com>, fbdev <linux-fbdev-devel@lists.sourceforge.net>

On Wed, 15 Jan 2003, James Simmons wrote:
> > Also, i think the drm drivers should compile not only on linux, but on
> > other oses too (BSDs at least).
> 
> That will be difficult. The VM layer to BSD is very very different from 
> linux. There is no way they coudl use the same code set for both without 
> making a mess. 

I think Sven meant the userspace part of DRM. Of course the actual kernelspace
implementation differs.

> > Also, i believe some of the XFree86 guys don't like fbdevs.
>  
> :-(

Yes indeed :-(

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds



-------------------------------------------------------
This SF.NET email is sponsored by: Take your first step towards giving 
your online business a competitive advantage. Test-drive a Thawte SSL 
certificate - our easy online guide will show you how. Click here to get 
started: http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0027en
