From: Jon Smirl <jonsmirl@yahoo.com>
Subject: Re: Reading the EDID block for x86 machines
Date: Tue, 18 Mar 2003 09:07:49 -0800 (PST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20030318170749.55622.qmail@web14904.mail.yahoo.com>
References: <1047981547.3668.73.camel@localhost.localdomain>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from web14904.mail.yahoo.com ([216.136.225.56])
	by sc8-sf-list1.sourceforge.net with smtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18vKZG-0006GN-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 18 Mar 2003 09:08:02 -0800
In-Reply-To: <1047981547.3668.73.camel@localhost.localdomain>
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
To: Antonino Daplas <adaplas@pol.net>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, James Simmons <jsimmons@infradead.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

Here is a description of how to control the shadow
write protect for a SIS chipset. It is done by writing
to PCI config space. There is a slim chance that this
is a standard procedure.

http://www.missl.cs.umd.edu/Projects/sebos/winint/index1.html

When you copied to 8000 ot 9000, did you copy the ROM
or the image at C000? I compared a dump of C000 to the
ROM and they don't match. ATI may have overlaid some
code during the init procedure.

So I guess we are stuck with a user space daemon.
Athlon-64 and IA64 will require the entire VM86
emulator. Last I checked the scitech emulator (ver8)
han't implemented all of the instructions needed to
run the ATI ROMs so it will need some work.

How do the Transmeta tools work? Could we turn the
ROMs into a C program and compile them again? Or use
something like use an emulator to capture the reset
sequence and then compile it for protected mode. 

I tried a couple of reverse engineering tools on the
ROMs but I didn't get very far. I don't have access to
the ATI Radeon documentation so it is hard for me to
tell what is going on.  

=====
Jon Smirl
jonsmirl@yahoo.com

__________________________________________________
Do you Yahoo!?
Yahoo! Platinum - Watch CBS' NCAA March Madness, live on your desktop!
http://platinum.yahoo.com


-------------------------------------------------------
This SF.net email is sponsored by: Does your code think in ink? 
You could win a Tablet PC. Get a free Tablet PC hat just for playing. 
What are you waiting for?
http://ads.sourceforge.net/cgi-bin/redirect.pl?micr5043en
