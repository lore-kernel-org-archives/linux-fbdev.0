From: James Simmons <jsimmons@infradead.org>
Subject: Re: fbmem: is bootup logo broken for monochrome
 LCD ?
Date: Mon, 20 Nov 2006 16:42:58 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0611201636500.17639@pentafluge.infradead.org>
References: <45535C08.5020607@innova-card.com> 
	<Pine.LNX.4.64.0611122138030.9472@pentafluge.infradead.org> 
	<cda58cb80611130153n60579de0w2ebb59b050595b3b@mail.gmail.com> 
	<Pine.LNX.4.64.0611131415270.25397@pentafluge.infradead.org> 
	<cda58cb80611131027h5052bf80va06003c23b844fe@mail.gmail.com> 
	<Pine.LNX.4.64.0611131850410.2366@pentafluge.infradead.org> 
	<cda58cb80611140144q79718798p40f2762955c1d91@mail.gmail.com> 
	<Pine.LNX.4.64.0611171825520.32200@pentafluge.infradead.org>
	<cda58cb80611171242sb40a53bvd02145364551b5a2@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GmCEv-000305-Gx for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 20 Nov 2006 08:43:25 -0800
Received: from pentafluge.infradead.org ([213.146.154.40])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1GmCEZ-0002nQ-4G
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 20 Nov 2006 08:43:04 -0800
In-Reply-To: <cda58cb80611171242sb40a53bvd02145364551b5a2@mail.gmail.com>
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


> On 11/17/06, James Simmons <jsimmons@infradead.org> wrote:
> > 
> > Are those actually numbers? If they are the problem isn't byte reversal
> > but bit shifting.
> > 
> > 1010100 = 54
> > 0101010 = 2A
> 
> It's not byte reversal, but _bits_ of each bytes have been inversed
> (bit7->bit0, bit6->bit1, bit5->bit2, bit4->bit3, bit3->bit4, ...)
> after calling slow_imageblit(). Is it something expected ?

Yipes!! Bit reversal. I have never seen that before. Is only the logo
messed up? Slow_imageblit can be called if there is no dword alignment 
for the font bitmaps. So the question is do most if not all our fonts 
look okay?
 
> > I really don't understand why fbmem.c has its own routines to handle the
> > logo for the color > map. I can set creating a fbcmap and calling
> > fb_set_cmap instead.
> 
> Unfortunately I cannot help you on this point...
> 
> > That will be a  separte patch.
> > 
> 
> Thanks
> 

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
