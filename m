From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: radeonfb_pci_register video memory clear?
Date: Wed, 23 Jun 2004 18:07:34 +0200 (MEST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.58.0406231807050.13111@waterleaf.sonytel.be>
References: <40D3A2E1.2060100@undead.cc> <20040619192744.GA3979@dreamland.darkstar.lan>
 <40D4980F.3000401@undead.cc> <1088006211.1854.147.camel@gaston>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BdAHo-0004oN-EL
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 23 Jun 2004 09:07:44 -0700
Received: from witte.sonytel.be ([80.88.33.193])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.30)
	id 1BdAHm-0002rO-FU
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 23 Jun 2004 09:07:42 -0700
In-Reply-To: <1088006211.1854.147.camel@gaston>
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
Cc: John Zielinski <grim@undead.cc>, Kronos <kronos@people.it>, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>

On Wed, 23 Jun 2004, Benjamin Herrenschmidt wrote:
> On Sat, 2004-06-19 at 14:46, John Zielinski wrote:
> > >AFAIK without that radeonfb will display the content of the memory as
> > >random garbage.
> > >
> > I does fix it but the side effects I listed make it a bad idea,
> > especially the fact that the radeonfb driver doesn't own the memory
> > yet.  Tony has posted a proper fix for the problem so whoever put this
> > in, please remove it.
>
> Provided Tony fix gets upstream instead of beeing lost for 6 more
> monthes in the fbdev tree ...

Nah, Tony is doing his best to get stuff merged with Andrew...

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
