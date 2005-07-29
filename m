From: Luca <kronos@people.it>
Subject: Re: Fw: framebuffer blitting performance loss 2.6.12 -> 2.6.13-rc3
Date: Sat, 30 Jul 2005 00:45:47 +0200
Message-ID: <20050729224547.GA18474@dreamland.darkstar.lan>
References: <20050715033912.1cd9b6c3.akpm@osdl.org> <200507221158.23454.adaplas@gmail.com> <20050729001735.5934622f.akpm@osdl.org> <42EA430C.2010405@t-online.de> <42EA4E6A.70907@gmail.com> <Pine.LNX.4.56.0507292041110.17988@pentafluge.infradead.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Dydbf-0007CC-RQ
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 29 Jul 2005 15:45:31 -0700
Received: from mail-relay-4.tiscali.it ([213.205.33.44])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1Dydbe-0004gE-DX
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 29 Jul 2005 15:45:32 -0700
Received: from dreamland.darkstar.lan (84.222.35.185) by mail-relay-4.tiscali.it (7.2.063)
        id 42D77844001439AE for linux-fbdev-devel@lists.sourceforge.net; Sat, 30 Jul 2005 00:45:21 +0200
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.56.0507292041110.17988@pentafluge.infradead.org>
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
Content-Transfer-Encoding: 7bit
To: linux-fbdev-devel@lists.sourceforge.net

Il Fri, Jul 29, 2005 at 08:51:34PM +0100, James Simmons ha scritto: 
> > Thank you for your persistence.  I think I know the culprit.  Someone
> > insisted on using memcpy in fb_pad_aligned_buffer().  I have already
> > fixed this before, but apparently, the memcpy was brought back.  Try
> > the attached patch and let me know.
> 
> Yipes, I did that. The memcpy function is suppose to be optimized for the 
> platform. See string.h in the include/asm directory. I seen for example 
> the Athlon would use the 3DNow instruction set to copy data. Something 
> is really wrong with memcpy if moving byte by byte is faster !!!! 

For small copies MMX/3DNow are not used at all. In current kernel
MMX/3DNow memcpy is used only when data size is greater than 512bytes.
Remember that MMX/3DNow uses FPU so the kernel must save/restore state
and this overhead would make the copy slow for small chunks.

Luca
-- 
Home: http://kronoz.cjb.net
Se il  destino di un uomo  e` annegare, anneghera` anche  in un bicchier
d'acqua.
Proverbio yddish


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
