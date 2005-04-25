From: Jon Smirl <jonsmirl@gmail.com>
Subject: Monitor failing mode validation in fb_validate_mode()
Date: Mon, 25 Apr 2005 13:03:42 -0400
Message-ID: <9e4733910504251003da4d47e@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DQ6zv-0003CT-9F
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 25 Apr 2005 10:03:51 -0700
Received: from wproxy.gmail.com ([64.233.184.204])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1DQ6zt-0002a9-TW
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 25 Apr 2005 10:03:51 -0700
Received: by wproxy.gmail.com with SMTP id 69so1306853wri
        for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 25 Apr 2005 10:03:42 -0700 (PDT)
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
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, fbdev <linux-fbdev-devel@lists.sourceforge.net>

I have a monitor that in DDC reports that it supports:
VESA 1024x768-75

The timing from modesdb.c
=09/* 15 1024x768-75 VESA */
=09{ NULL, 75, 1024, 768, 12690, 176, 16, 28, 1, 96, 3,

Now multiply out the bandwidth:
1000000000/12690*1000 / (1024 +176 + 16 + 96)
gives
60.062 KHz

From DDC the monitor also reports it's bandwidth:
      Monitor Operating Limits: From EDID
           H: 30-60KHz V: 50-75Hz DCLK: 80MHz

fb_validate_mode() then fails to validate this mode because
60.062Khz is greater than 60KHz

I checked and this isn't a round off problem. For the bandwidth to
multiply out to below 60KHz the dot clock would need to be 12704
instead of 12690.

What is the right fix for this? Maybe truncate (or round) hfreq to the
nearest KHz before doing the bandwidth comparison in the bottom of
fb_validate_mode()?

The dot clock is still well withing range, 78802000 dclkmax 80000000,
only the horizontal frequency is a little bit out. Dot clock is
probably the hard limit and shouldn't be adjusted.

--=20
Jon Smirl
jonsmirl@gmail.com


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
