From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: 2.6 fbcon and 15/16 bpp
Date: Wed, 24 Dec 2003 13:08:57 +0100 (MET)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.58.0312241306590.1638@waterleaf.sonytel.be>
References: <1070348676.4311.39.camel@gaston>  <3FCC4018.4020503@undead.cc>
  <1070403757.4300.75.camel@gaston>  <3FCD17D5.4040804@undead.cc> 
 <1070410792.21174.83.camel@gaston>  <3FE8CCE3.4010709@undead.cc>
 <1072230310.739.25.camel@gaston>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1AZ7p1-0000cJ-MG
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 24 Dec 2003 04:09:03 -0800
Received: from witte.sonytel.be ([80.88.33.193])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.24)
	id 1AZ7p1-0003YZ-5Y
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 24 Dec 2003 04:09:03 -0800
In-Reply-To: <1072230310.739.25.camel@gaston>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: John Zielinski <grim@undead.cc>, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>

On Wed, 24 Dec 2003, Benjamin Herrenschmidt wrote:
> > Here's a patch that fixed things on my machine.  I found it by trial and
> > error since I don't have a hardware reference document and the code is a
> > little confusing to me.  I don't know if this is the root cause or just
> > a fix for the symptoms.  Changing the u16's to u32's fixed the verticle
> > grille appearance and most of the color corruption.  Commenting out that
> > small block of code fixed the rest of the color problems.
>
> Intersting. The pseudo palette thing might have to be u32 indeed, I have
> to double check. That sounds like a typical misdesign crap vs. endian
> assuming a given value can be accessed via any size is a little endian
> "feature" that doesn't work on BE.

Yep, IIRC fb_info.pseudo_palette[] should always be an array of u32s in 2.6.
However, it's still `void *' in <linux/fb.h>. Perhaps this is fixed in James'
BK tree?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
