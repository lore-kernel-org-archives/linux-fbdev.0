From: Ilija Hadzic <ihadzic@research.bell-labs.com>
Date: Fri, 25 Nov 2011 05:11:28 +0000
Subject: Re: [RFC] Virtual CRTCs (proposal + experimental code)
Message-Id: <Pine.GSO.4.62.1111242226530.29639@umail>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CA+4h6Hk3gE+8ou6NSMhoGJWZJ-5aM1OgC0HFoKs55fjfQ-qN8g@mail.gmail.com>
	<CAPM=9tyPOkS7w3593-3ZtjSN6E+cO82125Lpmn2er8r9=PzROQ@mail.gmail.com>
	<Pine.GSO.4.62.1111232223110.18154@umail>
	<CAPM=9tx3ue8+PQ6QBxL_0Do2kLB01Q0yN-FOZrJkY2RKiyNm4Q@mail.gmail.com>
	<20111124105249.GA3867@phenom.ffwll.local>
In-Reply-To: <20111124105249.GA3867@phenom.ffwll.local>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Daniel Vetter <daniel@ffwll.ch>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org


>
> So I think we do have enough people interested in this and should be able
> to cobble together something that does The Right Thing.
>

We indeed have a non-trivial set of people interested in the same set of 
problems and each of us has partial and maybe competing solution. I want 
to make it clear that my, maybe disruptive and different from the 
plan-of-record, proposal should not be viewed as destructive or 
distracting. I am just offering to the community what I think is useful.

If this discussion sparks some joint effort that will bring us to the 
solution that everyone is happy with, even if no line of my code is found 
useful, I am perfectly fine with that (and I'll join the effort).

So at this point I think I should put out my back-of-the-napkin 
desiderata. That will hopefully shed some light on where I am coming from 
with VCRTCM proposal.

I want to be able to pull pixels out of the GPU and redirect them to an 
arbitrary device that can do something useful with them. This should not 
be limited to shooting photons into human eyeballs. I want to be able to 
run my applications without having to run X. I'd like the solution to be 
transparent to the application; that is, if I can write an application 
that can render something to a full screen, I want to redirect that 
"screen" to wherever I want without having to rewrite, recompile or relink 
the application. Actually, I want to do that redirection at runtime. I'd 
like to support all of the above in a way that it can also help solve more 
imminent shotcomings of Linux graphics system (Optimus, DisplayLink, etc. 
... cf. previous E-mails in this thread). I'd like it to work with 
multiple render nodes on the same GPU (something like Dave's multiseat 
work, in which both GPU and its display resources are virtual).

The logical consequence of this is that the render node and the display 
node should at some point become logically separate (different driver 
modules) even if they are physically on the same GPU. They are really two 
different subsystems that just happen to reside on the same circuit 
board, so it makes sense to separate them.

I don't think what I am saying is anything unique and what I said probably 
overlaps in good part with what others also want from the graphics 
subsystem. I can see the role of VCRTCM in all of the above, but I am 
open-minded. If we end up with a solution that has nothing to do with 
VCRTCM, I have no emotional ties with my code (and code of my colleagues 
that worked with me so far).

-- Ilija


