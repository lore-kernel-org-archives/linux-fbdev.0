From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [Dri-devel] Re: Rage128/Radeon framebuffer
	updates
Date: 16 Aug 2003 18:35:47 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1061051746.583.10.camel@gaston>
References: <20030816161900.85239.qmail@web14905.mail.yahoo.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
In-Reply-To: <20030816161900.85239.qmail@web14905.mail.yahoo.com>
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
To: Jon Smirl <jonsmirl@yahoo.com>
Cc: fb-devel <linux-fbdev-devel@lists.sourceforge.net>, dri-devel <dri-devel@lists.sourceforge.net>, Paul Mackerras <paulus@samba.org>

On Sat, 2003-08-16 at 18:19, Jon Smirl wrote:
> --- Benjamin Herrenschmidt <benh@kernel.crashing.org>
> wrote:
> 
> The big picture here is that aty128fb and radeonfb
> have not had their PCI ID tables updated since 2.6 was
> started. Any hardware made since then can't use the
> framebuffer drivers.

Yup, and that part of your patch is great. I have more chips
in the version in my tree than in official 2.6, but your list
is definitely more complete.
One reason my version isn't merged upstream yet is that it relies
on some other bits (mostly power management) that James didn't merge
yet, but I could strip them out.

> > So you still go to ROM unconditionally... Well, we
> > should get that tested, I don't have the offending
> x86
> > hardware, but I'd like to know if that still works
> with all
> > those DFPs for which we obtain the EDID via the BIOS
> > image in RAM...
> 
> I can't break something that doesn't exist in the 2.6
> framebuffer code.

It's in the 2.4 one and I was about to push it to 2.6. It is
necessary for a bunch of cases

> > Again, adding that fixed the driver for a _lot_ of
> > users, so I'd like not to change that until we have
> a
> > replacement with real i2c accesses...
> 
> I am not changing this, it doesn't exist in 2.6.

As I told you, it is in 2.4. The 2.6 codebase isn't up to date,
but that's not a reason not to fix that, the DFP code is necessary
for a lot of machines.

> Only the primary card is POSTed and copied to low RAM.
> Note that it is possible to mix vendors and the copy
> in RAM may not even belong to a Rage/Radeon.

This is a real issue yes.

> The correct solution is to read the I2C data like
> XFree does and not to rely on the copy in the BIOS.

Yes.

> The Redhat installer also gets it data from I2C.
> Reading the copy in low RAM doesn't work if the user
> switches monitors either. Besides, how are you sure
> the copy in low RAM belongs to your adapter?
> 
> Another way to get EDID data is to use an INT10 from a
> user level program.  This is compilcated because you
> need to use the real mode emulator and change the
> INT10 vectors for the various cards.

Int10 will not work on all archs

> When PCI/X gets here next year this problem will be
> much worse since it will be trivial to install
> multiple video cards.
> 
> I'm all for using EDID data, it just needs to
> retrieved in the correct manner.

Yes, but the current 2.4 DFP tweak is not that bad, few
people have more than one board, I'm also curious how does
XFree since that EDID thing was copied from it, I suppose
it gives me a c00000 RAM image that isn't the real one but
comes from what it's own call to that card's BIOS POST
generated...

> > If they aren't, then there's no point in that fix
> anyway
> > since neither aty128fb nor radeonfb will work on a
> card
> > that wasn't POSTed by the BIOS.
> 
> I have a small program that will POST a secondary
> card. Starting XFree on them as a primary or secondary
> will also POST them.

Provided they have an x86 BIOS...

> I have been annoying ATI (without success) for months
> trying to get code out of them to do this so that I
> can add it directly to the fb driver.

They'll not give you that as the POST code is basically board
specific (depends on how things are wired on a given board) and
only the version of BIOS on that board knows that...

> The change was made to select a string for the
> appropriate chip generation in the sign-on message. 
> 
> The driver has to know PCI or AGP. The PCI IDs are
> used to tell.
> 
> >  - r128 & radeon : your change of the setup
> > functions to turn them into module params, 
> > I'm not sure I like them at least not at this
> > point. This will change the syntax on the kernel
> > command line at least, which I'd rather not do 
> > at this stage
> 
> 2.6 has provided module functions to standardize the
> module parameter syntax. 
> 
> The only chage is under the old scheme you could say:
> modprobe radeonfb 1024x768
> now you have to say:
> modprobe radeonfb mode=1024x768
> Is there a way to do unnamed params with the new
> functions, or was that purposely left out?

What about kernel command line ? This is used a lot for
fbdev drivers

> I have posted several times indicating that I believe
> setting the mode from the load command to be
> non-functional in 2.6 anyway and asking for an
> explaination of how it is suppose to work. 
> 
> The current code, which I did not change, only uses
> the mode data to set the mode variables and not to
> actually set the mode. It I modify the driver to
> actually set the mode fbconsole breaks.

The mode is set by takeover_console on boot, though I didn't
try loading radeonfb as a module, that may be broken.

> >  - AFAIK, Paul Mackerras <paulus@samba.org> is the
> > current aty128fb
> > maintainer, can you pass the changes through him ?
> 
> I sent him a copy. Doesn't he read the fbdev list?

I don't know, it's always best to CC at least a maintainer. People
like Paul or I have way too many mails & lists to follow... at least
when I'm on the To or CC list, some filters highlight the message for
me.

Also, while it's not in the comments yet, I took over maintainership
of radeonfb in 2.4. I'm not 100% sure I want to be the maintainer for
2.6 as well (though I did the current port from an older 2.4 version),
let me know if you want to take that role.

Ben.



-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100003ave/direct;at.aspnet_072303_01/01
