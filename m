From: Kukjin Kim <kgene.kim@samsung.com>
Date: Wed, 01 Aug 2012 10:03:55 +0000
Subject: RE: [PATCH V2 0/5] arm: samsung: Move FIMD headers to include/video/
Message-Id: <037c01cd6fcc$f5cb10f0$e16132d0$%kim@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1343737385-23337-1-git-send-email-l.krishna@samsung.com>
 <02f701cd6f8d$5ca3e850$15ebb8f0$%kim@samsung.com> <5018FDF6.4020205@gmx.de>
In-Reply-To: <5018FDF6.4020205@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: 'Florian Tobias Schandinat' <FlorianSchandinat@gmx.de>
Cc: 'Leela Krishna Amudala' <l.krishna@samsung.com>, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, ben-linux@fluff.org, inki.dae@samsung.com, joshi@samsung.com, jg1.han@samsung.com, m.szyprowski@samsung.com

Florian Tobias Schandinat wrote:
> 
> On 08/01/2012 02:28 AM, Kukjin Kim wrote:
> > Leela Krishna Amudala wrote:
> >>
> >> This patchset moves the contents of regs-fb-v4.h and regs-fb.h from
> arch
> >> side
> >> to include/video/samsung_fimd.h
> >>
> >> This patchset is created and rebased against master branch of torvalds
> >> tree.
> >> Tested on smdk5250 board, build tested for other boards.
> >>
> > (Cc'ed Florian Tobias Schandinat)
> >
> > Yeah, since it's merge window, this series could be created against on
> > mainline. And IMO, would be helpful to us if this series could be sent
> to
> > upstream via samsung tree after reviewing, because this touches too many
> > files in samsung tree and just adds include/video/samsung_fimd.h. But
> I'm
> > not sure the added inclusion will be used in other file of
drivers/video.
> If
> > so, I can provide some topic branch can be merged into Florian's tree.
> > Florian, how about?
> 
> Using a topic branch to merge it in both trees sounds like a good plan
> to me.
> 
Sure, if this change is ready, I will create topic branch then let you know.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.

