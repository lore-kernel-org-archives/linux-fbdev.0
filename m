From: Antonino Daplas <adaplas@pol.net>
Subject: Re: Some questions
Date: 12 Mar 2003 06:51:53 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1047423048.1128.140.camel@localhost.localdomain>
References: <Pine.LNX.4.44.0303111628240.23668-100000@phoenix.infradead.org>	<1047407816
	 .1013.182.camel@localhost.localdomain> <3E6E4D9A.7060003@winischhofer.net>
	<1047419056.1100.26.camel@localhost.localdomain> 
	<3E6E62D9.40603@winischhofer.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from pine.compass.com.ph ([202.70.96.37])
	by sc8-sf-list1.sourceforge.net with smtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18sse6-00014e-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 11 Mar 2003 14:54:55 -0800
In-Reply-To: <3E6E62D9.40603@winischhofer.net>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: Thomas Winischhofer <thomas@winischhofer.net>
Cc: James Simmons <jsimmons@infradead.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Wed, 2003-03-12 at 06:27, Thomas Winischhofer wrote:
> Antonino Daplas wrote:
> > Unfortunately, this is what we are trying to prevent.  X assumes that
> > the console is in text mode, so only registers that affect text mode are
> > restored.  Frequently, cursor registers and bitmaps, as an example, are
> > not refreshed.  There's probably more, ie accel engine, etc.
> 
> Argh.. of course, cursor and accelerator registers are usually not 
> restored, you're right at this. But the drivers usually leave the engine 
> in the same state as when started. (A "restore" of accelerator engine 
> registers is mostly impossible, because a complete restore would cause 
> the last command to be executed again)
> 

The accel engine is probably not a problem if it uses mmio.  However,
engines that use command buffers are more susceptible to this if the
buffers can be dynamically allocated by the process.

The i810 for instance uses ringbuffers.  It has to be dynamically
allocated via agpgart.  Fortunately, the i810 can support 2 ringbuffers,
so X can use one and fb the other, so there's no conflict. 

Then you also have DRI joining in the confusion :-)

The best solution, personally, is to have one module controlling chipset
access -- DRM for 2D and 3D, and fb for video mode switching.

Tony



-------------------------------------------------------
This SF.net email is sponsored by:Crypto Challenge is now open! 
Get cracking and register here for some mind boggling fun and 
the chance of winning an Apple iPod:
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0031en
