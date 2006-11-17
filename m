From: James Simmons <jsimmons@infradead.org>
Subject: Re: fbmem: is bootup logo broken for monochrome
 LCD ?
Date: Fri, 17 Nov 2006 18:40:05 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0611171825520.32200@pentafluge.infradead.org>
References: <45535C08.5020607@innova-card.com> 
	<Pine.LNX.4.64.0611122138030.9472@pentafluge.infradead.org> 
	<cda58cb80611130153n60579de0w2ebb59b050595b3b@mail.gmail.com> 
	<Pine.LNX.4.64.0611131415270.25397@pentafluge.infradead.org> 
	<cda58cb80611131027h5052bf80va06003c23b844fe@mail.gmail.com> 
	<Pine.LNX.4.64.0611131850410.2366@pentafluge.infradead.org>
	<cda58cb80611140144q79718798p40f2762955c1d91@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Gl8dJ-0000CC-2Z for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 17 Nov 2006 10:40:13 -0800
Received: from pentafluge.infradead.org ([213.146.154.40])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1Gl8dG-0007MM-H4
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 17 Nov 2006 10:40:13 -0800
In-Reply-To: <cda58cb80611140144q79718798p40f2762955c1d91@mail.gmail.com>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Franck Bui-Huu <vagabon.xyz@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>


> > +static inline void slow_imageblit(const struct fb_image *image,
> > +                                 struct fb_info *p, u8 __iomem *dst,
> > +                                 u32 start_index, u32 pitch_index)
> 
> I still have my problem there: for example if image data are
> 0, 0, 0x54, 0, ...
> 
> then slow_imageblit() will write into the frame buffer, the following bytes:
> 0, 0, 0x2a, 0, ...
> 
> instead of the initial ones:
> 0, 0, 0x54, 0, ...
> 
> Bits of each bytes are reversed. I already tried to explain my
> problem, please look at
> 
> http://marc.theaimsgroup.com/?l=linux-kernel&m=116315548626875&w=2
 
Are those actually numbers? If they are the problem isn't byte reversal 
but bit shifting.

1010100 = 54
0101010 = 2A
 
> > +       if (fb_logo.depth == 1) {
> > +               if (info->fix.visual == FB_VISUAL_MONO01) {
> > +                       u32 fg = image.fg_color;
> > +
> > +                       image.fg_color = image.bg_color;
> > +                       image.bg_color = fg;
> 
> I had to fix this part to make the bootup logo worked. image.fg_color
> is not uninitialised at this point. I had to change this part as
> follow:
> 
> 	if (fb_logo.depth == 1) {
> 		image.fg_color = (info->fix.visual == FB_VISUAL_MONO01) ? 1:
> 0;
> 		image.bg_color = !image.fg_color;
> 	}
> 
> Otherwise this part of your patch (the one which fix the logo display)
> seems ok for my naive look. It would be nice if this part could be
> sent in a single patch to Andrew. I already tried to fix it but your
> patch looks better.

Your right about the colors not being set for mono logo. Your above fix is 
not correct but it needs to be fixed. I really don't understand why 
fbmem.c has its own routines to handle the logo for the color map. I can 
set creating a fbcmap and calling fb_set_cmap instead. That will be a 
separte patch.


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
