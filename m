From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: [PATCH 5/5] VT binding: Add new doc file describing the feature
Date: Sat, 10 Jun 2006 20:49:15 -0400
Message-ID: <9e4733910606101749r77d72a56mbcf6fb3505eb1de0@mail.gmail.com>
References: <44893407.4020507@gmail.com>
	 <9e4733910606092253n7fe4e074xe54eaec0fe4149f3@mail.gmail.com>
	 <448AC8BE.7090202@gmail.com>
	 <9e4733910606100916r74615af8i34d37f323414034c@mail.gmail.com>
	 <448B38F8.2000402@gmail.com>
	 <9e4733910606101644j79b3d8a5ud7431564f4f42c7f@mail.gmail.com>
	 <448B61F9.4060507@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1161058AbWFKAtQ@vger.kernel.org>
In-Reply-To: <448B61F9.4060507@gmail.com>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: "Antonino A. Daplas" <adaplas@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Linux Kernel Development <linux-kernel@vger.kernel.org>, Greg KH <greg@kroah.com>

On 6/10/06, Antonino A. Daplas <adaplas@gmail.com> wrote:
> > I see now that you can have tty0-7 assigned to a different console
> > driver than tty8-63.
> > Why do I want to do this?
>
> Multi-head.  I can have vgacon on the primary card for tty0-7,
> fbcon on the secondary card for tty8-16.

That's what I thought, I couldn't see any other reason. The kernel
doesn't support input from multiple users so multihead can only be
used by a single user.

Does anyone use single user multihead on current systems? The kernel
doesn't have code in it to initialize secondary VGA cards. What modern
non-VGA hardware does this work on?

If this feature doesn't work on current hardware, could it be dropped?
It would make binding to the vt system much simpler if only one driver
could be bound at a time. Anything we do to make that system simpler
would benefit everyone.

At some future point I would like to explore pushing the VT system out
to user space where it becomes much easier to make it multi-user and
multi-head. If you do that, something like a single user, in-kernel
system management console makes more sense.

-- 
Jon Smirl
jonsmirl@gmail.com
