From: Archit Taneja <a0393947@ti.com>
Date: Wed, 29 Jun 2011 17:02:30 +0000
Subject: Re: [PATCH] OMAP: DSS: dispc: enable/disable clocks in error handler
Message-Id: <4E0B5AA6.7070603@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1309195865-23808-1-git-send-email-dima@android.com>	 <4E09FEFD.9020005@ti.com> <1309323487.1829.9.camel@deskari>
In-Reply-To: <1309323487.1829.9.camel@deskari>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Valkeinen, Tomi" <tomi.valkeinen@ti.com>
Cc: "Taneja, Archit" <archit@ti.com>, Dima Zavin <dima@android.com>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi,

On Tuesday 28 June 2011 09:58 PM, Valkeinen, Tomi wrote:
> On Tue, 2011-06-28 at 09:19 -0700, Archit Taneja wrote:
>> Hi,
>>
>> On Monday 27 June 2011 10:31 AM, Dima Zavin wrote:
>>> There's no guarantee that the error handler worker thread
>>> will run while the dispc clocks are on. Explicitly enable/disable
>>> them.
>>
>> I agree with this.
>
> Yes, I think this patch is fine. I'll apply it to DSS tree.
>
>> Tomi,
>>
>> We could get prevent scheduling of the error worker by registering
>> omap_dispc_irq_handler() as an interrupt thread.
>
> But then we would get extra latency on the interrupt handlers. I wanted
> to keep handling DSS interrupts in interrupt context, because some use
> cases may require very fast reaction to an interrupt.

Okay..we don't need to handle the errors in interrupt context..the 
request_threaded_irq() takes 2 functions I think, we could have have 
omap_dispc_irq_handler() as the primary handler, and the error_worker as 
the thread.

I think the change I'm just suggesting just leads to some beautification 
in the end :), we would still need to ensure that clocks are enabled in 
the error_worker path.

Archit


