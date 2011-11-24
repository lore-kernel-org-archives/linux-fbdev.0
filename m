From: Daniel Vetter <daniel@ffwll.ch>
Date: Thu, 24 Nov 2011 10:52:49 +0000
Subject: Re: [RFC] Virtual CRTCs (proposal + experimental code)
Message-Id: <20111124105249.GA3867@phenom.ffwll.local>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CA+4h6Hk3gE+8ou6NSMhoGJWZJ-5aM1OgC0HFoKs55fjfQ-qN8g@mail.gmail.com>
	<CAPM=9tyPOkS7w3593-3ZtjSN6E+cO82125Lpmn2er8r9=PzROQ@mail.gmail.com>
	<Pine.GSO.4.62.1111232223110.18154@umail>
	<CAPM=9tx3ue8+PQ6QBxL_0Do2kLB01Q0yN-FOZrJkY2RKiyNm4Q@mail.gmail.com>
In-Reply-To: <CAPM=9tx3ue8+PQ6QBxL_0Do2kLB01Q0yN-FOZrJkY2RKiyNm4Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Dave Airlie <airlied@gmail.com>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org

On Thu, Nov 24, 2011 at 08:52:45AM +0000, Dave Airlie wrote:
> So the main problem with taking all this code on-board is it sort of
> solves (a), and (b) needs another bunch of work. Now I'd rather not
> solve 50% of the issue and have future userspace apps just think they
> can ignore the problem. As much as I dislike the whole dual-gpu setups
> the fact is they exist and we can't change that, so writing userspace
> to ignore the problem because its too hard isn't going to work. So if
> I merge this VCRTC stuff I give a lot of people an excuse for not
> bothering to fix the harder problems that hotplug and dynamic GPUs put
> in front of you.

My 2 Rappen on this: I agree completely with your point that we should aim
for a full solution. GPU memory management across different devices is
hard, but solveable.

Furthermore I fear that a 50% solution that hides the memory management
and shuffling issues from userspace will end up being a leaky abstraction
(e.g. how and when is stuff transferred to the usb dp port, the kernel
might pin scanout buffers behind userspace's back screwing up the vram
accounting in userspace, random hotplugging of outputs ...). Also
v4l/embedded folks have similar issues (and the same tendency to just go
with a "simple" solution fitting their usecase) and with Intel dead-set on
entering the SoC market I'll have the joy to mess around with this stuff
pretty soon, too.

So I think we do have enough people interested in this and should be able
to cobble together something that does The Right Thing.

Cheers, Daniel
-- 
Daniel Vetter
Mail: daniel@ffwll.ch
Mobile: +41 (0)79 365 57 48
