From: Daniel Mack <zonque@gmail.com>
Date: Thu, 06 Mar 2014 10:53:07 +0000
Subject: Re: [PATCH 0/4] Cleanups and fix for video/pxa3xx-gcu
Message-Id: <53185393.9030400@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1394035969-32420-1-git-send-email-zonque@gmail.com>
In-Reply-To: <1394035969-32420-1-git-send-email-zonque@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On 03/06/2014 11:30 AM, Tomi Valkeinen wrote:
> On 06/03/14 12:18, Daniel Mack wrote:

>>> That's clearly not the right place for it, but I
>>> think it's easier to move it along the other files, and later move it
>>> back to drivers/video/.
>>
>> Maybe it might be worth adding a subdirectory for hardware accelerators?
>> Because this is what the pxa3xx-gcu thing is all about really. And it's
>> only a tiny transport layer that passed commands between the hardware
>> block and a DirectFB userspace driver.
> 
> Well, there's drivers/gpu/. It sounds like a good match, and by "sounds"
> I mean the word "gpu" sounds like a good match. I'm not sure if other
> people have opinions on what drivers/gpu/ should contain, though.

Yes, you're right. Do you think we should do that in a 2nd step maybe,
after 3.15?


Daniel

