From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: Re: Rivafb won't work with DVI connector
Date: Sat, 20 Nov 2004 06:08:30 +0800
Message-ID: <200411200608.30821.adaplas@hotpop.com>
References: <200411191137.14649.andrew@walrond.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CVGvw-0002wd-TW
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 19 Nov 2004 14:08:48 -0800
Received: from smtp-out.hotpop.com ([38.113.3.71])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1CVGvt-0005a3-BX
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 19 Nov 2004 14:08:48 -0800
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id 7E98611F4630
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 19 Nov 2004 22:08:30 +0000 (UTC)
In-Reply-To: <200411191137.14649.andrew@walrond.org>
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
To: linux-fbdev-devel@lists.sourceforge.net, Andrew Walrond <andrew@walrond.org>

On Friday 19 November 2004 19:37, Andrew Walrond wrote:
> I have a TFT LCD screen (1600x1200) with both D-Sub and DVI inputs, and a
> NV25 [GeForce4 Ti 4600] with same outputs.
>
> Using the old D-Sub cable works fine:
>
>  rivafb: nVidia device/chipset 10DE0250
>  rivafb: nVidia Corporation NV25 [GeForce4 Ti 4600]
>  rivafb: Detected CRTC controller 0 being used
>  rivafb: RIVA MTRR set to ON
>  rivafb: Found EDID Block from BUS 2
>  rivafb: setting virtual Y resolution to 83886
>  Console: switching to colour frame buffer device 200x75
>  rivafb: PCI nVidia NV25 framebuffer ver 0.9.5b (128MB @ 0xE0000000)
>
> but with the DVI cable (dsub disconnected) I get a blank screen as soon as
> rivafb takes over:
>
>  rivafb: nVidia device/chipset 10DE0250
>  rivafb: nVidia Corporation NV25 [GeForce4 Ti 4600]
>  rivafb: Detected CRTC controller 0 being used
>  rivafb: RIVA MTRR set to ON
>  rivafb: Found EDID Block from BUS 3
>  EDID checksum failed, aborting
>  rivafb: setting virtual Y resolution to 209715
>  Console: switching to colour frame buffer device 80x30
>  rivafb: PCI nVidia NV25 framebuffer ver 0.9.5b (128MB @ 0xE0000000)
>
> I then have to plug the d-sub back in to see the output.
> [side note: 2.6.8.1 shows only garbage on reconnecting dsub, so rc2 is an
> improvement.]
>
> No I don't understand the lingo here, but I assume EDID/BUS2/BUS3 and the
> checksum failure are the bits I'm interested in here.

You can try the following:

1. turn on verbose debug output in drivers/video/fbmon.c

2. Try just grabbing the EDID from BUS2, since the EDID checksum failed from
BUS3.

3. if you can, send me your EDID block.  You can use the utility 'read-edid'. 

Tony




-------------------------------------------------------
This SF.Net email is sponsored by: InterSystems CACHE
FREE OODBMS DOWNLOAD - A multidimensional database that combines
robust object and relational technologies, making it a perfect match
for Java, C++,COM, XML, ODBC and JDBC. www.intersystems.com/match8
