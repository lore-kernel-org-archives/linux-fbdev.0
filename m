From: Petr Vandrovec <vandrove@vc.cvut.cz>
Subject: Re: [PATCH][FBDEV]: fb_putcs() and fb_setfont() methods
Date: Sun, 5 Jan 2003 00:17:29 +0100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20030104231729.GA1188@ppc.vc.cvut.cz>
References: <20030104204131.GD1319@ppc.vc.cvut.cz> <Pine.LNX.4.44.0301042109340.24903-100000@phoenix.infradead.org>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from r2l120.mistral.cz
	([62.245.75.120] helo=ppc.vc.cvut.cz ident=root)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 18UxYN-0005Tq-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Sat, 04 Jan 2003 15:18:07 -0800
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0301042109340.24903-100000@phoenix.infradead.org>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: James Simmons <jsimmons@infradead.org>
Cc: Antonino Daplas <adaplas@pol.net>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Linux Kernel List <linux-kernel@vger.kernel.org>

On Sat, Jan 04, 2003 at 09:12:24PM +0000, James Simmons wrote:
> 
> > I'll be happier with character coordinates for text mode. 
> 
> Yuck!! Using fbcon for text modes is just bloat. For hardware text mode it 
> is much better to write a nice small console driver like newport_con.c

When I said before christmas that I'll have to write matroxcon to get
reasonable functionality, you laughed... Now, it is clear that there is
no other way...
 
> > could decide on case-by-case basis whether it will use its own code or 
> > generic without touching pointer (without modifying potentially constant
> > fb_ops structure common to all fbdev instances).
> 
> The patch was rejected. I working on your driver. I can throw in a text 
> mode driver as well. 

You can throw anything in and out, of course... It is GPL, after all.
Only question left is whether I'll be satisfied with functionality you
offer.
						Best regards,
							Petr Vandrovec
							vandrove@vc.cvut.cz
 


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
