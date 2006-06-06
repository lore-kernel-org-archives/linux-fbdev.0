From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: [PATCH 0/7] Detaching fbcon
Date: Wed, 07 Jun 2006 07:17:18 +0800
Message-ID: <44860CFE.2060908@gmail.com>
References: <44856223.9010606@gmail.com>	 <9e4733910606060910m44cd4edfs8155c1fe031b37fe@mail.gmail.com>	 <9e4733910606060919p2a137e07wd58b51a227f5aa5e@mail.gmail.com>	 <4485DB6C.704@gmail.com> <9e4733910606061400i172d20a7qa9583b9b9245f6f9@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751349AbWFFXRx@vger.kernel.org>
In-Reply-To: <9e4733910606061400i172d20a7qa9583b9b9245f6f9@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
To: Jon Smirl <jonsmirl@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Linux Kernel Development <linux-kernel@vger.kernel.org>

Jon Smirl wrote:
> On 6/6/06, Antonino A. Daplas <adaplas@gmail.com> wrote:
>> Jon Smirl wrote:
>> > On 6/6/06, Jon Smirl <jonsmirl@gmail.com> wrote:
>> >> On 6/6/06, Antonino A. Daplas <adaplas@gmail.com> wrote:
>> >> > Overall, this feature is a great help for developers working in the
>> >> > framebuffer or console layer.  There is not need to continually
>> >> reboot the
>> >> > kernel for every small change. It is also useful for regular users
>> >> who wants
>> >> > to choose between a graphical console or a text console without
>> >> having to
>> >> > reboot.
>> >>
>> >> Instead of the sysfs attribute, what about creating a new escape
>> >> sequence that you send to the console system to detach? Doing it that
>> >> way would make more sense from a stacking order. It just seems
>> >> backwards to me that you ask a lower layer to detach from the layer
>> >> above it. The escape sequence would also work for any console
>> >> implementation, not just fbcon.
>> >>
>> >> If console detached this way and there was nothing to fallback to
>> >> (systems without VGAcon), it would know not to try and print anything
>> >> until something reattaches to it.
>> >
>> > Another thought, controlling whether console is attached or not is an
>> > attribute of console, not of fbcon.
>>
>> If the console attached fbcon, then I agree that console should decide
>> when to detach fbcon.  But that's not what happens, it's fbcon that
>> attaches itself.
>>
>> It's not that you're wrong, it's just how the current vt/console layer
>> works.  If someone do decide to add this feature to the vt/console layer,
>> then I'm more than willing to have fbcon support that as well.
> 
> This is just kind of twisted since console increments the fbcon ref
> count.

Oh, the console and vt layer is exactly that, twisted :-)

> Is /dev/console a real device, it that where the sysfs
> attribute should go?

We have /sys/class/tty/console.

 
> How is the stack maintained of what was previously bound to console?

That's the problem, there is no stack.  Once a driver binds to a console,
the previous driver is lost.

> What if I unbind fbcon on a system that doesn't have VGAcon for a backup?

All systems have a backup console, otherwise you're system won't boot.
It's either vgacon or dummycon.

Tony
Tony
 
