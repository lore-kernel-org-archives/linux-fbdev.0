From: Helge Hafting <helgehaf@aitel.hist.no>
Subject: Re: Much better framebuffer fixes.
Date: Thu, 27 Mar 2003 10:33:52 +0100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <3E82C580.1000801@aitel.hist.no>
References: <Pine.LNX.4.44.0303270017180.25001-100000@phoenix.infradead.org> <1048735712.1047.10.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from hermine.idb.hist.no ([158.38.50.15])
	by sc8-sf-list1.sourceforge.net with smtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18yTjQ-000184-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 27 Mar 2003 01:31:32 -0800
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
Cc: James Simmons <jsimmons@infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

Antonino Daplas wrote:
> On Thu, 2003-03-27 at 08:18, James Simmons wrote:
> 
>>Okay. Here are more framebuffer fixes. Please try these fixes and let me 
>>know how they work out for you.
>>
> 
> 
> This is a resend of the patch I previously sent.  I see that you have
> made changes to the logo drawing code targeted for monochrome logo
> drawing to use mono expansion.  You still need a few changes though,
> image->bg_color and image->fg_color must be initialized correctly when
> image->depth == 1.

This applied on top of James Simmons' patch, but didn't compile.
spin_lock_irqsave was "unknown".


Helge Hafting



-------------------------------------------------------
This SF.net email is sponsored by:
The Definitive IT and Networking Event. Be There!
NetWorld+Interop Las Vegas 2003 -- Register today!
http://ads.sourceforge.net/cgi-bin/redirect.pl?keyn0001en
