From: "Alex Deucher" <alexdeucher@gmail.com>
Subject: Re: Userspace blit API
Date: Thu, 4 Dec 2008 09:34:22 -0500
Message-ID: <a728f9f90812040634o4f7afdcbqb0056521f501b740@mail.gmail.com>
References: <200812040927.24861.thomas.cooksey@nokia.com>
	<21d7e9970812040103n54e877f1qb049bd9cbaf9c794@mail.gmail.com>
	<200812041141.40350.thomas.cooksey@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <alexdeucher@gmail.com>) id 1L8FHg-0006eI-9E
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 04 Dec 2008 14:34:28 +0000
Received: from nf-out-0910.google.com ([64.233.182.189])
	by 29vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1L8FHc-0005rJ-MY for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 04 Dec 2008 14:34:28 +0000
Received: by nf-out-0910.google.com with SMTP id g16so2007799nfd.2
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Thu, 04 Dec 2008 06:34:23 -0800 (PST)
In-Reply-To: <200812041141.40350.thomas.cooksey@nokia.com>
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
Cc: "linux-fbdev-devel@lists.sourceforge.net" <linux-fbdev-devel@lists.sourceforge.net>

On Thu, Dec 4, 2008 at 5:41 AM, Tom Cooksey <thomas.cooksey@nokia.com> wrote:
> On Thursday 04 December 2008 10:03:34 ext Dave Airlie wrote:
>> On Thu, Dec 4, 2008 at 6:27 PM, Tom Cooksey <thomas.cooksey@nokia.com>
> wrote:
>> > Hi,
>> >
>> > I'm a developer working on Qt for Embedded Linux.
>> >
>> > We have customers with hardware blitters who want to use them with Qt.
>> > Currently, this is done by either mmap'ing the device's registers or by
>> > adding special, device-specific ioctls to their fbdev driver. What would
>> > be nice is to have a generic blit API as part of fbdev - preferably one
>> > we can query to ask "Is this kind of blit accelerated?" and drop to pure
>> > user-space if it's not accelerated. This seems like a pretty common thing
>> > to want, which probably means there's a very good reason it has not
>> > already been implemented. I've searched the mailing list archives, Google
>> > and Documentation/fb but not found a huge amount of information.
>> >
>> > Also, how does fbdev fit with the DRM modesetting API? I've had a look at
>> > the modesetting stuff and it seems to be providing pretty much the same
>> > functionality?
>>
>> The rule we have for the DRM is the kernel doesn't provide
>> acceleration, except for a fast
>> memcpy (using blit hw if necessary) to move buffers in/out of VRAM.
>
> That does make sense from that I've read on the DRI-devel list....
>
>> DRM kms is mainly going to provide a modesetting interface that
>> reflects what modern gpu hw wants.
>> GPU hw with multiple crtcs and outputs, needs something that fbdev
>> really can't provide with its interfaces.
>
> Well, I'd argue that it's not just super-amazing desktop 3D drivers which need
> this. Pretty much all embedded display controllers I've come across in the
> last few years have had at least a TV-out and often support for 2 LCDs. I've
> seen a "Display control" sysfs interface for omap fb hardware which controls
> which /dev/fbx is mapped to which output. I think it even allows multiple
> outputs to share the same fb device and stack several framebuffers on top of
> each other with a global alpha. Seems very similar to the drm modesetting
> interface (apart from the overlay support).

Ideally they'd eventually provide a drm kms interface.

>
>
>> What we are planning on with kms is to provide fbdev drivers as part
>> of the kms drivers, but really for legacy users and to provide a console.
>
> Yup, I've played with this on my laptop with the i915 driver in jbarnes's
> tree. It's quite nice to have /dev/fb0 again :-). Although I see no problem in
> writing a Qt/Embedded driver which uses the libdrm interfaces to map the
> framebuffer directly (something I want to play with anyway). I think it's
> going to be a little more involved than just mmap'ing /dev/fb0, but not too
> much so.
>
>
>> Things like current directfb accel won't work with these fbdev
>> drivers, mapping card regs into userspace won't be allowed.
> What are your thoughts on expanding libdrm's scope beyond 3D drivers? I do
> think the modesetting API it provides is useful for embedded hardware too.
>
> I'm basically just lazy - I don't like having to support fbdev, directfb, drm
> (we have customers asking for it) as well as proprietary fbdev extensions for
> one-off devices.
>
>> For cards using kms, the DRM will provide a per-driver accel interface
>> (just like it does now) as many cards just don't provide blit engines
>> and the like anymore, so even though a generic blit interface might
>> seem sensible now, cards like the ATI r600, nvidia G80, etc don't have
>> 2D engines so you have to execute 3D state to do a blit.
>
> ... Then perhaps it would make sense to add a blit API to libdrm? The
> important bit I want to emphasize is that the entire API would be optional -
> We've learned from experience with XRender that providing an API with software
> fallbacks doesn't work very well. It's better to query "can the device
> accelerate this?" and do something else if it doesn't. So, hardware without a
> blitter will just say "I don't support this, do it yourself". This would apply
> to both high-end 3d chips which lack a blitter and to the ultra low-end
> framebuffer only chips. Plus, if it's exposed via libdrm, the device-specific
> part of the library could fire-up the 3d core to do the blit in userspace
> (well, assemble the command buffer in usespace anyway). Although to be honest,
> I'd expect people will want a 3d-composited UI if there's 3d available.
>
>
> I'm also not sure how video overlays play into this. Using the v4l API to
> accelerate video on top of fbdev seems odd. I think even ultra-high end mobile
> hardware will always have overlay hardware simply because it uses less power
> than the 3D core (I could be wrong about that though!).

Just like acceleration.  You'd built a command buffer or mmio list in
your usersapce accel driver and submit it to the drm just like you
would for 2D or 3D.  Since the the kms drm is no longer tied directly
to X, you can use the modesetting api directly and a separate lib for
accel.  Create a userspace blit or overlay lib with drm backends for
various hw that builds command packets if you don't want to use X.

Alex

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
