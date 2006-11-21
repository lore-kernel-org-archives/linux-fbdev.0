From: James Simmons <jsimmons@infradead.org>
Subject: Re: fbmem: is bootup logo broken for monochrome
 LCD ?
Date: Tue, 21 Nov 2006 18:02:12 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0611211507290.32103@pentafluge.infradead.org>
References: <45535C08.5020607@innova-card.com> 
	<Pine.LNX.4.64.0611122138030.9472@pentafluge.infradead.org> 
	<cda58cb80611130153n60579de0w2ebb59b050595b3b@mail.gmail.com> 
	<Pine.LNX.4.64.0611131415270.25397@pentafluge.infradead.org> 
	<cda58cb80611131027h5052bf80va06003c23b844fe@mail.gmail.com> 
	<Pine.LNX.4.64.0611131850410.2366@pentafluge.infradead.org> 
	<cda58cb80611140144q79718798p40f2762955c1d91@mail.gmail.com> 
	<Pine.LNX.4.64.0611171825520.32200@pentafluge.infradead.org> 
	<cda58cb80611171242sb40a53bvd02145364551b5a2@mail.gmail.com> 
	<Pine.LNX.4.64.0611201636500.17639@pentafluge.infradead.org>
	<cda58cb80611210145ic52001cr38aed6e38797e3a@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GmZwm-0008QA-36 for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 21 Nov 2006 10:02:16 -0800
Received: from pentafluge.infradead.org ([213.146.154.40])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1GmZwl-00061K-3o
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 21 Nov 2006 10:02:16 -0800
In-Reply-To: <cda58cb80611210145ic52001cr38aed6e38797e3a@mail.gmail.com>
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


> > Yipes!! Bit reversal. I have never seen that before. Is only the logo
> > messed up? Slow_imageblit can be called if there is no dword alignment
> > for the font bitmaps. So the question is do most if not all our fonts
> > look okay?
> > 
> 
> No, it's not an only logo issue. Bit reversals happen for all images
> which are passed to slow_imageblit() including all fonts.

I thought so. 

> Can it be a 'bit_per_pixel = 1' issue ? It seems that this config has
> not been widely tested.

Nope. I have tested it on 4bpp and above. No monochrome. 
 
> If you look at slow_imageblit() current implementation and for example
> let's say that at the begining of the function we have:
> 
> 	- __LITTLE_ENDIAN is defined
> 	- bpp = 1
> 	- fgcolor = 1
> 	- bgcolor = 0
> 	- start_index = 0
> 
> The function core can be simplified into:
> 
> 	for (i = image->height; i--; ) {
> 		shift = val = 0;
> 		l = 8;
> 		j = image->width;
> 		dst = (u32 __iomem *) dst1;
> 		s = src;
> 
> 		while (j--) {
> 			l--;
> 			color = (*s & (1 << l)) ? 1 : 0;
> 			val |= color << shift;
> 						/* Did the bitshift spill bits
> to the next long? */
> 			if (shift >= null_bits) {
> 				FB_WRITEL(val, dst++);
> 				val = (shift == null_bits) ? 0 :
> 					FB_SHIFT_LOW(color,32 - shift);
> 			}
> 			shift += 1;
> 			shift &= (32 - 1);
> 			if (!l) { l = 8; s++; };
> 		}
> 
> 		[ ...]
> 
> Doesn't this bit of code do a bit reversal ? Specially these 2
> following lines of code:
> 
> 	color = (*s & (1 << l)) ? 1 : 0;
> 	val |= color << shift;
> 
> 
> with 'l' taking values from 7 to 0, and 'shift' taking values from 0
> to 31.

Lets look at the new code that I have done with your above parameters. 

       for (i = image->height; i--; ) {
               shift = val = 0;
               n = image->width;
               dst = (u32 __iomem *) dst1;

		while (n--) {
			if (!s) { src++; s = 32; }
			s -= 1;
			color = (swapb32p(src) & (1 << s)) ? 1 : 0;
			val |= color << shift;

		       /* Did the bitshift spill bits to the next long? */
                       if (shift >= 31) {
                               FB_WRITEL(val, dst++);
                               val = (shift == 31) ? 0 :(color >> (32 - shift));
                       }
                       shift += 1;
                       shift &= (32 - 1);
               }

               [ ...]

with 's' taking values from 31 to 0, and 'shift' taking values from 0 to 
31. In the case of bits_per_pixel = 1 we have 

s -= 1;
color = (swapb32p(src) & (1 << s)) ? 1 : 0;
val |= color << shift;

which reduces to val = color;

I'm I seeing it wrong? BTW what is your visual? 




-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
