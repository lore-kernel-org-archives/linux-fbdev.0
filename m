From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Why moving driver includes ?
Date: 28 Mar 2003 14:18:44 +0100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1048857524.12125.2.camel@zion.wanadoo.fr>
References: <Pine.LNX.4.44.0303280443170.11648-100000@phoenix.infradead.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from griffon.mipsys.com ([217.167.51.129] helo=zion.wanadoo.fr)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18ytks-0006Q4-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 28 Mar 2003 05:18:46 -0800
In-Reply-To: <Pine.LNX.4.44.0303280443170.11648-100000@phoenix.infradead.org>
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
To: James Simmons <jsimmons@infradead.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

Hi James !

Why did you move the driver includes to include/video ? What is 
the reasoning here ?

For example, drivers/video/radeon.h moved to include/video/radeon.h

Is this to be able to share register definitions with the DRM drivers ?
(I doubt this will ever happen as the DRM is rather self contained)

I would have preferred those includes to stay next to their respective
drivers (though renaming radeon.h to radeonfb.h might have made some
sense).

Regards,
Ben.



-------------------------------------------------------
This SF.net email is sponsored by:
The Definitive IT and Networking Event. Be There!
NetWorld+Interop Las Vegas 2003 -- Register today!
http://ads.sourceforge.net/cgi-bin/redirect.pl?keyn0001en
