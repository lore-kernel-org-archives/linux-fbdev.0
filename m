From: Petr Vandrovec <vandrove@vc.cvut.cz>
Subject: fbdev tree pulled into Linus tree
Date: Wed, 14 Aug 2002 03:55:42 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20020814015542.GA14680@ppc.vc.cvut.cz>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: jsimmons@users.sourceforge.net
Cc: linux-fbdev-devel@lists.sourceforge.net

Hello James,
  besides that the beast does not compile because of
the use of p->type instead of info->fix.type in the logo code,
what's the reason for having next_line, next_plane
(and maybe other too - can_soft_blank, inverse, yscroll) 
in the display struct, if you moved rest of the values 
into fix. So now I maintain half of state in per-display 
structs, and half in the per-fbdev structure? Nigthmare.
Can you create some ('tmp' or 'par' or whatever) structure
and hold them in fb_info too?

  Also because of you moved these type/line_length and
other into the fix, there is no point in having dispsw
in the display struct: these functions must not be invoked
on the fbdev with con != fbcon.currcon now because of
part of state exists only for foreground console now. So
move them into per-fb_info structure too, and handle 
con != fbcon.currcon in generic code (if not done already).

  Then it will be clear what is really per-VT structure
which should be maintained by upper layer, and what is
fbdev bussiness. And while you'll move dispsw pointer, change
it to the embeded structure. It will make life easier to
atafb and matroxfb at least, as they like to modify fb_ops
according to the hardware they find, and currently they
modify structure global to the driver.

  That's all for now, I'll see what will happen after reboot. 
Expect first public matroxfb updates tomorrow.
					Best regards,
						Petr Vandrovec

P.S.: I do not have your new email address here at home,
and you are neither in MAINTAINERS nor in the CREDITS,
I hope that the address I randomly choosed from the credits
in fbdev files will work.


-------------------------------------------------------
This sf.net email is sponsored by: Dice - The leading online job board
for high-tech professionals. Search and apply for tech jobs today!
http://seeker.dice.com/seeker.epl?rel_code=31
