From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: [PATCH 3/9] VT binding: Make VT binding a
	Kconfig option
Date: Tue, 20 Jun 2006 16:32:53 +0800
Message-ID: <4497B2B5.4040001@gmail.com>
References: <44957026.2020405@gmail.com>	
	<9e4733910606191718n74d0bf40na7b0cc3902d80172@mail.gmail.com>	
	<44974AC7.4060708@gmail.com>
	<9e4733910606191916i1994d4d1i2ea661e015431750@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1FsbfV-0002LS-5Y for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 20 Jun 2006 01:33:05 -0700
Received: from nz-out-0102.google.com ([64.233.162.203])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1FsbfU-0007pF-La
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 20 Jun 2006 01:33:05 -0700
Received: by nz-out-0102.google.com with SMTP id o37so1257416nzf
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Tue, 20 Jun 2006 01:33:04 -0700 (PDT)
In-Reply-To: <9e4733910606191916i1994d4d1i2ea661e015431750@mail.gmail.com>
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
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Linux Kernel Development <linux-kernel@vger.kernel.org>

Jon Smirl wrote:
> On 6/19/06, Antonino A. Daplas <adaplas@gmail.com> wrote:
>> Jon Smirl wrote:
>> > I gave this patch a try and it seems to work. I say seems because I
>> > could not get the nvidiafb driver to set a usable mode after it was
>> > bound/unbound.
>>
>> What do you mean by this?  You mean that you cannot restore vgacon?
>> If that's the case, then yes, that is perfectly understandable as
>> nvidiafb does not restore VGA to text mode.
> 
> modprobe fbcon
> modprobe nvidiafb
> 
> Display is messed up.
> 
> I used to fix this by switching to X and back but the nvidia X driver
> won't build on the mm kernel. I can try again and write a script to
> echo a mode into sysfs after the modprobe.
> 
> When fbcon first gets a new fbdev driver registered with it, should it
> pick one of the modes is supports and set it automatically?

All fbdev drivers have a startup mode that should always be valid. All
fbcon does is enable that mode.

You can load nvidiafb like this instead:

modprobe nvidiafb mode_option=1024x768@60

> 
>>  or would it be better for each driver to set in a
>> > default mode that it understands when it gets control? The fbdev
>> > driver should not set a mode when it loads, but that doesn't mean
>> > fbcon can't set one when it is activated. Similarly VGAcon would set
>> > the mode (and load its fonts) when it regains control.
>>
>> The problem with vgacon setting its own mode is that it does not know
>> anything about the hardware. So VGA text mode will need to rely on
>> a secondary program to set the mode (whether it's vbetool, another
>> fb driver, or X does not matter).
> 
> How does vbetool save state?

vbetool basically calls an int10 function that saves the state.  This
function is unique per video BIOS, ie you cannot use the state file in
another machine even if the graphics chipset is the same.

> Could VGAcon do whatever vbetool is doing?
 
No it can't.  Once the card is in graphics mode, vgacon cannot go to
text mode on its own.  It has to know how to write to other VGA
registers which are unique per hardware.

Tony
