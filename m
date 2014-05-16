From: Olof Johansson <olof@lixom.net>
Date: Fri, 16 May 2014 22:56:26 +0000
Subject: Re: [PATCH v2 1/3] video: clps711x: Add new Cirrus Logic CLPS711X framebuffer driver
Message-Id: <20140516225626.GB6028@quad.lixom.net>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1397285583-15187-1-git-send-email-shc_work@mail.ru>
In-Reply-To: <1397285583-15187-1-git-send-email-shc_work@mail.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Thu, May 08, 2014 at 01:14:40PM +0300, Tomi Valkeinen wrote:
> On 08/05/14 11:27, Alexander Shiyan wrote:
> 
> >>> At this time the driver has three user.
> >>> Only one of them should theoretically work.
> >>> clps711x-autcpu12 should not work in the absence of memblock_reserve().
> >>> clps711x-p720t should not work due to physical address limitation as i
> >>> noticed before. Board means to use SRAM instead of SDRAM.
> >>> Only clps711x-edb7211 should work fine (in theory).
> >>> Is this a good reason to replace the driver? I think yes.
> >>
> >> Ok, if the situation is that bad, maybe we can just switch to the new
> >> driver. Have you verified that those boards do not work from anyone? Or
> >> asked someone to test the new driver with those boards?
> > 
> > I'm not familiar with other users of this platform .
> > I am do not have these boards, all that I have written before that it's just a theory.
> > Firm in which I work, uses its own board with CLPS711X CPU , this board is the
> > only way to check for changes on real hardware .
> 
> Ok. That makes me a bit nervous... You're removing a driver, which may
> (or may not) have been working for other users. And adding a new one,
> which may not (or may) work for the other users.

Keep the old one around under another Kconfig name, mark it BROKEN,
and if nobody speaks up in a couple of releases, remove it?

> >> I'm still not really happy about it, and I'd much rather see the current
> >> driver fixed. But if no one having those boards is up to the task
> >> (probably not if they have not been working at all), maybe just ditching
> >> the old driver and adding a new is the only way forward.
> >>
> >> One change that I think would be good is to change the series to first
> >> remove the old driver, and then add the new one, with the same file name
> >> as the old one. That way git log will show the history for both the new
> >> and the old driver.
> > 
> > In this case git-bisect will be broken. Is this OK?
> 
> I think this is such a big change for the users of the driver that it's
> not an issue. Of course, kernel should still build at all steps, but I
> think it's fine if the fb driver in question will be out for a commit or
> two.

Agreed.


-Olof
