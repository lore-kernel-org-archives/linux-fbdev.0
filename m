From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [Linux-fbdev-devel] Re: Who is stomping PCI config space?
Date: Sun, 06 Mar 2005 09:43:42 +1100
Message-ID: <1110062622.13594.77.camel@gaston>
References: <9e4733910503031103552514b9@mail.gmail.com>
	<1109891245.5611.246.camel@gaston>
	<9e473391050303161559c17955@mail.gmail.com>
	<9e47339105030319037f083f7@mail.gmail.com>
	<1109918459.5610.273.camel@gaston>
	<16936.20345.249542.65736@xf14.local>
	<9e473391050304095812a11208@mail.gmail.com>
	<1109976305.5611.312.camel@gaston> <16938.865.144516.757019@xf14.local>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
In-Reply-To: <16938.865.144516.757019@xf14.local>
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
To: Egbert Eich <eich@suse.de>
Cc: Jesse Barnes <jbarnes@sgi.com>, Xserver development <xorg@freedesktop.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Sat, 2005-03-05 at 20:07 +0100, Egbert Eich wrote:

> That's the apporach we took when we implemented this in X. 
> It was the safest bet.

Yes, whatever mecanism I want to provide at the kernel level will do
that bet by default, unless it's informed by the card's driver that
legacy decoding was disabled for the card. That is, we bet the worse,
and only the guy who "knows" (ie, the card specific driver) can tell us
that life is actually much brighter ;)

Ben.
