From: "Franck Bui-Huu" <vagabon.xyz@gmail.com>
Subject: Re: fbmem: is bootup logo broken for monochrome
	LCD ?
Date: Tue, 21 Nov 2006 10:45:41 +0100
Message-ID: <cda58cb80611210145ic52001cr38aed6e38797e3a@mail.gmail.com>
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
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GmSCH-0004jr-6z for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 21 Nov 2006 01:45:45 -0800
Received: from ug-out-1314.google.com ([66.249.92.170])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1GmSCF-0003u3-Kx
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 21 Nov 2006 01:45:45 -0800
Received: by ug-out-1314.google.com with SMTP id z38so1409321ugc
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Tue, 21 Nov 2006 01:45:41 -0800 (PST)
In-Reply-To: <Pine.LNX.4.64.0611201636500.17639@pentafluge.infradead.org>
Content-Disposition: inline
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
To: James Simmons <jsimmons@infradead.org>
Cc: Andrew Morton <akpm@osdl.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On 11/20/06, James Simmons <jsimmons@infradead.org> wrote:
>
> > On 11/17/06, James Simmons <jsimmons@infradead.org> wrote:
> > >
> > > Are those actually numbers? If they are the problem isn't byte reversal
> > > but bit shifting.
> > >
> > > 1010100 = 54
> > > 0101010 = 2A
> >
> > It's not byte reversal, but _bits_ of each bytes have been inversed
> > (bit7->bit0, bit6->bit1, bit5->bit2, bit4->bit3, bit3->bit4, ...)
> > after calling slow_imageblit(). Is it something expected ?
>
> Yipes!! Bit reversal. I have never seen that before. Is only the logo
> messed up? Slow_imageblit can be called if there is no dword alignment
> for the font bitmaps. So the question is do most if not all our fonts
> look okay?
>

No, it's not an only logo issue. Bit reversals happen for all images
which are passed to slow_imageblit() including all fonts.

Can it be a 'bit_per_pixel = 1' issue ? It seems that this config has
not been widely tested.

If you look at slow_imageblit() current implementation and for example
let's say that at the begining of the function we have:

	- __LITTLE_ENDIAN is defined
	- bpp = 1
	- fgcolor = 1
	- bgcolor = 0
	- start_index = 0

The function core can be simplified into:

	for (i = image->height; i--; ) {
		shift = val = 0;
		l = 8;
		j = image->width;
		dst = (u32 __iomem *) dst1;
		s = src;

		while (j--) {
			l--;
			color = (*s & (1 << l)) ? 1 : 0;
			val |= color << shift;
			
			/* Did the bitshift spill bits to the next long? */
			if (shift >= null_bits) {
				FB_WRITEL(val, dst++);
				val = (shift == null_bits) ? 0 :
					FB_SHIFT_LOW(color,32 - shift);
			}
			shift += 1;
			shift &= (32 - 1);
			if (!l) { l = 8; s++; };
		}

		[ ...]

Doesn't this bit of code do a bit reversal ? Specially these 2
following lines of code:

	color = (*s & (1 << l)) ? 1 : 0;
	val |= color << shift;


with 'l' taking values from 7 to 0, and 'shift' taking values from 0
to 31.

Thanks
		Franck

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
