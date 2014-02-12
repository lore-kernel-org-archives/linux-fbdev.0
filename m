From: Ryan Mallon <rmallon@gmail.com>
Date: Wed, 12 Feb 2014 05:02:22 +0000
Subject: Re: [RFC PATCH] video: Use fb_sys_write rather than open-coding in drivers
Message-Id: <52FB005E.1000207@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <523BF40B.1090002@gmail.com> <52FA2E57.3010300@ti.com> <52FA7509.1060704@gmail.com> <52FB1AB0.6090601@ti.com>
In-Reply-To: <52FB1AB0.6090601@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On 12/02/14 19:54, Tomi Valkeinen wrote:

> On 11/02/14 21:07, Ryan Mallon wrote:
>> On 12/02/14 03:06, Tomi Valkeinen wrote:
>>
>>> On 20/09/13 10:06, Ryan Mallon wrote:
>>>> Several video drivers open code the fb_write write function with code
>>>> which is very similar to fb_sys_write. Replace the open code versions
>>>> with calls to fb_sys_write. An fb_sync callback is added to each of
>>>> the drivers.
>>>>     
>>>> Signed-off-by: Ryan Mallon <rmallon@gmail.com>
>>>> ---
>>>
>>> Doesn't this change the behavior so that fb_write does no longer update
>>> the display, but fb_sync does? I don't think fb_sync is even meant to
>>> update the display, it's meant to wait for an update to finish. Then
>>> again, I'm not sure about that, all I see in fb.h is "wait for blit
>>> idle, optional"
>>
>>
>> fb_write() in fbmem.c calls ->fb_sync() after ->fb_write(), and I've set
>> the fb_sync() for each of the drivers, so the behaviour should be
>> unchanged for writes.
>>
>> The fb_sync() function is also called by fb_read() and 
>> fb_get_buffer_offset() (if FB_PIXMAP_SYNC flag is set). I don't know if
>> that will adversely affect behaviour.
> 
> Well, by just looking at the function names the drivers' fb_syncs call,
> it sounds to me that with your patch fb_sync will update the LCD, i.e.
> send data to it. Doing that in fb_read sounds totally wrong.


Well, the alternative is to supply an fb_write() implementation for each
driver that calls fb_sys_write(), and then updates the display. The
fb_sync() additions can be removed. That would cut down the boiler-plate
code, and should keep the behaviour the same.

If you don't think it is worth the effort, then the patch can just be
dropped.

~Ryan
