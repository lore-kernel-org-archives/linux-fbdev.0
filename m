From: James Simmons <jsimmons@infradead.org>
Subject: Re: [Linux-fbdev-devel] Re: RE: [Dri-devel] Memory
 management of AGP and VRAM
Date: Mon, 10 May 2004 17:16:15 +0100 (BST)
Sender: mesa3d-dev-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0405101714230.4338-100000@phoenix.infradead.org>
References: <20040509164514.17651.qmail@web14922.mail.yahoo.com>
Mime-Version: 1.0
Return-path: <mesa3d-dev-admin@lists.sourceforge.net>
In-Reply-To: <20040509164514.17651.qmail@web14922.mail.yahoo.com>
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
To: Jon Smirl <jonsmirl@yahoo.com>
Cc: Ian Romanick <idr@us.ibm.com>, Egbert Eich <eich@pdx.freedesktop.org>, dri-devel <dri-devel@lists.sourceforge.net>, mesa3d-dev <mesa3d-dev@lists.sourceforge.net>, fb-devel <linux-fbdev-devel@lists.sourceforge.net>


> Also, these is no rule saying a device driver can't have several tables of _init
> register values that can be used to set the mode on a primary monitor at boot. I
> would just like to see all of the code that does DDC decoding and modeline
> computations moved to user space. When you add up that code there is about 40K
> of it in the fbdriver and about 50K in the radeon driver. When the fbdev drivers
> start probing for multiple heads, TV support, etc that code is going to get even
> larger. Since the code is used only rarely (in kernel terms) this code should be
> in user space instead of the driver.
> 
> I've also proposed that if you really, really want to you could do the DDC
> probing the in driver at boot and mark all of the code _init. Then the user
> space code would take over after that. Note that I'm talking about early
> userspace (initrd) timeframe, not normal user space.

DDC probing is still new. I doubt it will be that large in the long run. I 
bet we will see redudency in the drivers that we seperate out. Give me 
time and I can show that it will be minimum code.




-------------------------------------------------------
This SF.Net email is sponsored by Sleepycat Software
Learn developer strategies Cisco, Motorola, Ericsson & Lucent use to 
deliver higher performing products faster, at low TCO.
http://www.sleepycat.com/telcomwpreg.php?From=osdnemail3
