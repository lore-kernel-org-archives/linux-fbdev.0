From: Kronos <kronos@kronoz.cjb.net>
Subject: Re: Re: [PATCH] Remove voodoo code from i2c
Date: Sat, 6 Mar 2004 16:08:45 +0100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20040306150845.GB901@dreamland.darkstar.lan>
References: <20040306004747.GA3218@dreamland.darkstar.lan> <20040306021016.46831.qmail@web14916.mail.yahoo.com>
Reply-To: kronos@kronoz.cjb.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1AzdeZ-0006vc-VC
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 06 Mar 2004 07:23:51 -0800
Received: from mailr-2.tiscali.it ([212.123.84.82])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.30)
	id 1AzdPm-0002T6-4f
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 06 Mar 2004 07:08:34 -0800
Content-Disposition: inline
In-Reply-To: <20040306021016.46831.qmail@web14916.mail.yahoo.com>
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
To: Jon Smirl <jonsmirl@yahoo.com>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

Il Fri, Mar 05, 2004 at 06:10:16PM -0800, Jon Smirl ha scritto: 
> Can this be written as a generic i2c probe function by calling i2c chanel
> functions instead of directly calling radeon_gpio_setscl, etc? The i2c chanel
> functions will then in turn call radeon_gpio_setscl, etc.

You can't use the i2c layer because you just send empty start-stop
sequencies on the bus, no real data. You must use bit banging functions:

struct i2c_algo_bit_data *bits = adapter->algo_data;

Then you use ->{s,g}et{scl,sda}. Remeber to pass bits->data to those
functions.

Luca
-- 
Home: http://kronoz.cjb.net
"It is more complicated than you think"
                -- The Eighth Networking Truth from RFC 1925


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
