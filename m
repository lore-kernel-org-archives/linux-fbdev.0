From: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Date: Sat, 19 Nov 2011 05:06:17 +0000
Subject: Re: [PATCH] fb: split out framebuffer initialization from allocation
Message-Id: <4EC73949.9060104@gmx.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1321308088-6327-1-git-send-email-timur@freescale.com>
In-Reply-To: <1321308088-6327-1-git-send-email-timur@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Hi Timur,

On 11/17/2011 08:19 PM, Timur Tabi wrote:
> Timur Tabi wrote:
>> Introduce functions framebuffer_init() and framebuffer_cleanup() to allow
>> the initialization of a user-allocated fb_info object.
>>
>> framebuffer_alloc() allows for appending a private data structure when it
>> allocates the fb_info object.  However, a driver that registers multiple
>> framebuffers for one device may also need another private data structure
>> for the device itself.  framebuffer_init() allows such drivers to store
>> the fb_info objects in the device-specific private data structure,
>> thereby simplifying memory allocation.
>>
>> Signed-off-by: Timur Tabi <timur@freescale.com>
> 
> Florian,
> 
> Any comments on this patch?  If you're okay with the change, I want to take
> advantage of it in my framebuffer driver.

Of course you want, otherwise I'd be wondering why you are sending this patch
at all.

But I don't see any advantages of your approach. Instead of pointers to fb_info
with this patch you could embed fb_info directly in your data structure but that
is barely a difference for a programmer I'd think. You'd still have to call your
new functions on init/exit so the amount of function calls needed is the same
with or without the patch (I could see an advantage if alloc and release were
pure memory allocations). Or is this all about handling the case when fb_alloc
fails?
Historically some drivers don't even call alloc but have their own fb_info and
call only register. I do not want to add yet another way of doing framebuffer
initialization unless you can clearly show its benefits.


Best regards,

Florian Tobias Schandinat
