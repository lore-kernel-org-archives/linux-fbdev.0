From: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: FB model basic issues (WAS: radeon, apertures & memory mapping)
Date: Tue, 15 Mar 2005 00:30:48 -0500
Message-ID: <9e473391050314213075ce0e47@mail.gmail.com>
References: <1110677744.19810.80.camel@gaston>
	<9e47339105031219223e606a52@mail.gmail.com>
	<1110696189.5787.100.camel@gaston>
	<1110774523.4003.511.camel@localhost>
	<1110784327.5787.288.camel@gaston>
	<1110817205.4004.527.camel@localhost>
	<1110837171.5863.16.camel@gaston>
	<1110838356.4003.548.camel@localhost>
	<1110839873.5673.41.camel@gaston>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
In-Reply-To: <1110839873.5673.41.camel@gaston>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/listinfo/xorg>,
	<mailto:xorg-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/xorg>
List-Post: <mailto:xorg@lists.freedesktop.org>
List-Help: <mailto:xorg-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/xorg>,
	<mailto:xorg-request@lists.freedesktop.org?subject=subscribe>
Sender: xorg-bounces@lists.freedesktop.org
Errors-To: xorg-bounces@lists.freedesktop.org
Content-Type: text/plain; charset="us-ascii"
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Jon Smirl <jonsmirl@yahoo.com>, =?ISO-8859-1?Q?Michel_D=E4nzer?= <michel@daenzer.net>, dri-devel@lists.sourceforge.net, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, xorg@lists.freedesktop.org

On Tue, 15 Mar 2005 09:37:53 +1100, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> 
> > Be that as it may, it remains a fact that such a change would break
> > existing installations...
> >
> > I think that mode setting and memory allocation should be separated. X
> > will always reserve enough video RAM for the largest resolution it uses
> > for the screen contents.
> 
> But X has no control on where fbdev will allocate memory. We are
> thinking with the "new model" in mind, and so far, a mode setting is
> under control of the framebuffer. Content of video memory (framebuffer,
> textures, overlay, whatever) simply cannot be considered as preserved
> accross mode switches.

I can agree that all video memory for that head can be booted. But
just because one head changes mode we shouldn't boot the objects for
the other head. You wouldn't want the two user case of one user
changing modes making the other user's display blink.

> 
> We can't also block all evolutions just because we have to support a
> broken model. We'll need to find a way to deal with that. An idea would
> be for me to do the clearing only when I come from a different bit depth
> or from text mode. That is, what i want to avoid, is those artifacts
> caused by incorrect bit depth content. A strict mode change isn't an
> issue in this case. That would solve my immediate problem.
> 
> _BUT_ in the long run, X will have to be smarter. Current UseFBDev or X
> "fbdev" can't support dual head properly on top of fbdev anyway, so that
> means I have some flexibility. The second head will probably" move on
> mode switches since I intend to allocate it at the top of the accessible
> aperture as described by Jon.

I agree that X has to be fixed to work cooperatively in this environment. 
The alternative is to just leave X alone and make all of this work for XGL.
The user would then choose which environment they want to run.

I'm leaning toward just leaving X alone and spending the resources on 
making XGL work. After all XGL is a complete X replacement.

If you want to run existing X load an old fbdev driver.  We can keep both
fbdev drivers in the kernel until it is clear if XGL is going mainstream.

One thing that does need to get fixed is mesa support for non-accelerated
fbdev drivers but mesa can add all of the appropriate locking.

> 
> All of that just keep uncovering more and more issues with our current
> fbdev model though. From discussions we had so far, it uncovers the
> problem of arbitration. That is, can we simply afford having a process
> mmap /dev/fb and blast things to it without any arbitration like we do
> today ?
> 
> If the answer is yes, then we are in deep trouble for lots of reason:
> 
>  - VGA Arbitration might require us to flip/flop MEM/IO enable bits
>  - Swapper control as explained earlier unless I can "reserve" a swapper
>    for each head, that is manage to have one aperture per head
>  - Engine discipline. What if the client on head 0 (like current X) uses
>    the engine ? Even if the one on head 1 doesn't, simple framebuffer
>    accesses can be enough to lock up the card.
>  - etc....
> 
> I think that Jon's dream of having totally independant heads that can
> run 2 separate applications is a long way away and we have sort-of to
> tie /dev/fb's together, though I don't know how to acheive that in
> practice, unless we switch to a new API that can enforce it. The current
> fbdev API cannot.

This is definitely something to works towards. There is a lot of
application for this in schools, libraries, internet cafe, etc. There
are several companies selling variations on this.

I don't expect an immediate solution but I want to make sure the
redesign allows it to be built.

> 
> DRI can do such things afaik (manage several contexts etc...), at least
> provides the infrastructure for it. But until all clients are DRI
> clients, we have a problem. That means that any direct fb client has to
> take over the entire card. All heads. There is simply no choice, and
> that doesn't even help with the VGA arbitration issue which still
> require explicit lock/unlock around accesses.
> 
> I'm open to suggestions...

Can we put in our own fault handler for the mmap, trap the directfb
accesses and do the proper locking?

> 
> Ben.
> 
> _______________________________________________
> xorg mailing list
> xorg@lists.freedesktop.org
> http://lists.freedesktop.org/mailman/listinfo/xorg
> 


-- 
Jon Smirl
jonsmirl@gmail.com
