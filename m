From: James Simmons <jsimmons@infradead.org>
Subject: Re: (no subject)
Date: Thu, 22 Aug 2002 11:48:24 -0700 (PDT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.33.0208221147160.9077-100000@maxwell.earthlink.net>
References: <Pine.GSO.4.21.0208191056040.12594-100000@vervain.sonytel.be>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from swan.mail.pas.earthlink.net ([207.217.120.123])
	by usw-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 17hx5O-0007Mt-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 22 Aug 2002 11:53:38 -0700
In-Reply-To: <Pine.GSO.4.21.0208191056040.12594-100000@vervain.sonytel.be>
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

> 	Hi,
>
> In cfb_copyarea(), `tmp' must be unsigned long because it is used to store
> unsigned long values (see patch at the end).

Oops. This might fix the one bug I see sometimes. When I delete some
characters some of the remaining characters get corrputed.

> cfb_copyarea() also doesn't clear the bits to modify in the first and last
> words of a line, e.g. it does
>
> |	last = (FB_READ(src) & start_mask);
> |
> |	if (shift > 0)
> |		FB_WRITE(FB_READ(dst) | (last >> shift_right), dst);
>                          ^^^^^^^^^^^^
> After this read, the bits to modify must be cleared first, before the OR!
>
> I'm working on a version of cfb_copyarea() that fixes this and handles _all_
> possible values of var.bits_per_pixel (the current code assumes
> var.bits_per_pixel is a multiple of 8). Stay tuned!

Yeah!!! Will test.




-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
