From: Kronos <kronos@kronoz.cjb.net>
Subject: Re: Re: [RADEON] Connector type
Date: Fri, 29 Aug 2003 17:14:28 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20030829151428.GA1534@dreamland.darkstar.lan>
References: <20030828162025.GA7317@dreamland.darkstar.lan> <1062090156.612.144.camel@gaston> <1062113236.14324.46.camel@thor.holligenstrasse29.lan>
Reply-To: kronos@kronoz.cjb.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19skyO-0001Du-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 29 Aug 2003 08:15:36 -0700
Received: from mail-1.tiscali.it ([195.130.225.147])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 19skyM-0003Jv-UY
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 29 Aug 2003 08:15:35 -0700
Content-Disposition: inline
In-Reply-To: <1062113236.14324.46.camel@thor.holligenstrasse29.lan>
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
Content-Transfer-Encoding: 7bit
To: michel@daenzer.net
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Jon Smirl <jonsmirl@yahoo.com>

Il Fri, Aug 29, 2003 at 01:27:16AM +0200, Michel D?nzer ha scritto: 
> On Thu, 2003-08-28 at 19:02, Benjamin Herrenschmidt wrote:
> > On Thu, 2003-08-28 at 18:20, Kronos wrote:
> > > Hi,
> > > currently DDCReg in  radeonfb is hardcoded to CRT  port (secondary port,
> > > primary DAC).
> > > 
> > > I've working code to detect connector type. On my board it finds the CRT
> > > port  and  DVI  port. The  latter is  ignored  because  dviDisp_type  is
> > > MT_NONE. If crtDisp_type is MT_NONE then it will use the DVI port.
> 
> BTW, do you do this the same way as or differently than the XFree86
> driver?

Same way. If both port are in use DVI is considered primary and VGA
secondary.

Luca
-- 
Reply-To: kronos@kronoz.cjb.net
Home: http://kronoz.cjb.net
Io mi ricordo sempre il compleanno della mia ragazza:
cade il giorno dopo di quando lei me lo ricorda


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
