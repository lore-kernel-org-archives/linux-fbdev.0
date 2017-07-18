From: Dave Airlie <airlied@gmail.com>
Date: Tue, 18 Jul 2017 23:16:46 +0000
Subject: Re: [PATCH] efifb: allow user to disable write combined mapping.
Message-Id: <CAPM=9twsWFjFcgjP6S4wt7-t9-wYP_gBH1zt6kL-CF4Tr7t2dg@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20170718060909.5280-1-airlied@redhat.com> <20170718143404.omgxrujngj2rhiya@redhat.com>
 <CA+55aFwKzwDPYFsPpuQNfBaS-dL2aD0=z1hGEnkaTT1MMfWB6Q@mail.gmail.com>
 <CAPM=9tyWv79U9=-YNacf34don_Gn5RGggBsZG7R9FNuV8_qe1g@mail.gmail.com>
 <CAPM=9twtiyJb2M3tBBb6Xy3ausVxhn3Be+NTr+BAV9FTMGPkug@mail.gmail.com>
 <CA+55aFyU3QrFeq4Lr9tgxR+6D9-eXZFZTzfqHdozHS72qE5q1w@mail.gmail.com> <CAPM=9twzgAJir3b+3UAxOfuTtOBTp2bUtoCcTawmHcEbcVAEew@mail.gmail.com>
In-Reply-To: <CAPM=9twzgAJir3b+3UAxOfuTtOBTp2bUtoCcTawmHcEbcVAEew@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Jones <pjones@redhat.com>, the arch/x86 maintainers <x86@kernel.org>, Dave Airlie <airlied@redhat.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Andrew Lutomirski <luto@kernel.org>, Peter Anvin <hpa@zytor.com>

On 19 July 2017 at 09:16, Dave Airlie <airlied@gmail.com> wrote:
> On 19 July 2017 at 08:22, Linus Torvalds <torvalds@linux-foundation.org> =
wrote:
>> On Tue, Jul 18, 2017 at 2:21 PM, Dave Airlie <airlied@gmail.com> wrote:
>>>
>>> Oh and just FYI, the machine I've tested this on has an mgag200 server
>>> graphics card backing the framebuffer, but with just efifb loaded.
>>
>> Yeah, it looks like it needs special hardware - and particularly the
>> kind of garbage hardware that people only have on servers.
>>
>> Why do server people continually do absolute sh*t hardware? It's crap,
>> crap, crap across the board outside the CPU. Nasty and bad hacky stuff
>> that nobody else would touch with a ten-foot pole, and the "serious
>> enterprise" people lap it up like it was ambrosia.
>>
>> It's not just "graphics is bad anyway since we don't care". It's all
>> the things they ostensibly _do_ care about too, like the disk and the
>> fabric infrastructure. Buggy nasty crud.
>
> I've tried to reproduce now on:
> Intel(R) Core(TM) i7-6820HQ CPU @ 2.70GHz
> using some address space from
> 02:00.0 3D controller: NVIDIA Corporation GM108M [GeForce 940MX] (rev a2)
>
> And I don't see the issue.
>
> I'll try and track down some more efi compatible mga or other wierd serve=
r chips
> stuff if I can.
>
>> Anyway, rant over. I wonder if we could show this without special
>> hardware by just mapping some region that doesn't even have hardware
>> in it as WC. Do we even expose the PAT settings to user space, though,
>> or do we always have to have some fake module to create the PAT stuff?
>
> I do wonder wtf the hw could be doing that would cause this, but I've no =
idea
> how to tell what difference a write combined PCI transaction would have o=
n the
> bus side of things, and what the device could generate that would cause s=
uch
> a horrible slowdown.
>
> Dave.

01:00.1 VGA compatible controller: Matrox Electronics Systems Ltd. MGA
G200EH (rev 01) (prog-if 00 [VGA controller])
        Subsystem: Hewlett-Packard Company iLO4
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr+ Stepping- SERR+ FastB2B- DisINTx-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=FAst >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0, Cache Line Size: 64 bytes
        Interrupt: pin B routed to IRQ 255
        Region 0: Memory at 91000000 (32-bit, prefetchable) [size=16M]
        Region 1: Memory at 92a88000 (32-bit, non-prefetchable) [size=16K]
        Region 2: Memory at 92000000 (32-bit, non-prefetchable) [size=3D8M]
        [virtual] Expansion ROM at 000c0000 [disabled] [size=128K]
        Capabilities: [a8] Power Management version 3
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=3D0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 PME-
        Capabilities: [b0] MSI: Enable- Count=3D1/1 Maskable- 64bit+
                Address: 0000000000000000  Data: 0000
        Capabilities: [c0] Express (v2) Legacy Endpoint, MSI 00
                DevCap: MaxPayload 128 bytes, PhantFunc 0, Latency L0s
unlimited, L1 unlimited
                        ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
                DevCtl: Report errors: Correctable- Non-Fatal+ Fatal+
Unsupported-
                        RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
                        MaxPayload 128 bytes, MaxReadReq 128 bytes
                DevSta: CorrErr+ UncorrErr- FatalErr- UnsuppReq+
AuxPwr- TransPend-
                LnkCap: Port #0, Speed 2.5GT/s, Width x1, ASPM L0s,
Latency L0 <4us, L1 <4us
                        ClockPM- Surprise- LLActRep- BwNot-
                LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- Retrain- Comm=
Clk-
                        ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
                LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train-
SlotClk- DLActive- BWMgmt- ABWMgmt-
                DevCap2: Completion Timeout: Not Supported,
TimeoutDis+, LTR-, OBFF Not Supported
                DevCtl2: Completion Timeout: 50us to 50ms,
TimeoutDis-, LTR-, OBFF Disabled
                LnkSta2: Current De-emphasis Level: -6dB,
EqualizationComplete-, EqualizationPhase1-
                         EqualizationPhase2-, EqualizationPhase3-,
LinkEqualizationRequest-
        Capabilities: [100 v2] Advanced Error Reporting
                UESta:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt-
UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
                UEMsk:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt-
UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
                UESvrt: DLP+ SDES- TLP- FCP+ CmpltTO- CmpltAbrt-
UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
                CESta:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatal=
Err+
                CEMsk:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatal=
Err+
                AERCap: First Error Pointer: 00, GenCap- CGenEn- ChkCap- Ch=
kEn-

Is a full lspci -vvv for the VGA device in question.

Dave.
