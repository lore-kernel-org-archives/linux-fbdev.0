From: Jimmy Jazz <Jimmy.Jazz@gmx.net>
Subject: Re: radeonfb doesn't work with an ati X800 pcie
 card
Date: Sat, 14 Apr 2007 12:17:36 +0200
Message-ID: <4620AA40.4080306@gmx.net>
References: <46093D22.3090401@gmx.net> <461BD18E.5020706@gmx.net>	
	<461CD1F7.40004@gmx.net>	
	<1176329514.8061.106.camel@localhost.localdomain>
	<68676e00704121638o6e723806ue163fbd17af4b246@mail.gmail.com>
Reply-To: Jimmy.Jazz@gmx.net, linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------080205040701090005090804"
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HcfKB-000437-6c for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 14 Apr 2007 03:17:43 -0700
Received: from ip-62-241-114-101.evc.net ([62.241.114.101]
	helo=snowman.cryosphere.shacknet.nu)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HcfK9-0003Ua-R7
	for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 14 Apr 2007 03:17:43 -0700
In-Reply-To: <68676e00704121638o6e723806ue163fbd17af4b246@mail.gmail.com>
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
To: Luca Tettamanti <kronos.it@gmail.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, linux-fbdev-devel@lists.sourceforge.net, pizza@shaftnet.org, kofboy@163.com

This is a multi-part message in MIME format.
--------------080205040701090005090804
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

Luca Tettamanti a =C3=A9crit :
> On 4/12/07, Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
>> On Wed, 2007-04-11 at 14:17 +0200, Jimmy Jazz wrote:
>> > Hello,
>> >
>> > i sent it without care and i forgot to add some diff files you will=20
>> have
>> > to apply to radeonfb.h, ati_ids.h and radeon_base.c with both
>> > radeon_accel.c and radeon_monitor.c patches. Otherwise, you won't be
>> > able to compile the kernel anymore. Sorry for the inconvenient.
>> >
>> > Thank you all of you who contributed to these patches, the initiator=
 of
>> > the radeonfb driver and of course the Xorg team who made ATI cards
>> > compatible with the xorg server.
>>
>> There are already patches from Solomon for Atom BIOSes.
>=20
> I'm attaching the usual patch for the OP, rediffed against
> git-current. Works here on a X850.
>=20
>> I admit that I never found the time to fully cleanup, split, test,
>> etc... those along with other fixes I have in my queue. I could use a
>> co-maintainer for radeonfb...
>=20
> Splitting the ATOM patch is PITA, the changes are very interdependent.
> For other stuff: I can do testing and cleanup ;-)
>=20
> Luca

Hi Luca,

I added some lines to your code to make my ATI X800 work (it doesn't=20
otherwise). Also DVI Flat panel owners will probably be happy :)

I made the test on linux 2.6.21-rc6-r1 Andrew Morton's kernel release.

Here have a look at the differences before and after i added my patch.
As you can see, before applying the patch, the monitor isn't detected=20
and is defaulted to CRT even if EDID data returns the right informations=20
about the display connected.

# cat /var/log/kern.log (THE BAD)
Apr 13 21:58:01 seal Starting monitor auto detection...
Apr 13 21:58:01 seal i2c-adapter i2c-3: unable to read EDID block.
Apr 13 21:58:01 seal i2c-adapter i2c-3: unable to read EDID block.
Apr 13 21:58:01 seal i2c-adapter i2c-3: unable to read EDID block.
Apr 13 21:58:01 seal radeonfb: I2C (port 1) ... not found
Apr 13 21:58:01 seal radeonfb: I2C (port 0) ... found CRT display
Apr 13 21:58:01 seal * Connector 1 is VGA. Head -1, Monitor: None
Apr 13 21:58:01 seal ddc port: 1, dac: 0, tmds: -1
Apr 13 21:58:01 seal * Connector 2 is DVI-I. Head 0, Monitor: CRT (EDID=20
probed)
Apr 13 21:58:01 seal ddc port: 0, dac: 1, tmds: 0

# cat /var/log/kern.log (THE GOOD)

Apr 13 23:39:54 seal i2c-adapter i2c-1: nForce2 SMBus adapter at 0x4c40
Apr 13 23:39:54 seal radeonfb_pci_register BEGIN
Apr 13 23:39:54 seal ACPI: PCI Interrupt Link [APC3] enabled at IRQ 18
Apr 13 23:39:54 seal ACPI: PCI Interrupt 0000:01:00.0[A] -> Link [APC3]=20
-> GSI 18 (level, low) -> IRQ 18
Apr 13 23:39:54 seal radeonfb (0000:01:00.0): Found 131072k of DDR 256=20
bits wide videoram
Apr 13 23:39:54 seal radeonfb (0000:01:00.0): mapped 16384k videoram
Apr 13 23:39:54 seal radeonfb: Found Intel x86 BIOS ROM Image
Apr 13 23:39:54 seal Retrieved PLL infos from ATOM BIOS
Apr 13 23:39:54 seal radeonfb: Reference=3D27.00 MHz (RefDiv=3D2)=20
Memory=3D500.00 Mhz, System=3D500.00 MHz
Apr 13 23:39:54 seal PLL min 20000 max 50000
Apr 13 23:39:54 seal TMDS PLL from BIOS: 16500 b011c
Apr 13 23:39:54 seal id=3D1 GPIO: 0xbac4+0x64
Apr 13 23:39:54 seal id=3D2 GPIO: 0xbac4+0x68
Apr 13 23:39:54 seal Port 0: DDCType-1, DACType-0, TMDSType--1,=20
ConnectorType-1
Apr 13 23:39:54 seal Port 1: DDCType-0, DACType-1, TMDSType-0,=20
ConnectorType-2
Apr 13 23:39:54 seal Starting monitor auto detection...
Apr 13 23:39:54 seal i2c-adapter i2c-3: unable to read EDID block.
Apr 13 23:39:54 seal i2c-adapter i2c-3: unable to read EDID block.
Apr 13 23:39:54 seal i2c-adapter i2c-3: unable to read EDID block.
Apr 13 23:39:54 seal radeonfb: I2C (port 1) ... not found
Apr 13 23:39:54 seal radeonfb: I2C (port 0) ... found TMDS panel
Apr 13 23:39:54 seal * Connector 1 is VGA. Head -1, Monitor: None
Apr 13 23:39:54 seal ddc port: 1, dac: 0, tmds: -1
Apr 13 23:39:54 seal * Connector 2 is DVI-I. Head 0, Monitor: DVI Flat=20
panel (EDID probed)
Apr 13 23:39:54 seal ddc port: 0, dac: 1, tmds: 0

You will find in attachment the diff code source. (AND THE UGLY)

A lot of code was altered recently in xf86-video-ati-6.6.191. I think=20
xorg team made the cleanup Benh asks for ;)

IMHO that would have been great to unify kernel and xorg code regarding=20
display drivers.


@kofboy

I'm unable to send you more than one mail a day. There should be=20
something wrong with your ISP. Please join us on the list :)

Jj

--------------080205040701090005090804
Content-Type: text/x-patch;
 name="aty.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="aty.patch"

--- /usr/src/model_with-radeon-r400/aty/radeon_i2c.c	2007-04-13 13:35:49.000000000 +0200
+++ radeon_i2c.c	2007-04-13 22:07:16.000000000 +0200
@@ -163,7 +163,7 @@
 		mon_type = MT_NONE;
 		goto done;
 	}
-	if ((edid[EDID_STRUCT_DISPLAY] & 0x80) && (conn->ddc_type == ddc_dvi)) {
+	if ((edid[EDID_STRUCT_DISPLAY] & 0x80) && ((conn->ddc_type == ddc_dvi) || (conn->ddc_type == ddc_monid))) {
 		RTRACE("radeonfb: I2C (port %d) ... found TMDS panel\n", conn->ddc_type);
 		mon_type = MT_DFP;
 		goto done;
--- /usr/src/model_with-radeon-r400/aty/radeon_monitor.c	2007-04-13 13:35:49.000000000 +0200
+++ radeon_monitor.c	2007-04-13 14:00:11.000000000 +0200
@@ -610,6 +610,105 @@
 }
 #endif /* CONFIG_PPC_OF */
 
+#if 1
+int __devinit radeon_get_conn_info_atom(struct radeonfb_info *rinfo)
+{
+    int i = 0, j, tmp, tmp0=0, tmp1=0;
+
+    if(!rinfo->bios_seg) return -ENODEV;
+
+    if (rinfo->is_atom_bios) {
+        if((tmp = BIOS_IN16 (rinfo->atom_data_start + 22))) {
+            int crtc = 0, id[2];
+            tmp1 = BIOS_IN16 (tmp + 4);
+            for (i=0; i<8; i++) {
+                if(tmp1 & (1<<i)) {
+                    u16 portinfo = BIOS_IN16(tmp+6+i*2);
+                    if (crtc < 2) {
+                        if ((i==2) || (i==6)) continue; /* ignore TV here */
+
+                        if (crtc == 1) {
+                            /* sharing same port with id[0] */
+                            if (((portinfo>>8) & 0xf) == id[0]) {
+                                if (i == 3)
+                                    rinfo->connectors[0].tmds_type = tmds_internal;
+                                else if (i == 7)
+                                    rinfo->connectors[0].tmds_type = tmds_external;
+
+                                if (rinfo->connectors[0].dac_type == dac_unknown)
+                                    rinfo->connectors[0].dac_type = (portinfo & 0xf) - 1;
+                                continue;
+                            }
+                        }
+
+                        /* crtc == 0 */
+                        id[crtc] = (portinfo>>8) & 0xf;
+                        rinfo->connectors[crtc].dac_type = (portinfo & 0xf) - 1;
+                        rinfo->connectors[crtc].conn_type = (portinfo>>4) & 0xf;
+                        if (i == 3)
+                            rinfo->connectors[crtc].tmds_type = tmds_internal;
+                        else if (i == 7)
+                            rinfo->connectors[crtc].tmds_type = tmds_external;
+
+                        if((tmp0 = BIOS_IN16 (rinfo->atom_data_start + 24)) && id[crtc]) {
+                            int gpio;
+                            switch (gpio = BIOS_IN16 (tmp0 + 4 + 27 * id[crtc]) * 4)
+                            {
+                            case GPIO_MONID:
+                                rinfo->connectors[crtc].ddc_type = ddc_monid;
+                                break;
+                            case GPIO_DVI_DDC:
+                                rinfo->connectors[crtc].ddc_type = ddc_dvi;
+                                break;
+                            case GPIO_VGA_DDC:
+                                rinfo->connectors[crtc].ddc_type = ddc_vga;
+                                break;
+                            case GPIO_CRT2_DDC:
+                                rinfo->connectors[crtc].ddc_type = ddc_crt2;
+                                break;
+                            default:
+                                rinfo->connectors[crtc].ddc_type = ddc_none;
+                                break;
+                            }
+                            RTRACE("id=%d GPIO: 0x%x+0x%x\n",id[crtc],tmp0,gpio);
+
+                        } else {
+                            rinfo->connectors[crtc].ddc_type = ddc_none;
+                        }
+                        crtc++;
+                    } else {
+                        /* we have already had two CRTCs assigned. the rest may share the same
+ *                          * port with the existing connector, fill in them accordingly.
+ *                                                   */
+                        for (j=0; j<2; j++) {
+                            if (((portinfo>>8) & 0xf) == id[j]) {
+                                if (i == 3)
+                                    rinfo->connectors[j].tmds_type = tmds_internal;
+                                else if (i == 7)
+                                    rinfo->connectors[j].tmds_type = tmds_external;
+
+                                if (rinfo->connectors[j].dac_type == dac_unknown)
+                                    rinfo->connectors[j].dac_type = (portinfo & 0xf) - 1;
+                            }
+                        }
+                    }
+                }
+            }
+
+            for (i=0; i<2; i++) {
+                        RTRACE("Port %d: DDCType-%d, DACType-%d, TMDSType-%d, ConnectorType-%d\n", i,
+                        rinfo->connectors[i].ddc_type, rinfo->connectors[i].dac_type,
+                        rinfo->connectors[i].tmds_type, rinfo->connectors[i].conn_type);
+            }
+        } else {
+                RTRACE("No Device Info Table found!\n");
+            return -ENODEV;
+        }
+    }
+    return 0;
+}
+#endif
+#if 0
 int __devinit radeon_get_conn_info_atom(struct radeonfb_info *rinfo)
 {
 	int i, j, offset, valids;
@@ -727,6 +826,7 @@
 
 	return 0;
 }
+#endif
 
 /* Try to extract the connector informations from the BIOS. This
  * doesn't quite work yet, but it's output is still useful for

--------------080205040701090005090804
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--------------080205040701090005090804
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-fbdev-devel mailing list
Linux-fbdev-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel

--------------080205040701090005090804--
