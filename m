From: "Jaya Kumar" <jayakumar.lkml@gmail.com>
Subject: Re: [RFC 2.6.27 1/1] gpiolib: add support for batch set of pins
Date: Thu, 1 Jan 2009 02:05:50 +0800
Message-ID: <45a44e480812311005k709c410ao1116187e9427e452@mail.gmail.com>
References: <12276535632759-git-send-email-jayakumar.lkml@gmail.com>
	 <200812302355.45193.rgetz@blackfin.uclinux.org>
	 <45a44e480812302058k365eddcfxf902095657b78534@mail.gmail.com>
	 <200812311238.13810.rgetz@blackfin.uclinux.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-embedded-owner@vger.kernel.org>
In-Reply-To: <200812311238.13810.rgetz@blackfin.uclinux.org>
Content-Disposition: inline
Sender: linux-embedded-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"
To: Robin Getz <rgetz@blackfin.uclinux.org>
Cc: David Brownell <david-b@pacbell.net>, Eric Miao <eric.y.miao@gmail.com>, Sam Ravnborg <sam@ravnborg.org>, Eric Miao <eric.miao@marvell.com>, Haavard Skinnemoen <hskinnemoen@atmel.com>, Philipp Zabel <philipp.zabel@gmail.com>, Russell King <rmk@arm.linux.org.uk>, Ben Gardner <bgardner@wabtec.com>, Greg KH <greg@kroah.com>, linux-arm-kernel@lists.arm.linux.org.uk, linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, linux-embedded@vger.kernel.org

On Thu, Jan 1, 2009 at 1:38 AM, Robin Getz <rgetz@blackfin.uclinux.org> wrote:
> On Tue 30 Dec 2008 23:58, Jaya Kumar pondered:
>> On Tue, Dec 30, 2008 at 11:55 PM, Robin Getz <rgetz@blackfin.uclinux.org> wrote:
>> > Yeah, I hadn't thought about spanning more than one gpio_chip. That's a good
>> > point.
>>
>> The currently posted code already supports spanning more than one gpio_chip.
>>
>
> But doesn't do all the other things that David suggested/requested.
>

Hi Robin,

Yes, you are right. My implementation does not support a driver that
needs to set/get more than 32-bits of gpio in a single call. I'm okay
with that restriction as I don't see a concrete use case for that. I
understand that you're saying that's not satisfactory. I guess we'll
have to agree to differ.

Thanks,
jaya
