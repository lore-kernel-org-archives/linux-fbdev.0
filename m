From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: 2.6 fbcon and 15/16 bpp
Date: Wed, 24 Dec 2003 13:10:18 +0100 (MET)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.58.0312241309040.1638@waterleaf.sonytel.be>
References: <1070348676.4311.39.camel@gaston>  <3FCC4018.4020503@undead.cc>
  <1070403757.4300.75.camel@gaston>  <3FCD17D5.4040804@undead.cc> 
 <1070410792.21174.83.camel@gaston>  <3FE8CCE3.4010709@undead.cc> 
 <1072230310.739.25.camel@gaston>  <3FE90001.3080207@undead.cc> 
 <1072236683.739.32.camel@gaston>  <3FE919E1.7050609@undead.cc>
 <1072242753.820.41.camel@gaston> <3FE92BFD.8020104@undead.cc>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1AZ7qI-0000fL-Pu
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 24 Dec 2003 04:10:22 -0800
Received: from witte.sonytel.be ([80.88.33.193])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.24)
	id 1AZ7qI-0003kv-8K
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 24 Dec 2003 04:10:22 -0800
In-Reply-To: <3FE92BFD.8020104@undead.cc>
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
To: John Zielinski <grim@undead.cc>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>

On Wed, 24 Dec 2003, John Zielinski wrote:
> Benjamin Herrenschmidt wrote:
> >Looks fine, I'll do tests here. What's up with the penguin ? (what do
> >you mean by "test order" ?)
> >
> There are two penguin tests and Tux's colors are wrong in test004 but
> not too bad in test009.  But if you run test007 (the directcolor test)
> before test004 by running "fbtest test007 test004" Tux looks ok for the
> most part (has a green outline, looks like the poor fellow got nuked)
> because test007 leaves the palette not quite linear.
>
> A quick analysis looking at fbtest's debug output I noticed that before
> test007 it uses a 555 color map and a 565 color map after test007.  I'm
> look at it in more detail tommorrow.

Strange...

I know there are some issues with the penguin in 24 bpp, though (penguin may
have blue feet and mouth).

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
