From: James Simmons <jsimmons@infradead.org>
Subject: Re: Current discussion about the future of free
 software graphics
Date: Tue, 11 May 2004 00:45:59 +0100 (BST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0405110043020.8016-100000__48257.705444894$1084232899@phoenix.infradead.org>
References: <1084205711.804.43.camel@thor.asgaard.local>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
In-Reply-To: <1084205711.804.43.camel@thor.asgaard.local>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
Cc: xserver@freedesktop.org, mesa3d-dev@lists.sf.net, dri-devel@lists.sf.net, linux-fbdev-devel@lists.sf.net


> single kernel driver should muck with the hardware directly. However,
> I'd like to point out again that it doesn't follow that the DRM and the
> framebuffer device must merge to a single entity (which 'has to be' the
> DRM if you ask some people, the framebuffer device if you ask
> others...). E.g., they could both use the same mini-driver which deals
> with the hardware. Let's try and keep our minds open to all possible
> solutions.

I agree. The disagreement is about where to put mode setting.
 
> > register values. Finally the plug-in lib would use a private IOCTL to set the
> > state into the video hardware. 
> > 
> > There are numerous pros and cons for both a both schemes. The user space code is
> > swappable, easier to debug, and does not need to be run as root.
> 
> It does, or the ioctl must verify the register data, which could require
> about the same amount of code as computing it in the kernel in the first
> place (possibly even more; the problem changes from computing a valid
> combination of register values for a specific requested mode to limiting
> the huge number of register value combinations to those that don't lock
> up the chip or worse). I've pointed this out several times before, but
> nobody has presented a solution yet. Will the userspace code live in a
> daemon that runs as root? Or will only privileged processes be allowed
> to change display properties?

So in reality having mode switching would be just as expensive in 
userspace as having it in the kernel? 




-------------------------------------------------------
This SF.Net email is sponsored by Sleepycat Software
Learn developer strategies Cisco, Motorola, Ericsson & Lucent use to 
deliver higher performing products faster, at low TCO.
http://www.sleepycat.com/telcomwpreg.php?From=osdnemail3
