From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Re: still ..Confused about atyfb and M1
Date: Thu, 05 Feb 2004 10:29:27 +1100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1075937366.4029.43.camel@gaston>
References: <Pine.LNX.4.44.0401302147390.22830-100000@phoenix.infradead.org>
	 <401FF39B.7090406@bitworks.com>
	 <Pine.GSO.4.58.0402041003560.20790@waterleaf.sonytel.be>
	 <40210D52.5020009@bitworks.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1AoWTS-0003Vg-Ex
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 04 Feb 2004 15:30:26 -0800
Received: from gate.crashing.org ([63.228.1.57] ident=root)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.30)
	id 1AoWTR-0002UG-Vw
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 04 Feb 2004 15:30:26 -0800
In-Reply-To: <40210D52.5020009@bitworks.com>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: RSmith@bitworks.com
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, James Simmons <jsimmons@infradead.org>, Alexander Kern <alex.kern@gmx.de>, Jon Smirl <jonsmirl@yahoo.com>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Thu, 2004-02-05 at 02:18, Richard Smith wrote:
> Geert Uytterhoeven wrote:
> 
> > Indeed, atyfb needs BIOS (or OpenFirmware) initialization. It has
> > initialization code for RAGE XL, though.
> 
> Does OpenFirmware support exist for the M1?

Some iBooks ship with an M1, those have an OF driver

Ben.



-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
