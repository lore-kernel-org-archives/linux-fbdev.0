From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: [PATCH 5/5] VT binding: Add new doc file
	describing the feature
Date: Sat, 10 Jun 2006 21:27:26 +0800
Message-ID: <448AC8BE.7090202@gmail.com>
References: <44893407.4020507@gmail.com>
	<9e4733910606092253n7fe4e074xe54eaec0fe4149f3@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Fp3V5-0005eL-3Q for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 10 Jun 2006 06:27:39 -0700
Received: from py-out-1112.google.com ([64.233.166.183])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1Fp3V4-0005M9-IZ
	for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 10 Jun 2006 06:27:39 -0700
Received: by py-out-1112.google.com with SMTP id x31so1230000pye
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Sat, 10 Jun 2006 06:27:37 -0700 (PDT)
In-Reply-To: <9e4733910606092253n7fe4e074xe54eaec0fe4149f3@mail.gmail.com>
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
To: Jon Smirl <jonsmirl@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Linux Kernel Development <linux-kernel@vger.kernel.org>

Jon Smirl wrote:
> On 6/9/06, Antonino A. Daplas <adaplas@gmail.com> wrote:
>> - Describe the characteristics of 2 general types of console drivers
>> - How to use the sysfs to unbind and bind console drivers
>> - Uses for this feature
> 
> I like this new binding feature and that for doing the work to make it
> happen. It is definitely something I will use in the future.
> 
>> From the docs I see a distinction between system consoles and modular
> consoles, can't all consoles be created equally?  The only rule would
> be, that if there is only a single console registered it can't be
> unbound or unregistered. It shouldn't matter which console is the last
> one left.

Yes, it can be made that way. I just made it like that because
system consoles, since they are initialized very, very early, have to
be compiled statically. Therefore, they have can never be unloaded. So
why give them the prerogative to directly unbind, when they can never
be unloaded? One can unbind them anyway by binding a modular driver.

It would also make binding/unbinding a more complicated process.

> 
> We have these console systems: dummy, serial, vga, mda, prom, sti,
> newport, sisusb, fb, network (isn't there some way to use the net for
> console?)

network is different.  It's a different class of console itself.  We
have different console classes BTW. We have netconsole, serial console,
vt consoles etc. fbcon, vgacon, promcon, etc all fall under the vt
console class.

> 
> All of these console system could follow the same protocol for
> registering/binding as the modular consoles so we would end up with a
> single class of console, not modular vs system.

That was the plan before, the problem here is that we won't have any
output during the early part of the boot process. That's why I
differentiated them into system and modular consoles.

> Of course some of these consoles are built in and are never going to
> unregister themselves, but that doesn't meant that their binding
> sequence has to be different from the modular systems.
> 
> For example I can easily see VGA being converted from built-in to
> modular. There have also been times when I was working on video
> drivers that I wanted to switch to a serial console. For symmetry
> dummycon should be built into all systems.

As mentioned above, making vgacon (and other system drivers) take this
pathway means we lose output during the early part.  

> 
> As for the way the sysfs attribute works, in a similar situation in fb
> I used two attributes. Maybe 'backends' which is a read only list of
> available console systems. And 'backend' which is read/write. Copy one
> of the names from 'backends' to 'backend' to swtich the active/bound
> console. Cat 'backend' to see the active console. Any idea on a better
> name than 'backend'?
> 
> cat /sys/class/tty/console/backends
> vga
> serial
> dummy
> fb
> 
> cat /sys/class/tty/console/backend
> vga
> 
> echo fb >/sys/class/tty/console/backend
> 
> cat /sys/class/tty/console/backend
> fb
> 

I was thinking of changing it to something like this, after GregKH's
suggestion:

/sys/class/vtconsole --- vgacon - bind
                     : 
                     --- fbcon - bind
                     : 
                     --- dummycon - bind

... with the 'bind' as a r/w attribute, 0 for unbound/unbind, 1 for
bound/bind. 

What do you think?

Tony
