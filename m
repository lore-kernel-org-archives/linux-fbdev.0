From: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: Who is stomping PCI config space?
Date: Thu, 3 Mar 2005 22:03:43 -0500
Message-ID: <9e47339105030319037f083f7@mail.gmail.com>
References: <9e4733910503031103552514b9@mail.gmail.com>
	<1109891245.5611.246.camel@gaston>
	<9e473391050303161559c17955@mail.gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
In-Reply-To: <9e473391050303161559c17955@mail.gmail.com>
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
Cc: fbdev <linux-fbdev-devel@lists.sourceforge.net>, Xserver development <xorg@freedesktop.org>, Egbert Eich <eich@pdx.freedesktop.org>

Hopefully someone who knows what is going on with VT switching and how
hardware gets enabled will respond and we can get this fixed in the
server.  I see Zoltan's patch but we shouldn't have to tell X to leave
hardware alone that doesn't belong to it. X just has no business
messing with cards it does not own.

Meanwhile I am forced to write to PCI config space and reenable IO
access from inside my interrupt handler. Yuck, yuck, yuck!!!

-- 
Jon Smirl
jonsmirl@gmail.com
