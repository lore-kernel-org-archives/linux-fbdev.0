From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Date: Thu, 17 Feb 2011 18:56:09 +0000
Subject: Re: [PATCH 1/2] ARM: PXA: PXAFB: Fix double-free issue.
Message-Id: <20110217185609.GB30606@n2100.arm.linux.org.uk>
List-Id: <linux-fbdev.vger.kernel.org>
References: <201102151718.00800.anarsoul@gmail.com>
	<1297928588-10545-1-git-send-email-anarsoul@gmail.com>
	<201102171917.41442.marek.vasut@gmail.com>
In-Reply-To: <201102171917.41442.marek.vasut@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Thu, Feb 17, 2011 at 07:17:41PM +0100, Marek Vasut wrote:
> Why are you getting rid of the atomic operations ?

Because they're idiotic.  Just because something is called "atomic"
doesn't make it so, and this is one instance where it's absolutely
useless.

The open and release functions are called with a mutex held.  Only
_one_ thread can be inside these at any one time.  So what use does
additionally doing an atomic operation within an already thread-safe
environment gain you?

> Besides, "if (ofb->usage++ = 0)" looks suspicious, especially if you later 
> declare it as uint32_t.

No.  You're not understanding the code.  This is equivalent to:

	usage = ofb->usage;
	ofb->usage = usage + 1;
	if (usage = 0)

And if you write it like that, then it is obvious.  It's your understanding
of what a post-increment looks like which is suspicious here.

> > @@ -733,12 +739,24 @@ static int overlayfb_release(struct fb_info *info,
> > int user) {
> >  	struct pxafb_layer *ofb = (struct pxafb_layer*) info;
> > 
> 
> DTTO, why no atomic?

Because this is already a thread-safe code region.

> >  	ofb->video_mem = alloc_pages_exact(size, GFP_KERNEL | __GFP_ZERO);
> > @@ -891,7 +910,7 @@ static void __devinit init_pxafb_overlay(struct
> > pxafb_info *fbi,
> > 
> >  	ofb->id = id;
> >  	ofb->ops = &ofb_ops[id];
> 
> DTTO

An initializing store by which a machine can write the entire contents in
one instruction _is_ by its very nature atomic.

atomic_t is one of the most over(ab)used types because people just don't
think about the code they're writing. ;(
