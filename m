From: "jonsmirl@gmail.com" <jonsmirl@gmail.com>
Date: Tue, 30 Sep 2014 12:50:40 +0000
Subject: Re: [linux-sunxi] Re: [PATCH 4/4] simplefb: add clock handling code
Message-Id: <CAKON4Oz9ONdtMmoHfUXnm3mgKLKm1Ez7n78UWZZFBX__TR78HA@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20140902092508.GR15297@lukather>
 <20140927235601.19023.31593@quantum> <20140929080637.GB12506@ulmo>
 <20140929092301.GC4388@lukather> <20140929101805.GB26008@ulmo>
 <20140929114643.GB4081@lukather> <20140929134708.GB30998@ulmo>
 <20140929162814.GE4081@lukather> <20140929165842.GC5599@skynet.be>
 <20140929220250.GD5599@skynet.be>
 <20140930124140.GC4273@sirena.org.uk>
In-Reply-To: <20140930124140.GC4273@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Tue, Sep 30, 2014 at 8:41 AM, Mark Brown <broonie@kernel.org> wrote:
> On Tue, Sep 30, 2014 at 12:02:50AM +0200, Luc Verhaegen wrote:
>
>> 2) Simplefb will only have a single user: the rpi. As the only other
>> users i can think of, which does not have a full driver and which does
>> not have clocks automatically disabled, are discrete cards. And they do
>> not really tend to happen with dt or platform devices.
>
> I thought the goal was for other platforms to use simplefb while waiting
> for the real drivers to be loaded (so you can get get console output as
> early as possible from a built in driver for example)?

That is an option that might work. Stop trying to make simplefb work
after the system is fully booted. Instead just let it run until the
clocks get shut off. That allows it to go back to being nothing but a
simple pointer to the video buffer.

Then if you want to keep your display going and don't have a KMS
driver written, whip together a device specific framebuffer driver for
your hardware that does the right thing with the clocks, etc. The
device specific framebuffer driver can load later in the boot process
so that it doesn't have to be built into the kernel. This device
specfic driver matches on a compatible string and knows what to do
with all of the device tree info.

-- 
Jon Smirl
jonsmirl@gmail.com
