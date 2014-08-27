From: Hans de Goede <hdegoede@redhat.com>
Date: Wed, 27 Aug 2014 10:35:24 +0000
Subject: Re: [linux-sunxi] Re: [PATCH 4/4] simplefb: add clock handling code
Message-Id: <53FDB46C.5010609@redhat.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20140825133953.GJ4163@ulmo.nvidia.com>
 <53FB3E7F.4000503@redhat.com> <20140825141600.GA14763@ulmo.nvidia.com>
 <20140825145854.GA15297@lukather> <20140825150501.GE14763@ulmo.nvidia.com>
 <20140825152232.GE15297@lukather> <20140826080432.GD17263@ulmo>
 <20140826135341.GM15297@lukather> <20140826143550.GB3027@ulmo>
 <53FCE704.4030103@redhat.com> <20140827093121.GA23186@ulmo>
In-Reply-To: <20140827093121.GA23186@ulmo>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi,

On 08/27/2014 11:31 AM, Thierry Reding wrote:
> Can you please fix you mail setup. You're addressing me directly in this
> email, yet I'm neither in To: nor Cc: headers. That's really annoying.

Sorry, I'll pay closer attention that you're in the To when I'm directly
addressing you next time.

> On Tue, Aug 26, 2014 at 09:59:00PM +0200, Hans de Goede wrote:

<snip>

>>> Either way, Mark already suggested a different alternative in another
>>> subthread, namely to add a new kind of checkpoint at which subsystems
>>> can call a "disable unused" function that's called later than a late
>>> initcall. This is not going to fix things for you immediately because
>>> the clocks will still be switched off (only later) if you don't have
>>> a real driver that's claiming the clocks. But you can work around that
>>> for now by making the relevant clocks always on and remove that
>>> workaround once a real driver is loaded that knows how to handle them
>>> properly.
>>
>> This will simply not work, and is a ton more complicated then
>> simply teaching simplefb about a clocks property, which is a really simple
>> and clean patch.
>>
>> First of all let me explain why this won't work. When should those
>> subsystems call this "later then a late initcall" call ? the kms driver
>> may very well be a kernel module, which will be loaded by userspace,
>> so we would need this to be triggered by userspace, but when ?
>>
>> When the initrd is done? What then if the kms driver is not in the initrd,
>> so maybe when udev is done enumerating devices, but what then if the kernel
>> is still enumerating hardware at this time?
> 
> Usually an initrd knows how to wait for all or a given set of devices to
> be probed. udev is pretty good for that.

udev does not have a clue how to wait for all devices, it can be used to
wait for a specific device to show up, that is true, but this requires
adding specific logic for this (class of) device to the initrd init process,
which is really sub-optimal.

>> Will we just put a sleep 30
>> in our initscripts to make sure the kernel is done scanning all busses,
>> will that be long enough? Maybe we need to re-introduce the scsi_wait_done
>> kernel module which was added as an ugly hack to allow userspace to wait
>> for the kernel to have finished scanning scsi (and ata / sata) busses,
>> for controllers found at the time the module was load. Which never worked
>> reliable, because it would be possible that the controller itself still
>> needed to be discovered. We've spend years cleaning up userspace enough
>> to be able to kill scsi_wait_done. We've already been down this road of
>> waiting for hw enumeration to be done, and the problem is that on
>> modern systems *it is never done*.
> 
> Those are mostly integration issues. If you don't load the driver from
> initrd then I don't think anybody will complain when there's flicker
> when it finally gets loaded. The whole point of this is to have early
> access to the framebuffer and get display and graphics going as soon as
> possible, so please don't pull in hypothetical scenarios where people
> manually load drivers half an hour after the system has booted.

In another mail in this thread you've mentioned 2 uses for simplefb:

1) Serving as *the* fb until a kms driver is present
2) Allowing for output of early kernel boot messages.

I agree that those are the 2 use-cases we're dealing with here.

Note that the whole discussion we're having hear about disabling the clocks
once hardware probing is "done", is moot for 1. One possible way mentioned
of dealing with 1. is to mark these clocks as always on for now, and then we
need to drop this hack (I cannot call this anything else then a hack), once
we get kms, meaning interdependencies between the dropping patch and the kms
adding patches, etc. All not very pretty.

For 2. We have what you call "mostly integration issues". Allow me to copy
and paste in another bit of this thread here:

>> I've been doing low level Linux development for 10 years now and I've
>> worked a lot on storage (raid, iscsi, fcoe support, etc.) in the past.
>
> Ah, so this is now officially a pissing contest, is it?

No I'm merely trying to explain that I've a ton of experience with what
you seem to think of as merely integration issues, and they are a royal PITA,
and thus to be avoided at all costs. Really, please just trust me on this
one, doing the whole add some later then late init call type is a bad idea.

>> So second of all, Thierry, what exactly is the technical argument against
>> adding support for dealing with clocks to simplefb ?
> 
> I've already stated technical arguments against it. You could just go
> back and read the thread again, or would you rather want me to repeat
> them for your convenience?

It is a long thread, IIRC your main arguments against this are:

1) You don't want this kind of platform-specific knowledge in simplefb
2) That simplefb is supposed to be simple, and this is not simple

As for 1. several people have already argued that clocks as such are
an abstract concept, found one many platforms and as such are not
platform specific.

Any generic hw driver dealing with embedded platforms, be it ahci, ohci,
ehci, etc. has ended up adding abstract support for things like clocks
(and other resources). I say abstract support here, since to all these
drivers the support was added in a way that no platform specific knowledge
is necessary, they just deal with clocks not caring about the specific
underlying clock implementation, clock names, etc.

This really is unavoidable. The framebuffer memory needed was mentioned
as another example of a resource in this thread. You suggested using the
new mem-reserve framework for this. I agree that that is the right thing
to do, but even then we still need a way to tie this reserved mem to
the simplefb, so that the kernel can know when it is no longer used
and can be added to the general memory pool.

If you look at how almost all dt bindings work, then the dt node for
a device specifies the resources needed, I don't see why simplefb would
be so special that it should be different here. I agree that it is
important to get the abstractions right here, but to me it seems that
the right abstraction is to be consistent with how all other devices
are abstracted and to add needed resources to the dt node for the
simplefb.

As for 2. Yes this will add some more code to simplefb, more code but
code which is not complicated in anyway, so the simplefb code would
become larger but still stay simple. Were as all the suggested
alternatives sofar are at least an order of magnitude more complicated,
crossing many subsystems, demanding coordination with userspace, etc.


>> I've heard a lot of people in favor of it,
> 
> Of course you have, all the people in favour of it are sunxi people that
> really want to see this merged because it gives them working display
> after U-Boot.

I don't think that that is entirely fair towards Maxime, yes Maxime is
a sunxi person, but he usually pushed back hard against anything he
considers not clean enough, even if it would enable highly desirable
functionality.

> 
>> and only pretty much you against it,
> 
> At least Stephen also spoke out about it. But this quickly devolved into
> the kind of thread you want to get out of as quickly as possible, so I
> can't blame him for not continuing this discussion. In fact I'm very
> much regretting getting into this in the first place. You clearly have
> no intention to even consider any possible other solution that what was
> posted, so it's pretty useless to try and convince you.
> 
>> and your argument so far seems to boil down to "I don't like it",
> 
> I'm not surprised that you think so since you seem to be very selective
> in what you read (or register) and what you don't.

See above, I've summarized the 2 arguments which you've made as
"I don't like it" before since to me they seem to be subjective arguments,
you say it is too platform specific, but where is the divide line for
something being _too_ platform specific ?  I realize in the end everything
is pretty much subjective. I apologize for the "I don't like it"
characterization that was not fair of me.

> 
>> is not really a technical sound argument IMHO. Moreover all the
>> alternatives seem to be horribly complicated and most of them also
>> seem to have several issues which will make them simply not work
>> reliable.
> 
> I'm not an unreasonable person, or at least I like to think so, and if
> there really isn't a better solution then I won't object to this patch
> any longer.

That is good to hear.

> But as it stands I am not convinced that this is the best solution

I'm very much open to a better solution, but so far everything suggested
is so much more complicated, that I don;t consider any of the suggestions
done so far better.

> so I think we should keep the discussion going for a bit and
> see if we really can't come up with something that will fix this for a
> more general case rather than just your particular use-case. It's
> evidently a recurring problem that others suffer from, too.

Yes needing resources despite the device being behind some generic
interface where the main driver code for that interface has no knowledge
about such resources sofar, because e.g. on PC-s this was not necessary
is a recurring problem, which has been solved already 3 times at least,
see the ohci-, ehci- and ahci-platform drivers, and for all 3 the conclusion
was that the best solution was to simple add the resources to the dt-node,
and add code to claim and enable them.

Regards,

Hans



> 
> Thierry
> 
