From: Antonino Daplas <adaplas@pol.net>
Subject: Re: Some questions
Date: 06 Mar 2003 17:03:58 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1046941303.1209.38.camel@localhost.localdomain>
References: <Pine.GSO.4.21.0303060932150.28248-100000@vervain.sonytel.be>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from pine.compass.com.ph ([202.70.96.37])
	by sc8-sf-list1.sourceforge.net with smtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18qrGy-0007CD-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 06 Mar 2003 01:02:40 -0800
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
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: James Simmons <jsimmons@infradead.org>, Thomas Winischhofer <thomas@winischhofer.net>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Thu, 2003-03-06 at 16:33, Geert Uytterhoeven wrote:
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
> 

Ideally, that is what should happen.  However, fb_set_var does a check
if the passed var is different from the default var.  If it's the same,
fb_set_par is skipped.  Switching back from X, this check will be mostly
false, so fb_set_par will be skipped, and register refreshing would have
failed.

So, I think fbcon should also detect if the previous console is not
fbcon (ie previous con > last_fbvc || previous con < first_fbvc), and if
it isn't, force an fb_set_par.

Tony



-------------------------------------------------------
This SF.net email is sponsored by: Etnus, makers of TotalView, The debugger 
for complex code. Debugging C/C++ programs can leave you feeling lost and 
disoriented. TotalView can help you find your way. Available on major UNIX 
and Linux platforms. Try it free. www.etnus.com
