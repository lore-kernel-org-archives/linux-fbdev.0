From: James Simmons <jsimmons@infradead.org>
Subject: Re: [Linux-fbdev-devel] Re: RE: [Dri-devel] Memory
 management of AGP and VRAM
Date: Tue, 11 May 2004 19:48:50 +0100 (BST)
Sender: mesa3d-dev-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0405111942080.17349-100000@phoenix.infradead.org>
References: <16545.1085.173860.37370@xf11.fra.suse.de>
Mime-Version: 1.0
Return-path: <mesa3d-dev-admin@lists.sourceforge.net>
In-Reply-To: <16545.1085.173860.37370@xf11.fra.suse.de>
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
To: Egbert Eich <eich@pdx.freedesktop.org>
Cc: Jon Smirl <jonsmirl@yahoo.com>, Ian Romanick <idr@us.ibm.com>, dri-devel <dri-devel@lists.sourceforge.net>, mesa3d-dev <mesa3d-dev@lists.sourceforge.net>, fb-devel <linux-fbdev-devel@lists.sourceforge.net>


> I'm not speaking about a text mode. 
> I would think on most systems the firmware would provide some reasonable
> initial mode that the kernel can use. If there is no such firmware one 
> would expect there is some preboot software that is used to bootstrap the
> kernel that could do such a setup - using a number of fixed modes hard
> coded in tables. (It is a pain to debug, though).

   You haven't done to work much with embedded hardware. So instead of one 
graphics driver initailzing the hardware for every platform we need to 
force all the embedded companies out there to add code to there boot 
setups to initialize the different possible graphics cards out there. 
That is alot of duplicated work for nothing.



-------------------------------------------------------
This SF.Net email is sponsored by Sleepycat Software
Learn developer strategies Cisco, Motorola, Ericsson & Lucent use to 
deliver higher performing products faster, at low TCO.
http://www.sleepycat.com/telcomwpreg.php?From=osdnemail3
