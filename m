From: Antonino Daplas <adaplas@pol.net>
Subject: Re: [ANNOUNCE]: VM86 Daemon
Date: 01 Apr 2003 17:41:10 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1049189944.1009.61.camel@localhost.localdomain>
References: <1049104351.1037.53.camel@localhost.localdomain>
	<3E886C5F.28140.1013B3CA@localhost>
	<1049160350.1059.39.camel@localhost.localdomain> 
	<1049185774.593.46.camel@zion.wanadoo.fr>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from pine.compass.com.ph ([202.70.96.37])
	by sc8-sf-list1.sourceforge.net with smtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 190IxT-0005Pg-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 01 Apr 2003 02:25:36 -0800
In-Reply-To: <1049185774.593.46.camel@zion.wanadoo.fr>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Kendall Bennett <KendallB@scitechsoft.com>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Tue, 2003-04-01 at 16:29, Benjamin Herrenschmidt wrote:
> 
> Once the fbdev can provide, upon request, the EDID and probing info
> (some cards can tell you if something is connected even without
> providing an EDID, like on the S-Video output, or on the VGA output
> with a non-DDC capable monitor), we need some consistent API to
> retreive that from, userland at least
> 
> Then, we need fbdev to "validate" modes based on those EDID infos
> (via fbmon ?).
> 

How I'm currently doing it with the extended vesafb driver is this:

1. construct a database of video modes in struct fb_videomode format
based on all the modes given by the EDID.  This database can be passed
to fb_find_mode() in modedb.c to select the best video mode.  If the
monitor's operating limits are unknown, then the driver is restricted to
using only modes listed by the database.

2. If the monitor's operating limits are known (again via EDID), modes
can be easily validated.  There's already working code for this in
fbmon.c -- fb_validate_mode().  

3. If the monitor is GTF-capable, then referring to the database can
actually be skipped, and modelines will just be computed using the VESA
GT formula.  Again, the code is already existent in fbmon.c --
fb_get_mode().  

I've also extended EDID parsing in fbmon.c.  Here's a sample output:

========================================
Display Information (EDID)
========================================
   EDID Version 1.3
   Manufacturer: VSC Model: 2007 Serial#: 16843009
   Year: 2001 Week 47
   Display Characteristics:
      Analog Display Input: Input Voltage - 0.700V/0.300V
      Sync: Separate Composite Sync on Green
      Max H-size in cm: 38
      Max V-size in cm: 30
      Gamma: 2.40
      DPMS: Active yes, Suspend no, Standby no
      RGB Color Display
      First DETAILED Timing is preferred
   Standard Timings
      1280x10240@60Hz
      1280x1024@75Hz
      1152x864@75Hz
      1024x768@75Hz
      832x624@75Hz
      800x600@75Hz
      640x480@75Hz
      640x480@60Hz
   Supported VESA Modes
      720x400@70Hz
      640x480@60Hz
      640x480@67Hz
      640x480@72Hz
      640x480@75Hz
      800x600@56Hz
      800x600@60Hz
      800x600@72Hz
      800x600@75Hz
      832x624@75Hz
      1024x768@60Hz
      1024x768@70Hz
      1024x768@75Hz
      1280x1024@75Hz
      1152x870@75Hz
      Manufacturer's mask: 0
   Detailed Monitor Information
      108 MHz 1280 1328 1440 1688 1024 1025 1028 1066 +HSync +VSync

      Serial No     : A0Y014710490
      HorizSync     : 30-82 KHz
      VertRefresh   : 50-75 Hz
      Max Pixelclock: 140 MHz
      Monitor Name  : VG191
========================================

Tony



-------------------------------------------------------
This SF.net email is sponsored by: ValueWeb: 
Dedicated Hosting for just $79/mo with 500 GB of bandwidth! 
No other company gives more support or power for your dedicated server
http://click.atdmt.com/AFF/go/sdnxxaff00300020aff/direct/01/
