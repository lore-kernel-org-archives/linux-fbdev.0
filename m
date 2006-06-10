From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: [PATCH 5/5] VT binding: Add new doc file
	describing the feature
Date: Sat, 10 Jun 2006 19:44:56 -0400
Message-ID: <9e4733910606101644j79b3d8a5ud7431564f4f42c7f@mail.gmail.com>
References: <44893407.4020507@gmail.com>
	<9e4733910606092253n7fe4e074xe54eaec0fe4149f3@mail.gmail.com>
	<448AC8BE.7090202@gmail.com>
	<9e4733910606100916r74615af8i34d37f323414034c@mail.gmail.com>
	<448B38F8.2000402@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1FpD8T-0004lr-HH for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 10 Jun 2006 16:44:57 -0700
Received: from nz-out-0102.google.com ([64.233.162.200])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1FpD8T-00051g-7q
	for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 10 Jun 2006 16:44:57 -0700
Received: by nz-out-0102.google.com with SMTP id 4so919369nzn
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Sat, 10 Jun 2006 16:44:56 -0700 (PDT)
In-Reply-To: <448B38F8.2000402@gmail.com>
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

On 6/10/06, Antonino A. Daplas <adaplas@gmail.com> wrote:
> > I may be looking at the problem a little differently. I see the
> > drivers like fb, vga, etc as registering with the console and saying
> > they are capable of providing console services. I then see the console
> > system as opening one of the registered devices. A driver is free to
> > register/unregister whenever it wants to as long as it isn't open by
> > the console system. Console can only open one driver at a time.
>
> No, this isn't true.  You can have multiple console drivers active,
> that's why you have a first and last parameter in take_over_console().
> Thus at boot time, the system driver will take consoles 0 - 63.
> Later on when a driver loads, it can take over consoles 0 - 7, leaving
> consoles 8 - 63 to the system driver.
>
> To put it another way, console drivers can register for consoles 0 - 63,
> but the user may choose to use it only for consoles 0 - 7.
>
> This is another reason for the system driver, it makes the unbinding
> behavior predictable.  Without a system driver, guessing which driver
> replaces the just unbound one may become just a tad bit confusing for
> the typical user.

I find the whole console/tty layer to be quite confusing to talk
about. I am mixing up console as in where printk goes and console the
video card login device. The part about making everything equal was
directed towards the printk output device.

I see now that you can have tty0-7 assigned to a different console
driver than tty8-63.
Why do I want to do this?
Why do we need 64 predefined tty devices?

Googling around the only example I could find was someone with a VGA
card and a Hercules card. They setup 8 consoles on each card.

> > Over time it would nice if these all merged to a single
> > interchangeable interface. I would really like to be able to
> > dynamically switch to serial/net while debugging a video driver. Is
> > there some fundamental reason why these can't be merged?
>
> It's already possible to redirect the system messages to two different
> console classes, ie with the boot parameter:
>
> console=tty0,ttyS0 /* direct output to VT and serial console */
>
> And you can already choose the console you want by adjusting /etc/inittab.

How can I change where printk are going at run-time? I didn't know you
could do that.

-- 
Jon Smirl
jonsmirl@gmail.com
