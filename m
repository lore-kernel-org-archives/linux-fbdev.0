From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: Re: [PATCH 2/2] cirrusfb: use 24bpp instead of
 32bpp
Date: Sat, 28 Feb 2009 00:29:39 +0100
Message-ID: <20090228002939.73a7af76.krzysztof.h1@poczta.fm>
References: <20090227214853.b2de2273.krzysztof.h1@poczta.fm>
	<20090227223031.GA12659@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <krzysztof.h1@poczta.fm>) id 1LdC46-0001rZ-5C
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 27 Feb 2009 23:24:22 +0000
Received: from smtp239.poczta.interia.pl ([217.74.64.239])
	by 72vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1LdC43-0008Tp-L0 for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 27 Feb 2009 23:24:22 +0000
In-Reply-To: <20090227223031.GA12659@localhost>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Ondrej Zajicek <santiago@crfreenet.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Linux-fbdev-devel <linux-fbdev-devel@lists.sourceforge.net>

On Fri, 27 Feb 2009 23:30:31 +0100
Ondrej Zajicek <santiago@crfreenet.org> wrote:

> On Fri, Feb 27, 2009 at 09:48:53PM +0100, Krzysztof Helt wrote:
> > From: Krzysztof Helt <krzysztof.h1@wp.pl>
> > 
> > The 32bpp is supported only on the latest
> > Cirrus Logic chips. Use the 24bpp which
> > is supported at least since Alpine chips
> > (GD543x).
> > 
> > Change 32bpp mode setting to 24bpp mode.
> 
> Why do not support both modes?
> 

1. The 32bpp is broken or unsupported on all chips except Laguna ones (on Laguna I made it work a week or two ago).
2. Very little to gain from 32-bit (is the alpha channel used on fb?). The previous implementation just set transparency to 0
length.
3. It is supported only on Laguna and GD5480 (and I have only one Laguna chip to test). It should work on GD5436/46 but it does not (even X11 driver left it out).
4. Acceleration for GD5480 would be untested in 32-bit mode (Laguna has no acceleration anyway) - probably (surely) broken.

Regards,
Krzysztof

----------------------------------------------------------------------
SPEAK UP uczysz sie przez 3 miesiace za darmo. 
Sukces gwarantujemy na pismie! http://link.interia.pl/f206b


------------------------------------------------------------------------------
Open Source Business Conference (OSBC), March 24-25, 2009, San Francisco, CA
-OSBC tackles the biggest issue in open source: Open Sourcing the Enterprise
-Strategies to boost innovation and cut costs with open source participation
-Receive a $600 discount off the registration fee with the source code: SFAD
http://p.sf.net/sfu/XcvMzF8H
