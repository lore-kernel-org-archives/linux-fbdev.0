From: Kronos <kronos@people.it>
Subject: Re: Framebuffer drivers in kernel 2.6.x
Date: Wed, 18 Aug 2004 22:35:09 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20040818203509.GA25325@dreamland.darkstar.lan>
References: <412238E7.C4A7ED2D@orpatec.ch> <20040818053646.GC16935@lug-owl.de> <4123B35C.64E07B02@orpatec.ch>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BxX9S-0001ar-M1
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 18 Aug 2004 13:35:18 -0700
Received: from mail-relay-4.tiscali.it ([213.205.33.44])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.34)
	id 1BxX9R-0001Ud-KX
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 18 Aug 2004 13:35:18 -0700
Content-Disposition: inline
In-Reply-To: <4123B35C.64E07B02@orpatec.ch>
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
Content-Transfer-Encoding: 7bit
To: Otto Wyss <otto.wyss@orpatec.ch>
Cc: 'linux-fbdev-devel' <linux-fbdev-devel@lists.sourceforge.net>

Il Wed, Aug 18, 2004 at 09:51:56PM +0200, Otto Wyss ha scritto: 
> *This message was transferred with a trial version of CommuniGate(tm) Pro*
> Jan-Benedict Glaw wrote:
> > 
> > On Tue, 2004-08-17 18:57:10 +0200, Otto Wyss <otto.wyss@orpatec.ch>
> > 
> > The API changed, but it isn't too hard to port old-style drivers to the
> > new API. If this hasn't happened yet, it's just because nobody yet
> > really missed that particular driver. However, there are a lot of
> > drivers available...
> > 
> I miss radeonfb :-(

radeonfb also exists in 2.6. I know for sure since I wrote a small part
of it :)

You must say y to "Support for frame buffer devices", under "Graphics
support" to see supported framebuffer drivers.

Luca
-- 
Home: http://kronoz.cjb.net
"Su cio` di cui non si puo` parlare e` bene tacere".
 Ludwig Wittgenstein


-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
