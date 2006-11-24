From: Helge Deller <deller@gmx.de>
Subject: Re: [PATCH] Fbdev driver for IBM GXT4500P video
	cards
Date: Fri, 24 Nov 2006 20:13:08 +0100
Message-ID: <ek7g84$93g$1@sea.gmane.org>
References: <17766.24132.505274.631108@cargo.ozlabs.ibm.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Gngfh-0005Mx-O4 for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 24 Nov 2006 11:25:13 -0800
Received: from main.gmane.org ([80.91.229.2] helo=ciao.gmane.org)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1Gngfg-00078M-1C
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 24 Nov 2006 11:25:12 -0800
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1GngfW-00056h-E0 for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 24 Nov 2006 20:25:02 +0100
Received: from mnhm-590c13b4.pool.einsundeins.de ([89.12.19.180])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00 for <linux-fbdev-devel@lists.sourceforge.net>;
	Fri, 24 Nov 2006 20:25:02 +0100
Received: from deller by mnhm-590c13b4.pool.einsundeins.de with local (Gmexim
	0.1 (Debian)) id 1AlnuQ-0007hv-00
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Fri, 24 Nov 2006 20:25:02 +0100
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: linux-fbdev-devel@lists.sourceforge.net
Cc: linuxppc-dev@ozlabs.org

Hi Paul,

Paul Mackerras wrote:
> This is an fbdev driver for the IBM GXT4500P display card found in
> some IBM System P (pSeries) machines.  These cards have hardware 2D
> and 3D capabilities, but the driver does not use them; it just exports
> a dumb framebuffer.


You might try to "const"-ify a few static structs and arrays...

Helge


> +/* Indexed by DFA_PIX_* values */
> +static unsigned char watfmt[] = {
> +     WAT_FMT_8BIT, WAT_FMT_16BIT_565, WAT_FMT_16BIT_1555, 0,


> +static unsigned char mdivtab[] = {
> +/* 1 */                    0x3f, 0x00, 0x20, 0x10, 0x28, 0x14, 0x2a, 0x15, 0x0a,


> +static unsigned char ndivtab[] = {
> +/* 2 */                          0x00, 0x80, 0xc0, 0xe0, 0xf0, 0x78, 0xbc, 0x5e,



not sure about those:

> +static struct fb_bitfield eightbits = {0, 8};
> +static struct fb_bitfield nobits = {0, 0};


> +static struct fb_ops gxt4500_ops = {
> +     .owner = THIS_MODULE,


> +static struct pci_device_id gxt4500_pci_tbl[] = {
> +     { PCI_VENDOR_ID_IBM, PCI_DEVICE_ID_IBM_GXT4500P,
> +       PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },


maybe this one:
> +static struct pci_driver gxt4500_driver = {
> +     .name = "gxt4500",

and maybe more ?



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
