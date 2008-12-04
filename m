From: "Dave Airlie" <airlied@gmail.com>
Subject: Re: Userspace blit API
Date: Thu, 4 Dec 2008 19:03:34 +1000
Message-ID: <21d7e9970812040103n54e877f1qb049bd9cbaf9c794@mail.gmail.com>
References: <200812040927.24861.thomas.cooksey@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <airlied@gmail.com>) id 1L8A7W-00053w-Nh
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 04 Dec 2008 09:03:38 +0000
Received: from yw-out-1718.google.com ([74.125.46.155])
	by 1b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1L8A7T-0004xz-LG for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 04 Dec 2008 09:03:38 +0000
Received: by yw-out-1718.google.com with SMTP id 6so1730560ywa.82
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Thu, 04 Dec 2008 01:03:34 -0800 (PST)
In-Reply-To: <200812040927.24861.thomas.cooksey@nokia.com>
Content-Disposition: inline
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Tom Cooksey <thomas.cooksey@nokia.com>
Cc: linux-fbdev-devel@lists.sourceforge.net

On Thu, Dec 4, 2008 at 6:27 PM, Tom Cooksey <thomas.cooksey@nokia.com> wrote:
> Hi,
>
> I'm a developer working on Qt for Embedded Linux.
>
> We have customers with hardware blitters who want to use them with Qt.
> Currently, this is done by either mmap'ing the device's registers or by adding
> special, device-specific ioctls to their fbdev driver. What would be nice is
> to have a generic blit API as part of fbdev - preferably one we can query to
> ask "Is this kind of blit accelerated?" and drop to pure user-space if it's
> not accelerated. This seems like a pretty common thing to want, which probably
> means there's a very good reason it has not already been implemented. I've
> searched the mailing list archives, Google and Documentation/fb but not found
> a huge amount of information.
>
> Also, how does fbdev fit with the DRM modesetting API? I've had a look at the
> modesetting stuff and it seems to be providing pretty much the same
> functionality?

The rule we have for the DRM is the kernel doesn't provide
acceleration, except for a fast
memcpy (using blit hw if necessary) to move buffers in/out of VRAM.

DRM kms is mainly going to provide a modesetting interface that
reflects what modern gpu hw wants.
GPU hw with multiple crtcs and outputs, needs something that fbdev
really can't provide with its interfaces.

What we are planning on with kms is to provide fbdev drivers as part
of the kms drivers, but really for legacy users and to
provide a console.

Things like current directfb accel won't work with these fbdev
drivers, mapping card regs into userspace won't be allowed.

For cards using kms, the DRM will provide a per-driver accel interface
(just like it does now) as many cards just don't provide blit engines
and the like anymore, so even though a generic blit interface might
seem sensible now, cards like the ATI r600, nvidia G80, etc don't have
2D engines so you have to execute 3D state to do a blit.

Dave.

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
