From: Daniel Mack <zonque@gmail.com>
Date: Thu, 06 Mar 2014 10:18:42 +0000
Subject: Re: [PATCH 0/4] Cleanups and fix for video/pxa3xx-gcu
Message-Id: <53184B82.4040006@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1394035969-32420-1-git-send-email-zonque@gmail.com>
In-Reply-To: <1394035969-32420-1-git-send-email-zonque@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On 03/06/2014 10:23 AM, Tomi Valkeinen wrote:
> On 06/03/14 11:09, Daniel Mack wrote:

>> Given that this driver doesn't actually have any connection points to
>> the framebuffer or video subsystem (despite its location) maybe you can
>> just take these patches through your pxa tree? It's a PXA3xx specific
>> device, after all. Jean-Christophe, Tomi - any objections?
>>
>> The driver is also broken since awhile, and the fact that nobody noticed
>> tells me that our platform is most probably the only real user.
> 
> If these do not have any dependencies to non-fbdev patches, and nothing
> else has dependencies to these patches, I'd rather take them via fbdev
> tree, based on the file location. There shouldn't be any conflicts, but
> just in case...

Ok for me. I really don't mind :)

> As a side note, I've got a drivers/video/ reorg patch series, possibly
> headed for v3.15, which moves the pxa3xx-gcu file to
> drivers/video/fbdev/.

Ah, ok. So then they really better go via your tree then.

> That's clearly not the right place for it, but I
> think it's easier to move it along the other files, and later move it
> back to drivers/video/.

Maybe it might be worth adding a subdirectory for hardware accelerators?
Because this is what the pxa3xx-gcu thing is all about really. And it's
only a tiny transport layer that passed commands between the hardware
block and a DirectFB userspace driver.


Thanks,
Daniel

