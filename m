From: Thomas Winischhofer <thomas@winischhofer.net>
Subject: Re: Some questions
Date: Wed, 12 Mar 2003 00:12:34 +0100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <3E6E6D62.7090601@winischhofer.net>
References: <Pine.LNX.4.44.0303111628240.23668-100000@phoenix.infradead.org>	<1047407816	 .1013.182.camel@localhost.localdomain> <3E6E4D9A.7060003@winischhofer.net>	<1047419056.1100.26.camel@localhost.localdomain> 	<3E6E62D9.40603@winischhofer.net> <1047423048.1128.140.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from static213-229-38-018.adsl.inode.at ([213.229.38.18] helo=home.winischhofer.net)
	by sc8-sf-list1.sourceforge.net with smtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18ssvy-0000hk-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 11 Mar 2003 15:13:23 -0800
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Antonino Daplas <adaplas@pol.net>
Cc: James Simmons <jsimmons@infradead.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

Antonino Daplas wrote:
> The accel engine is probably not a problem if it uses mmio.  However,
> engines that use command buffers are more susceptible to this if the
> buffers can be dynamically allocated by the process.

OK, ack.

> 
> The i810 for instance uses ringbuffers.  It has to be dynamically
> allocated via agpgart.  Fortunately, the i810 can support 2 ringbuffers,
> so X can use one and fb the other, so there's no conflict. 
> 
> Then you also have DRI joining in the confusion :-)

Not in my case :) The SiS DRI stuff is made in a way to prevent problems 
of this kind. But I ack that it might be on others.

> The best solution, personally, is to have one module controlling chipset
> access -- DRM for 2D and 3D, and fb for video mode switching.

Well. I personally don't want every graphics application to depend on 
kernel modules.

Thomas

-- 
Thomas Winischhofer
Vienna/Austria
mailto:thomas@winischhofer.net          *** http://www.winischhofer.net



-------------------------------------------------------
This SF.net email is sponsored by:Crypto Challenge is now open! 
Get cracking and register here for some mind boggling fun and 
the chance of winning an Apple iPod:
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0031en
