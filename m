From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Re: monochrome display fix.
Date: Tue, 27 Jan 2004 21:19:29 +1100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1075198769.30623.187.camel@gaston>
References: <Pine.LNX.4.44.0401262212140.5445-100000@phoenix.infradead.org>
	 <Pine.LNX.4.58.0401261446560.2313@home.osdl.org>
	 <20040127074035.GF1315@rembrandt.csv.ica.uni-stuttgart.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1AlQMR-00026D-HF
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 27 Jan 2004 02:22:23 -0800
Received: from gate.crashing.org ([63.228.1.57] ident=root)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.30)
	id 1AlQMQ-0004zT-UR
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 27 Jan 2004 02:22:23 -0800
In-Reply-To: <20040127074035.GF1315@rembrandt.csv.ica.uni-stuttgart.de>
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
To: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Cc: Linus Torvalds <torvalds@osdl.org>, James Simmons <jsimmons@infradead.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>


> It was always broken. This went unnoticed, apparently nobody tried to use
> a kernel which supports mono and colour framebuffers at the same time.

Still, the patch is ugly.. I'd rather just calculate the colour
normally, and only conditionally store it once in the end...

Ben.




-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
