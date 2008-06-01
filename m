From: Denis Oliver Kropp <dok-iGvX3keArt1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [directfb-dev] DirectFB without FBDev
Date: Sun, 01 Jun 2008 11:31:34 +0200
Message-ID: <48426C76.5080606@directfb.org>
References: <483D7344.6030503@directfb.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <directfb-users-bounces-iGvX3keArt1g9hUCZPvPmw@public.gmane.org>
In-Reply-To: <483D7344.6030503-iGvX3keArt1g9hUCZPvPmw@public.gmane.org>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <http://mail.directfb.org/cgi-bin/mailman/listinfo/directfb-users>,
	<mailto:directfb-users-request-iGvX3keArt1g9hUCZPvPmw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://mail.directfb.org/pipermail/directfb-users>
List-Post: <mailto:directfb-users-iGvX3keArt1g9hUCZPvPmw@public.gmane.org>
List-Help: <mailto:directfb-users-request-iGvX3keArt1g9hUCZPvPmw@public.gmane.org?subject=help>
List-Subscribe: <http://mail.directfb.org/cgi-bin/mailman/listinfo/directfb-users>,
	<mailto:directfb-users-request-iGvX3keArt1g9hUCZPvPmw@public.gmane.org?subject=subscribe>
Sender: directfb-users-bounces-iGvX3keArt1g9hUCZPvPmw@public.gmane.org
Errors-To: directfb-users-bounces-iGvX3keArt1g9hUCZPvPmw@public.gmane.org
To: directfb-dev-iGvX3keArt1g9hUCZPvPmw@public.gmane.org, directfb-users-iGvX3keArt1g9hUCZPvPmw@public.gmane.org
Cc: linux-fbdev-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org

Denis Oliver Kropp wrote:
> Hi,
> 
> after getting too depressed by the current state of the FBDev backend with the new
> surface core I decided to drop FBDev support as it no longer fits into the architecture.
> 
> If you feel you like to fix the frame buffer device system module or better the frame
> buffer device itself, you're welcome to help the FBDev backend to creep over the 1.2 hurdle...
> 
> One major bug at the moment is mode switching and pitch values being wrong. It's dumb to
> return the pitch of the variable mode settings in the fixed settings structure anyhow, but
> if you like to start with the above mentioned mission, that's where it could begin.
> 
> And while you're at it, please also add an ioctl to just simply set the display offset without
> a virtual resolution and x/y offset values within the whole frame buffer...
> 
> I have no idea why the FBDev backend uses the wrong pitch (4096) after switching to RGB16 which
> should have a pitch of 2048. One out of ten tries did work though. I remember it has been
> working once I added several workarounds and hacks to keep the FBDev backend alive, but somehow
> the code or core have changed, I don't know and I'm not in the mood of spending time on cruft
> like VTs, FBDev etc...

It seems the bug is not happening that often on other
systems, I was using vmwarefb with a 2.4 kernel.

Right now I can only reproduce it when switching from a fullscreen
application back to the window stack and that's due to the weird
workarounds I've added.

> Volunteers are welcome, urgently, I'm going to make a first release candidate of 1.2 tomorrow,
> most likely after removing the fbdev system module.

I'm partly rewriting the FBDev system module now. Without those
workarounds, but a different overall structure it should behave
much better.

Still my wish is to set the frame buffer via byte offset/pitch!

I also forget about those extensions like layer transparency,
scaling, YUV formats, ...

But I suggest everyone planning some more sophisticated stuff
not to start writing a frame buffer driver, but starting off
cleanly in user space with a simple DirectFB driver using the
devmem system module or writing one yourself.

	http://www.directfb.org/docs/ELC2008/elc2008_directfb_gfx.pdf

-- 
Best regards,
   Denis Oliver Kropp

.------------------------------------------.
| DirectFB - Hardware accelerated graphics |
| http://www.directfb.org/                 |
"------------------------------------------"
