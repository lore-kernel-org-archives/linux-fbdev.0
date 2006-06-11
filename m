From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: [PATCH 5/5] VT binding: Add new doc file
	describing the feature
Date: Sun, 11 Jun 2006 11:05:06 +0800
Message-ID: <448B8862.3040904@gmail.com>
References: <44893407.4020507@gmail.com>	
	<9e4733910606092253n7fe4e074xe54eaec0fe4149f3@mail.gmail.com>	
	<448AC8BE.7090202@gmail.com>	
	<9e4733910606100916r74615af8i34d37f323414034c@mail.gmail.com>	
	<448B38F8.2000402@gmail.com>	
	<9e4733910606101644j79b3d8a5ud7431564f4f42c7f@mail.gmail.com>	
	<448B61F9.4060507@gmail.com>	
	<9e4733910606101749r77d72a56mbcf6fb3505eb1de0@mail.gmail.com>	
	<9e4733910606101805t3060c0cdgd08ceabe8cfe4e0e@mail.gmail.com>	
	<448B7594.6040408@gmail.com>
	<9e4733910606101926h73addc1j7cbb4027d3d9f41e@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-list1-b.sourceforge.net ([10.3.1.7]
	helo=sc8-sf-list1.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1FpGGO-0004OF-5p for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 10 Jun 2006 20:05:20 -0700
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FpGGN-00031L-SS for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 10 Jun 2006 20:05:19 -0700
Received: from py-out-1112.google.com ([64.233.166.177])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1FpGGM-0003K5-Jk
	for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 10 Jun 2006 20:05:19 -0700
Received: by py-out-1112.google.com with SMTP id x31so1344696pye
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Sat, 10 Jun 2006 20:05:16 -0700 (PDT)
In-Reply-To: <9e4733910606101926h73addc1j7cbb4027d3d9f41e@mail.gmail.com>
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
>> Jon Smirl wrote:
>> > On 6/10/06, Jon Smirl <jonsmirl@gmail.com> wrote:
>> >> On 6/10/06, Antonino A. Daplas <adaplas@gmail.com> wrote:
>> >> > > I see now that you can have tty0-7 assigned to a different console
>> >> > > driver than tty8-63.
>> >> > > Why do I want to do this?
>> >> >
>> >> > Multi-head.  I can have vgacon on the primary card for tty0-7,
>> >> > fbcon on the secondary card for tty8-16.
>> >>
>> >
>> > When I say dropped, I mean drop the feature of having multiple drivers
>> > simultaneously open by the VT layer. You would still be able to switch
>> > from vgacon to fbcon by using sysfs. You just wouldn't be able to use
>> > VT swap hotkeys between them.
>>
>> Quoting you:
>>
>> "Googling around the only example I could find was someone with a VGA
>> card and a Hercules card. They setup 8 consoles on each card."
>>
>> How do you think they accomplished that? They did not rewrite the VT
>> layer, all they need to do is change the 'first' and 'last' parameter
>> passed to take_over_console() in mdacon.c.  This implies that the VT
>> layer already supports multiple active VT console drivers, maybe as
>> early as 2.2, and no, we won't remove that.
> 
> But the hardware has changed. The kernel is missing a lot of the
> support needed for multiple VGA cards in a single box so that option
> isn't legal. So this needs to be done with non-VGA cards. Are there
> non-VGA cards still in production where a user would want to put
> multiple cards in their box? As far as I know they aren't any in the
> x86 world, I don't know about other architectures.
> 
> All modern Hercules cards are VGA based, they use NVidia and ATI
> chips. The reference was from 1998, they were referring to the ancient
> Hercules cards that were non-VGA.
> 
> Back in the days of CGA, MDA, HGC, 8514, etc this situation was
> common, but now everything is VGA.
> 

It doesn't really matter what the hardware is.  We have a feature that
is supported in the kernel for a long time, we can't just drop it
because we do not have the capability to initialize secondary cards?
That's too x86-centric.

And even today, in an x86 system, we can support multiple vt drivers
in one system:

primary card - vgacon
secondary card - fbcon (the secondary card initialized by X perhaps,
	or even any tool that uses lrmi).

But the argument is moot anyway.  Users won't be able to support
multiple drivers at one time without hacking the kernel. We are not
giving them the interface nor the control to do that, except perhaps
for fbcon, but that option was present for a long time.  

Tony
