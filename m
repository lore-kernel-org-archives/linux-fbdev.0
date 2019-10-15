From: Thomas Zimmermann <tzimmermann@suse.de>
Date: Tue, 15 Oct 2019 06:11:08 +0000
Subject: Re: [PATCH v2 00/15] DRM fbconv helpers for converting fbdev drivers
Message-Id: <9633ac37-00c3-f699-9fb6-e2ecae0d1905@suse.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20191014140416.28517-1-tzimmermann@suse.de>
 <20191014203644.GB4373@ravnborg.org>
In-Reply-To: <20191014203644.GB4373@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Sam Ravnborg <sam@ravnborg.org>
Cc: linux-fbdev@vger.kernel.org, corbet@lwn.net, airlied@linux.ie, gregkh@linuxfoundation.org, michel@daenzer.net, b.zolnierkie@samsung.com, dri-devel@lists.freedesktop.org, malat@debian.org, sean@poorly.run

Hi

Am 14.10.19 um 22:36 schrieb Sam Ravnborg:
> Hi Thomas.
> 
> On Mon, Oct 14, 2019 at 04:04:01PM +0200, Thomas Zimmermann wrote:
>> (was: DRM driver for fbdev devices)
>>
>> This is version 2 of the fbdev conversion helpers. It's more or less a
>> rewrite of the original patchset.
>>
>> The fbdev subsystem is considered legacy and will probably be removed at
>> some point. This would mean the loss of a signifanct number of drivers.
>> Some of the affected hardware is not in use any longer, but some hardware
>> is still around and provides good(-enough) framebuffers.
>>
>> The fbconv helpers allow for running the current DRM stack on top of fbdev
>> drivers. It's a set of functions that convert between fbdev interfaces and
>> DRM interfaces. Based on SHMEM and simple KMS helpers, it only offers the
>> basic functionality of a framebuffer, but should be compatible with most
>> existing fbdev drivers.
>>
>> A DRM driver using fbconv helpers consists of
>>
>>    * DRM stub code that calls into fbconv helpers, and
>>    * the original fbdev driver code.
>>
>> The fbdev driver code has to be modified to register itself with the
>> stub driver instead of the fbdev core framework. A tutorial on how to use
>> the helpers is part of this patchset. The resulting driver hybrid can be
>> refactored into a first-class DRM driver. The fbconv helpers contain a
>> number of comments, labeled 'DRM porting note', which explain the required
>> steps.
>>
>> I tested the current patchset with the following drivers: atyfb, aty128fb,
>> matroxfb, pm2fb, pm3fb, rivafb, s3fb, savagefb, sisfb, tdfxfb and tridentfb.
>> With each, I was able to successfully start with fbcon enabled, run weston and
>> X11. The drivers are available at [1]. For reference, the patchset includes
>> the Matrox stub driver.
> 
> In general I like the idea of modernizing the existing fbdev drivers.
> What I fail to read in your intro above is if this allows us to phase
> out the migrated fbdev drivers sooner?
> Or do we end up with two drivers to maintain?

The idea is that an fbdev driver is converted over to DRM and, once 
ready, the original fbdev driver gets removed. When a hybrid driver gets 
added, I'd want to see the rsp developer actually clean up and refactor 
the code. There shouldn't be multiple drivers for long.

But most of the fbdev drivers appear to be unmaintained anyway. I 
wouldn't expect having two drivers for a few releases would make much of 
a difference.

> Obviously a full migration to a DRM driver was preferred - but this may
> serve as a step in that direction.
> But we should not end up with two drivers doing almost the same.
> 
> Another general question. Do we want the modernized DRM drivers to end
> up in staging? Why should they not go direct into drm/*
> I know they are not fully atomic but this is not new drivers so maybe
> they can be excused.
> Problem is that drm drivers in staging live a secret nonvisible life
> where they are easy to forget when we change interfaces and such.

True. OTOH putting them next to the regular DRM code sends the message 
that the driver is already complete and in good shape. Those hybrid 
drivers are limited in functionality and don't really live up to 
anyone's requirements for code quality. It's the kind of code one would 
expect in staging.

Best regards
Thomas

> 	Sam
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
> 

-- 
Thomas Zimmermann
Graphics Driver Developer
SUSE Linux GmbH, Maxfeldstrasse 5, 90409 Nuernberg, Germany
GF: Felix Imendörffer, Mary Higgins, Sri Rasiah
HRB 21284 (AG Nürnberg)
