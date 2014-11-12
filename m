From: Grant Likely <grant.likely@linaro.org>
Date: Wed, 12 Nov 2014 10:28:57 +0000
Subject: Re: [PATCH v4 0/5] simplefb: add clock handling code
Message-Id: <CACxGe6sYy8vY6RjXiCn4O+sM2xcEPW6L5rjoR2GPMWLtKfzRng@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1413996311-4287-1-git-send-email-hdegoede@redhat.com>
 <544F737A.7000109@ti.com>
 <CAL_JsqJ2JRg7k21CEVe4-At7enD+y3TN_7wfqhY0OHZm-_j17w@mail.gmail.com>
 <544F7E5D.60104@redhat.com> <5450CAA5.5020205@ti.com>
 <CAL_JsqKWqq+H5ymUW3n8tkmLJHEUGaKDLX5+orJmGUQ3ECQwUQ@mail.gmail.com>
 <20141111214950.7FCABC41610@trevor.secretlab.ca>
 <CAMuHMdUoPK_s7OP1Aop4eOyhec+abFij7ZoAAdA5fqpJJy-Dgg@mail.gmail.com>
 <CACxGe6sMF2C6hvRNNnB_i6a44fh0WC7JjjisFOh5GMV66mC6Fw@mail.gmail.com>
 <CAMuHMdVX72ve9TqpA9GUtumZGDnCjYqKemMxyNf=a4AxWR44iQ@mail.gmail.com>
In-Reply-To: <CAMuHMdVX72ve9TqpA9GUtumZGDnCjYqKemMxyNf=a4AxWR44iQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-arm-kernel@lists.infradead.org

On Wed, Nov 12, 2014 at 10:08 AM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> Hi Grant,
>
> On Wed, Nov 12, 2014 at 10:57 AM, Grant Likely <grant.likely@linaro.org> =
wrote:
>> On Wednesday, November 12, 2014, Geert Uytterhoeven
>> <geert@linux-m68k.org> wrote:
>>> On Tue, Nov 11, 2014 at 10:49 PM, Grant Likely <grant.likely@linaro.org=
> wrote:
>>> > However, I am concerned about handover. I've lost track over the enti=
re
>>> > thread on whether the handover mechanism has been resolved, and I wou=
ld
>>> > really like to have a proposed solution to this documented in the
>>> > binding. The fact that there is nothing tying the simple framebuffer =
to
>>> > the actual hardware backing the framebuffer is concerning. It means t=
he
>>> > kernel needs to guess which graphics device is associated with the
>>> > framebuffer.
>>>
>>> We did discuss handover in D=FCsseldorf, and concluded that the simplef=
b's
>>> regs property can be used for this.
>>>
>>> While on a modern system with unified memory this association cannot be
>>> derived in a generic way, a device-specific driver for the graphics har=
dware
>>> can if the regs property of the simplefb node matches the address the C=
RTC
>>> engine is configured for.
>>
>> ???
>>
>> Right, I'm going to be blunt here: That's just dumb. All the
>> capability needed is there in the DT to associate a simple FB to a
>> display controller, and the solution chosen is to use a heuristic?
>>
>> The association needs to be explicit. I strongly prefer putting the
>> simple FB directly into the display controller node, but I would
>> consider phandle linkage also.
>
> IFF there's a display controller node, you can put it there.
> I actually proposed to have a minimal/preliminary display controller node,
> but people countered that for various reasons (too many components
> with multiple nodes on many systems, bindings not yet defined, etc.).
>
> And if there's no graphics driver/bindings yet at the time the bootloader
> is written, it doesn't know how to link simplefb with it in DT.
> Hence the heuristic to match regs... Does that make sense?

No, not really. The simplefb binding /should/ make it clear that
handover to the real display controller driver is an expected use
case; therefore the simplefb binding should itemize exactly how that
linkage is supposed to be expressed. When the display controller
binding is written, it should go hand in glove with the simplefb
binding. We want to be sure that generic code can be used to resolve a
display controller with (one of) the simple framebuffers.

It also sounds like some are making the assumption that firmware
should generate the simplefb node from scratch, hence all the hand
wringing about firmware not knowing what extra stuff to put into the
simplefb node. I don't think this is necessary, or even a good
approach. A disabled simplefb node can be put into the dts file with
any dependencies it needs to care about and linkage to the real
display controller. Firmware should be able to locate that node,
update the parameters as needed, and enable it. That gets out of the
cycle of updating firmware in lockstep.

g.
