From: James Simmons <jsimmons@transvirtual.com>
Subject: Re: cfb_{copyarea,fillrect}()
Date: Thu, 4 Jul 2002 20:39:25 -0700 (PDT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0207042034540.4852-100000@www.transvirtual.com>
References: <Pine.GSO.4.21.0207021330420.25055-100000@vervain.sonytel.be>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from www.transvirtual.com ([206.14.214.140])
	by usw-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 17QJwa-0001P9-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 04 Jul 2002 20:39:40 -0700
In-Reply-To: <Pine.GSO.4.21.0207021330420.25055-100000@vervain.sonytel.be>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=linux-fbdev-devel>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>


> It also adds 64-bit support to cfb_copyarea().

Thanks. Added to BK tree.

> Other comments/notes:
>
>   - Shouldn't cfb_fillrect() use the pseudo_palette in DIRECTCOLOR mode?

??? I thought you had to go threw the DAC to get values.

>   - I think the cfb_*() routines can easily be modified to work for bpp < 8,
>     and for bpp == 24:

It doesn't work for bpp < 4 for you? It should work for those as well. Bpp
24 is a bit more trick if we want to do word align access to the
framebuffer.

>       o initialize src/dst indices to be bit indices instead of byte indices
>       o remove shifts by 3
>       o n is number of bits to copy/fill

Hm. I have to work up so psuedo code to try that idea out.

>   - I think that line length is not guaranteed to be a multiple of
>     sizeof(unsigned long). Hence a different start/end mask per line is
>     possible as well.

Missed that one.



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Caffeinated soap. No kidding.
http://thinkgeek.com/sf
