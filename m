From: Adam Jackson <ajax@nwnk.net>
Subject: Re: RE: [Linux-fbdev-devel] Current discussion about the future of free software graphics
Date: Mon, 10 May 2004 21:20:48 -0500
Sender: mesa3d-dev-admin@lists.sourceforge.net
Message-ID: <200405102120.48640.ajax@nwnk.net>
References: <A98078D7EF5BEA4D8D8FD797FFBBC75F0742A3A6@fmsmsx402.fm.intel.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <mesa3d-dev-admin@lists.sourceforge.net>
In-Reply-To: <A98078D7EF5BEA4D8D8FD797FFBBC75F0742A3A6@fmsmsx402.fm.intel.com>
Content-Disposition: inline
Errors-To: mesa3d-dev-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/mesa3d-dev>,
	<mailto:mesa3d-dev-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:mesa3d-dev@lists.sourceforge.net>
List-Help: <mailto:mesa3d-dev-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/mesa3d-dev>,
	<mailto:mesa3d-dev-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=mesa3d-dev>
Content-Type: text/plain; charset="us-ascii"
To: mesa3d-dev@lists.sourceforge.net
Cc: "Sottek, Matthew J" <matthew.j.sottek@intel.com>, Michel =?iso-8859-1?q?D=E4nzer?= <michel@daenzer.net>, xserver@freedesktop.org, dri-devel@lists.sourceforge.net, linux-fbdev-devel@lists.sourceforge.net

On Monday 10 May 2004 19:11, Sottek, Matthew J wrote:
> >It does, or the ioctl must verify the register data, which could require
> >about the same amount of code as computing it in the kernel in the first
> >place (possibly even more; the problem changes from computing a valid
> >combination of register values for a specific requested mode to limiting
> >the huge number of register value combinations to those that don't lock
> >up the chip or worse). I've pointed this out several times before, but
> >nobody has presented a solution yet. Will the userspace code live in a
> >daemon that runs as root? Or will only privileged processes be allowed
> >to change display properties?
>
> I am in agreement with Michel on this point.
> There is a privilege problem.
> Either you trust the data coming from user-space to kernel-space
> implicitly which means the user-space process now must be privileged,
> or you don't trust user-space and you have to re-validate the data coming
> into the kernel.

Close.  You only need to trust the user if the operation could have security 
implications.  If your graphics card can use DMA to write to any point in 
memory, then you need to restrict that operation to root, otherwise a user 
can change the euid of a running process to 0.  Or, the other way around, DMA 
reads could be used to read the shadow password file out of login(8)'s 
memory.

Framebuffer and texture memory don't count as sensitive areas because the user 
can already write whatever he likes to them (perhaps through whatever 
authentication method your graphics system uses).  Likewise mode setting 
isn't sensitive because changing the display mode isn't going to stomp on 
kernel data structures or on the address space of other running processes.

Note that this is security from the kernel's point of view.  How you limit 
access to your display is an orthogonal issue.  X has no concept of 
segmentation, only authorization (modulo the Security extension, which by all 
accounts doesn't work very well anymore...).  Presumably any future system 
will have/want to do authorization at some level, and will face the same 
issues X has now.

> I have conceded that I am fine with a user-space mode setting API
> as long as there is no imposed user/kernel split. For those who's chips
> would require too much code to revalidate, they can just put the whole
> mode setting in the kernel. I think we will discover that many of the
> more advanced drivers will end up taking this route.

Again, mode setting is a usability issue, not a security one.  You can't 
violate the pagetable access control by changing timing settings on the video 
card.  (With the possible exception of IGP-style chips where the framebuffer 
resizes to match the resolution; does this case even happen?  Even in this 
case we could get away with the kernel knowing not to expand the resolution 
beyond a certain number of megapixels, or (speculation) running the 
framebuffer through the AGP aperture instead of directly on core.)

That said, obviously the API is all that matters, and the user-kernel split is 
only mandatory to the extent that the hardware is able to circumvent the MMU 
to violate process separation and kernel protection.  The mechanism _should_ 
be masked behind a library that abstracts away the device and implementation 
details as much as possible so the user (where here "user" equals X11 
Classic, Y-Windows, Mesa Solo, whatever) doesn't have to care, and also so 
each new user doesn't have to write the same code again.

Or am I missing something?

> In the end I think this design is more complicated than is necessary. The
> end goal should be to minimize privileged code, not just kernel code. When
> you go with a split design you are forcing more privileged code than if
> all the code lived in the same place.

I agree with the second sentence, but not the rest.  Consider OpenSSH's 
privsep implementation.  Before, the entire daemon ran as root; now only a 
fraction.  The number of lines of code running in as root (and thus needing 
auditing) was cut by a factor of ten, IIRC.

If anything, proper separation _reduces_ the amount of code that runs in a 
privileged context.  If the hardware details create security-sensitive code 
that has to live in the kernel, then it has to live in the kernel; so be it 
[1].  Putting code where it belongs cannot possibly count as bloat.

- ajax

[1] - For those unfortunate users who can't easily add kernel modules, 
something like the current X mechanism - exclusive mmap() of the hardware by 
a trusted userspace process - will have to suffice.  They might sacrifice 
nice things like safe VT switching etc., but those are not bugs that free 
software developers can fix.  Again, the API is all that matters, if a vendor 
has that they can fill in the implementation.


-------------------------------------------------------
This SF.Net email is sponsored by Sleepycat Software
Learn developer strategies Cisco, Motorola, Ericsson & Lucent use to 
deliver higher performing products faster, at low TCO.
http://www.sleepycat.com/telcomwpreg.php?From=osdnemail3
