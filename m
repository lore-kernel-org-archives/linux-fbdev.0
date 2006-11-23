From: "Franck Bui-Huu" <vagabon.xyz@gmail.com>
Subject: Re: fbmem: is bootup logo broken for monochrome
	LCD ?
Date: Thu, 23 Nov 2006 15:53:16 +0100
Message-ID: <cda58cb80611230653x2951d9d8x41b193f0101f9fdf@mail.gmail.com>
References: <45535C08.5020607@innova-card.com>
	<Pine.LNX.4.64.0611131850410.2366@pentafluge.infradead.org>
	<cda58cb80611140144q79718798p40f2762955c1d91@mail.gmail.com>
	<Pine.LNX.4.64.0611171825520.32200@pentafluge.infradead.org>
	<cda58cb80611171242sb40a53bvd02145364551b5a2@mail.gmail.com>
	<Pine.LNX.4.64.0611201636500.17639@pentafluge.infradead.org>
	<cda58cb80611210145ic52001cr38aed6e38797e3a@mail.gmail.com>
	<Pine.LNX.4.64.0611211507290.32103@pentafluge.infradead.org>
	<cda58cb80611220048p73bb54e3w414f1c0a5ce178d3@mail.gmail.com>
	<Pine.LNX.4.64.0611222101220.14604@pentafluge.infradead.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GnFx2-0005vc-0U for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 23 Nov 2006 06:53:20 -0800
Received: from ug-out-1314.google.com ([66.249.92.169])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1GnFx1-0005sb-6U
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 23 Nov 2006 06:53:19 -0800
Received: by ug-out-1314.google.com with SMTP id z38so453793ugc
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Thu, 23 Nov 2006 06:53:16 -0800 (PST)
In-Reply-To: <Pine.LNX.4.64.0611222101220.14604@pentafluge.infradead.org>
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

On 11/22/06, James Simmons <jsimmons@infradead.org> wrote:
> Replace the below line in my patch I sent
>
> > >                     val |= color << shift;
>
> with
>                         val <<= shift;
>                         val |= color;

I think it can't work since shift is 0 to 31, you'll end up with 'val
<<= 31' which I don't think is what you want.

doing
                         val <<= 1;

make it works but it's still very fragile. Code which deals with
trailing bit seems bogus since new value of 'val' is simply discarded
here.

                /* write trailing bits */
                if (shift) {
                        u32 end_mask = (~(u32)0 << shift);

                        val = FB_READL(dst1);
                        val &= end_mask;
                        FB_WRITEL(val, dst1);
                }

Another thing is that I don't see how very small images (for example
when image->width = 4) will be handled.

> > >                    /* Did the bitshift spill bits to the next long? */
> > >                        if (shift >= 31) {
> > >                                FB_WRITEL(val, dst++);
> > >                                val = (shift == 31) ? 0 :(color >> (32 - shift));
> > >                        }
> > >                        shift += 1;
> > >                        shift &= (32 - 1);
> > >                }
> > >
> > >                [ ...]
>
> Let me know if that works.

I'm wondering if working with 32 bits words really worth... I mean the
code is quite hard to follow because it needs to deal with endianess,
heading bits, trailings bits whereas working with 8 bits would be so
much easier, wouldn't it ? Are writings in video RAM very long ?

-- 
               Franck

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
