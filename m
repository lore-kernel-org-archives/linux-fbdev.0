From: "Magnus Damm" <magnus.damm@gmail.com>
Subject: Re: [PATCH] video: SuperH Mobile LCDC Driver
Date: Fri, 30 May 2008 15:50:18 +0900
Message-ID: <aec7e5c30805292350w4cb2ff13h24b352119af17ea5@mail.gmail.com>
References: <20080529092451.19666.91541.sendpatchset@rx1.opensource.se>
	 <20080530135928.9a555aca.iwamatsu@nigauri.org>
	 <20080530051554.GA21499@roarinelk.homelinux.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <20080530051554.GA21499@roarinelk.homelinux.net>
Content-Disposition: inline
Sender: linux-sh-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"
To: Manuel Lauss <mano@roarinelk.homelinux.net>
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, linux-fbdev-devel@lists.sourceforge.net, lethal@linux-sh.org, akpm@linux-foundation.org, linux-sh@vger.kernel.org

Hi Manuel,

Thanks for your email.

On Fri, May 30, 2008 at 2:15 PM, Manuel Lauss
<mano@roarinelk.homelinux.net> wrote:
> On Fri, May 30, 2008 at 01:59:28PM +0900, Nobuhiro Iwamatsu wrote:
>> On Thu, 29 May 2008 18:24:51 +0900
>> Magnus Damm <magnus.damm@gmail.com> wrote:
>>
>> > This patch adds frame buffer support for the LCDC block found in
>> > SuperH Mobile processors. The hardware supports up to two LCD panels
>> > per LCDC block, and both RGB and SYS interfaces can be used to hook
>> > up LCD panels/modules.
>> >
>> > The device driver is a regular platform driver, so LCD configuration
>> > and board specific hooks are passed to the driver using platform data.
>> > LCD modules using SYS interface often require special configuration
>> > using the SYS bus, and to solve this cleanly the driver provides SYS
>> > interface operations to the board code.
>> >
>> > Tested on sh7723 and sh7722 processors with a SYS16A QVGA panel and
>> > WVGA panels using RGB16 and RGB18 interfaces.
>> >
>> > Signed-off-by: Magnus Damm <damm@igel.co.jp>
>> > ---

>> I am coding sh7763's frame buffer driver.
>
>  I wrote a driver for the SH7760 LCDC 2 years ago. From a quick glance at
> the respective datasheets it seems both 7760 and 7763 have identical
> register layout.  Looking at Magnus' driver, the 7722/7723 LCDC seems to
> be an extended version of the 7760/63 LCDC. Maybe we can unify them somehow?

As for the SuperH Mobile LCDC block, the sh7723 is register compatible
with sh7722, but it only supports a single channel. I suspect that
sh7343 is register compatible with sh7722 as well, but I have no docs.
Both SYS and RGB interfaces are supported. Up to 24bpp. Both RGB and
YUV pixel formats are supported by the hardware. Clock configuration
and SYS bus stuff is shared between the channels.

The sh7760 LCDC supports a single channel using RGB interface up to
16bpp. No YUV. Just a handful of registers seem to have the same
layout as the SuperH Mobile LCDC block.

My gut feeling is that the complexity of a driver for one type of LCDC
block is enough. Think about the number of combinations of board type,
processor type, LCD panel, bus type, bus configuration and potentially
external LCD controller chip. And now we're talking about an extra
dimension on top of that... =)

If we can unify drivers and keep the complexity relatively low then
that's great, but before that can happen we sort of need something to
unify. So please write simple framebuffer drivers for now, and work on
getting them merged upstream. And when that's done _then_ we can unify
drivers and/or break out common code. In my mind, that's the right
order to do things.

/ magnus
