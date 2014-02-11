From: Ryan Mallon <rmallon@gmail.com>
Date: Tue, 11 Feb 2014 19:07:53 +0000
Subject: Re: [RFC PATCH] video: Use fb_sys_write rather than open-coding in drivers
Message-Id: <52FA7509.1060704@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <523BF40B.1090002@gmail.com> <52FA2E57.3010300@ti.com>
In-Reply-To: <52FA2E57.3010300@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On 12/02/14 03:06, Tomi Valkeinen wrote:

> On 20/09/13 10:06, Ryan Mallon wrote:
>> Several video drivers open code the fb_write write function with code
>> which is very similar to fb_sys_write. Replace the open code versions
>> with calls to fb_sys_write. An fb_sync callback is added to each of
>> the drivers.
>>     
>> Signed-off-by: Ryan Mallon <rmallon@gmail.com>
>> ---
> 
> Doesn't this change the behavior so that fb_write does no longer update
> the display, but fb_sync does? I don't think fb_sync is even meant to
> update the display, it's meant to wait for an update to finish. Then
> again, I'm not sure about that, all I see in fb.h is "wait for blit
> idle, optional"


fb_write() in fbmem.c calls ->fb_sync() after ->fb_write(), and I've set
the fb_sync() for each of the drivers, so the behaviour should be
unchanged for writes.

The fb_sync() function is also called by fb_read() and 
fb_get_buffer_offset() (if FB_PIXMAP_SYNC flag is set). I don't know if
that will adversely affect behaviour.

Note that I haven't actually tested this code since I don't have any of
the hardware. It was just something I noticed while digging through
framebuffer driver code.

~Ryan
