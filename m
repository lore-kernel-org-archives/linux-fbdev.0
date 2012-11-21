From: Alex Courbot <acourbot@nvidia.com>
Date: Wed, 21 Nov 2012 01:56:36 +0000
Subject: Re: [PATCHv9 1/3] Runtime Interpreted Power Sequences
Message-Id: <4316169.5QXVzv7peZ@percival>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1353149747-31871-1-git-send-email-acourbot@nvidia.com>
 <1353149747-31871-2-git-send-email-acourbot@nvidia.com>
 <50AB9832.90709@ti.com>
In-Reply-To: <50AB9832.90709@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi Tomi,

On Tuesday 20 November 2012 22:48:18 Tomi Valkeinen wrote:
> I guess there's a reason, but the above looks a bit inconsistent. For
> gpio you define the gpio resource inside the step. For power and pwm the
> resource is defined before the steps. Why wouldn't "pwm = <&pwm 2
> 5000000>;" work in step2?

That's mostly a framework issue. Most frameworks do not export a function that 
allow to dereference a phandle - they expect resources to be declared right 
under the device node and accessed by name through foo_get(device, name). So 
using phandles in power sequences would require to export these additional 
functions and also opens the door to some inconsistencies - for instance, your 
PWM phandle could be referenced a second time in the sequence with a different 
period - how do you know that these are actually referring the same PWM 
device?

> > +When a power sequence is run, its steps is executed one after the other
> > until +one step fails or the end of the sequence is reached.
> 
> The document doesn't give any hint of what the driver should do if
> running the power sequence fails. Run the "opposite" power sequence?
> Will that work for all resources? I'm mainly thinking of a case where
> each enable of the resource should be matched by a disable, i.e. you
> can't call disable if no enable was called.

We discussed that issue already (around v5 I think) and the conclusion was 
that it should be up to the driver. When we simply enable/disable resources it 
is easy to revert, but in the future non-boolean properties will likely be 
introduced, and these cannot easily be reverted. Moreover some drivers might 
have more complex recovery needs. This deserves more discussion I think, as 
I'd like to have some "generic" recovery mechanism that covers most of the 
cases.

Alex.

