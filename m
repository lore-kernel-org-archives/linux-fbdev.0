From: Sven Luther <luther@dpt-info.u-strasbg.fr>
Subject: Re: Some questions
Date: Thu, 6 Mar 2003 10:00:35 +0100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20030306090035.GA3714@iliana>
References: <Pine.LNX.4.44.0303051932120.27760-100000@phoenix.infradead.org> <Pine.GSO.4.21.0303060932150.28248-100000@vervain.sonytel.be>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from smtp-out-3.wanadoo.fr ([193.252.19.233] helo=mel-rto3.wanadoo.fr)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18qrGG-0006vn-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 06 Mar 2003 01:01:56 -0800
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.21.0303060932150.28248-100000@vervain.sonytel.be>
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
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: James Simmons <jsimmons@infradead.org>, Antonino Daplas <adaplas@pol.net>, Thomas Winischhofer <thomas@winischhofer.net>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Thu, Mar 06, 2003 at 09:33:34AM +0100, Geert Uytterhoeven wrote:
> On Wed, 5 Mar 2003, James Simmons wrote:
> > > > We should split the monitor programing stuff out from stuff like bpp etc.
> > > > Now if you think about it we can do things like change the bpp without 
> > > > having to redo the monitor programming. This is the flaw with the old and 
> > > > even the new api. 
> > > 
> > > You could have done that from the beginning. Just look at which fields have
> > > changed and which haven't.
> > 
> > I should of but didn't because I knew driver would take teh path of lest 
> > resistance to port there drivers. TO much change would have made the 
> > current situtation much much worst. 
> 
> One other reason why this isn't done is because X may interfere with it. If we
> don't do a full register update, but change the parts that need a change only,
> we will see less flickering (no PLL reprogramming), but we will suffer if X
> doesn't restore the registers to the exact same values they were before.

X is supposed to do that, even if it doesn't know anything about fbdevs,
maybe especially if it doesn't know anything about fbdevs. If it knows
about fbdev and uses it, X should not be touching the modes anyway,
right ?

So, we are saving/restoring things twice, one time in X, the other in
the fbdev.

Friendly,

Sven Luther


-------------------------------------------------------
This SF.net email is sponsored by: Etnus, makers of TotalView, The debugger 
for complex code. Debugging C/C++ programs can leave you feeling lost and 
disoriented. TotalView can help you find your way. Available on major UNIX 
and Linux platforms. Try it free. www.etnus.com
