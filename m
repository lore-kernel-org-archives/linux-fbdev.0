From: <fsco_v-mail@yahoo.it>
Subject: cyblafb on Acer Travelmate 212TX
Date: Mon, 13 Feb 2006 02:15:32 -0800 (PST)
Message-ID: <20060213101532.94007.qmail@web86805.mail.ukl.yahoo.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="0-1667047668-1139825732=:92353"
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1F8ako-0002Py-GH
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 13 Feb 2006 02:16:22 -0800
Received: from web86805.mail.ukl.yahoo.com ([217.12.13.47])
	by mail.sourceforge.net with smtp (Exim 4.44)
	id 1F8akl-0005In-7u
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 13 Feb 2006 02:16:22 -0800
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
To: linux-fbdev-devel@lists.sourceforge.net, Knut_Petersen@t-online.de

--0-1667047668-1139825732=:92353
Content-Type: text/plain; charset=iso-8859-1
Content-Id: 
Content-Disposition: inline

I tried a cyblafb driver on a Acer Travelmate 212TX.
Graphic board is a Trident Cyberblade/i1 on ALi motherboard.
If I try to use tridentfb framebuffer it generates (udevd) a fb0 node
and works almost correctly, but cyblafb driver do not make fb0 node.
Kernel release i 2.6.15.1 and dmesg does not list nothing about driver
messages.

It is my laptop supported?

Thanks :-)

Francesco Vasco

PS: I am waiting for reply... Thanks

--
NeXTWare s.n.c. di Giglione Marco e Guarnieri Giuseppe
Via Prospero Petroni, 9 - 70100 BARI (BA)
P.Iva 06111910722
http://www.next-ware.it


	

	
		
___________________________________ 
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB 
http://mail.yahoo.it
--0-1667047668-1139825732=:92353
Content-Type: text/plain; name="lspci_vn.txt"
Content-Description: 3716441873-lspci_vn.txt
Content-Disposition: inline; filename="lspci_vn.txt"

lspci version 2.1.11
0000:00:00.0 0600: 10b9:1621 (rev 01)
	Flags: bus master, slow devsel, latency 0
	Memory at e0000000 (32-bit, prefetchable) [size=64M]
	Capabilities: [b0] AGP version 1.0
	Capabilities: [a4] Power Management version 1

0000:00:01.0 0604: 10b9:5247 (rev 01)
	Flags: bus master, fast devsel, latency 0
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	Memory behind bridge: 80100000-818fffff

0000:00:06.0 0401: 10b9:5451 (rev 01)
	Subsystem: 1025:1019
	Flags: bus master, medium devsel, latency 32, IRQ 10
	I/O ports at 8000 [size=256]
	Memory at 81a00000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [dc] Power Management version 2

0000:00:07.0 0601: 10b9:1533
	Subsystem: 1025:1019
	Flags: bus master, medium devsel, latency 0
	Capabilities: [a0] Power Management version 1

0000:00:10.0 0101: 10b9:5229 (rev c3) (prog-if fa)
	Subsystem: 1025:1019
	Flags: bus master, medium devsel, latency 32, IRQ 15
	I/O ports at 7050 [size=16]
	Capabilities: [60] Power Management version 2

0000:00:11.0 0680: 10b9:7101
	Subsystem: 1025:1019
	Flags: medium devsel

0000:00:13.0 0607: 1217:6872 (rev 05)
	Subsystem: 1025:1019
	Flags: bus master, stepping, slow devsel, latency 168, IRQ 11
	Memory at 24000000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=00, secondary=02, subordinate=05, sec-latency=176
	Memory window 0: 20000000-21fff000 (prefetchable)
	Memory window 1: 22000000-23fff000
	I/O window 0: 00001400-000014ff
	I/O window 1: 00001800-000018ff
	16-bit legacy interface ports at 0001

0000:00:14.0 0c03: 10b9:5237 (rev 03) (prog-if 10)
	Subsystem: 1025:1019
	Flags: bus master, medium devsel, latency 32, IRQ 11
	Memory at 81c00000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [60] Power Management version 2

0000:01:00.0 0300: 1023:8620 (rev 5d)
	Subsystem: 1025:1019
	Flags: 66MHz, medium devsel, IRQ 11
	Memory at 80800000 (32-bit, non-prefetchable) [size=8M]
	Memory at 80100000 (32-bit, non-prefetchable) [size=128K]
	Memory at 81000000 (32-bit, non-prefetchable) [size=8M]
	Expansion ROM at 80120000 [disabled] [size=64K]
	Capabilities: [80] AGP version 1.0
	Capabilities: [90] Power Management version 1


--0-1667047668-1139825732=:92353--


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
