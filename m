From: Antonino Daplas <adaplas@pol.net>
Subject: Re: Feature Freeze?
Date: 06 Mar 2003 09:17:52 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1046910001.1227.22.camel@localhost.localdomain>
References: <Pine.LNX.4.44.0303051836300.27760-100000@phoenix.infradead.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from pine.compass.com.ph ([202.70.96.37])
	by sc8-sf-list1.sourceforge.net with smtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18qk06-00076y-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 05 Mar 2003 17:16:46 -0800
In-Reply-To: <Pine.LNX.4.44.0303051836300.27760-100000@phoenix.infradead.org>
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
To: James Simmons <jsimmons@infradead.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Thu, 2003-03-06 at 02:37, James Simmons wrote:
> 
> > So we just make fbcon permanently loaded unconditionally?  The current
> > code allows 'rmmod fbcon', but it will freeze the system.
> 
> Because no other console takes over. This is not a easy problem to solve.
> Which driver takes over when we switch from one console driver to 
> another.

I have already a working fbcon module unloading code in my local copy. 
The way it works is like this.  

1. If take_over_console() is called with the "default" flag clear, it
behaves as usual.  It takes only a subset of console numbers but
"conswitchp" still points to the console driver that was loaded at boot
time.

2. If take_over_console() is called with the "default" flag set, it will
replace "conswitchp", but the original value of "conswitchp" is saved.

3.  If take_over_console() with the "default" flag set is called again,
it will fail.  It's not logical to just overwrite "conswitchp" over and
over again.

4. If give_up_console() is called and if the previous
take_over_console() did not overwrite "conswitchp", it proceeds as
usual.

5. If give_up_console() is called and if the previous
take_over_console() overwrote "conswitchp", give_up_console() will also
call take_over_console() but using the saved "conswitchp".

I can then load fbdev and fbcon as modules.  If I "rmmod fbcon", I get
back again to vgacon/dummycon/whatever.  I can then load and unload
different fbdev's and load fbcon at will.

If I want to load mdacon, it will still work on top of fbcon, because
mdacon calls take_over_console() with the "default" flag cleared.

If you need to load other console drivers, then fbcon must be unloaded
first.  This is because the rest of the console drivers call
take_over_console() with the "default" flag set.

I can already load/unload fbcon using vga16fb, rivafb or i810fb as the
backend at will.  Drivers that wish to allow fbcon unloading can define
the xxxfb_release() method.  They can choose to save/restore the state
(if they have a vga core and running as primary), or just define the
xxfb_release method as a dummy (if no vga core or running as secondary).

What do you think?  Any suggestions to improve this (multiple console
drivers for instance)? I would rather have the above, or disallow
unloading, than having the whole console system freeze on me.

Tony



-------------------------------------------------------
This SF.net email is sponsored by: Etnus, makers of TotalView, The debugger 
for complex code. Debugging C/C++ programs can leave you feeling lost and 
disoriented. TotalView can help you find your way. Available on major UNIX 
and Linux platforms. Try it free. www.etnus.com
