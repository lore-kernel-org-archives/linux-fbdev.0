From: "Parag Warudkar" <parag.warudkar@wipro.com>
Subject: 2.5.70 - Blank Screen with VESA VGA Framebuffer
Date: Tue, 10 Jun 2003 15:06:23 +0530
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <0BCBFEACE44CF0469CF5EBF7F6B61253410228@chn-snr-msg.wipro.com>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from wiprom2mx1.wipro.com ([203.197.164.41])
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 19PfYV-0005VQ-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 10 Jun 2003 02:36:39 -0700
Received: from m2vwall5.wipro.com (m2vwall5.wipro.com [10.115.50.5])
	by wiprom2mx1.wipro.com (8.11.3/8.11.3) with SMTP id h5A9aSC08805
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 10 Jun 2003 15:06:28 +0530 (IST)
content-class: urn:content-classes:message
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
To: linux-fbdev-devel@lists.sourceforge.net

I have a Sony VAIO laptop with ATI Mobility M1 AGP chip. I can use
XFree86 on 2.4.x if I enable VESA VGA Frame buffer and enable vga=3D788 =
on
kernel command line. With Kernel 2.5.70 after enabling VESA VGA
Framebuffer console and specifying vga=3D commandline, I just get a =
blank
screen just after the boot process starts and X doesn't work. (Garbled
screen). Without the vga=3D commandline, I get normal boot screen but X
needs the vga=3D option and doesn't work.

I have tried everything but to no avail. Does anyone know what do I need
to do in order to get kernel 2.5.X working with Framebuffer console
(VESA VGA or atyfb) and vga=3D788? I tried video=3Datyfb but that too
doesn't work..=20

Regards

Parag


-------------------------------------------------------
This SF.net email is sponsored by:  Etnus, makers of TotalView, The best
thread debugger on the planet. Designed with thread debugging features
you've never dreamed of, try TotalView 6 free at www.etnus.com.
