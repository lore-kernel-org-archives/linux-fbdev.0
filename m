From: Petr Vandrovec <vandrove@vc.cvut.cz>
Subject: Re: Mixing g400 dualhead and old Millennium.
Date: Sun, 13 Oct 2002 02:13:24 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20021013001324.GF4267@ppc.vc.cvut.cz>
References: <20021012153641.GA13798@casa.fluido.as>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from panoramix.vasoftware.com ([198.186.202.147])
	by usw-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 180WQh-0000ge-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Sat, 12 Oct 2002 17:16:23 -0700
Received: from p0041.as-l042.contactel.cz ([194.108.237.41]:32797 helo=ppc.vc.cvut.cz)
	by panoramix.vasoftware.com with esmtp (Exim 4.05-VA-mm1 #1 (Debian))
	id 180WQX-0006Tg-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Sat, 12 Oct 2002 17:16:15 -0700
Content-Disposition: inline
In-Reply-To: <20021012153641.GA13798@casa.fluido.as>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Carlo E. Prelz" <fluido@fluido.as>
Cc: linux-fbdev-devel@lists.sourceforge.net

On Sat, Oct 12, 2002 at 05:36:41PM +0200, Carlo E. Prelz wrote:
> Hello. I am trying to obtain a 'simple' system where 3 framebuffers
> output their images to three monitors (no TV output). In the past I
> was able to have 4 outputs using 4 old millenniums. Now I have to help
> a friend who lives 1000 kms from here, and who hasn't enough PCI slots
> (and would not find 3 millenniums anyway...) So, he found a dualhead
> AGP g400 (PCI ID 102b:0525) and an old Millennium (PCI ID 102b:0519,
> MGA 2064W).
> 
> Using kernel 2.4.19, and loading kernel modules in this order:
> 
> i2c-matroxfb
> matroxfb_base
> matroxfb_crtc2

If it is G400, you must also insmod matroxfb_maven, otherwise
there is no second output. And you should build everything
into kernel, not as a modules - you'll not have problem to find
where secondary output lives then...
 
> In all cases, it appears (when looking at the source of the driver)
> that the second head cannot be assigned this value, so that
> MATROXFB_GET_AVAILABLE_OUTPUTS is 0 for it. I can assign it to the
> first head, as follows
> 
> /usr/src/matroxset/matroxset -f /dev/fb2 -m 0
> /usr/src/matroxset/matroxset -f /dev/fb1 -m 4
> 
> but after that, too, MATROXFB_GET_AVAILABLE_OUTPUTS for the second
> head is 0. Or I can assign 1 to the second head, but then I cannot
> assign 4 to the first head, although it is allowed in
> MATROXFB_GET_AVAILABLE_OUTPUTS, because I can only assign a value to

Digital output and secondary output use same pins on G400, so you have
either one or another. On G450/G550 all three outputs are completely
independent, with proper cabling you can connect three monitors
to your Gx50 (of course, two of them will have same picture, but
it is enough if you are doing some presentations).
							Petr Vandrovec
					


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
