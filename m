From: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: Patch to add mode setting to sysfs
Date: Wed, 16 Feb 2005 20:28:15 -0500
Message-ID: <9e473391050216172841410bb2@mail.gmail.com>
References: <9e4733910502161430ff1dad1@mail.gmail.com>
	 <Pine.LNX.4.56.0502162238570.25965@pentafluge.infradead.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D1aSr-0007VR-TB
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 16 Feb 2005 17:28:21 -0800
Received: from rproxy.gmail.com ([64.233.170.193])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1D1aSq-0003xC-HV
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 16 Feb 2005 17:28:21 -0800
Received: by rproxy.gmail.com with SMTP id z35so130032rne
        for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 16 Feb 2005 17:28:15 -0800 (PST)
In-Reply-To: <Pine.LNX.4.56.0502162238570.25965@pentafluge.infradead.org>
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
To: James Simmons <jsimmons@www.infradead.org>
Cc: fbdev <linux-fbdev-devel@lists.sourceforge.net>

I applied your patch, it makes a new directory,
sys/class/graphics/fb0/modes with two entries dev and name. What is
your mechanism for displaying the list of modes and setting a new one?

Note that you can continue to use class_simple as
class_simple_device_add returns the class_device for the new device.

Give my patch a try, cat 'modes' and you you can see the list of
modes. Echo one to 'mode' and it will set the new mode. The mode set
works without being root.

-- 
Jon Smirl
jonsmirl@gmail.com


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
