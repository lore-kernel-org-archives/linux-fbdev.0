From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: Re: Patch to add mode setting to sysfs
Date: Thu, 17 Feb 2005 21:50:16 +0800
Message-ID: <200502172150.16256.adaplas@hotpop.com>
References: <9e4733910502161430ff1dad1@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D1m37-00049T-FH
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 17 Feb 2005 05:50:33 -0800
Received: from smtp-out.hotpop.com ([38.113.3.61])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1D1m36-0000Ov-SZ
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 17 Feb 2005 05:50:33 -0800
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id 841FEDF7DA1
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 17 Feb 2005 13:50:24 +0000 (UTC)
In-Reply-To: <9e4733910502161430ff1dad1@mail.gmail.com>
Content-Disposition: inline
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
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
To: linux-fbdev-devel@lists.sourceforge.net, Jon Smirl <jonsmirl@gmail.com>

On Thursday 17 February 2005 06:30, Jon Smirl wrote:
> This is a first pass at adding two new sysfs attributes to
> /sys/class/graphics/fb0 for setting modes. There are two attributes:
> modes which contains a list of valid modes, and mode which is the
> current mode. To switch modes echo one of the entries from the modes
> list to the mode attribute.
> The D,V,S on the modes represents Detailed, Vesa, Standard from the DDC
> info.
>
> modes is root writable. It can also be used to set the list of modes.
> For example a /etc file could add modes that are not in the monitor's
> DDC.
>
> mode is user writable. PAM would set ownership of mode at user login
> time. This provides a safe way  for a user to set the mode without
> being root. You can only set the mode to one of the modes on the list.
>
> If this code looks good I'll do another pass that adds some more
> features and makes it more robust.

Looks very interesting, and I will try it soon.  A few comments:

+                       fb_videomode_to_var(&var, mode);
+                       var.activate |= FB_ACTIVATE_FORCE;
+                       var.bits_per_pixel = 32;

Instead of hardcoding some of the fields in var, why not
copy it from the current var?  Ie:

var = info->var;
fb_videomode_to_var(&var, mode);

Tony




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
