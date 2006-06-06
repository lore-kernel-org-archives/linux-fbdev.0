From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: [PATCH 0/7] Detaching fbcon
Date: Tue, 6 Jun 2006 12:19:36 -0400
Message-ID: <9e4733910606060919p2a137e07wd58b51a227f5aa5e@mail.gmail.com>
References: <44856223.9010606@gmail.com>
	 <9e4733910606060910m44cd4edfs8155c1fe031b37fe@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751331AbWFFQTh@vger.kernel.org>
In-Reply-To: <9e4733910606060910m44cd4edfs8155c1fe031b37fe@mail.gmail.com>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: "Antonino A. Daplas" <adaplas@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Linux Kernel Development <linux-kernel@vger.kernel.org>

On 6/6/06, Jon Smirl <jonsmirl@gmail.com> wrote:
> On 6/6/06, Antonino A. Daplas <adaplas@gmail.com> wrote:
> > Overall, this feature is a great help for developers working in the
> > framebuffer or console layer.  There is not need to continually reboot the
> > kernel for every small change. It is also useful for regular users who wants
> > to choose between a graphical console or a text console without having to
> > reboot.
>
> Instead of the sysfs attribute, what about creating a new escape
> sequence that you send to the console system to detach? Doing it that
> way would make more sense from a stacking order. It just seems
> backwards to me that you ask a lower layer to detach from the layer
> above it. The escape sequence would also work for any console
> implementation, not just fbcon.
>
> If console detached this way and there was nothing to fallback to
> (systems without VGAcon), it would know not to try and print anything
> until something reattaches to it.

Another thought, controlling whether console is attached or not is an
attribute of console, not of fbcon. It should be possible to have
VGAcon, fbcon, serial etc loaded and then switch console between them.
Does console need to get a sysfs entry showing what console providers
have registered with it and then allow you to choose which one (or
none) it is attached to?

-- 
Jon Smirl
jonsmirl@gmail.com
