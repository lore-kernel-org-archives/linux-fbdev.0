From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: Some questions
Date: Thu, 6 Mar 2003 09:33:34 +0100 (MET)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.21.0303060932150.28248-100000@vervain.sonytel.be>
References: <Pine.LNX.4.44.0303051932120.27760-100000@phoenix.infradead.org>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from mail2.sonytel.be ([195.0.45.172] helo=mail.sonytel.be)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18qqqF-00063z-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 06 Mar 2003 00:35:04 -0800
In-Reply-To: <Pine.LNX.4.44.0303051932120.27760-100000@phoenix.infradead.org>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: James Simmons <jsimmons@infradead.org>
Cc: Antonino Daplas <adaplas@pol.net>, Thomas Winischhofer <thomas@winischhofer.net>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Wed, 5 Mar 2003, James Simmons wrote:
> > > We should split the monitor programing stuff out from stuff like bpp etc.
> > > Now if you think about it we can do things like change the bpp without 
> > > having to redo the monitor programming. This is the flaw with the old and 
> > > even the new api. 
> > 
> > You could have done that from the beginning. Just look at which fields have
> > changed and which haven't.
> 
> I should of but didn't because I knew driver would take teh path of lest 
> resistance to port there drivers. TO much change would have made the 
> current situtation much much worst. 

One other reason why this isn't done is because X may interfere with it. If we
don't do a full register update, but change the parts that need a change only,
we will see less flickering (no PLL reprogramming), but we will suffer if X
doesn't restore the registers to the exact same values they were before.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds



-------------------------------------------------------
This SF.net email is sponsored by: Etnus, makers of TotalView, The debugger 
for complex code. Debugging C/C++ programs can leave you feeling lost and 
disoriented. TotalView can help you find your way. Available on major UNIX 
and Linux platforms. Try it free. www.etnus.com
