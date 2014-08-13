From: Luc Verhaegen <libv@skynet.be>
Date: Wed, 13 Aug 2014 08:11:00 +0000
Subject: Re: simplefb: add clock handling
Message-Id: <20140813081100.GB31326@skynet.be>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1407914239-12054-1-git-send-email-libv@skynet.be>
 <CANq1E4Re79+D5H-pf8pW87NZ5MWz9UFknd5Dk2GKCvhzm5MNSA@mail.gmail.com>
In-Reply-To: <CANq1E4Re79+D5H-pf8pW87NZ5MWz9UFknd5Dk2GKCvhzm5MNSA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Wed, Aug 13, 2014 at 09:54:21AM +0200, David Herrmann wrote:
> Hi
> 
> Hans de Goede shortly told me about this and, tbh, I am not very
> pleased. Stephen tried to keep simplefd "as simple as possible", your
> patch now adds hardware-specific features. To be fair, the patch is
> simple and clocks are easy to handle, but I somehow fear we have to
> add more and more hardware-support that is required to keep the
> framebuffer active. This really defeats the purpose of simplefb.

SimpleFB is a really deceptive name. If you lie to your ARM core all the 
time, and do most things behind its back, like RPi does, then you can 
get away with simplefb.

If not, it quickly becomes a lot more complicated, fast. This should've 
been called rpibootfb or something.

How does one deal with this dealbreaker issue of clocks? Or memory, 
apart from telling the kernel that the fb area is simple not accessible 
as normal ram. Or dpms?

> The biggest question I have, is why do you add the clocks to your DT
> at all?

I didn't, someone else did.

> The framebuffer is set up by your boot-loader (or maybe
> platform code) and should prepare the clocks. I don't see why we add
> the clocks to DT now. If they're not added, then no-one will disable
> them and simplefb works just fine, right?
> 
> Or is there some requirement to make DT a _complete_ hw-description?

Again, i am not responsible for that part. But my impression is that it 
should be absolutely complete, and i have been whining about actual bit 
offsets into registers being provided from the dt :(

> Or is there some parent clock which might be used by other drivers and
> controls the clock used for your display?

Not at this point for sunxi, but there will be.

> The only reason I see to add the clocks, is to support both, simplefb
> *and* a hardware-driver. However, fbdev hand-over is horribly racy and
> I'd much rather prefer a solution like sysfb that does proper handover
> from primitive firmware-FBs to real hardware-drivers. In that case,
> we'd have to figure out how to deal with clocks, but we could do it in
> sysfb (which is meant to deal with those issues) with the benefit of
> controlling hand-over directly, and allowing hw-dependent features.

Yes, a KMS driver is being worked on. I was, as a first order 
approximation (when i move it to mainline code), going to manually do 
some of this handover from simplefb.

> My sysfb patches haven't been updated for a while, though, and you
> have a working solution here. So I'm not going to NAK this, I
> appreciate people working on this. But I'd like to get a discussion
> started so we can at least figure out some nicer solution for the
> future which might replace your code.

So much for this being simple. again :)

> Btw., my current idea was to destroy the platform-devices of EFI/VGA
> framebuffers during hand-over (because usually the underlying hw is
> shutdown/modified). This automatically unloads simplefb and makes sure
> the real hw-driver can be probed without other drivers touching the
> hardware in parallel. Iff you unload the hw-driver afterwards, it can
> re-create the firmware framebuffer and add a platform-device to make
> simplefb load again (in case anyone really needs this).
> Looking at your 3rd patch, I wonder whether this works with DT based
> machines, or whether we'd have to use the "disable" mechanism you
> chose. Any reason destroying the device would not work there? If yes,
> I will look into the "disable-idea".

The clocks we currently claim handle the ahb gating of different display 
engines. Disable the gating bit, and all power is lost to the respective 
engine, and register content vanishes. So there is absolutely no coming 
back from that, apart from starting a proper display driver.

Luc Verhaegen.
