From: David Airlie <airlied@redhat.com>
Date: Thu, 03 Nov 2011 17:27:59 +0000
Subject: Re: [RFC] Virtual CRTCs (proposal + experimental code)
Message-Id: <e80977e3-0992-454e-8ee2-2944560d3b3d@zmail16.collab.prod.int.phx2.redhat.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CA+4h6Hk3gE+8ou6NSMhoGJWZJ-5aM1OgC0HFoKs55fjfQ-qN8g@mail.gmail.com>
In-Reply-To: <CA+4h6Hk3gE+8ou6NSMhoGJWZJ-5aM1OgC0HFoKs55fjfQ-qN8g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ilija Hadzic <ilijahadzic@gmail.com>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org


> 
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

Well the current plan I had for this was to do it in userspace, I don't think the kernel
has any business doing it and I think for the simple USB case its fine but will fallover
when you get to the non-trivial cases where some sort of acceleration is required to move
pixels around. But in saying that its good you've done what something, and I'll try and spend
some time reviewing it.

The current plan from my POV is to add hotplug support to the X server and just hotplug USB
devices up there, and not mess up the kernel with lots of extra state that really the drivers
don't need to know about.

I'm also not sure how you deal with tiling etc, you can also start hitting rendering limits,
where a GPU can render to 4kx4k but you can plug in more USB devices, again I'm hoping to
solve this in userspace as well.

But I'll take some time if I can find it to look over it.

Dave.
