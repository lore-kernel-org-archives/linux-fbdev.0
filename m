From: Andrew Morton <akpm@osdl.org>
Subject: Fw: [Bugme-new] [Bug 4347] New: savavgfb ddc eeprom oops when
 "sensors" used as non-root
Date: Thu, 17 Mar 2005 11:09:41 -0800
Message-ID: <20050317110941.4e5801fa.akpm@osdl.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DC0Nj-0005m9-Lr
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 17 Mar 2005 11:10:07 -0800
Received: from fire.osdl.org ([65.172.181.4] helo=smtp.osdl.org)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.41)
	id 1DC0Nf-00076U-Tl
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 17 Mar 2005 11:10:07 -0800
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
Cc: khali@linux-fr.org, salahx@yahoo.com


This might be a savagefb bug?


Begin forwarded message:

Date: Tue, 15 Mar 2005 23:31:20 -0800
From: bugme-daemon@osdl.org
To: bugme-new@lists.osdl.org
Subject: [Bugme-new] [Bug 4347] New: savavgfb ddc eeprom oops when "sensors" used as non-root


http://bugme.osdl.org/show_bug.cgi?id=4347

           Summary: savavgfb ddc eeprom oops when "sensors" used as non-root
    Kernel Version: 2.6.11.3
            Status: NEW
          Severity: normal
             Owner: khali@linux-fr.org
         Submitter: salahx@yahoo.com


Distribution: Gentoo (Linux ardvarc 2.6.11-gentoo-r2 #4 Wed Mar 9 15:50:59 CST
2005 i686 AMD Athlon(tm) XP 2000+ AuthenticAMD GNU/Linux)

Hardware Environment: Put-together machine 512M 

Output of lspci:
0000:00:00.0 Host bridge: VIA Technologies, Inc. VT8375 [KM266/KL266] Host Bridge
0000:00:01.0 PCI bridge: VIA Technologies, Inc. VT8633 [Apollo Pro266 AGP]
0000:00:10.0 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1
Controller (rev 80)
0000:00:10.1 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1
Controller (rev 80)
0000:00:10.2 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1
Controller (rev 80)
0000:00:10.3 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 82)
0000:00:11.0 ISA bridge: VIA Technologies, Inc. VT8235 ISA Bridge
0000:00:11.1 IDE interface: VIA Technologies, Inc.
VT82C586A/B/VT82C686/A/B/VT823x/A/C PIPC Bus Master IDE (rev 06)
0000:00:11.5 Multimedia audio controller: VIA Technologies, Inc.
VT8233/A/8235/8237 AC97 Audio Controller (rev 50)
0000:00:13.0 Ethernet controller: Realtek Semiconductor Co., Ltd.
RTL-8139/8139C/8139C+ (rev 10)
0000:01:00.0 VGA compatible controller: S3 Inc. VT8375 [ProSavage8 KM266/KL266]


Software Environment: For this one, a stripped down 2.6.11.3 kernel (but its
occured since at least when savagefb was introduced)

Problem Description:
when "savagefb-i2c" is loaded, framebuffer console enabled and eeprom module
loaded or compiled in, if a non-root user runs the "sensors" command, the kernel
panics or reboots instantly

Steps to reproduce:

1) Compile kernel with "S3 Savage support", "Enable ddc2 support" and
"Framebuffer Console Support" compiled in.
2) Either compile in or load eeprom and i2c algorithm modules
3) Boot kernel with Command line: video=savagefb:1024x768-16@60
4) Run "sensors" command with eeprom in kernel (Either built-in or modprobed")
as a non-root user

------- You are receiving this mail because: -------
You are on the CC list for the bug, or are watching someone who is.


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
