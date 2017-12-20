From: Daniel Vetter <daniel@ffwll.ch>
Date: Wed, 20 Dec 2017 09:45:28 +0000
Subject: Re: [RFC PATCH v2 03/13] bootsplash: Flush framebuffer after drawing
Message-Id: <20171220094527.GK26573@phenom.ffwll.local>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20171213194755.3409-1-mstaudt@suse.de>
 <20171213194755.3409-4-mstaudt@suse.de>
 <20171213213506.GD26573@phenom.ffwll.local>
 <d66a994a-cb3a-c1fb-8f91-adbd475a40f0@suse.de>
 <20171219122313.GE26573@phenom.ffwll.local>
 <8bbb0497-4a10-2f81-0040-6e7cd4e7353c@suse.de>
 <20171219135715.GG26573@phenom.ffwll.local>
 <8036b6a6-6ed5-2f34-e854-1c397a9f34d4@suse.de>
 <CAKMK7uHgPheSuGc6v3aSxzaJ_BNMGRs3zZ=Mv7M_us37QS8-sg@mail.gmail.com>
 <24fd8767-bdf2-0073-2161-a0cf3b61780d@suse.de>
In-Reply-To: <24fd8767-bdf2-0073-2161-a0cf3b61780d@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Max Staudt <mstaudt@suse.de>
Cc: Linux Fbdev development list <linux-fbdev@vger.kernel.org>, michal@markovi.net, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, sndirsch@suse.com, Oliver Neukum <oneukum@suse.com>, Takashi Iwai <tiwai@suse.com>, dri-devel <dri-devel@lists.freedesktop.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, philm@manjaro.org, Bero =?iso-8859-1?Q?Rosenkr=E4nzer?= <bernhard.rosenkranzer@linaro.org>

On Tue, Dec 19, 2017 at 05:23:52PM +0100, Max Staudt wrote:
> On 12/19/2017 05:02 PM, Daniel Vetter wrote:
> > On Tue, Dec 19, 2017 at 4:41 PM, Max Staudt <mstaudt@suse.de> wrote:
> >> On 12/19/2017 02:57 PM, Daniel Vetter wrote:
> >>> The problem is that defio is totally not how a real driver works.
> >>
> >> But they do exist and I can't ignore them.
> >>
> >> I'm afraid I don't understand - why are those, such as xenfb, not real drivers?
> > 
> > I mean kms drivers. The problem is that the magic mapping that fbdev
> > expects is real pain. Everyone else, including kms, expects an
> > explicit flush operation. So instead of hacking around even more with
> > the defio corner cases that don't work, I'm suggesting we just add
> > that flush operation. At least internally.
> > 
> > Fixing kms drivers to implement a better defio is probably not a
> > reasonable investement of time.
> 
> Ah yes, I understand now, you mean that KMS drivers have explicit flush,
> and defio is a hack to retrofit such drivers to an API that never
> supported a flush operation (the fbdev API), but always used to expose
> the video memory directly. Right?
> 
> If yes, then I agree. Fixing the defio in the KMS drivers wouldn't even
> solve my problem - I'd still need to implement flush. So might as well
> care about the flush straight away, yep!

Yup.

I'll leave the more fundamental discussion to the other thread on the
cover letter.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
