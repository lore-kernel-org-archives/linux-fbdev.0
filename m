From: Otto Solares <solca@guug.org>
Subject: Re: Re: [Dri-devel] Re: [Linux-fbdev-devel] Redesign of kernel graphics interface
Date: Mon, 10 May 2004 14:47:42 -0600
Sender: mesa3d-dev-admin@lists.sourceforge.net
Message-ID: <20040510204742.GA12863@guug.org>
References: <Pine.LNX.4.44.0405101708310.4338-100000@phoenix.infradead.org> <20040510182940.14049.qmail@web14924.mail.yahoo.com> <20040510223950.B2268@armor.freesurf.fr>
Mime-Version: 1.0
Return-path: <mesa3d-dev-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <20040510223950.B2268@armor.freesurf.fr>
Errors-To: mesa3d-dev-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/mesa3d-dev>,
	<mailto:mesa3d-dev-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:mesa3d-dev@lists.sourceforge.net>
List-Help: <mailto:mesa3d-dev-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/mesa3d-dev>,
	<mailto:mesa3d-dev-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=mesa3d-dev>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Nicolas Souchu <nsouch@free.fr>
Cc: Jon Smirl <jonsmirl@yahoo.com>, James Simmons <jsimmons@infradead.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, dri-devel <dri-devel@lists.sourceforge.net>, mesa3d-dev <mesa3d-dev@lists.sourceforge.net>, fb-devel <linux-fbdev-devel@lists.sourceforge.net>

On Mon, May 10, 2004 at 10:39:50PM +0000, Nicolas Souchu wrote:
> Do apps manage their swap? No. I think the OS should be responsible for
> placing the data (vertices, textures, commands) at the right/best place
> for the HW 3D engine and the client should only fill virtual memory.

> http://www.freebsd.org/~nsouch/kgi4BSD

Browsing through kgi.sf.net I found that they have proper multihead
and DDC2 support.  They just lack DRI integrated into KGI and it will
rock from my user perspective.

Is true that the BSDs are adopting KGI as their unified kernel
graphics layer?

-otto



-------------------------------------------------------
This SF.Net email is sponsored by Sleepycat Software
Learn developer strategies Cisco, Motorola, Ericsson & Lucent use to 
deliver higher performing products faster, at low TCO.
http://www.sleepycat.com/telcomwpreg.php?From=osdnemail3
