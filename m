From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [Linux-fbdev-devel] Re: Who is stomping PCI config space?
Date: Fri, 04 Mar 2005 17:40:59 +1100
Message-ID: <1109918459.5610.273.camel@gaston>
References: <9e4733910503031103552514b9@mail.gmail.com>
	<1109891245.5611.246.camel@gaston>
	<9e473391050303161559c17955@mail.gmail.com>
	<9e47339105030319037f083f7@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
In-Reply-To: <9e47339105030319037f083f7@mail.gmail.com>
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
To: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>
Cc: Xserver development <xorg@freedesktop.org>, Egbert Eich <eich@pdx.freedesktop.org>

On Thu, 2005-03-03 at 22:03 -0500, Jon Smirl wrote:
> Hopefully someone who knows what is going on with VT switching and how
> hardware gets enabled will respond and we can get this fixed in the
> server.  I see Zoltan's patch but we shouldn't have to tell X to leave
> hardware alone that doesn't belong to it. X just has no business
> messing with cards it does not own.
> 
> Meanwhile I am forced to write to PCI config space and reenable IO
> access from inside my interrupt handler. Yuck, yuck, yuck!!!

Well, that shows why we need this arbitration for who gets the VGA
enable bits in the kernel :)

X disables any other VGA card IO/MEM in the system so that at one given
point in time, only one of them will decode VGA cycles. Wether it has
those cards to drive in it's config or not doesn't matter, the problem
at the bus level is the same.

Ben.
