From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH 01/10] fbdev: Clean up of sparc FB
	options
Date: Wed, 16 May 2007 17:42:40 -0700 (PDT)
Message-ID: <20070516.174240.62344054.davem@davemloft.net>
References: <1179360635.28568.0.camel@daplas>
	<20070516.171526.08322463.davem@davemloft.net>
	<1179362181.28568.4.camel@daplas>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HoU4g-00075y-Ao for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 16 May 2007 17:42:34 -0700
Received: from [74.93.104.97] (helo=sunset.davemloft.net)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HoU4g-00043S-4x
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 16 May 2007 17:42:34 -0700
In-Reply-To: <1179362181.28568.4.camel@daplas>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: adaplas@gmail.com
Cc: akpm@osdl.org, linux-fbdev-devel@lists.sourceforge.net

From: "Antonino A. Daplas" <adaplas@gmail.com>
Date: Thu, 17 May 2007 08:36:21 +0800

> On Wed, 2007-05-16 at 17:15 -0700, David Miller wrote:
> > Excellent.
> > 
> > The only missing piece for sparc is how do I get from an fb_info to
> > the firmware node for that device.  What we can do is add a "struct
> > device_node *" or similar to fb_info.  powerpc and all future
> > openfirmware platforms will be able to make use of this as well.
> 
> struct fb_info already has struct device *device field.  Isn't that
> sufficient enough?  Or if you must, just define a flag somewhere in
> struct fb_info or struct par which the fb_get_primary_device() can
> check.

Indeed, struct device is sufficient, I store the info I need
in the struct dev_archdata.

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
