From: Antonino Daplas <adaplas@pol.net>
Subject: Re: Feature Freeze?
Date: 05 Mar 2003 22:46:37 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1046875559.1291.135.camel@localhost.localdomain>
References: <1046852721.1228.13.camel@localhost.localdomain>
	<20030305110529.GA2036@iliana>
	<1046868330.1229.59.camel@localhost.localdomain> 
	<20030305134355.GA3105@iliana>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from pine.compass.com.ph ([202.70.96.37])
	by sc8-sf-list1.sourceforge.net with smtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18qa97-00080t-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 05 Mar 2003 06:45:25 -0800
In-Reply-To: <20030305134355.GA3105@iliana>
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
To: Sven Luther <luther@dpt-info.u-strasbg.fr>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Wed, 2003-03-05 at 21:43, Sven Luther wrote:
> On Wed, Mar 05, 2003 at 08:46:52PM +0800, Antonino Daplas wrote:
> > On Wed, 2003-03-05 at 19:05, Sven Luther wrote:
> > > On Wed, Mar 05, 2003 at 04:26:04PM +0800, Antonino Daplas wrote:
> > > > 
> > > > Hi,
> > > > 
> > > > I believe it's time to finalize what is needed/not needed for the
> > > > framebuffer framework:
> > > > 
> > > > 1. Text mode support?
> > > 
> > > Would this work also on arches which don't traditionnaly do text mode ?
> > > Like ppc for example. 
> > 
> > Yes, pixel-based drawing is still the default.  It's only for drivers
> > (matrox and sbus) where it might be needed.
> 
> And do you think there is a chance of standard vgacon working on a ppc
> board ? I have a pegasos powerpc/pop based board, and its OF use a x86
> emulator to boot the card into vga textmode. matroxfb is broken on it
> last i tried, and radeonfb was not uptodate in the kernel that was
> provided, and i there is problems with other fbdevs also, so it
> would be nice if it was possible to use vgacon on such hardware, until
> the fbdevs are fixed, but it is a bit hard to fix things without a
> working console.
> 
> > > > 2. console resizing using fbset (besides stty)?
> > > 
> > > What about dynamic multi-head support ?
> > > 
> > > > 7. Anything else?
> > > 
> > > Well, what is the exact status of mult-head and multi-seat ? It is
> > 
> > If you mean one card with multiple heads, that will need driver-specific
> > support. 
> 
> I thought that the new API, separating the fbcon layer from the fbdev
> drivers would add support for this more easily. I guess it would be easy
> for the Appian Jeronimo 2000 board, which has two permedia3 chips, and
> thus can be seen as two separate devices. Cards with two ramdacs per
> chip, like the G400, the later radeon's and most recent cards would need
> driver level support, that is understandable, but is all there for fbcon
> to take advantage of it ? What about multi-seat, with two full consoles,
> with mouse and keyboard for each ?
> 

This was one of the goals of the Ruby project, but I think it's mostly 
the input layer that got into the kernel. 

Fbcon needs to be cleaned up, a lot. It still implements the "current
console or foreground console" concept (only one console active at a
time).  Also, this is more of a job for linuxconsole than fbdev.  I may
be wrong though.

> > It does have one benefit though, the newer code should make it easier to
> > add an infrastructure on top of fbdev, such as xinerama-style support. 
> > But this will be in the future.
> 
> Mmm, I don't know if there is really a point to this, are there really
> all that much applications which do xinerama-like things on top of fbdev ?
> I rather thought that more higlevel userland apps would be doing this.
> like either xfree86 with chip-specific drivers or fbdev drivers, or
> directfb or something such.
> 

You're right, xinerama is mainly user-app.

Tony



-------------------------------------------------------
This SF.net email is sponsored by: Etnus, makers of TotalView, The debugger 
for complex code. Debugging C/C++ programs can leave you feeling lost and 
disoriented. TotalView can help you find your way. Available on major UNIX 
and Linux platforms. Try it free. www.etnus.com
