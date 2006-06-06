From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: [PATCH 0/7] Detaching fbcon
Date: Tue, 6 Jun 2006 17:55:37 -0400
Message-ID: <9e4733910606061455l2ab3a217q431a90a6c3555813@mail.gmail.com>
References: <44856223.9010606@gmail.com>
	 <9e4733910606060910m44cd4edfs8155c1fe031b37fe@mail.gmail.com>
	 <9e4733910606060919p2a137e07wd58b51a227f5aa5e@mail.gmail.com>
	 <4485DB6C.704@gmail.com>
	 <9e4733910606061400i172d20a7qa9583b9b9245f6f9@mail.gmail.com>
	 <21d7e9970606061439m6e914bf8ya5567b672d5e14bb@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751188AbWFFV4z@vger.kernel.org>
In-Reply-To: <21d7e9970606061439m6e914bf8ya5567b672d5e14bb@mail.gmail.com>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Dave Airlie <airlied@gmail.com>
Cc: "Antonino A. Daplas" <adaplas@gmail.com>, Andrew Morton <akpm@osdl.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Linux Kernel Development <linux-kernel@vger.kernel.org>

On 6/6/06, Dave Airlie <airlied@gmail.com> wrote:
> > > >
> > How is the stack maintained of what was previously bound to console?
> > What if I unbind fbcon on a system that doesn't have VGAcon for a backup?
>
> You could try actually reading the patches...

I was working on a patch for this but now I've lost interest.

Detach should be an attribute off from /dev/console. /dev/console is
using the standard device support and appears at
/sys/class/tty/console so /sys/class/tty/console/detach can be added
as an attribute. /sys/class/tty/console could have another attribute
which lists the available drivers. One solution would be for the
attribute to list the names of the available drivers that have
registered with console and then copy one of those names back to the
attribute to select where console is bound.

In my opinion attach/detach does not belong as an attribute on fbcon,
it is part of /dev/console. The fact that fbcon has to ask console to
unbind from it implies these attributes are in the wrong place.

-- 
Jon Smirl
jonsmirl@gmail.com
