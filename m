From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: Re: [PATCH] fix for using >16 pixel wide font in fb console
Date: Mon, 8 Nov 2004 18:16:12 +0800
Message-ID: <200411081816.15633.adaplas@hotpop.com>
References: <Pine.LNX.4.58.0411080202040.5524@glomgold-9.cs.helsinki.fi>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CR6Zc-0006xY-NL
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 08 Nov 2004 02:16:32 -0800
Received: from smtp-out.hotpop.com ([38.113.3.61])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1CR6Zb-00041y-Nd
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 08 Nov 2004 02:16:32 -0800
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id C86CD9C21FC
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon,  8 Nov 2004 10:16:18 +0000 (UTC)
In-Reply-To: <Pine.LNX.4.58.0411080202040.5524@glomgold-9.cs.helsinki.fi>
Content-Disposition: inline
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
To: linux-fbdev-devel@lists.sourceforge.net
Cc: jjaakkol@cs.Helsinki.FI

On Monday 08 November 2004 08:17, Jani Jaakkola wrote:
> [ Please, CC any replies to me, I am not a regular kernel hacker ]
>
> I wrote a small tool to convert fonts understood by freetype to linux
> console fonts, since I wanted to use larger fonts than the ones shipped
> with kbd package on my console. This exposed (at least) two bugs in fb
> console driver.
>
> The first one was that fbcon_set_font() used one byte padding for fonts
> having width 16 <= width < 24, which was wrong since the pieces of code
> actually using the font did not use any padding. This is fixed in the
> included patch and also fbcon_set_font() is made a little cleaner. After
> the patch the following font is not garbled in fb console:
> http://www.cs.helsinki.fi/u/jjaakkol/psf/bitstream_vera_sans_mono_roman.16x
>30.psf
>

Nice, I just checked it on vesafb and rivafb and it works.

> The other bug is that fonts having height == 32 crash the kernel. I have
> no fix for this (at least not yet), but it can be reproduced with font:
> http://www.cs.helsinki.fi/u/jjaakkol/psf/bitstream_vera_sans_mono_roman.17x
>32.psf

I think I know where the problem is. The src bitmap is statically allocated
at 64 bytes, enough for a 16x32 font, previously the maximum font dimension
allowed.  Dynamically allocating it based on the font dimension fixes the
problem (patch attached), at least for drivers with no hardware cursor
implementation, such as vesafb.  (I tested it on rivafb, but I get cursor
corruption, probably a driver problem. Also nvidia's maximum cursor
dimension is 32x32, so it's probably hitting a corner case bug).

>
> +	/* Is there a reason why fbconsole couldn't handle any charcount >256?
> +	 * If not this check should be changed to charcount < 256 */

This is because the console was based on VGA in which each character is
described in 16 bits.  The upper byte is for the attributes and the lower byte
is for the character.  Sometimes, one can use bit 8, giving 9-bits allowing
for 512 bytes of character count.

Tony

PS: Diff is against 2.6.10-rc1-mm3





-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
