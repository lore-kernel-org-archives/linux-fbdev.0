From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: fbdev tree pulled into Linus tree
Date: Wed, 14 Aug 2002 08:58:51 +0200 (MEST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.21.0208140852540.23277-100000@vervain.sonytel.be>
References: <20020814015542.GA14680@ppc.vc.cvut.cz>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
In-Reply-To: <20020814015542.GA14680@ppc.vc.cvut.cz>
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
To: Petr Vandrovec <vandrove@vc.cvut.cz>
Cc: jsimmons@users.sourceforge.net, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>

On Wed, 14 Aug 2002, Petr Vandrovec wrote:
> fbdev bussiness. And while you'll move dispsw pointer, change
> it to the embeded structure. It will make life easier to
> atafb and matroxfb at least, as they like to modify fb_ops
> according to the hardware they find, and currently they
> modify structure global to the driver.

Yes, this can cause problems on machines with multiple graphics cards of the
same family, but using different acceleration features. That's why I made the
dispsw structs const, to make sure you copy them before modifying them. But now
e.g. atyfb doesn't compile anymore due to `assignment discards qualifiers from
pointer target type'.

> P.S.: I do not have your new email address here at home,
> and you are neither in MAINTAINERS nor in the CREDITS,
> I hope that the address I randomly choosed from the credits
> in fbdev files will work.

Fortunately you've picked the right one ;-)

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds



-------------------------------------------------------
This sf.net email is sponsored by: Dice - The leading online job board
for high-tech professionals. Search and apply for tech jobs today!
http://seeker.dice.com/seeker.epl?rel_code=31
