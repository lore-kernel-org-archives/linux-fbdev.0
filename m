From: Andrew Walrond <andrew@walrond.org>
Subject: Re: Rivafb won't work with DVI connector
Date: Sat, 20 Nov 2004 15:52:53 +0000
Message-ID: <200411201552.53919.andrew@walrond.org>
References: <200411191137.14649.andrew@walrond.org> <200411200608.30821.adaplas@hotpop.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_Vh2nB2wDVwX1XXq"
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CVXXn-0004je-P1
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 20 Nov 2004 07:52:59 -0800
Received: from [62.24.231.113] (helo=cenedra.walrond.org)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41)
	id 1CVXXl-0001a8-Ve
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 20 Nov 2004 07:52:59 -0800
Received: from [62.24.231.115] (helo=orac.walrond.org)
	by cenedra.walrond.org with esmtp (Exim 4.34)
	id 1CVXXi-0004SZ-63
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 20 Nov 2004 15:52:54 +0000
In-Reply-To: <200411200608.30821.adaplas@hotpop.com>
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
To: linux-fbdev-devel@lists.sourceforge.net

--Boundary-00=_Vh2nB2wDVwX1XXq
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Friday 19 Nov 2004 22:08, Antonino A. Daplas wrote:
> On Friday 19 November 2004 19:37, Andrew Walrond wrote:
> > I have a TFT LCD screen (1600x1200) with both D-Sub and DVI inputs, and a
> > NV25 [GeForce4 Ti 4600] with same outputs.
> >
> > Using the old D-Sub cable works fine:
> >
> >  rivafb: nVidia device/chipset 10DE0250
> >  rivafb: nVidia Corporation NV25 [GeForce4 Ti 4600]
> >  rivafb: Detected CRTC controller 0 being used
> >  rivafb: RIVA MTRR set to ON
> >  rivafb: Found EDID Block from BUS 2
> >  rivafb: setting virtual Y resolution to 83886
> >  Console: switching to colour frame buffer device 200x75
> >  rivafb: PCI nVidia NV25 framebuffer ver 0.9.5b (128MB @ 0xE0000000)
> >
> > but with the DVI cable (dsub disconnected) I get a blank screen as soon
> > as rivafb takes over:
> >
> >  rivafb: nVidia device/chipset 10DE0250
> >  rivafb: nVidia Corporation NV25 [GeForce4 Ti 4600]
> >  rivafb: Detected CRTC controller 0 being used
> >  rivafb: RIVA MTRR set to ON
> >  rivafb: Found EDID Block from BUS 3
> >  EDID checksum failed, aborting
> >  rivafb: setting virtual Y resolution to 209715
> >  Console: switching to colour frame buffer device 80x30
> >  rivafb: PCI nVidia NV25 framebuffer ver 0.9.5b (128MB @ 0xE0000000)
> >
> > I then have to plug the d-sub back in to see the output.
> > [side note: 2.6.8.1 shows only garbage on reconnecting dsub, so rc2 is an
> > improvement.]
> >
> > No I don't understand the lingo here, but I assume EDID/BUS2/BUS3 and the
> > checksum failure are the bits I'm interested in here.
>
> You can try the following:
>
> 1. turn on verbose debug output in drivers/video/fbmon.c

Done; but nothing gets displayed when checksum fails. Displays lots of nice 
stuff with dsub connection though :)
>
> 2. Try just grabbing the EDID from BUS2, since the EDID checksum failed
> from BUS3.

Ok - I modified riva_get_EDID_i2c to probe only BUS 2, but the checksum still 
fails unless the dsub is (also) connected. Infact, I hard coded each bus, 1-3 
in turn. With just DVI connected, the returned EDID failed the checksum for 
all three buses. With the Dsub connected, I got valid EDID's on BUS 1 and 2, 
and a message saying none was available on BUS 3.

I cannot get a DVI display, whatever I try. I have also tried various 
combinations of video:rivafb:forceCRTC=0/1 and video:rivafb:flatpanel, all to 
no effect (flatpanel gives me a corrupt dsub display)

>
> 3. if you can, send me your EDID block.  You can use the utility
> 'read-edid'.

EDID attached. Parsed output:

./read-edid-1.4.1/parse-edid: parse-edid version 1.4.1
./read-edid-1.4.1/parse-edid: EDID checksum passed.

        # EDID version 1 revision 3
Section "Monitor"
        # Block type: 2:0 3:fd
        # Block type: 2:0 3:fc
        Identifier "iiyama "
        VendorName "IVM"
        ModelName "iiyama "
        # Block type: 2:0 3:fd
        HorizSync 30-80
        VertRefresh 56-85
        # Max dot clock (video bandwidth) 170 MHz
        # Block type: 2:0 3:fc
        # DPMS capabilities: Active off:yes  Suspend:yes  Standby:yes

        Mode    "1024x768"      # vfreq 59.196Hz, hfreq 48.363kHz
                DotClock        65.000000
                HTimings        1024 1040 1104 1344
                VTimings        768 781 783 817
                Flags   "-HSync" "-VSync"
        EndMode
        Mode    "1600x1200"     # vfreq 60.000Hz, hfreq 75.000kHz
                DotClock        162.000000
                HTimings        1600 1664 1856 2160
                VTimings        1200 1201 1204 1250
                Flags   "+HSync" "+VSync"
        EndMode
        # Block type: 2:0 3:fd
        # Block type: 2:0 3:fc
EndSection

--Boundary-00=_Vh2nB2wDVwX1XXq
Content-Type: application/octet-stream;
  name="edid.dsub.32"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="edid.dsub.32"

AP///////wAmzQBI6QMAAAEMAQOBJx146orDnldHmSMXSky/74CBgGGZRZkxmQEBAQEBAQEBZBkA
QEEAMTAQQNIAgiIRAAAYSD9AMGKwMkBAwBMAgiIRAAAeAAAA/QA4VR5QEQAKICAgICAgAAAA/ABp
aXlhbWEgCiAgICAgABo=

--Boundary-00=_Vh2nB2wDVwX1XXq--


-------------------------------------------------------
This SF.Net email is sponsored by: InterSystems CACHE
FREE OODBMS DOWNLOAD - A multidimensional database that combines
robust object and relational technologies, making it a perfect match
for Java, C++,COM, XML, ODBC and JDBC. www.intersystems.com/match8
