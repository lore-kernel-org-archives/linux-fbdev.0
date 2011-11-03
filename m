From: Daniel Vetter <daniel@ffwll.ch>
Date: Thu, 03 Nov 2011 17:21:24 +0000
Subject: Re: [RFC] Virtual CRTCs (proposal + experimental code)
Message-Id: <20111103172124.GB2970@phenom.ffwll.local>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CA+4h6Hk3gE+8ou6NSMhoGJWZJ-5aM1OgC0HFoKs55fjfQ-qN8g@mail.gmail.com>
In-Reply-To: <CA+4h6Hk3gE+8ou6NSMhoGJWZJ-5aM1OgC0HFoKs55fjfQ-qN8g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ilija Hadzic <ilijahadzic@gmail.com>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org

Hi,

Quick question: How does this compare to Dave Airlies' PRIME buffer
sharing work for drm respectively the more generic dma_buf buffer sharing
work pushed by Linaro? You seem to aim for a solution for similar problems
(judging by your description) using a rather different approach.

Cheers, Daniel

On Thu, Nov 03, 2011 at 11:59:21AM -0400, Ilija Hadzic wrote:
> Hi everyone,
> 
> I would like to bring to the attention of dri-devel and linux-fbdev
> community a set of hopefully useful and interesting patches that
> I (and a few other colleagues) have been working on during the past
> few months. Here, I will provide a short abstract, so that you can
> decide whether this is of interest for you. At the end, I will
> provide the pointers to the code and documentation.
> 
> The code is based on Dave Arilie's tree, drm-next branch and it
> allows a GPU driver to have an arbitrary number of CRTCs
> (configurable by user) instead of only those CRTCs that represent
> real hardware.
> 
> The new CRTCs, that we call Virtual CRTCs can be attached to a
> foreign device, that we call CTD device (short for Compression
> Transmission and Display), and pixels can be streamed out of the GPU
> to the device.
> 
> In one example, we use AMD/ATI Radeon GPU to do 3D rendering
> (accelerated, of course) and we use our code to add additional
> monitor heads using DisplayLink devices. In other words, we achieve
> accelerated 3D rendering on a DisplayLink monitor. In another example
> we funnel rendered pixels to userland by emulating a Video-for-Linux
> device (and then userland can do whatever it wants with it). While
> doing all this, GPU has no idea that we are doing this, the entire DRI
> "thinks" that it is just dealing with a GPU that has a few "extra"
> connectors and CRTCs. So everything ports without the need to modify
> anything in the userland.
> 
> In general any device that can do something good with rendered pixels
> can act as a CTD device, allowing a GPU to be an acceleration device
> for a less capable display device or (the opposite) a frame-buffer-based
> display device to be an expansion card for a GPU. Of course, for
> each display device, a driver would have to be made compatible with our
> new infrastructure (which is what we have done with DisplayLink driver
> and also wrote one "synthetic" driver to fake out a V4L2 device as a
> CTD device).
> 
> The newly introduced kernel module that we call VCRTCM (short for
> Virtual CRTC Manager) handles the "traffic" between GPUs (actually
> their CRTCs) and CTDs. The code makes use of DMA wherever possible
> and also deals with specifics of CRTCs like modes, vblanks, page
> flips, hardware cursor, etc. (just for kick, we played OpenArena
> and watched Unigine Heaven demo on a DisplayLink monitor).
> 
> At this time, we would like to solicit feedback, comments, and
> possibly contributions. The code is on github (pointers below)
> and is based on the current state of drm-next branch from Dave's
> tree. The code is very experimental, but complete and stable enough
> that you can do something useful with it. We will be adding more
> CTD drivers and updates to current ones in the near future and will
> continue to maintain the code on github.
> 
> If the community finds this useful, we would be glad to work with
> the maintainers on merging this upstream. So we would especially like
> to hear what you would like to see changed to make this code acceptable
> for the mainline of development.
> 
> My Github page is at https://github.com/ihadzic. To access the kernel
> code type:
> 
> $ git clone git://github.com/ihadzic/linux-vcrtcm.git
> $ git branch drm-next-vcrtcm origin/drm-next-vcrtcm
> $ git checkout drm-next-vcrtcm
> 
> You will get all that's currently on Dave's drm-next plus our patches on
> the top. We kept the development history preserved without squashing patches
> (unless we had to due to merge/rebase conflicts), so you can see (and laugh
> at) all our goofs and fixes to them.
> 
> To access the documentation, type:
> 
> $ git clone git://github.com/ihadzic/vcrtcm-doc.git
> 
> Then read the HOWTO.txt file. The first few sections provide some
> general overview, and the sections that come later provide instructions
> how to use our stuff.
> 
> Again, all comments, positive or negative, are very welcome.
> 
> -- Ilija
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> http://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Daniel Vetter
Mail: daniel@ffwll.ch
Mobile: +41 (0)79 365 57 48
