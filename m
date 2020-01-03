From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Fri, 03 Jan 2020 11:55:44 +0000
Subject: Re: [PATCH v3 3/3] fbdev: fbmem: avoid exporting fb_center_logo
Message-Id: <f248b742-37c8-356f-3128-628b578e896e@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190827110854.12574-1-peda@axentia.se>
 <20190827110854.12574-4-peda@axentia.se>
 <CAMuHMdVkqX7x_D5nf01s-kE=o+y5OLM-5fd3q=2RDKGTcpCfHg@mail.gmail.com>
 <CGME20190829070834epcas1p2dbdbae4159daba3c62057effa46bb4ab@epcas1p2.samsung.com>
 <6cb5ec1b-ae60-5ca4-f0d9-1414f52fed73@axentia.se>
In-Reply-To: <6cb5ec1b-ae60-5ca4-f0d9-1414f52fed73@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Peter Rosin <peda@axentia.se>, Geert Uytterhoeven <geert@linux-m68k.org>
Cc: "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Matthew Wilcox <willy@infradead.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>


On 8/29/19 9:08 AM, Peter Rosin wrote:
> On 2019-08-27 13:35, Geert Uytterhoeven wrote:
>> Hi Peter,
>>
>> On Tue, Aug 27, 2019 at 1:09 PM Peter Rosin <peda@axentia.se> wrote:
>>> The variable is only ever used from fbcon.c which is linked into the
>>> same module. Therefore, the export is not needed.
>>>
>>> Signed-off-by: Peter Rosin <peda@axentia.se>
>>
>> Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>

Thanks, patch queued for v5.6 (also sorry for the delay).

>> But note that the same is true for fb_class, so perhaps it can be added
>> (or better, removed ;-)?
> 
> Right. Someone please let me know if 3/3 needs to be extended. I'm also
> happy to just drop it...

Please send incremental patch for fb_class. 

>> Once drivers/staging/olpc_dcon/olpc_dcon.c stops abusing registered_fb[]
>> and num_registered_fb, those can go, too.
>>
>> Does anyone remembe why au1200fb calls fb_prepare_logo() and fb_show_logo()
>> itself?
> 
> Maybe there should be a small drivers/video/fbdev/core/fbmem.h file (or
> something) with these "internal" declarations, to hide some clutter currently
> in include/linux/fb.h?

Sounds like a good idea.

> Feels like that could be done later, after these other cleanups you mention,
> so that the new file has a few more things to declare.
Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
