From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: FB model basic issues (WAS: radeon, apertures & memory mapping)
Date: Tue, 15 Mar 2005 09:37:53 +1100
Message-ID: <1110839873.5673.41.camel@gaston>
References: <1110677744.19810.80.camel@gaston>
	 <9e47339105031219223e606a52@mail.gmail.com>
	 <1110696189.5787.100.camel@gaston>  <1110774523.4003.511.camel@localhost>
	 <1110784327.5787.288.camel@gaston>  <1110817205.4004.527.camel@localhost>
	 <1110837171.5863.16.camel@gaston>  <1110838356.4003.548.camel@localhost>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
In-Reply-To: <1110838356.4003.548.camel@localhost>
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, dri-devel@lists.sourceforge.net, Jon Smirl <jonsmirl@yahoo.com>, xorg@lists.freedesktop.org


> Be that as it may, it remains a fact that such a change would break
> existing installations...
> 
> I think that mode setting and memory allocation should be separated. X
> will always reserve enough video RAM for the largest resolution it uses
> for the screen contents.

But X has no control on where fbdev will allocate memory. We are
thinking with the "new model" in mind, and so far, a mode setting is
under control of the framebuffer. Content of video memory (framebuffer,
textures, overlay, whatever) simply cannot be considered as preserved
accross mode switches.

We can't also block all evolutions just because we have to support a
broken model. We'll need to find a way to deal with that. An idea would
be for me to do the clearing only when I come from a different bit depth
or from text mode. That is, what i want to avoid, is those artifacts
caused by incorrect bit depth content. A strict mode change isn't an
issue in this case. That would solve my immediate problem.

_BUT_ in the long run, X will have to be smarter. Current UseFBDev or X
"fbdev" can't support dual head properly on top of fbdev anyway, so that
means I have some flexibility. The second head will probably" move on
mode switches since I intend to allocate it at the top of the accessible
aperture as described by Jon.

All of that just keep uncovering more and more issues with our current
fbdev model though. From discussions we had so far, it uncovers the
problem of arbitration. That is, can we simply afford having a process
mmap /dev/fb and blast things to it without any arbitration like we do
today ?

If the answer is yes, then we are in deep trouble for lots of reason:

 - VGA Arbitration might require us to flip/flop MEM/IO enable bits
 - Swapper control as explained earlier unless I can "reserve" a swapper
   for each head, that is manage to have one aperture per head
 - Engine discipline. What if the client on head 0 (like current X) uses
   the engine ? Even if the one on head 1 doesn't, simple framebuffer
   accesses can be enough to lock up the card.
 - etc....

I think that Jon's dream of having totally independant heads that can
run 2 separate applications is a long way away and we have sort-of to
tie /dev/fb's together, though I don't know how to acheive that in
practice, unless we switch to a new API that can enforce it. The current
fbdev API cannot.

DRI can do such things afaik (manage several contexts etc...), at least
provides the infrastructure for it. But until all clients are DRI
clients, we have a problem. That means that any direct fb client has to
take over the entire card. All heads. There is simply no choice, and
that doesn't even help with the VGA arbitration issue which still
require explicit lock/unlock around accesses.

I'm open to suggestions...

Ben.




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
