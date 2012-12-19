From: David Howells <dhowells@redhat.com>
Date: Wed, 19 Dec 2012 16:42:18 +0000
Subject: UAPI patch for fbdev
Message-Id: <7542.1355935338@warthog.procyon.org.uk>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="=-=-="
List-Id: <linux-fbdev.vger.kernel.org>
To: linux-fbdev@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hi Florian, Tomi,

Would it be possible to get an Acked-by or two for my UAPI disintegration
patch for fbdev (see attached)?

The patch can be merged from here if you're that way inclined:

	http://git.infradead.org/users/dhowells/linux-headers.git/shortlog/refs/he=
ads/disintegrate-fbdev

or I can send it directly to Linus now if you'd prefer?

Thanks,
David
=2D--
commit 7e9b729bd6d076c905e91e4a48c1ea07fb1a25a7
Author: David Howells <dhowells@redhat.com>
Date:   Wed Dec 19 16:07:26 2012 +0000

    UAPI: (Scripted) Disintegrate include/video
=20=20=20=20
    Signed-off-by: David Howells <dhowells@redhat.com>
    Acked-by: Arnd Bergmann <arnd@arndb.de>
    Acked-by: Thomas Gleixner <tglx@linutronix.de>
    Acked-by: Michael Kerrisk <mtk.manpages@gmail.com>
    Acked-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
    Acked-by: Dave Jones <davej@redhat.com>

diff --git a/include/uapi/video/Kbuild b/include/uapi/video/Kbuild
index aafaa5a..ac7203b 100644
=2D-- a/include/uapi/video/Kbuild
+++ b/include/uapi/video/Kbuild
@@ -1 +1,4 @@
 # UAPI Header export list
+header-y +=3D edid.h
+header-y +=3D sisfb.h
+header-y +=3D uvesafb.h
diff --git a/include/uapi/video/edid.h b/include/uapi/video/edid.h
new file mode 100644
index 0000000..8c0f032
=2D-- /dev/null
+++ b/include/uapi/video/edid.h
@@ -0,0 +1,9 @@
+#ifndef _UAPI__linux_video_edid_h__
+#define _UAPI__linux_video_edid_h__
+
+struct edid_info {
+	unsigned char dummy[128];
+};
+
+
+#endif /* _UAPI__linux_video_edid_h__ */
diff --git a/include/uapi/video/sisfb.h b/include/uapi/video/sisfb.h
new file mode 100644
index 0000000..9250b22
=2D-- /dev/null
+++ b/include/uapi/video/sisfb.h
@@ -0,0 +1,209 @@
+/*
+ * sisfb.h - definitions for the SiS framebuffer driver
+ *
+ * Copyright (C) 2001-2005 by Thomas Winischhofer, Vienna, Austria.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the named License,
+ * or any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307, USA
+ */
+
+#ifndef _UAPI_LINUX_SISFB_H_
+#define _UAPI_LINUX_SISFB_H_
+
+#include <linux/types.h>
+#include <asm/ioctl.h>
+
+/**********************************************/
+/*                   PUBLIC                   */
+/**********************************************/
+
+/* vbflags, public (others in sis.h) */
+#define CRT2_DEFAULT		0x00000001
+#define CRT2_LCD		0x00000002
+#define CRT2_TV			0x00000004
+#define CRT2_VGA		0x00000008
+#define TV_NTSC			0x00000010
+#define TV_PAL			0x00000020
+#define TV_HIVISION		0x00000040
+#define TV_YPBPR		0x00000080
+#define TV_AVIDEO		0x00000100
+#define TV_SVIDEO		0x00000200
+#define TV_SCART		0x00000400
+#define TV_PALM			0x00001000
+#define TV_PALN			0x00002000
+#define TV_NTSCJ		0x00001000
+#define TV_CHSCART		0x00008000
+#define TV_CHYPBPR525I		0x00010000
+#define CRT1_VGA		0x00000000
+#define CRT1_LCDA		0x00020000
+#define VGA2_CONNECTED          0x00040000
+#define VB_DISPTYPE_CRT1	0x00080000	/* CRT1 connected and used */
+#define VB_SINGLE_MODE		0x20000000	/* CRT1 or CRT2; determined by DISPTYPE=
_CRTx */
+#define VB_MIRROR_MODE		0x40000000	/* CRT1 + CRT2 identical (mirror mode) =
*/
+#define VB_DUALVIEW_MODE	0x80000000	/* CRT1 + CRT2 independent (dual head =
mode) */
+
+/* Aliases: */
+#define CRT2_ENABLE		(CRT2_LCD | CRT2_TV | CRT2_VGA)
+#define TV_STANDARD		(TV_NTSC | TV_PAL | TV_PALM | TV_PALN | TV_NTSCJ)
+#define TV_INTERFACE		(TV_AVIDEO|TV_SVIDEO|TV_SCART|TV_HIVISION|TV_YPBPR|T=
V_CHSCART|TV_CHYPBPR525I)
+
+/* Only if TV_YPBPR is set: */
+#define TV_YPBPR525I		TV_NTSC
+#define TV_YPBPR525P		TV_PAL
+#define TV_YPBPR750P		TV_PALM
+#define TV_YPBPR1080I		TV_PALN
+#define TV_YPBPRALL 		(TV_YPBPR525I | TV_YPBPR525P | TV_YPBPR750P | TV_YPB=
PR1080I)
+
+#define VB_DISPTYPE_DISP2	CRT2_ENABLE
+#define VB_DISPTYPE_CRT2	CRT2_ENABLE
+#define VB_DISPTYPE_DISP1	VB_DISPTYPE_CRT1
+#define VB_DISPMODE_SINGLE	VB_SINGLE_MODE
+#define VB_DISPMODE_MIRROR	VB_MIRROR_MODE
+#define VB_DISPMODE_DUAL	VB_DUALVIEW_MODE
+#define VB_DISPLAY_MODE		(SINGLE_MODE | MIRROR_MODE | DUALVIEW_MODE)
+
+/* Structure argument for SISFB_GET_INFO ioctl  */
+struct sisfb_info {
+	__u32	sisfb_id;		/* for identifying sisfb */
+#ifndef SISFB_ID
+#define SISFB_ID	  0x53495346    /* Identify myself with 'SISF' */
+#endif
+	__u32   chip_id;		/* PCI-ID of detected chip */
+	__u32   memory;			/* total video memory in KB */
+	__u32   heapstart;		/* heap start offset in KB */
+	__u8    fbvidmode;		/* current sisfb mode */
+
+	__u8	sisfb_version;
+	__u8	sisfb_revision;
+	__u8	sisfb_patchlevel;
+
+	__u8	sisfb_caps;		/* sisfb capabilities */
+
+	__u32	sisfb_tqlen;		/* turbo queue length (in KB) */
+
+	__u32	sisfb_pcibus;		/* The card's PCI ID */
+	__u32	sisfb_pcislot;
+	__u32	sisfb_pcifunc;
+
+	__u8	sisfb_lcdpdc;		/* PanelDelayCompensation */
+
+	__u8	sisfb_lcda;		/* Detected status of LCDA for low res/text modes */
+
+	__u32	sisfb_vbflags;
+	__u32	sisfb_currentvbflags;
+
+	__u32	sisfb_scalelcd;
+	__u32	sisfb_specialtiming;
+
+	__u8	sisfb_haveemi;
+	__u8	sisfb_emi30,sisfb_emi31,sisfb_emi32,sisfb_emi33;
+	__u8	sisfb_haveemilcd;
+
+	__u8	sisfb_lcdpdca;		/* PanelDelayCompensation for LCD-via-CRT1 */
+
+	__u16	sisfb_tvxpos, sisfb_tvypos;	/* Warning: Values + 32 ! */
+
+	__u32	sisfb_heapsize;		/* heap size (in KB) */
+	__u32	sisfb_videooffset;	/* Offset of viewport in video memory (in bytes)=
 */
+
+	__u32	sisfb_curfstn;		/* currently running FSTN/DSTN mode */
+	__u32	sisfb_curdstn;
+
+	__u16	sisfb_pci_vendor;	/* PCI vendor (SiS or XGI) */
+
+	__u32	sisfb_vbflags2;		/* ivideo->vbflags2 */
+
+	__u8	sisfb_can_post;		/* sisfb can POST this card */
+	__u8	sisfb_card_posted;	/* card is POSTED */
+	__u8	sisfb_was_boot_device;	/* This card was the boot video device (ie is=
 primary) */
+
+	__u8	reserved[183];		/* for future use */
+};
+
+#define SISFB_CMD_GETVBFLAGS	0x55AA0001	/* no arg; result[1] =3D vbflags */
+#define SISFB_CMD_SWITCHCRT1	0x55AA0010	/* arg[0]: 99 =3D query, 0 =3D off=
, 1 =3D on */
+/* more to come */
+
+#define SISFB_CMD_ERR_OK	0x80000000	/* command succeeded */
+#define SISFB_CMD_ERR_LOCKED	0x80000001	/* sisfb is locked */
+#define SISFB_CMD_ERR_EARLY	0x80000002	/* request before sisfb took over g=
fx system */
+#define SISFB_CMD_ERR_NOVB	0x80000003	/* No video bridge */
+#define SISFB_CMD_ERR_NOCRT2	0x80000004	/* can't change CRT1 status, CRT2 =
disabled */
+/* more to come */
+#define SISFB_CMD_ERR_UNKNOWN   0x8000ffff	/* Unknown command */
+#define SISFB_CMD_ERR_OTHER	0x80010000	/* Other error */
+
+/* Argument for SISFB_CMD ioctl */
+struct sisfb_cmd {
+	__u32  sisfb_cmd;
+	__u32  sisfb_arg[16];
+	__u32  sisfb_result[4];
+};
+
+/* Additional IOCTLs for communication sisfb <> X driver                */
+/* If changing this, vgatypes.h must also be changed (for X driver)    */
+
+/* ioctl for identifying and giving some info (esp. memory heap start) */
+#define SISFB_GET_INFO_SIZE	_IOR(0xF3,0x00,__u32)
+#define SISFB_GET_INFO		_IOR(0xF3,0x01,struct sisfb_info)
+
+/* ioctrl to get current vertical retrace status */
+#define SISFB_GET_VBRSTATUS	_IOR(0xF3,0x02,__u32)
+
+/* ioctl to enable/disable panning auto-maximize (like nomax parameter) */
+#define SISFB_GET_AUTOMAXIMIZE	_IOR(0xF3,0x03,__u32)
+#define SISFB_SET_AUTOMAXIMIZE	_IOW(0xF3,0x03,__u32)
+
+/* ioctls to relocate TV output (x=3DD[31:16], y=3DD[15:0], + 32)*/
+#define SISFB_GET_TVPOSOFFSET	_IOR(0xF3,0x04,__u32)
+#define SISFB_SET_TVPOSOFFSET	_IOW(0xF3,0x04,__u32)
+
+/* ioctl for internal sisfb commands (sisfbctrl) */
+#define SISFB_COMMAND		_IOWR(0xF3,0x05,struct sisfb_cmd)
+
+/* ioctl for locking sisfb (no register access during lock) */
+/* As of now, only used to avoid register access during
+ * the ioctls listed above.
+ */
+#define SISFB_SET_LOCK		_IOW(0xF3,0x06,__u32)
+
+/* ioctls 0xF3 up to 0x3F reserved for sisfb */
+
+/****************************************************************/
+/* The following are deprecated and should not be used anymore: */
+/****************************************************************/
+/* ioctl for identifying and giving some info (esp. memory heap start) */
+#define SISFB_GET_INFO_OLD	   _IOR('n',0xF8,__u32)
+/* ioctrl to get current vertical retrace status */
+#define SISFB_GET_VBRSTATUS_OLD	   _IOR('n',0xF9,__u32)
+/* ioctl to enable/disable panning auto-maximize (like nomax parameter) */
+#define SISFB_GET_AUTOMAXIMIZE_OLD _IOR('n',0xFA,__u32)
+#define SISFB_SET_AUTOMAXIMIZE_OLD _IOW('n',0xFA,__u32)
+/****************************************************************/
+/*               End of deprecated ioctl numbers                */
+/****************************************************************/
+
+/* For fb memory manager (FBIO_ALLOC, FBIO_FREE) */
+struct sis_memreq {
+	__u32	offset;
+	__u32	size;
+};
+
+/**********************************************/
+/*                  PRIVATE                   */
+/*         (for IN-KERNEL usage only)         */
+/**********************************************/
+
+
+#endif /* _UAPI_LINUX_SISFB_H_ */
diff --git a/include/uapi/video/uvesafb.h b/include/uapi/video/uvesafb.h
new file mode 100644
index 0000000..cee063d
=2D-- /dev/null
+++ b/include/uapi/video/uvesafb.h
@@ -0,0 +1,60 @@
+#ifndef _UAPI_UVESAFB_H
+#define _UAPI_UVESAFB_H
+
+#include <linux/types.h>
+
+struct v86_regs {
+	__u32 ebx;
+	__u32 ecx;
+	__u32 edx;
+	__u32 esi;
+	__u32 edi;
+	__u32 ebp;
+	__u32 eax;
+	__u32 eip;
+	__u32 eflags;
+	__u32 esp;
+	__u16 cs;
+	__u16 ss;
+	__u16 es;
+	__u16 ds;
+	__u16 fs;
+	__u16 gs;
+};
+
+/* Task flags */
+#define TF_VBEIB	0x01
+#define TF_BUF_ESDI	0x02
+#define TF_BUF_ESBX	0x04
+#define TF_BUF_RET	0x08
+#define TF_EXIT		0x10
+
+struct uvesafb_task {
+	__u8 flags;
+	int buf_len;
+	struct v86_regs regs;
+};
+
+/* Constants for the capabilities field
+ * in vbe_ib */
+#define VBE_CAP_CAN_SWITCH_DAC	0x01
+#define VBE_CAP_VGACOMPAT	0x02
+
+/* The VBE Info Block */
+struct vbe_ib {
+	char  vbe_signature[4];
+	__u16 vbe_version;
+	__u32 oem_string_ptr;
+	__u32 capabilities;
+	__u32 mode_list_ptr;
+	__u16 total_memory;
+	__u16 oem_software_rev;
+	__u32 oem_vendor_name_ptr;
+	__u32 oem_product_name_ptr;
+	__u32 oem_product_rev_ptr;
+	__u8  reserved[222];
+	char  oem_data[256];
+	char  misc_data[512];
+} __attribute__ ((packed));
+
+#endif /* _UAPI_UVESAFB_H */
diff --git a/include/video/Kbuild b/include/video/Kbuild
index ad3e622..e69de29 100644
=2D-- a/include/video/Kbuild
+++ b/include/video/Kbuild
@@ -1,3 +0,0 @@
=2Dheader-y +=3D edid.h
=2Dheader-y +=3D sisfb.h
=2Dheader-y +=3D uvesafb.h
diff --git a/include/video/edid.h b/include/video/edid.h
index c5f1987..0cb8b2a 100644
=2D-- a/include/video/edid.h
+++ b/include/video/edid.h
@@ -1,14 +1,9 @@
 #ifndef __linux_video_edid_h__
 #define __linux_video_edid_h__
=20
=2Dstruct edid_info {
=2D	unsigned char dummy[128];
=2D};
+#include <uapi/video/edid.h>
=20
=2D#ifdef __KERNEL__
 #ifdef CONFIG_X86
 extern struct edid_info edid_info;
 #endif
=2D#endif
=2D
 #endif /* __linux_video_edid_h__ */
diff --git a/include/video/sisfb.h b/include/video/sisfb.h
index 6dc5df9..6ddff93 100644
=2D-- a/include/video/sisfb.h
+++ b/include/video/sisfb.h
@@ -17,197 +17,12 @@
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307, USA
  */
=2D
 #ifndef _LINUX_SISFB_H_
 #define _LINUX_SISFB_H_
=20
=2D#include <linux/types.h>
=2D#include <asm/ioctl.h>
=2D
=2D/**********************************************/
=2D/*                   PUBLIC                   */
=2D/**********************************************/
=2D
=2D/* vbflags, public (others in sis.h) */
=2D#define CRT2_DEFAULT		0x00000001
=2D#define CRT2_LCD		0x00000002
=2D#define CRT2_TV			0x00000004
=2D#define CRT2_VGA		0x00000008
=2D#define TV_NTSC			0x00000010
=2D#define TV_PAL			0x00000020
=2D#define TV_HIVISION		0x00000040
=2D#define TV_YPBPR		0x00000080
=2D#define TV_AVIDEO		0x00000100
=2D#define TV_SVIDEO		0x00000200
=2D#define TV_SCART		0x00000400
=2D#define TV_PALM			0x00001000
=2D#define TV_PALN			0x00002000
=2D#define TV_NTSCJ		0x00001000
=2D#define TV_CHSCART		0x00008000
=2D#define TV_CHYPBPR525I		0x00010000
=2D#define CRT1_VGA		0x00000000
=2D#define CRT1_LCDA		0x00020000
=2D#define VGA2_CONNECTED          0x00040000
=2D#define VB_DISPTYPE_CRT1	0x00080000	/* CRT1 connected and used */
=2D#define VB_SINGLE_MODE		0x20000000	/* CRT1 or CRT2; determined by DISPTY=
PE_CRTx */
=2D#define VB_MIRROR_MODE		0x40000000	/* CRT1 + CRT2 identical (mirror mode=
) */
=2D#define VB_DUALVIEW_MODE	0x80000000	/* CRT1 + CRT2 independent (dual hea=
d mode) */
=2D
=2D/* Aliases: */
=2D#define CRT2_ENABLE		(CRT2_LCD | CRT2_TV | CRT2_VGA)
=2D#define TV_STANDARD		(TV_NTSC | TV_PAL | TV_PALM | TV_PALN | TV_NTSCJ)
=2D#define TV_INTERFACE		(TV_AVIDEO|TV_SVIDEO|TV_SCART|TV_HIVISION|TV_YPBPR=
|TV_CHSCART|TV_CHYPBPR525I)
=2D
=2D/* Only if TV_YPBPR is set: */
=2D#define TV_YPBPR525I		TV_NTSC
=2D#define TV_YPBPR525P		TV_PAL
=2D#define TV_YPBPR750P		TV_PALM
=2D#define TV_YPBPR1080I		TV_PALN
=2D#define TV_YPBPRALL 		(TV_YPBPR525I | TV_YPBPR525P | TV_YPBPR750P | TV_Y=
PBPR1080I)
=2D
=2D#define VB_DISPTYPE_DISP2	CRT2_ENABLE
=2D#define VB_DISPTYPE_CRT2	CRT2_ENABLE
=2D#define VB_DISPTYPE_DISP1	VB_DISPTYPE_CRT1
=2D#define VB_DISPMODE_SINGLE	VB_SINGLE_MODE
=2D#define VB_DISPMODE_MIRROR	VB_MIRROR_MODE
=2D#define VB_DISPMODE_DUAL	VB_DUALVIEW_MODE
=2D#define VB_DISPLAY_MODE		(SINGLE_MODE | MIRROR_MODE | DUALVIEW_MODE)
=2D
=2D/* Structure argument for SISFB_GET_INFO ioctl  */
=2Dstruct sisfb_info {
=2D	__u32	sisfb_id;		/* for identifying sisfb */
=2D#ifndef SISFB_ID
=2D#define SISFB_ID	  0x53495346    /* Identify myself with 'SISF' */
=2D#endif
=2D	__u32   chip_id;		/* PCI-ID of detected chip */
=2D	__u32   memory;			/* total video memory in KB */
=2D	__u32   heapstart;		/* heap start offset in KB */
=2D	__u8    fbvidmode;		/* current sisfb mode */
=2D
=2D	__u8	sisfb_version;
=2D	__u8	sisfb_revision;
=2D	__u8	sisfb_patchlevel;
=2D
=2D	__u8	sisfb_caps;		/* sisfb capabilities */
=2D
=2D	__u32	sisfb_tqlen;		/* turbo queue length (in KB) */
=2D
=2D	__u32	sisfb_pcibus;		/* The card's PCI ID */
=2D	__u32	sisfb_pcislot;
=2D	__u32	sisfb_pcifunc;
=2D
=2D	__u8	sisfb_lcdpdc;		/* PanelDelayCompensation */
=2D
=2D	__u8	sisfb_lcda;		/* Detected status of LCDA for low res/text modes */
=2D
=2D	__u32	sisfb_vbflags;
=2D	__u32	sisfb_currentvbflags;
=2D
=2D	__u32	sisfb_scalelcd;
=2D	__u32	sisfb_specialtiming;
=2D
=2D	__u8	sisfb_haveemi;
=2D	__u8	sisfb_emi30,sisfb_emi31,sisfb_emi32,sisfb_emi33;
=2D	__u8	sisfb_haveemilcd;
=2D
=2D	__u8	sisfb_lcdpdca;		/* PanelDelayCompensation for LCD-via-CRT1 */
=2D
=2D	__u16	sisfb_tvxpos, sisfb_tvypos;	/* Warning: Values + 32 ! */
=2D
=2D	__u32	sisfb_heapsize;		/* heap size (in KB) */
=2D	__u32	sisfb_videooffset;	/* Offset of viewport in video memory (in byte=
s) */
=2D
=2D	__u32	sisfb_curfstn;		/* currently running FSTN/DSTN mode */
=2D	__u32	sisfb_curdstn;
=2D
=2D	__u16	sisfb_pci_vendor;	/* PCI vendor (SiS or XGI) */
=2D
=2D	__u32	sisfb_vbflags2;		/* ivideo->vbflags2 */
=2D
=2D	__u8	sisfb_can_post;		/* sisfb can POST this card */
=2D	__u8	sisfb_card_posted;	/* card is POSTED */
=2D	__u8	sisfb_was_boot_device;	/* This card was the boot video device (ie =
is primary) */
=2D
=2D	__u8	reserved[183];		/* for future use */
=2D};
=2D
=2D#define SISFB_CMD_GETVBFLAGS	0x55AA0001	/* no arg; result[1] =3D vbflags=
 */
=2D#define SISFB_CMD_SWITCHCRT1	0x55AA0010	/* arg[0]: 99 =3D query, 0 =3D o=
ff, 1 =3D on */
=2D/* more to come */
=2D
=2D#define SISFB_CMD_ERR_OK	0x80000000	/* command succeeded */
=2D#define SISFB_CMD_ERR_LOCKED	0x80000001	/* sisfb is locked */
=2D#define SISFB_CMD_ERR_EARLY	0x80000002	/* request before sisfb took over=
 gfx system */
=2D#define SISFB_CMD_ERR_NOVB	0x80000003	/* No video bridge */
=2D#define SISFB_CMD_ERR_NOCRT2	0x80000004	/* can't change CRT1 status, CRT=
2 disabled */
=2D/* more to come */
=2D#define SISFB_CMD_ERR_UNKNOWN   0x8000ffff	/* Unknown command */
=2D#define SISFB_CMD_ERR_OTHER	0x80010000	/* Other error */
=2D
=2D/* Argument for SISFB_CMD ioctl */
=2Dstruct sisfb_cmd {
=2D	__u32  sisfb_cmd;
=2D	__u32  sisfb_arg[16];
=2D	__u32  sisfb_result[4];
=2D};
=2D
=2D/* Additional IOCTLs for communication sisfb <> X driver                =
*/
=2D/* If changing this, vgatypes.h must also be changed (for X driver)    */
=2D
=2D/* ioctl for identifying and giving some info (esp. memory heap start) */
=2D#define SISFB_GET_INFO_SIZE	_IOR(0xF3,0x00,__u32)
=2D#define SISFB_GET_INFO		_IOR(0xF3,0x01,struct sisfb_info)
=2D
=2D/* ioctrl to get current vertical retrace status */
=2D#define SISFB_GET_VBRSTATUS	_IOR(0xF3,0x02,__u32)
=2D
=2D/* ioctl to enable/disable panning auto-maximize (like nomax parameter) =
*/
=2D#define SISFB_GET_AUTOMAXIMIZE	_IOR(0xF3,0x03,__u32)
=2D#define SISFB_SET_AUTOMAXIMIZE	_IOW(0xF3,0x03,__u32)
=2D
=2D/* ioctls to relocate TV output (x=3DD[31:16], y=3DD[15:0], + 32)*/
=2D#define SISFB_GET_TVPOSOFFSET	_IOR(0xF3,0x04,__u32)
=2D#define SISFB_SET_TVPOSOFFSET	_IOW(0xF3,0x04,__u32)
=2D
=2D/* ioctl for internal sisfb commands (sisfbctrl) */
=2D#define SISFB_COMMAND		_IOWR(0xF3,0x05,struct sisfb_cmd)
=2D
=2D/* ioctl for locking sisfb (no register access during lock) */
=2D/* As of now, only used to avoid register access during
=2D * the ioctls listed above.
=2D */
=2D#define SISFB_SET_LOCK		_IOW(0xF3,0x06,__u32)
=2D
=2D/* ioctls 0xF3 up to 0x3F reserved for sisfb */
=2D
=2D/****************************************************************/
=2D/* The following are deprecated and should not be used anymore: */
=2D/****************************************************************/
=2D/* ioctl for identifying and giving some info (esp. memory heap start) */
=2D#define SISFB_GET_INFO_OLD	   _IOR('n',0xF8,__u32)
=2D/* ioctrl to get current vertical retrace status */
=2D#define SISFB_GET_VBRSTATUS_OLD	   _IOR('n',0xF9,__u32)
=2D/* ioctl to enable/disable panning auto-maximize (like nomax parameter) =
*/
=2D#define SISFB_GET_AUTOMAXIMIZE_OLD _IOR('n',0xFA,__u32)
=2D#define SISFB_SET_AUTOMAXIMIZE_OLD _IOW('n',0xFA,__u32)
=2D/****************************************************************/
=2D/*               End of deprecated ioctl numbers                */
=2D/****************************************************************/
=2D
=2D/* For fb memory manager (FBIO_ALLOC, FBIO_FREE) */
=2Dstruct sis_memreq {
=2D	__u32	offset;
=2D	__u32	size;
=2D};
=2D
=2D/**********************************************/
=2D/*                  PRIVATE                   */
=2D/*         (for IN-KERNEL usage only)         */
=2D/**********************************************/
=2D
=2D#ifdef __KERNEL__
=20
 #include <linux/pci.h>
+#include <uapi/video/sisfb.h>
=20
 #define	UNKNOWN_VGA  0
 #define	SIS_300_VGA  1
@@ -220,5 +35,3 @@ extern void sis_malloc_new(struct pci_dev *pdev, struct =
sis_memreq *req);
 extern void sis_free(u32 base);
 extern void sis_free_new(struct pci_dev *pdev, u32 base);
 #endif
=2D
=2D#endif
diff --git a/include/video/uvesafb.h b/include/video/uvesafb.h
index 0993a22..1a91850 100644
=2D-- a/include/video/uvesafb.h
+++ b/include/video/uvesafb.h
@@ -1,63 +1,8 @@
 #ifndef _UVESAFB_H
 #define _UVESAFB_H
=20
=2D#include <linux/types.h>
=2D
=2Dstruct v86_regs {
=2D	__u32 ebx;
=2D	__u32 ecx;
=2D	__u32 edx;
=2D	__u32 esi;
=2D	__u32 edi;
=2D	__u32 ebp;
=2D	__u32 eax;
=2D	__u32 eip;
=2D	__u32 eflags;
=2D	__u32 esp;
=2D	__u16 cs;
=2D	__u16 ss;
=2D	__u16 es;
=2D	__u16 ds;
=2D	__u16 fs;
=2D	__u16 gs;
=2D};
=2D
=2D/* Task flags */
=2D#define TF_VBEIB	0x01
=2D#define TF_BUF_ESDI	0x02
=2D#define TF_BUF_ESBX	0x04
=2D#define TF_BUF_RET	0x08
=2D#define TF_EXIT		0x10
=2D
=2Dstruct uvesafb_task {
=2D	__u8 flags;
=2D	int buf_len;
=2D	struct v86_regs regs;
=2D};
=2D
=2D/* Constants for the capabilities field
=2D * in vbe_ib */
=2D#define VBE_CAP_CAN_SWITCH_DAC	0x01
=2D#define VBE_CAP_VGACOMPAT	0x02
=2D
=2D/* The VBE Info Block */
=2Dstruct vbe_ib {
=2D	char  vbe_signature[4];
=2D	__u16 vbe_version;
=2D	__u32 oem_string_ptr;
=2D	__u32 capabilities;
=2D	__u32 mode_list_ptr;
=2D	__u16 total_memory;
=2D	__u16 oem_software_rev;
=2D	__u32 oem_vendor_name_ptr;
=2D	__u32 oem_product_name_ptr;
=2D	__u32 oem_product_rev_ptr;
=2D	__u8  reserved[222];
=2D	char  oem_data[256];
=2D	char  misc_data[512];
=2D} __attribute__ ((packed));
+#include <uapi/video/uvesafb.h>
=20
=2D#ifdef __KERNEL__
=20
 /* VBE CRTC Info Block */
 struct vbe_crtc_ib {
@@ -191,5 +136,4 @@ struct uvesafb_par {
 	struct vbe_crtc_ib crtc;
 };
=20
=2D#endif /* __KERNEL__ */
 #endif /* _UVESAFB_H */

--=-=-=
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIVAwUBUNHuZhOxKuMESys7AQJYtBAAqjXnlMettZ0zSh9oDjJjqFRlnnVvQH0E
38dwncK8keF81VYj6Ali5K4N/ghPkZonWmGhuJpHNRIZykl3wQHpI2HTGJb/u14S
mVB5X2d0ZKAE/LUxsIwMexDTs4OofDM0Ei9E05RjThIghKrtnmB8qqJ/AEEBTlyQ
Wzb/JQ1OXsVhTm8CBegpAcS9XwAAfTX/24I1nw5BHtlu19pCo+tWX4D2zUBHtMB2
1cbdXAVYCw4xqyXbsJIQ7QkN2r7QZ45osigOmueMb8ECYHvpFfUHttoLmXz3ciHC
Rbwic1Wvd8AKb4wUCQ6DTHHVnRalM9hQenYYdBXWDeCmTp2WKph/YZFroR82VPbc
oTvdJWASscFqMaRxOHHyglWh9FGBwqU4Qh97E7mGBXaL+ag3xmTehOk3j5UUKSDi
nhY34zeriYH+g19C7+tqWI/mxao7QjjMjVuwoBmzqz8o5Ty9R3WcpfKtA15r+t8v
VwdFjzcW/xkNkgIXCvG/0L7AsMv3Tcv1a2ErEX1jDB4YQKXUv/4z3kSS2ZIdyLB5
g2ofpGcOZUJj/JTLKX9BuNjZBVhbvw+1b/uYABJjxVqSbX1abcLOzuZtVydaACCT
SpZL/neqZctxQYc9wS9d4AT3nBkS9PAYA9NFjz+9tCebfLYgb7aLwf6nm54T49Uv
BWegU/f1H38=
=9NgQ
-----END PGP SIGNATURE-----
--=-=-=--
