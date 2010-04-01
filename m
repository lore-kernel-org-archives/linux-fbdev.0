From: Jon Povey <Jon.Povey@racelogic.co.uk>
Date: Thu, 01 Apr 2010 06:47:40 +0000
Subject: RE: [PATCH v2] DA8XX/OMAP-L1XX: FB: Implement double buffering
Message-Id: <70E876B0EA86DD4BAF101844BC814DFE0FDD0EFE@Cloud.RL.local>
List-Id: <linux-fbdev.vger.kernel.org>
References: <A24693684029E5489D1D202277BE89445316FAB1@dlee02.ent.ti.com>
In-Reply-To: <A24693684029E5489D1D202277BE89445316FAB1@dlee02.ent.ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Andrew Morton wrote:
> On Wed, 31 Mar 2010 20:43:29 -0500 "Ambrose, Martin" <martin@ti.com>
> wrote:

>>> If the calling process has signal_pending() (say, someone hit ^C)
>>> then wait_event_interruptible_timeout() will fall straight through
>>> with -ERESTARTSYS.  Will this cause the driver to malfunction at
>>> all?
>>
>> I don't think so since the driver doesn't make use of this
>> information in any way. This is just status to the caller that the
>> current frame has finished DMA'ing out of the framebuffer.
>>
>> Could you maybe propose a scenario/use case where you think it is
>> problematic? I could then either reason why it should be OK or
>> I'll create a test harness and see how the driver can/should be
>> modified.
>
> Gee, I dunno - I don't understand the driver to that level.  If you're
> OK with this wait being interrupted by a signal and the driver handles
> it OK then fine, that's a feature.
>
> To test it I suppose you should give your test app a signal handler
> and blast kills at it from another process.

Jumping in..

This should not cause a problem for the driver; its purpose is to tell userland that it can write to the buffer without corrupting graphics (as presumably it is double-buffering and the other buffer is now being DMA'd from by the hardware).

At worst, if the userland software doesn't handle this correctly it may draw one bad frame of graphics. Although if it's had a ctrl-C it probably has bigger things to worry about.

If the app wants to handle signals it needs to consider such things.. I would not expect the driver to do anything other than what this patch does.

--
Jon Povey
jon.povey@racelogic.co.uk

Racelogic is a limited company registered in England. Registered number 2743719 .
Registered Office Unit 10, Swan Business Centre, Osier Way, Buckingham, Bucks, MK18 1TB .

The information contained in this electronic mail transmission is intended by Racelogic Ltd for the use of the named individual or entity to which it is directed and may contain information that is confidential or privileged. If you have received this electronic mail transmission in error, please delete it from your system without copying or forwarding it, and notify the sender of the error by reply email so that the sender's address records can be corrected. The views expressed by the sender of this communication do not necessarily represent those of Racelogic Ltd. Please note that Racelogic reserves the right to monitor e-mail communications passing through its network


