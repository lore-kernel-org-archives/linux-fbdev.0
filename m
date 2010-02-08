From: "Maupin, Chase" <chase.maupin@ti.com>
Date: Mon, 08 Feb 2010 15:14:36 +0000
Subject: FW: Requested feedback on FBDev driver design
Message-Id: <131E5DFBE7373E4C8D813795A6AA7F0802C4E0FF46@dlee06.ent.ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

All,

I am forwarding the below message to this mailing list since the linux-fbdev-devel@lists.sourceforge.net list has been moved here.

Sincerely,
Chase Maupin
Software Applications
Catalog DSP Products
e-mail: chase.maupin@ti.com

For support:
Forums - http://community.ti.com/forums/
Wiki - http://wiki.davincidsp.com/

-----Original Message-----
From: Maupin, Chase 
Sent: Monday, February 08, 2010 9:12 AM
To: 'imre.deak@nokia.com'; 'tomi.valkeinen@nokia.com'; 'linux-fbdev-devel@lists.sourceforge.net'
Cc: vpss_driver_design@list.ti.com - This list is to discuss the VPSS driver design (May contain non-TIers)
Subject: Requested feedback on FBDev driver design

All,

Texas Instruments (TI) is working on the design for the FBDev driver for our next generation system-on-chip (SoC) processor and would like to solicit your feedback.  Our new SoCs have been improved to allow for higher video resolutions and greater frame rates.  To this end the display hardware has been moved to a separate processing block called the video processing subsystem (VPSS).  The VPSS will be running a firmware image that controls the display hardware and services requests from one or more host processors.

Moving to a remote processor for the processing of graphics output data requires that commands to control the hardware be passed to this processing block using some form of inter-processor communication (IPC).  TI would like to solicit your feedback on proposal for the FBDev driver design to get a feel for whether or not this design would be accepted into the Linux kernel.  To this end we have put together an overview of the design and usage on our wiki at http://wiki.davincidsp.com/index.php/Video_Processing_Subsystem_Driver_Design.  We would greatly appreciate feedback from community members on the acceptability of our driver design.

If you have additional questions or need more information please feel free to contact us (we have setup a mailing list at vpss_driver_design@list.ti.com) so we can answer them.

Sincerely,
Chase Maupin
Software Applications
Catalog DSP Products
e-mail: chase.maupin@ti.com
phone: (281) 274-3285

For support:
Forums - http://community.ti.com/forums/
Wiki - http://wiki.davincidsp.com/

