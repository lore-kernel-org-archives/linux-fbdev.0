From: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: [Linux-fbdev-devel] Re: radeon, apertures & memory mapping
Date: Sun, 13 Mar 2005 12:56:26 -0500
Message-ID: <9e4733910503130956401e1107@mail.gmail.com>
References: <1110677744.19810.80.camel@gaston> <20050313082216.GA7362@sci.fi>
	 <1110705646.14684.126.camel@gaston> <20050313103936.GA11002@sci.fi>
	 <1110715499.14684.132.camel@gaston>
	 <9e473391050313081937cde207@mail.gmail.com>
	 <20050313174714.GA15871@sci.fi>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20050313174714.GA15871@sci.fi>
Sender: dri-devel-admin@lists.sourceforge.net
Errors-To: dri-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/dri-devel>,
	<mailto:dri-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:dri-devel@lists.sourceforge.net>
List-Help: <mailto:dri-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/dri-devel>,
	<mailto:dri-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=dri-devel>
Content-Type: text/plain; charset="iso-8859-1"
To: linux-fbdev-devel@lists.sourceforge.net, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Jon Smirl <jonsmirl@yahoo.com>, dri-devel@lists.sourceforge.net, xorg@lists.freedesktop.org

On Sun, 13 Mar 2005 19:47:14 +0200, Ville Syrj=E4l=E4 <syrjala@sci.fi> wrot=
e:
> I don't understand why we have "GART memory" anyway. It's just main memor=
y
> and I don't see any point going through the GART to access it with the
> CPU. Only the graphics card needs to use the GART.

I see no need to for the CPU to go through the GART either. The main
CPU page tables can provide the same rearranging that the GART does.

We do need specially marked GART memory because of caching issues. If
the CPU writes to GART RAM the write may still be on the CPU chip in a
cache. We have to make sure it gets pushed into physical memory so
that the GPU can see it.

The best model would be to chuck the AGP/PCI Express interface on the
board and have a hyperchannel instead. Hyperchannel provides full
cache consistency without all of these flushing problems. The GPU
really is another specialized CPU, give it a CPU class memory
interface.

--=20
Jon Smirl
jonsmirl@gmail.com


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
--
