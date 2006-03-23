From: "Dave Airlie" <airlied@gmail.com>
Subject: Re: [Linux-fbdev-devel] [PATCH] [git tree] Intel i9xx support for intelfb
Date: Fri, 24 Mar 2006 09:28:55 +1100
Message-ID: <21d7e9970603231428t1172c5cdlaffe3603b920fc5a@mail.gmail.com>
References: <21d7e9970603221820p5c89e46fgbd9878a3c60eac0a@mail.gmail.com>
	 <b00ca3bd0603222159t63ea0f4j38e085ecff5b93c8@mail.gmail.com>
	 <21d7e9970603222209r45beeb99nccc6435b99b79154@mail.gmail.com>
	 <4422E171.1040909@worldonline.fr>
Mime-Version: 1.0
Content-Transfer-Encoding: 7BIT
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1422711AbWCWW26@vger.kernel.org>
In-Reply-To: <4422E171.1040909@worldonline.fr>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
To: linux-fbdev-devel@lists.sourceforge.net
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, akpm@osdl.org

On 3/24/06, Sylvain Meyer <sylvain.meyer@worldonline.fr> wrote:
>         Sorry for my very long silence.
>
> For i2c support. I've done it to have a workable tv-out on my hardware.
> It was the main reason  why i ported the driver to kernels 2.6 as i use
> my computer as a set-top-box only connected to a tv. I've it on my own
> tree (very old).
> I can send you the code. I did it in a way not accepted by kernel
> reviewers as my tv driver (for chrontel ch7011 chipset) is all in kernel
> space. But it can be a base for a better scheme.

I actually have your code already, I picked it up on directfb-dev
quite a while back :-)

The i810 i2c code is nearly exactly the same as intelfb, they use the
same scheme, i9xx also support GMBUS, which means the chipset takes
over the bitbanging, you just give it a byte count and register... but
I'm not having the greatest luck reverse engineering it, hopefully
Intel will tell us how it might work at some point..

Im trying to figure out the architecture for moving a lot of stuff
into userspace, but keeping enough in kernel for people to do what
works now..

Dave.
