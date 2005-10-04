From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [Linux-fbdev-devel] VESA, EDID & flat panels
Date: Tue, 04 Oct 2005 13:43:55 +1000
Message-ID: <1128397436.31063.0.camel@gaston>
References: <1128380013.8267.125.camel@gaston>
	<8a0c36780510031618m48c55f45u648d867bcf0130d2@mail.gmail.com>
Reply-To: Discuss issues related to the xorg tree <xorg@lists.freedesktop.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <xorg-bounces@lists.freedesktop.org>
In-Reply-To: <8a0c36780510031618m48c55f45u648d867bcf0130d2@mail.gmail.com>
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
To: linux-fbdev-devel@lists.sourceforge.net
Cc: Discuss issues related to the xorg tree <xorg@lists.freedesktop.org>

On Mon, 2005-10-03 at 18:18 -0500, Richard Smith wrote:
> > Somebody around here has access to the VESA specs ? I'm trying to figure
> > out if the EDID block, at least on recent flat panels, tells us wether
> > the panel digital input is 6:6:6 or 8:8:8 ... If it's 6:6:6, we should
> > enable dithering in drivers like radeon and "nv", while if 8:8:8, we
> > should not. If not enabling it on a 6 bits panel, we end up with crappy
> > looking gradients, if enabling it on a 8 bits panel, we basically end up
> > sending a 6 bits signal to a 8 bits panel, thus reducing the quality.
> 
> We have  a copy from a few years ago.  Its not too descriptive if
> IIRC.  I'll try to look at it tomorrow.

I found a lot of stuff on VESA Public site in fact. Looks like we really
need to write some infrastructure to get to the EDID extensions :) They
contain all sort of useful infos, though unfortunately, all of the
panels I've come accross so far didn't seem to implement them =P

Ben.
