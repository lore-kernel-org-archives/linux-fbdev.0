From: Antonino Daplas <adaplas@pol.net>
Subject: RE: (no subject)
Date: 13 Dec 2002 11:33:39 +0500
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1039761085.1046.73.camel@localhost.localdomain>
References: <001301c2a08f$f49d9250$3c01a8c0@berflo.lan>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from willow.compass.com.ph ([202.70.96.38])
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18Mgfr-0001aI-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 12 Dec 2002 19:39:39 -0800
In-Reply-To: <001301c2a08f$f49d9250$3c01a8c0@berflo.lan>
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
To: vivens <vivens@berflo.dhs.org>
Cc: 'James Simmons' <jsimmons@infradead.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Wed, 2002-12-11 at 02:05, vivens wrote:
> Well, I mend it like this:
> I'm trying to build a framebuffer for an embedded ARM platform (which
> doesn't use any kind of a Lunix distr).
> I want to use a framebuffer, because some apps need it. For example the
> ZEN browser I want to implement on this platform.

You can check the linux-2.5.51 for insights.  But if you just want to 
implement the API without necessarily conforming to linux's framebuffer
support (don't want to use linux), then:

First you need hardware with linear video memory.

If you want compatibility with standard fb_apps , then you need the
following;
1. accessing the driver as a file (/dev/fbx) - the name is pretty much
hardwired.
2. support standard file operations (open, close, read, write).  The
read/write operation accesses the video memory.

3. This is the biggie:  support for most fb_specific ioctls (check
drivers/video/fbmem.c).  

Required ioctl support:
a. Setting the struct fb_var_screeninfo.  This is basically the
structure used to communicate between user apps and the driver, and
contains information that can modify the video/framebuffer state
depending on the capabilities of the hardware.  As for the video
/framebuffer state, it encompasses the dimensions of the display, the
pixelformat, the color information, etc, as described in the file
linux/include/linux/fb.h.  

You don't have to follow everything in the request.  In fact, you don't
even have to do anything at all, but you must return an
fb_var_screeninfo structure that is valid for the driver. It's like the
app saying "this is what I want" and the driver returning with "this is
what you get, take it or leave it".

b. Getting the struct fb_var_screeninfo.  This is simple enough, it
returns the structure containing information describing the current
state.

c. Getting struct fb_fix_screeninfo.  This structure contains
information that cannot be altered by outside requests, that's why get
is only supported.  It does partly depend on fb_var_screeninfo, but is
more or less hardware specific information. This is a one way ioctl,
driver to user.

As for the rest of the ioctls, you can just return success or fail.

4. have video memory mappable to user space (check fb_mmap in fbmem.c).
Although optional, practically all apps use/need this.

5. You may wish to skip console support because that entails a lot of
work. (and you probably don't need this)

> So my question is:
> What basic functions does a framebuffer normally have, what is need to
> initialize for these functions?

At a bare minimum, the driver must set the hardware into a state as
imposed by itself during initialization, or by requests through
fb_var_screeninfo..  

For most apps, mmap support must be included.

The simplest driver then would support #1, #2, #4, and set the video
mode at initialization.  As for #3, just return success/fail, making
sure the driver channels back the correct information to the userland
app, without actually doing anything at all. 

> Can I see the framebuffer as the API between the video hardware and any
> application what uses the video hardware?
> 

Yes, that's the goal of the framebuffer, to abstract the underlying
hardware into a well-defined interface.  But to keep it as simple and as
cross-platform as possible, the API is at the barest minimum (set the
hardware, set the mode, and offer access to the graphics memory either
through file reads/writes or mmap). The rest are icing on the cake.

If I missed anything, feel free.

Tony



-------------------------------------------------------
This sf.net email is sponsored by:
With Great Power, Comes Great Responsibility 
Learn to use your power at OSDN's High Performance Computing Channel
http://hpc.devchannel.org/
