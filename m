From: James Simmons <jsimmons@infradead.org>
Subject: Re: [Linux-fbdev-devel] Redesign of kernel graphics interface
Date: Thu, 6 May 2004 23:48:06 +0100 (BST)
Sender: mesa3d-dev-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0405062327050.20402-100000@phoenix.infradead.org>
References: <20040507003029.D23760@armor.freesurf.fr>
Mime-Version: 1.0
Return-path: <mesa3d-dev-admin@lists.sourceforge.net>
In-Reply-To: <20040507003029.D23760@armor.freesurf.fr>
Errors-To: mesa3d-dev-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/mesa3d-dev>,
	<mailto:mesa3d-dev-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:mesa3d-dev@lists.sourceforge.net>
List-Help: <mailto:mesa3d-dev-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/mesa3d-dev>,
	<mailto:mesa3d-dev-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=mesa3d-dev>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Nicolas Souchu <nsouch@free.fr>
Cc: Jon Smirl <jonsmirl@yahoo.com>, dri-devel <dri-devel@lists.sourceforge.net>, mesa3d-dev <mesa3d-dev@lists.sourceforge.net>, fb-devel <linux-fbdev-devel@lists.sourceforge.net>


> But who cares? Do you really intend to keep a common BSD and Linux API/code base?
> Offering both solutions under BSD and GPL would be good for suggesting correct
> license usage in the embedded world. GPL is too often bypassed.

What about a dual license.
 
> > The big reason for merging is memory management. If FB supports multiple heads
> > it is forced into doing memory management. DRI has memory management needs that
> > go far beyond what FB needs so a merged system has to use DRM memory management.
> > Ian has made proposals on how to do this and he is working on improving them. 
> 
> What is best? Bring modesetting to DRM or memory management to FB?

Bring mode setting to DRM since all FB does is mode setting, color maps 
and 3 accel functions for the console. With sysfs we could bring both 
together.

> > BenH and others have made proposals for pushing the mode setting code into a
> > user space library in order to reduce kernel footprint and ease debugging. Most
> > of the code needed for this library already exists in the current Linux FB
> > drivers. I'm not sure if this could be relicensed BSD when it is moved to user
> > space.
> 
> One advantage of true graphic drivers (opposed to VESA or more generally bios modes)
> is that they can boot some archs in graphic mode (no text mode) without bios.
> Exactly what linuxfb was originaly designed to. How do you perform this 
> from userspace?

The idea was to mount userland inside the kernel while booting and run a 
library to initialize the mode. We have two options:

1) Keep mode switching in the kernel. Merge DRI and fb together via 
   sysfs interface.

2) Ben suggestion that we mount userland inside the kernel during early 
   boot and use a userland library. If we would use a library then it MUST 
   be OpenGL. This would be the forced standard on all platforms. This 
   would mean Mesa would be needed to build the kernel. We could move over 
   Mesa into the kernel like zlib is in the tree right now.




-------------------------------------------------------
This SF.Net email is sponsored by Sleepycat Software
Learn developer strategies Cisco, Motorola, Ericsson & Lucent use to 
deliver higher performing products faster, at low TCO.
http://www.sleepycat.com/telcomwpreg.php?From=osdnemail3
