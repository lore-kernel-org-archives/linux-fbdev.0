From: Ian Romanick <idr@us.ibm.com>
Subject: Re: [Dri-devel] Re: DRM and pci_driver conversion
Date: Mon, 27 Oct 2003 11:38:04 -0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <3F9D741C.9010501@us.ibm.com>
References: <16282.45806.428547.279213@zeus.local> <Pine.LNX.4.44.0310251116140.4083-100000@home.osdl.org> <20031027114006.A66611@xfree86.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
In-Reply-To: <20031027114006.A66611@xfree86.org>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: David Dawes <dawes@XFree86.Org>
Cc: dri-devel <dri-devel@lists.sourceforge.net>, fb-devel <linux-fbdev-devel@lists.sourceforge.net>

David Dawes wrote:
> On Sat, Oct 25, 2003 at 11:37:05AM -0700, Linus Torvalds wrote:
> 
>>But I'm _not_ interested in some interfaces to let user mode just bypass 
>>the kernel. Because they will not solve any of the other problems that 
>>clearly _do_ need solving, and if the X server continues to believe that 
>>it can just access the hardware directly, it will never play well together 
>>with projects like fbcon/dri.
> 
> XFree86 cares more about being a useable X server on a wide range of
> platforms than on playing well with a few Linux-specific hacks.
> 
> The real problem is that you have a mix of ideologies in the Linux
> kernel, each struggling for supremacy.  Come back to us when you know
> who the winner is.  At that time I'm sure you'll feel free to re-write
> history and claim that we should have been doing things that way all
> along.

I'm really baffled here.  Why would you even say such a thing?  In 
relation to Linus' *whole* message, your first paragraph and second 
paragraph are incongruous.  Linus (or anyone else) did not suggest that 
XFree86 be shoe-horned into any of the existing Linux video driver 
architectures.  In fact, he said quite the opposite.  He said that 
XFree86 is trying to do things that really do need kernel support, and 
all the existing methods for doing that suck.

Part of the problem is that, with the exception of DRI, the existing 
video specific interfaces in Linux were, as far as I know, created 
without input from XFree86.  You're suggesting that same mistake be 
repeated.

I'm also baffled by the general animosty shown towards Linux.  Judging 
by the traffic on the various lists, it seems to me that Linux and *BSD 
represent the lion's share of the XFree86 user base.  Making a consious 
choice to not support those platforms better is making a consious choice 
to not support our users.  I simply don't understand the rationalle 
behind such a decision.

Not only that, there is no requirement that the drivers use any given 
kernel interface.  Just because the drivers use a kernel interface on 
Linux or *BSD does not mean that they have to use a kernel interface on 
Solaris or HPUX.  There will be growing pains involved in having a 
kernel path and a non-kernel path.  I think that several of the DRI 
drivers (Radeon and Rage128) have shown that it *is* doable.

The next step is to create a kernel interface that is both generic 
enough and specific enough to acomplish the task at hand.  After 
watching the development of fbdev / fbcon, DRI, and XFree86 for a long 
time, I can say that there is no point in squabling over whether or not 
a kernel interface is useful for performance or necessary for proper 
device configuration.  Both of those questions have been sufficiently 
answered.  The question of where we go from here has not been answered.




-------------------------------------------------------
This SF.net email is sponsored by: The SF.net Donation Program.
Do you like what SourceForge.net is doing for the Open
Source Community?  Make a contribution, and help us add new
features and functionality. Click here: http://sourceforge.net/donate/
