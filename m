From: Olof Johansson <olof@lixom.net>
Date: Mon, 29 Apr 2013 22:40:44 +0000
Subject: Re: [PATCH V2] video: implement a simple framebuffer driver
Message-Id: <CAOesGMiCvBwck0Z6Nyo9zW=1=J=wjhJW68qNGMrN_8iim=8Srg@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1365043183-28905-1-git-send-email-swarren@wwwdotorg.org>
 <6607610.omg016OAvj@avalon> <201304300004.20320.arnd@arndb.de>
 <2040099.REU8D4ds1g@avalon>
In-Reply-To: <2040099.REU8D4ds1g@avalon>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Mon, Apr 29, 2013 at 3:23 PM, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
> Hi Arnd,
>
> On Tuesday 30 April 2013 00:04:20 Arnd Bergmann wrote:
>> On Monday 29 April 2013, Laurent Pinchart wrote:
>> > On Monday 29 April 2013 23:31:30 Tomasz Figa wrote:
>> > > Good point. Stephen, would it be a problem to make this a KMS driver
>> > > instead? Old fbdev API could be emulated on top of it, until it goes out
>> > > of use, couldn't it?
>> >
>> > There's already an fbdev emulation layer in KMS, for such a simple use
>> > case it will work fine.
>>
>> I suggested the same to Stephen when he first brought up this driver.
>> Unfortunately his attempt to create a simple KMS driver resulted in a
>> significantly larger driver than the one he did for the framebuffer
>> interface. This means that either Stephen did something really wrong in his
>> attempt, or the KMS interface isn't as good as it should be if we want to
>> move people away from frame buffer drivers.
>
> Implementing a KMS driver requires a fair amount of code. The DRM/KMS
> subsystem provides helpers that significantly reduce the driver size. Those
> helpers have been designed around common use cases found in existing KMS
> drivers.
>
> I'm pretty sure we will be able to add useful helpers for existing fbdev
> drivers that will make porting them to KMS pretty easy, but that first
> requires starting to port drivers to find out what common code could be
> factored out.

Meanwhile this tiny driver will allow us to use hardware that can't
otherwise be used (because the proper graphics drivers for said
hardware is _also_ stuck behind large reworks, i.e. common display
framework, which has uncertain progress at this time).

As Stephen mentioned in the original patch, this particular driver is
very useful for Raspberry Pi. But it is also the best way forward
(right now) for getting basic upstream usability out of the Samsung
ARM-based Chromebook. As a matter of fact, as of this weekend
linux-next boots on that platform with keyboard, trackpad, framebuffer
and USB2.0 without a single out-of-tree patch. Getting the same
functionality out of 3.10 would be very desirable.

So, I clearly understand the desire to move over to a more modern
framework. At the same time, there's definite value in merging this
small driver while that's happening. Holding useful code hostage isn't
always very productive.


-Olof
