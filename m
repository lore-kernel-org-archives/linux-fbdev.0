From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Tue, 28 Jan 2020 15:20:58 +0000
Subject: Re: [PATCH] fbdev: wait for references go away
Message-Id: <e16f568b-c629-b81e-ec3a-7c7dd6edb766@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20200120100025eucas1p21f5e2da0fd7c1fcb33cb47a97e9e645c@eucas1p2.samsung.com>
 <20200120100014.23488-1-kraxel@redhat.com>
 <d143e43b-8a38-940e-3ae5-e7b830a74bb3@samsung.com>
 <20200121055348.s4anrveo2z6avin6@sirius.home.kraxel.org>
In-Reply-To: <20200121055348.s4anrveo2z6avin6@sirius.home.kraxel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: "open list:FRAMEBUFFER LAYER" <linux-fbdev@vger.kernel.org>, marmarek@invisiblethingslab.com, dri-devel@lists.freedesktop.org, open list <linux-kernel@vger.kernel.org>


On 1/21/20 6:53 AM, Gerd Hoffmann wrote:
>   Hi,
> 
>>> open.  Which can result in drm driver not being able to grab resources
>>> (and fail initialization) because the firmware framebuffer still holds
>>> them.  Reportedly plymouth can trigger this.
>>
>> Could you please describe issue some more?
>>
>> I guess that a problem is happening during DRM driver load while fbdev
>> driver is loaded? I assume do_unregister_framebuffer() is called inside
>> do_remove_conflicting_framebuffers()?
> 
> Yes.  Specifically bochs-drm.ko and efifb in virtual machines.
> 
>> At first glance it seems to be an user-space issue as it should not be
>> holding references on /dev/fb0 while DRM driver is being loaded.
> 
> Well, the drm driver is loaded by udev like everything else.
> 
> Dunno what plymouth (graphical boot screen tool) does to handle the
> situation.  I guess listening to udev events.  So it should notice efifb
> going away and drop the /dev/fb0 reference, but this races against
> bochs-drm initializing.

It has been a week and there have been no alternative proposals to
address the problem so I incline to accepting this approach..

However please rework the patch slightly:

- Don't wait in the usual fb_info removal code-path, only in the driver
  replacement one. You can achieve this by adding additional "bool wait"
  parameter to do_unregister_framebuffer()

- Add a FIXME comment just before the wait loop with the description of
  the issue (the above explanation of the race between plymouth and udev
  would be fine) so we will remember why this workaround is needed.

- Change patch summary to something more descriptive (i.e. to "fbdev:
  workaround race on driver replacement").

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

>>> Fix this by trying to wait until all references are gone.  Don't wait
>>> forever though given that userspace might keep the file handle open.
>>
>> Where does the 1s maximum delay come from?
> 
> Pulled out something out of thin air which I expect being on the safe
> side.  plymouth responding on the udev event should need only a small
> fraction of that.
> 
> cheers,
>   Gerd
