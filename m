From: "James H. Cloos Jr." <cloos@jhcloos.com>
Subject: Re: Re: Status of radeonfb in 2.5?
Date: 04 Nov 2002 03:46:51 -0500
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <m3bs55pvr8.fsf@lugabout.jhcloos.org>
References: <3DACA222.5030409@netscape.net> <20021016223613.17897@192.168.4.1>
	<3DADD22F.9030508@netscape.net> <1034808341.1229.282.camel@tibook>
	<aopfrg$aln$1@main.gmane.org>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from signup.localnet.com ([207.251.201.46] helo=smtp.localnet.com)
	by usw-sf-list1.sourceforge.net with smtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 188ctB-0006zE-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 04 Nov 2002 00:47:17 -0800
In-Reply-To: <aopfrg$aln$1@main.gmane.org>
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
Content-Transfer-Encoding: 7bit
To: nwourms@netscape.net
Cc: linux-fbdev-devel@lists.sourceforge.net

>>>>> "Nicholas" == Nicholas Wourms <nwourms@netscape.net> writes:

Nicholas> how do I get (calculate) the modelines for fb.modes
Nicholas> based on the information the i2c DDC probing XFree-4.2.1
Nicholas> outputs in XFree.0.log?

It is just a matter of reformatting.  Eg, from this box:


(II) Reloading /usr/X11R6/lib/modules/libddc.a
[etc]
(II) RADEON(0): Supported Future Video Modes:
(II) RADEON(0): #0: hsize: 1600  vsize 1200  refresh: 60  vid: 16553
(II) RADEON(0): Supported additional Video Mode:
(II) RADEON(0): clock: 162.0 MHz   Image Size:  305 x 228 mm
(II) RADEON(0): h_active: 1600  h_sync: 1664  h_sync_end 1856 h_blank_end 2160 h_border: 0
(II) RADEON(0): v_active: 1200  v_sync: 1201  v_sync_end 1204 v_blanking: 1250 v_border: 0

Those lines give the data for a modeline.  That translates to:

Modeline "1600x1200x60"  162.0  1600 1664 1856 2160  1200 1201 1204 1250

-JimC



-------------------------------------------------------
This SF.net email is sponsored by: ApacheCon, November 18-21 in
Las Vegas (supported by COMDEX), the only Apache event to be
fully supported by the ASF. http://www.apachecon.com
