From: James Simmons <jsimmons@infradead.org>
Subject: Re: Framebuffer updates.
Date: Wed, 26 Mar 2003 20:08:49 +0000 (GMT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0303262007550.21188-100000@phoenix.infradead.org>
References: <1048684571.10476.40.camel@zion.wanadoo.fr>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from phoenix.mvhi.com ([195.224.96.167] helo=phoenix.infradead.org)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 18yHDB-00064L-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 26 Mar 2003 12:09:26 -0800
In-Reply-To: <1048684571.10476.40.camel@zion.wanadoo.fr>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Florin Iucha <florin@iucha.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>


> On Tue, 2003-03-25 at 21:50, James Simmons wrote:
> 
> > Try using stty. I see most people will continue to use fbset so I guess I 
> > need to patch it up to do the right thing.
> 
> Well, I don't like the fbdev magially picking modes like this,
> those modes may just not be supported by the display. At least,
> fbset allows me to setup the proper timings for 'special'
> displays like iMac fixed hoziontal frequency for example.
> 
> Ultimately, we really need a "monitor" driver on top of the
> fbdev that does DDC/EDID when the low level fbdev can provide
> an i2c bus or EDID information via some different way and
> that can be tweaked to deal with special monitors when we
> know we are using these.

fbmon.c :-) 

The code should work for PPC and I seen a patch for generic ix86 support. 
No DDC stuff yet tho.




-------------------------------------------------------
This SF.net email is sponsored by:
The Definitive IT and Networking Event. Be There!
NetWorld+Interop Las Vegas 2003 -- Register today!
http://ads.sourceforge.net/cgi-bin/redirect.pl?keyn0001en
