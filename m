From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: [PATCH 5/5] VT binding: Add new doc file
	describing the feature
Date: Sat, 10 Jun 2006 21:05:05 -0400
Message-ID: <9e4733910606101805t3060c0cdgd08ceabe8cfe4e0e@mail.gmail.com>
References: <44893407.4020507@gmail.com>
	<9e4733910606092253n7fe4e074xe54eaec0fe4149f3@mail.gmail.com>
	<448AC8BE.7090202@gmail.com>
	<9e4733910606100916r74615af8i34d37f323414034c@mail.gmail.com>
	<448B38F8.2000402@gmail.com>
	<9e4733910606101644j79b3d8a5ud7431564f4f42c7f@mail.gmail.com>
	<448B61F9.4060507@gmail.com>
	<9e4733910606101749r77d72a56mbcf6fb3505eb1de0@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-list1-b.sourceforge.net ([10.3.1.7]
	helo=sc8-sf-list1.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1FpEO5-00031g-1h for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 10 Jun 2006 18:05:09 -0700
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FpEO4-0001qD-QC for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 10 Jun 2006 18:05:08 -0700
Received: from nz-out-0102.google.com ([64.233.162.193])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1FpEO2-0000k2-JG
	for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 10 Jun 2006 18:05:08 -0700
Received: by nz-out-0102.google.com with SMTP id z3so1028010nzf
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Sat, 10 Jun 2006 18:05:06 -0700 (PDT)
In-Reply-To: <9e4733910606101749r77d72a56mbcf6fb3505eb1de0@mail.gmail.com>
Content-Disposition: inline
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: "Antonino A. Daplas" <adaplas@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, Greg KH <greg@kroah.com>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Linux Kernel Development <linux-kernel@vger.kernel.org>

On 6/10/06, Jon Smirl <jonsmirl@gmail.com> wrote:
> On 6/10/06, Antonino A. Daplas <adaplas@gmail.com> wrote:
> > > I see now that you can have tty0-7 assigned to a different console
> > > driver than tty8-63.
> > > Why do I want to do this?
> >
> > Multi-head.  I can have vgacon on the primary card for tty0-7,
> > fbcon on the secondary card for tty8-16.
>
> That's what I thought, I couldn't see any other reason. The kernel
> doesn't support input from multiple users so multihead can only be
> used by a single user.
>
> Does anyone use single user multihead on current systems? The kernel
> doesn't have code in it to initialize secondary VGA cards. What modern
> non-VGA hardware does this work on?

The kernel is also missing the logic for controlling which VGA card is
active when multiple ones exist in the same box.

> If this feature doesn't work on current hardware, could it be dropped?
> It would make binding to the vt system much simpler if only one driver
> could be bound at a time. Anything we do to make that system simpler
> would benefit everyone.

When I say dropped, I mean drop the feature of having multiple drivers
simultaneously open by the VT layer. You would still be able to switch
from vgacon to fbcon by using sysfs. You just wouldn't be able to use
VT swap hotkeys between them.

> At some future point I would like to explore pushing the VT system out
> to user space where it becomes much easier to make it multi-user and
> multi-head. If you do that, something like a single user, in-kernel
> system management console makes more sense.
>
> --
> Jon Smirl
> jonsmirl@gmail.com
>

-- 
Jon Smirl
jonsmirl@gmail.com
