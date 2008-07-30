From: "Jaya Kumar" <jayakumar.lkml@gmail.com>
Subject: Re: [RFC 2.6.26-rc9 1/5] pxafb: add shared
	framebuffer interface
Date: Tue, 29 Jul 2008 23:10:10 -0400
Message-ID: <45a44e480807292010wf673d2ucecd575d79343caf@mail.gmail.com>
References: <1216534233-26674-1-git-send-email-jayakumar.lkml@gmail.com>
	<1216534233-26674-2-git-send-email-jayakumar.lkml@gmail.com>
	<20080721111159.GA18909@flint.arm.linux.org.uk>
	<45a44e480807210532w20495622ub36bd8a9722c2023@mail.gmail.com>
	<45a44e480807252030w9f542j4926005249dbf01@mail.gmail.com>
	<f17812d70807291941u3617b2e8q3ba0422c1db15b2d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KO24r-0005R9-V3 for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 29 Jul 2008 20:10:14 -0700
Received: from ik-out-1112.google.com ([66.249.90.181])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1KO24q-0005Hd-0P
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 29 Jul 2008 20:10:13 -0700
Received: by ik-out-1112.google.com with SMTP id c21so168874ika.2
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Tue, 29 Jul 2008 20:10:10 -0700 (PDT)
In-Reply-To: <f17812d70807291941u3617b2e8q3ba0422c1db15b2d@mail.gmail.com>
Content-Disposition: inline
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Eric Miao <eric.y.miao@gmail.com>
Cc: linux-fbdev-devel@lists.sourceforge.net, ymiao3@marvell.com, Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-arm-kernel@lists.arm.linux.org.uk

On Tue, Jul 29, 2008 at 10:41 PM, Eric Miao <eric.y.miao@gmail.com> wrote:
> On Sat, Jul 26, 2008 at 11:30 AM, Jaya Kumar <jayakumar.lkml@gmail.com> wrote:
>>
>> I took a look at doing the above, ie: adjusting bpp instead of
>> custom_xfer_size. I've realized that I would still need to adjust lccr
>> in at least one other place:
>>
>>        fbi->reg_lccr1 =
>>                LCCR1_DisWdth(var->xres) +
>>
>> I'll try to improve my explanation. :-)
>>
>> The reason for this is that metronome requires a different bus width
>> (16 bit) for AMLCD transfers than it requires for its expected bits
>> per pixel ( 8 bits). To get LCDC to use 16 bits on the AMLCD bus, we
>> need to set 16bpp in LCCR3. So we then need to divide down the x
>> resolution in LCCR1. Eg: 800 pixels at 8bpp is the framebuffer. We
>> need 16-bit transfers so we set the desired pixels per line in LCCR to
>> = 800 pixels / ( 16 custom bus bits / 8 bits per pixel ) = 400 pixels
>> per line. So the code would be like:
>>
>> pix_per_line = var->xres / ( inf->custom_lccr_bpp / var->bits_per_pixel )
>>
>> I hope I was able to explain my reasoning for this above.
>>
>
> Sorry for the delay, I begin to understand the way this metronome is
> working, so each transfer is 16-bit wide and contains two 8-bit pixels?

Correct, the AMLCD xfer is 16-bit wide and is treated by Metronome as
2 8-bit pixels.

>
> Then the most simple way is to treat this display as 16-bit, and
> adjust the resolution parameters in the platform data with a nice
> comment.

I originally had it as .bpp = 16 ( in v6 and before) and used
custom_xfer_data to divide down the buffer sizes. The resolution needs
to stay at 800x600 so that the reported resolution for the display is
correct. So've I changed that to .bpp = 8 and used custom_lccr_bpp to
set LCCR3 to 16bpp in v7. Let me know if the implementation in v7 is
consistent with your suggestion.

>
> The problem of doing so is that:
> 1) framebuffer console cann't work anymore, and will show garbage
> instead of showing the nice penguine logo
>
> 2) the framebuffer application has to be aware of this, and handles
> the pixel format correctly.
>
> Provided the fact of this weird organized pixel format, I don't see many
> chances that X window or console can be run on top of this, but a
> specialized application, no?

Deferred IO converts the pixel data organization for the Metronome
controller so the latter is transparent to anything above fbdev. I
have tested with Xfbdev and it works quite well. So no specialized
applications needed. :-) Some video clips of it running here:
http://youtube.com/watch?v=Or3R3Q8oyuE and also a LinuxJournal article
showing the display with dillo and other standard applications.
http://www.linuxjournal.com/article/10110

Thanks,
jaya

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
