From: Dave Kavanagh <dumuzix@gmail.com>
Subject: intelfb does not work with i915
Date: Wed, 20 Jul 2005 14:25:59 -0300
Message-ID: <6d86e88105072010252790b42d@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DvIL4-0005ZA-9l
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 20 Jul 2005 10:26:34 -0700
Received: from wproxy.gmail.com ([64.233.184.192])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.44)
	id 1DvIL4-0003Dn-2T
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 20 Jul 2005 10:26:34 -0700
Received: by wproxy.gmail.com with SMTP id i3so1613969wra
        for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 20 Jul 2005 10:26:27 -0700 (PDT)
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
To: linux-fbdev-devel@lists.sourceforge.net

I have been having no luck getting the intelfb driver working
with an i915 chipset. I've been searching and reading message
boards and mail lists for days and haven't found anything.
It seems that the driver is not setting the proper video timings.

I have tried using the vesafb driver and my hardware works fine.

If I try to use the intelfb driver my monitor either complains
and shuts off or I get text and graphics that is horizontally
squiggly (if that makes sense).

I tried initializing the driver in several modes with parameters
such as:

      video=3Dintelfb
      video=3Dintelfb:640x480-16@60


fbset -i reports the following:

mode "1024x768-70"
    # D: 75.002 MHz, H: 56.477 kHz, V: 70.071 Hz
    geometry 1024 768 1024 768 32
    timings 13333 144 24 29 3 136 6
    accel true
    rgba 8/16,8/8,8/0,0/0
endmode

Frame buffer device information:
    Name        : Intel(R) 915G
    Address     : 0xd0000000
    Size        : 8253440
    Type        : PACKED PIXELS
    Visual      : TRUECOLOR
    XPanStep    : 8
    YPanStep    : 1
    YWrapStep   : 0
    LineLength  : 4096
    MMIO Address: 0xcfd80000
    MMIO Size   : 524288
    Accelerator : Unknown (42)


I am using kernel 2.6.12. Any help or ideas would be appreciated.

Thanks,
Dave Kavanagh


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
