From: Otto Solares <solca@guug.org>
Subject: Re: [Linux-fbdev-devel] Redesign of kernel graphics interface
Date: Thu, 6 May 2004 14:57:35 -0600
Sender: mesa3d-dev-admin@lists.sourceforge.net
Message-ID: <20040506205735.GA5194@guug.org>
References: <20040506181639.61975.qmail@web14929.mail.yahoo.com>
Mime-Version: 1.0
Return-path: <mesa3d-dev-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <20040506181639.61975.qmail@web14929.mail.yahoo.com>
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
Content-Transfer-Encoding: 7bit
To: Jon Smirl <jonsmirl@yahoo.com>
Cc: dri-devel <dri-devel@lists.sourceforge.net>, mesa3d-dev <mesa3d-dev@lists.sourceforge.net>, fb-devel <linux-fbdev-devel@lists.sourceforge.net>

On Thu, May 06, 2004 at 11:16:39AM -0700, Jon Smirl wrote:
> At the X Developers Conference there was a discussion of the issues around
> framebuffer and DRI. Theodore Ts'o suggested that I write it up and post it for
> discussion. I'm going to try and list all of the issues I've heard from all
> sides so some of the proposed solutions are in conflict. The goal of this list
> is to provide direction for a topic discussion at the Ottawa Kernel Summit.

I see as common sense that fbdev should become the low-level and unified
interface for graphics in Linux, it has too many advantages for us:

- Exists now.
- Multi-architecture.
- Very popular in embedded solutions.
- Interface to change video modes.
- Supports low-end hardware.
- It has an interface to control the hw from userspace.
- Can be enhanced or fixed.

Missing in fbdev:

- Memory management.
- Hardware lock to synch or flag changes in hardware.
  (Maybe with the DRM/FB merge we could reuse the lock.)
- sysfs (being fixed by Luca).
- Video-out port API.
- Video capture API (gatos).

I imply too that fbcon should not be considered as part of this low-level
layer, but a client of it, because it implements acceleration and other
stuff not related nor pertinent to a graphics layer per se.

I am not saying that everything should be in the kernel, just the necesary
API to properly have a Linux graphics state machine.  Anything else should
be in userspace, specially acceleration that could be provided by DRI,
directfb, fbcon, etc. which all will be clients of the low-level fbdev layer.

This path makes it feasible to implement graphics servers (like Xserver)
without implementing or duplicating the graphics layer details.  This
would lead to a sane and (with time) a stable graphics layer for linux in
the same way we have first-class networking, input and sound layers in Linux
now.

-otto



-------------------------------------------------------
This SF.Net email is sponsored by Sleepycat Software
Learn developer strategies Cisco, Motorola, Ericsson & Lucent use to 
deliver higher performing products faster, at low TCO.
http://www.sleepycat.com/telcomwpreg.php?From=osdnemail3
