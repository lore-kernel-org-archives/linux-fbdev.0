From: James Simmons <jsimmons@infradead.org>
Subject: Re: Re: [Dri-devel] Re: [Linux-fbdev-devel] Redesign
 of kernel graphics interface
Date: Tue, 11 May 2004 00:58:42 +0100 (BST)
Sender: mesa3d-dev-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0405110057000.8016-100000@phoenix.infradead.org>
References: <20040510204742.GA12863@guug.org>
Mime-Version: 1.0
Return-path: <mesa3d-dev-admin@lists.sourceforge.net>
In-Reply-To: <20040510204742.GA12863@guug.org>
Errors-To: mesa3d-dev-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/mesa3d-dev>,
	<mailto:mesa3d-dev-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:mesa3d-dev@lists.sourceforge.net>
List-Help: <mailto:mesa3d-dev-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/mesa3d-dev>,
	<mailto:mesa3d-dev-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=mesa3d-dev>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Otto Solares <solca@guug.org>
Cc: Nicolas Souchu <nsouch@free.fr>, Jon Smirl <jonsmirl@yahoo.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, dri-devel <dri-devel@lists.sourceforge.net>, mesa3d-dev <mesa3d-dev@lists.sourceforge.net>, fb-devel <linux-fbdev-devel@lists.sourceforge.net>


> On Mon, May 10, 2004 at 10:39:50PM +0000, Nicolas Souchu wrote:
> > Do apps manage their swap? No. I think the OS should be responsible for
> > placing the data (vertices, textures, commands) at the right/best place
> > for the HW 3D engine and the client should only fill virtual memory.
> 
> > http://www.freebsd.org/~nsouch/kgi4BSD
> 
> Browsing through kgi.sf.net I found that they have proper multihead
> and DDC2 support.  They just lack DRI integrated into KGI and it will
> rock from my user perspective.
> 
> Is true that the BSDs are adopting KGI as their unified kernel
> graphics layer?

It looks like BSD is heading in the right direction. If this lame idea of 
a userland library goes threw I wil quite fbdev developement and go over 
to BSD then. Either that or fork the tree and start my company with my 
work.




-------------------------------------------------------
This SF.Net email is sponsored by Sleepycat Software
Learn developer strategies Cisco, Motorola, Ericsson & Lucent use to 
deliver higher performing products faster, at low TCO.
http://www.sleepycat.com/telcomwpreg.php?From=osdnemail3
