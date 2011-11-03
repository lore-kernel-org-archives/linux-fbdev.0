From: Ilija Hadzic <ihadzic@research.bell-labs.com>
Date: Thu, 03 Nov 2011 18:00:24 +0000
Subject: Re: [RFC] Virtual CRTCs (proposal + experimental code)
Message-Id: <Pine.GSO.4.62.1111031247310.7191@umail>
List-Id: <linux-fbdev.vger.kernel.org>
References: <e80977e3-0992-454e-8ee2-2944560d3b3d@zmail16.collab.prod.int.phx2.redhat.com>
In-Reply-To: <e80977e3-0992-454e-8ee2-2944560d3b3d@zmail16.collab.prod.int.phx2.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Airlie <airlied@redhat.com>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org



On Thu, 3 Nov 2011, David Airlie wrote:

>
> Well the current plan I had for this was to do it in userspace, I don't think the kernel
> has any business doing it and I think for the simple USB case its fine but will fallover
> when you get to the non-trivial cases where some sort of acceleration is required to move
> pixels around. But in saying that its good you've done what something, and I'll try and spend
> some time reviewing it.
>

The reason I opted for doing this in kernel is that I wanted to confine 
all the changes to a relatively small set of modules. At first this was a 
pragmatic approach, because I live out of the mainstream development tree 
and I didn't want to turn my life into an ethernal 
merging/conflict-resolution activity.

However, a more fundamental reason for it is that I didn't want to be tied 
to X. I deal with some userland applications (that unfortunately I can't 
provide much detail of .... yet) that live directly on the top of libdrm.

So I set myself a goal of "full application transparency". Whatever is 
thrown at me, I wanted to be able to handle without having to touch any 
piece of application or library that the application relies on.

I think I have achieved this goal and really everything I tried just 
worked out of the box (with an exception of two bug fixes to ATI DDX
and Xorg, that are bugs with or without my work).

-- Ilija

