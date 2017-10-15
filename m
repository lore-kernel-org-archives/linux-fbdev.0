From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Date: Sun, 15 Oct 2017 14:26:25 +0000
Subject: Re: [PATCH] video: fbdev: Fix an errro handling path in 'au1200fb_drv_probe()'
Message-Id: <197e2a4e-bfc9-c0d5-11fc-c071be0c18b3@wanadoo.fr>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20170912054234epcas4p2afadfa32766d7a186c00f1fdc568c7bf@epcas4p2.samsung.com>
 <20170912053930.18931-1-christophe.jaillet@wanadoo.fr>
 <12781513.OMEBNrce0f@amdc3058>
In-Reply-To: <12781513.OMEBNrce0f@amdc3058>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: tj@kernel.org, viro@zeniv.linux.org.uk, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, dri-devel@lists.freedesktop.org

Le 12/10/2017 à 18:25, Bartlomiej Zolnierkiewicz a écrit :
> [ added dri-devel ML to cc: ]
>
> On Tuesday, September 12, 2017 07:39:30 AM Christophe JAILLET wrote:
>> If 'dmam_alloc_attrs()' fails, we must go through the error handling code,
>> as done elsewhere in this function. Otherwise, there is a resource leak.
>>
>> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
>> ---
>> I'm also puzzled by the 'framebuffer_alloc()' call a few lines above.
>> 'ret' is known to be 0 at this point. I guess that -ENOMEM should also be
>> returned.
> Yes, moreover the "failed:" error path is incomplete (please take
> a look at au1200fb_drv_remove() for comparison) and needs to be fixed.
>
> Could you please take care of it?

I will try, but be indulgent :)

My understanding of the code is that they are several issues all related 
to this error handling path (double free, missing memory release, 
invalid irq release...)
I will try to sort it out, but my first tries will likely be incomplete 
and/or broken.

CJ
