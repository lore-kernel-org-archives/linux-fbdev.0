From: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
Subject: Re: [PATCH] 0/3 Add I2C/DDC support to
	radeonfb (resend)
Date: Mon, 25 Aug 2003 12:22:56 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1061806975.17152.98.camel@thor.holligenstrasse29.lan>
References: <20030822170905.GA5757@dreamland.darkstar.lan>
	 <1061595832.1259.41.camel@thor.holligenstrasse29.lan>
	 <20030825094032.GA3327@iliana>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from [195.141.226.27] (helo=netline-mail1.netline.ch)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 19rEVC-0002CV-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 25 Aug 2003 03:23:10 -0700
In-Reply-To: <20030825094032.GA3327@iliana>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="utf-8"
To: Sven Luther <sven.luther@wanadoo.fr>
Cc: linux-fbdev-devel@lists.sourceforge.net

On Mon, 2003-08-25 at 11:40, Sven Luther wrote:
> On Sat, Aug 23, 2003 at 01:43:53AM +0200, Michel Dänzer wrote:
> > 
> > BTW, regarding the EDID discussion, I'm not sure that a list of modes
> > will cut it - e.g., the EDID of the panel in this TiBook only contains
> > the native mode, but the chip can scale up pretty much any lower
> > resolution.
> 
> Which is a good thing, compared to my sony SDM-X52, which in digital
> mode only supports the native resolution, but the EDID erroneously
> reports the mode supported by the digital connection in both case.

I'd think the driver was supposed to handle this.


-- 
Earthling Michel Dänzer   \  Debian (powerpc), XFree86 and DRI developer
Software libre enthusiast  \     http://svcs.affero.net/rm.php?r=daenzer



-------------------------------------------------------
This SF.net email is sponsored by: VM Ware
With VMware you can run multiple operating systems on a single machine.
WITHOUT REBOOTING! Mix Linux / Windows / Novell virtual machines
at the same time. Free trial click here:http://www.vmware.com/wl/offer/358/0
