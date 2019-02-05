From: Daniel Vetter <daniel@ffwll.ch>
Date: Tue, 05 Feb 2019 09:02:46 +0000
Subject: Re: [PATCH 0/8] fbdev: sm712fb: implement 2D acceleration w/ cleanups.
Message-Id: <20190205090246.GB3271@phenom.ffwll.local>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190202061648.30374-1-tomli@tomli.me>
 <20190204092618.GM3271@phenom.ffwll.local>
 <20190204220650.GA24673@localhost.localdomain>
In-Reply-To: <20190204220650.GA24673@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tom Li <tomli@tomli.me>
Cc: linux-fbdev@vger.kernel.org, Teddy Wang <teddy.wang@siliconmotion.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, Sudip Mukherjee <sudipm.mukherjee@gmail.com>

On Tue, Feb 05, 2019 at 06:06:50AM +0800, Tom Li wrote:
> > Since you care about this driver, considered converting it to a drm
> > display driver? You can still have all the acceleration and stuff, the
> > fbdev compat mode in drm is rather flexible.
> > -Daniel
> 
> Yes, I know fbdev is now in maintenance-only mode, reimplementing it
> on top of DRM is on my roadmap, including rewriting a saner version
> of the modesetting code. The current version is beyond repair. I'll
> start working on it once I managed to purchase the hardware for testing.
> 
> But currently my objectively is to have something usable during the
> transitional period. The major user of the chipset was Yeeloong 8089D
> laptop - a choice for many non-x86 and MIPS hobbyists for experimentation.
> Getting the current version of the patch merged would solve the immediate
> usability issues, and then trying to get some platform drivers merged.
> And after completing the preliminary upstreaming process, since then,
> can start working on a DRM version of the driver, and possibly eventually
> remove the fbdev version of sm712fb entirely. 
> 
> The 2D acceleration implementation is strictly no more than 200 lines,
> the vast majority of the code insertions are comments and documentation
> changes ranting about the known issues of the driver/hardware, nothing
> non-trivial is added and I think the changeset is manageable and would
> not be a burden for the fbdev maintainers, and I can grarantee that I will
> not add any other new features to this driver.

Awesome, and I think as a gradual plan this makes tons of sense.

Cheers, Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
