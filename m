From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: [PATCH 5/5] VT binding: Add new doc file
	describing the feature
Date: Sun, 11 Jun 2006 08:21:13 +0800
Message-ID: <448B61F9.4060507@gmail.com>
References: <44893407.4020507@gmail.com>	
	<9e4733910606092253n7fe4e074xe54eaec0fe4149f3@mail.gmail.com>	
	<448AC8BE.7090202@gmail.com>	
	<9e4733910606100916r74615af8i34d37f323414034c@mail.gmail.com>	
	<448B38F8.2000402@gmail.com>
	<9e4733910606101644j79b3d8a5ud7431564f4f42c7f@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-list1-b.sourceforge.net ([10.3.1.7]
	helo=sc8-sf-list1.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1FpDhj-0007f3-Rs for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 10 Jun 2006 17:21:23 -0700
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FpDhj-0006gM-Lu for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 10 Jun 2006 17:21:23 -0700
Received: from py-out-1112.google.com ([64.233.166.181])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1FpDhj-0001kZ-C8
	for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 10 Jun 2006 17:21:23 -0700
Received: by py-out-1112.google.com with SMTP id x31so1323494pye
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Sat, 10 Jun 2006 17:21:22 -0700 (PDT)
In-Reply-To: <9e4733910606101644j79b3d8a5ud7431564f4f42c7f@mail.gmail.com>
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
Cc: Andrew Morton <akpm@osdl.org>, Greg KH <greg@kroah.com>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Linux Kernel Development <linux-kernel@vger.kernel.org>

Jon Smirl wrote:
> On 6/10/06, Antonino A. Daplas <adaplas@gmail.com> wrote:
>> > I may be looking at the problem a little differently. I see the
>> > drivers like fb, vga, etc as registering with the console and saying
>> > they are capable of providing console services. I then see the console
>> > system as opening one of the registered devices. A driver is free to
>> > register/unregister whenever it wants to as long as it isn't open by
>> > the console system. Console can only open one driver at a time.
>>
>> No, this isn't true.  You can have multiple console drivers active,
>> that's why you have a first and last parameter in take_over_console().
>> Thus at boot time, the system driver will take consoles 0 - 63.
>> Later on when a driver loads, it can take over consoles 0 - 7, leaving
>> consoles 8 - 63 to the system driver.
>>
>> To put it another way, console drivers can register for consoles 0 - 63,
>> but the user may choose to use it only for consoles 0 - 7.
>>
>> This is another reason for the system driver, it makes the unbinding
>> behavior predictable.  Without a system driver, guessing which driver
>> replaces the just unbound one may become just a tad bit confusing for
>> the typical user.
> 
> I find the whole console/tty layer to be quite confusing to talk
> about. I am mixing up console as in where printk goes and console the
> video card login device. The part about making everything equal was
> directed towards the printk output device.
> 

Sorry about that, I probably should use VT or VC for the main topic
of this thread, and plain 'console' for where the printk output goes.

This illustration might help, though I'm not sure if it's entirely
correct. The main topic of this thread deals with the VT branch only.

Console
   :
   :-----:-----------:--- etc
   :     :           :
   VT    Serial      Net
   :
   :--------:-------:-----etc
   :        :       : 
   vgacon   fbcon   newport_con
   :        :       :
   :        :       :
   hardware fbdev   hardware
            :
            :
            hardware


> I see now that you can have tty0-7 assigned to a different console
> driver than tty8-63.
> Why do I want to do this?

Multi-head.  I can have vgacon on the primary card for tty0-7,
fbcon on the secondary card for tty8-16.

> Why do we need 64 predefined tty devices?

I don't know, but no one's stopping you to redefine MAX_NR_CONSOLES to
a lower or higher number.

> 
> Googling around the only example I could find was someone with a VGA
> card and a Hercules card. They setup 8 consoles on each card.
> 
>> > Over time it would nice if these all merged to a single
>> > interchangeable interface. I would really like to be able to
>> > dynamically switch to serial/net while debugging a video driver. Is
>> > there some fundamental reason why these can't be merged?
>>
>> It's already possible to redirect the system messages to two different
>> console classes, ie with the boot parameter:
>>
>> console=tty0,ttyS0 /* direct output to VT and serial console */
>>
>> And you can already choose the console you want by adjusting
>> /etc/inittab.
> 
> How can I change where printk are going at run-time? I didn't know you
> could do that.

I really don't know.  Maybe we have some kind of entry in /proc somewhere?

Tony
