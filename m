From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [Dri-devel] Re: [Linux-fbdev-devel] Redesign of kernel
 graphics interface
Date: Mon, 10 May 2004 20:33:11 +0100
Sender: mesa3d-dev-admin@lists.sourceforge.net
Message-ID: <1084217590.24759.10.camel@localhost.localdomain>
References: <Pine.LNX.4.44.0405101708310.4338-100000@phoenix.infradead.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <mesa3d-dev-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.44.0405101708310.4338-100000@phoenix.infradead.org>
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
To: James Simmons <jsimmons@infradead.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Nicolas Souchu <nsouch@free.fr>, Jon Smirl <jonsmirl@yahoo.com>, DRI Devel <dri-devel@lists.sourceforge.net>, mesa3d-dev <mesa3d-dev@lists.sourceforge.net>, fb-devel <linux-fbdev-devel@lists.sourceforge.net>

On Llu, 2004-05-10 at 17:14, James Simmons wrote:
> Speaking of bloat in the kernel. When will the crypto and TCP/IP stack be 
> moved to userspace. The networking code alone is over 17 megs in size. 

Not on my box. Nothing like it. Although to answer that question with a
definitive example ELKS (a Linux like 8086 kernel in 64K) has IP demux
in kernel space and tcp in user space. The v7 NCP stack also had much of
the protocol in user space.

So its a perfectly valid argument to build such hybrid systems for
display management too



-------------------------------------------------------
This SF.Net email is sponsored by Sleepycat Software
Learn developer strategies Cisco, Motorola, Ericsson & Lucent use to 
deliver higher performing products faster, at low TCO.
http://www.sleepycat.com/telcomwpreg.php?From=osdnemail3
