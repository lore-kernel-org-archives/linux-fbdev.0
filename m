From: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: radeon, apertures & memory mapping
Date: Sun, 13 Mar 2005 11:22:17 -0500
Message-ID: <9e4733910503130822293c0105@mail.gmail.com>
References: <1110677744.19810.80.camel@gaston>
	<9e47339105031219223e606a52@mail.gmail.com>
	<1110696189.5787.100.camel@gaston>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
In-Reply-To: <1110696189.5787.100.camel@gaston>
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
Cc: Jon Smirl <jonsmirl@yahoo.com>, dri-devel@lists.sourceforge.net, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, xorg@lists.freedesktop.org

On Sun, 13 Mar 2005 17:43:09 +1100, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> > In the long term I was hoping to design thing such that the two heads
> > can be used by two independent users, each could be running X or
> > fbdev.
> 
> You mean fbcon ? Unless there is proper arbitration, there can't be 2
> users. Hopefully we'll get there. But in any way, there can be only one
> driver in charge of the "card". That is, if X is using UseFBDev, then
> yes, it can use one head and fbcon the other. But if X is reprogramming
> the whole card, no way fbdev (and I mean -dev in this case) can use the
> other head at the same time, that's just not realistic.

I meant fbcon and XGL. Both will be running on fbdev/DRM and using a
coordinated memory manager, probably in DRM.

Current X is broken for sharing.

-- 
Jon Smirl
jonsmirl@gmail.com
